-- ============================================================================
--  Daag · 004 · URGENT: legacy policies were overriding the lockdown
-- ============================================================================
--  APPLIED to the live database on 28 October 2026. Kept here as the record
--  of what the schema is. Until it ran, anyone holding the public anon key,
--  which is in the page source of daag-bd.com because it is designed to be,
--  could publish straight into the archive with no human review.
--
--  Verified on 28 October 2026 with nothing but the anon key and curl:
--
--      POST /rest/v1/submissions  {"status":"approved", ...}   ->  201
--      GET  /public_entries?profile_name=ilike.*PROBE*         ->  the row
--
--  The row appeared in the live public archive immediately. Two test rows got
--  in this way during diagnosis and have been set to rejected, so the public
--  count is back to 27.
--
--  Also possible as anon today: setting your own ref_id, so a fabricated entry
--  can be given a reference number that looks like a real one.
--
--  What is NOT exposed: anon still cannot read the raw tables. Submitter
--  emails and pending reports are safe (401 on select, confirmed). The
--  privilege half of 001 applied correctly. It is the RLS half that did not.
--
--  Cause, confirmed by reading pg_policy rather than guessing: RLS was already
--  enabled and forced, and the correct policy from 001 was present. What 001
--  never did was REMOVE the policies that predated it:
--
--      anon_insert_submissions   insert   PUBLIC   with check (true)
--      anon_read_submissions     select   PUBLIC   using (true)
--      anon_update_submissions   update   PUBLIC   using (true)
--      anon_delete_submissions   delete   PUBLIC   using (true)
--      ... and the same shape on appeals and contact_messages
--
--  Policies are OR'd. A permissive `with check (true)` next to a careful policy
--  does not narrow anything, it simply wins. So every constraint 001 wrote was
--  dead on arrival for inserts.
--
--  Reads, updates and deletes were never actually exposed, because the GRANTs
--  were revoked and privileges are checked independently of policies. That is
--  also why all 16 of the old verify.sh probes passed: every one of them tested
--  a grant. The belt held while the braces were missing.
--
--  Why migrations/verify.sh reported "passed 16, failed 0" through all of
--  this: every one of its 16 probes tests a GRANT, never a POLICY. It checked
--  that anon cannot update, delete or select. It never checked that an insert
--  anon IS allowed to make is constrained. New probes are added at the bottom
--  of verify.sh to close that gap.
-- ============================================================================

begin;

-- ---------------------------------------------------------------------------
--  1. Remove the pre-lockdown policies, then put the right ones back
-- ---------------------------------------------------------------------------
-- These are the ones that were actually letting everything through.
drop policy if exists anon_insert_submissions on public.submissions;
drop policy if exists anon_read_submissions   on public.submissions;
drop policy if exists anon_update_submissions on public.submissions;
drop policy if exists anon_delete_submissions on public.submissions;
drop policy if exists anon_insert_appeals     on public.appeals;
drop policy if exists anon_read_appeals       on public.appeals;
drop policy if exists anon_update_appeals     on public.appeals;
drop policy if exists anon_delete_appeals     on public.appeals;
drop policy if exists "Allow public inserts"  on public.contact_messages;
drop policy if exists "Allow admin reads"     on public.contact_messages;

alter table public.submissions      enable row level security;
alter table public.submissions      force  row level security;
alter table public.appeals          enable row level security;
alter table public.appeals          force  row level security;
alter table public.contact_messages enable row level security;
alter table public.contact_messages force  row level security;

-- A submission from the public is always pending and always carries evidence.
-- ref_id is omitted from the allowed shape on purpose: it comes from the
-- sequence, so the policy refuses any insert that tries to choose one.
drop policy if exists submissions_anon_insert on public.submissions;
create policy submissions_anon_insert on public.submissions
  for insert to anon, authenticated
  with check (
    coalesce(status, 'pending') = 'pending'
    and screenshot_url is not null
    and length(trim(screenshot_url)) > 0
    and perpetrator_url is not null
    and source_post_url is not null
  );

drop policy if exists appeals_anon_insert on public.appeals;
create policy appeals_anon_insert on public.appeals
  for insert to anon, authenticated
  with check (
    coalesce(status, 'under_review') = 'under_review'
    and entry_id is not null
    and statement is not null
    and length(trim(statement)) > 0
  );

drop policy if exists contact_anon_insert on public.contact_messages;
create policy contact_anon_insert on public.contact_messages
  for insert to anon, authenticated
  with check (
    coalesce(status, 'unread') = 'unread'
    and name is not null and email is not null and message is not null
  );

-- The sequence owns ref_id. A WITH CHECK cannot express "this column must take
-- its default", so it is closed at the privilege level: anon may insert the
-- columns a submitter legitimately fills in and nothing else. ai_score and
-- severity are moderator fields the form never sends, so they are out too.
alter table public.submissions alter column ref_id set default public.next_submission_ref();

revoke insert on public.submissions from anon, authenticated;
grant insert (perpetrator_url, source_post_url, screenshot_url, profile_name,
              comment_text, category, incident_type, context_note, language,
              translation, tags, submitter_email, submitter_relationship, status)
  on public.submissions to anon, authenticated;

revoke insert on public.appeals from anon, authenticated;
grant insert (entry_id, grounds, statement, contact_email, status)
  on public.appeals to anon, authenticated;

commit;

-- ---------------------------------------------------------------------------
--  2. Give the submit and appeal forms their reference number back
-- ---------------------------------------------------------------------------
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
--
--  This migration also makes comment_text optional, which is a separate
--  decision and is explained where it happens, further down.
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
    nullif(trim(coalesce(p_comment_text, '')), ''), p_category, p_incident_type,
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

-- ---------------------------------------------------------------------------
--  The comment is no longer required
-- ---------------------------------------------------------------------------
--  001 made comment_text mandatory on new submissions. Dropping that:
--  a screenshot on its own is still a usable record, which is already true of
--  20 of the 27 entries published today. They predate the column, and the
--  archive renders them honestly as "this comment is in the screenshot only"
--  rather than pretending there is text to read.
--
--  The screenshot stays mandatory. That rule is the one that matters: nothing
--  is published without evidence, enforced here on insert and again by
--  submissions_approved_needs_evidence on approval (003).
--
--  The cost is searchability. An entry with no transcription cannot be found
--  by searching its words, only by profile and category. Worth typing when the
--  submitter can, which is what the form now says.
drop policy if exists submissions_anon_insert on public.submissions;
create policy submissions_anon_insert on public.submissions
  for insert to anon, authenticated
  with check (
    coalesce(status, 'pending') = 'pending'
    and screenshot_url is not null
    and length(trim(screenshot_url)) > 0
    and perpetrator_url is not null
    and source_post_url is not null
  );

comment on column public.submissions.comment_text is
  'The archived comment, verbatim, when the submitter transcribed it. Optional: an entry backed by a screenshot alone is valid, and the public archive shows those as screenshot-only.';

commit;

-- ---------------------------------------------------------------------------
--  Check it worked. Both should return a reference number, and anon should
--  still be unable to read either table.
-- ---------------------------------------------------------------------------
-- select public.submit_report(
--   'https://example.com/p','https://example.com/s','https://example.com/x.png',
--   'test.profile',null,'Victim Blaming','Cyber Harassment');  -- no comment: allowed
-- select public.file_appeal('DG-2025-0001','Other','test statement');

-- ---------------------------------------------------------------------------
--  3. Remove the rows that diagnosing this created
-- ---------------------------------------------------------------------------
--  Finding the hole meant writing rows through it. All of them are tagged, and
--  none name a real person. Two reached the live public archive and have
--  already been set to rejected, so the published count is back to 27.
--
--  Look before you delete. This counts first:
--
--      select status, profile_name, ref_id, created_at
--      from public.submissions
--      where profile_name like 'PROBE%' or profile_name like 'ANON-PROBE%'
--         or profile_name like 'VERIFY-PROBE%' or profile_name like 'DAAG-TEST%'
--      order by created_at;
--
--  Then, once the list looks like only test rows, delete them:

delete from public.submissions
 where profile_name like 'PROBE%'
    or profile_name like 'ANON-PROBE%'
    or profile_name like 'VERIFY-PROBE%'
    or profile_name like 'DAAG-TEST%';

delete from public.appeals
 where statement like '%PROBE%'
    or statement like '%Automated probe%'
    or entry_id = 'DG-0000-0000';

delete from public.contact_messages
 where email = 'probe@example.com'
    or message like '%Automated probe%';

-- The screenshots bucket also holds two throwaway uploads named probe-*.png.
-- Storage is not reachable from SQL; delete those in the Supabase dashboard
-- under Storage > screenshots, or leave them, they are 68-byte 1x1 images.

-- Expect approved = 27 afterwards.
-- select * from public.public_stats;
