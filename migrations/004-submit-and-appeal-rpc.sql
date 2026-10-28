-- ============================================================================
--  Daag · 004 · Give the submit and appeal forms their reference number back
-- ============================================================================
--  Bug introduced by 001, found on 28 October 2026 by trying to submit.
--
--  001 did the right thing:
--
--      revoke all on public.submissions, public.appeals, ... from anon;
--      grant insert on public.submissions, public.appeals, ... to anon, ...;
--
--  anon can write a report and cannot read one. That is the whole point: a
--  stranger must not be able to list pending reports or read submitter emails.
--
--  But the client does this:
--
--      sb.from('submissions').insert({...}).select('ref_id').single()
--
--  PostgREST turns .select() into a RETURNING clause, and RETURNING needs
--  SELECT privilege on the table. anon does not have it, so every submission
--  has been failing with:
--
--      42501  permission denied for table submissions
--
--  The same applies to appeals. Contact messages were unaffected because that
--  form does a bare insert and never reads anything back.
--
--  Verified: a bare INSERT by anon still succeeds today. Only the read-back
--  fails. So nothing is wrong with the policies; the client simply cannot be
--  handed the generated ref_id without a privilege nobody should have.
--
--  The fix is NOT `grant select on public.submissions to anon`, which is what
--  the Postgres error message helpfully suggests. That would expose every
--  pending report, every rejected one, and every submitter email to anyone
--  with the anon key.
--
--  Instead: two SECURITY DEFINER functions that do the insert and return only
--  the reference number. They run as their owner, so they can read back
--  ref_id, and the caller gets a single text value and nothing else. Same
--  pattern as submission_status() in 001.
-- ============================================================================

begin;

-- ---------------------------------------------------------------------------
--  Submitting a report
-- ---------------------------------------------------------------------------
create or replace function public.submit_report(
  p_perpetrator_url        text,
  p_source_post_url        text,
  p_screenshot_url         text,
  p_profile_name           text,
  p_comment_text           text,
  p_category               text,
  p_incident_type          text,
  p_context_note           text default null,
  p_language               text default 'Bangla',
  p_translation            text default null,
  p_tags                   text[] default '{}',
  p_submitter_email        text default null,
  p_submitter_relationship text default null
)
returns text
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_ref text;
begin
  -- The same requirements the RLS insert policy enforces. Restated here
  -- because a SECURITY DEFINER function bypasses that policy, so this is the
  -- only thing standing between the public and a malformed row.
  if p_screenshot_url is null or length(trim(p_screenshot_url)) = 0 then
    raise exception 'A screenshot is required.' using errcode = '23514';
  end if;
  if p_comment_text is null or length(trim(p_comment_text)) = 0 then
    raise exception 'The comment text is required.' using errcode = '23514';
  end if;
  if p_perpetrator_url is null or length(trim(p_perpetrator_url)) = 0
     or p_source_post_url is null or length(trim(p_source_post_url)) = 0 then
    raise exception 'Both links are required.' using errcode = '23514';
  end if;

  insert into public.submissions (
    perpetrator_url, source_post_url, screenshot_url, profile_name,
    comment_text, category, incident_type, context_note, language,
    translation, tags, submitter_email, submitter_relationship, status
  ) values (
    p_perpetrator_url, p_source_post_url, p_screenshot_url, p_profile_name,
    p_comment_text, p_category, p_incident_type,
    nullif(trim(coalesce(p_context_note, '')), ''),
    coalesce(nullif(trim(p_language), ''), 'Bangla'),
    nullif(trim(coalesce(p_translation, '')), ''),
    coalesce(p_tags, '{}'),
    nullif(trim(coalesce(p_submitter_email, '')), ''),
    nullif(trim(coalesce(p_submitter_relationship, '')), ''),
    -- Never taken from the caller. A submission is always pending.
    'pending'
  )
  returning ref_id into v_ref;

  return v_ref;
end;
$$;

comment on function public.submit_report is
  'Files a public report and returns its reference number. SECURITY DEFINER so the reference can be read back without granting anon SELECT on submissions. Status is always pending and is never taken from the caller.';

revoke all on function public.submit_report(
  text,text,text,text,text,text,text,text,text,text,text[],text,text) from public;
grant execute on function public.submit_report(
  text,text,text,text,text,text,text,text,text,text,text[],text,text) to anon, authenticated;

-- ---------------------------------------------------------------------------
--  Filing an appeal
-- ---------------------------------------------------------------------------
create or replace function public.file_appeal(
  p_entry_id      text,
  p_grounds       text,
  p_statement     text,
  p_contact_email text default null
)
returns text
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_ref text;
begin
  if p_entry_id is null or length(trim(p_entry_id)) = 0 then
    raise exception 'The entry reference is required.' using errcode = '23514';
  end if;
  if p_statement is null or length(trim(p_statement)) = 0 then
    raise exception 'A supporting statement is required.' using errcode = '23514';
  end if;

  insert into public.appeals (entry_id, grounds, statement, contact_email, status)
  values (
    trim(p_entry_id), p_grounds, trim(p_statement),
    nullif(trim(coalesce(p_contact_email, '')), ''),
    'under_review'
  )
  returning ref_id into v_ref;

  return v_ref;
end;
$$;

comment on function public.file_appeal is
  'Files an appeal against an archive entry and returns its reference number. SECURITY DEFINER for the same reason as submit_report. Status is always under_review.';

revoke all on function public.file_appeal(text,text,text,text) from public;
grant execute on function public.file_appeal(text,text,text,text) to anon, authenticated;

commit;

-- ---------------------------------------------------------------------------
--  Check it worked. Both should return a reference number, and anon should
--  still be unable to read either table.
-- ---------------------------------------------------------------------------
-- select public.submit_report(
--   'https://example.com/p','https://example.com/s','https://example.com/x.png',
--   'test.profile','test comment','Victim Blaming','Cyber Harassment');
-- select public.file_appeal('DG-2025-0001','Other','test statement');
