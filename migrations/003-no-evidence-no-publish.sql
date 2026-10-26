-- ============================================================================
--  Daag · 003 · No screenshot, no publication
-- ============================================================================
--  Gap left open after 002.
--
--  001 required a screenshot on INSERT, via the RLS policy. That stops the
--  public form from filing an evidence-free report, and it still does.
--
--  002 then dropped the table-level CHECK, because as a NOT VALID constraint it
--  was making every legacy row un-editable. Correct fix, but it left nothing
--  stopping a MODERATOR from approving a row that has no screenshot. Six such
--  rows are sitting in the queue right now: they predate the fix that makes a
--  failed upload fail the whole submission.
--
--  The rule belongs at publication, not at insertion. A report may EXIST
--  without evidence, because that is how those six got here and a moderator
--  still needs to be able to reject or edit them. It may not BECOME PUBLIC
--  without evidence.
--
--  Unlike 001 this constraint is validated immediately. That is safe: all 27
--  approved rows already carry a screenshot, so nothing is stranded, and a
--  pending row with no screenshot stays fully editable because the constraint
--  only applies once status = 'approved'.
-- ============================================================================

begin;

alter table public.submissions
  drop constraint if exists submissions_approved_needs_evidence;

alter table public.submissions
  add constraint submissions_approved_needs_evidence
  check (
    status <> 'approved'
    or (screenshot_url is not null and length(trim(screenshot_url)) > 0)
  );

comment on constraint submissions_approved_needs_evidence on public.submissions is
  'An entry cannot be approved without a screenshot. Reports may exist without one so moderators can reject or repair them, but they can never be published.';

-- Belt and braces. Even if a row somehow reaches approved without evidence,
-- the public never sees it: the archive reads only through this view.
drop view if exists public.public_entries;
create view public.public_entries as
  select
    ref_id, perpetrator_url, source_post_url, screenshot_url, profile_name,
    comment_text, category, incident_type, context_note, language, translation,
    tags, severity, version, last_edit, created_at
  from public.submissions
  where status = 'approved'
    and screenshot_url is not null
    and length(trim(screenshot_url)) > 0;

grant select on public.public_entries to anon, authenticated;

-- Keep the published count honest about the same rule.
drop view if exists public.public_stats;
create view public.public_stats as
  select
    count(*) filter (
      where status = 'approved'
        and screenshot_url is not null
        and length(trim(screenshot_url)) > 0
    ) as approved,
    count(*) filter (where status = 'pending')  as pending,
    count(distinct profile_name) filter (
      where status = 'approved'
        and screenshot_url is not null
        and length(trim(screenshot_url)) > 0
    ) as profiles,
    (select count(*) from public.appeals where status = 'under_review') as open_appeals
  from public.submissions;

grant select on public.public_stats to anon, authenticated;

commit;

-- How many reports can never be published as they stand.
select count(*) as pending_without_evidence
from public.submissions
where status = 'pending'
  and (screenshot_url is null or length(trim(screenshot_url)) = 0);
