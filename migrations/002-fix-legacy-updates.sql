-- ============================================================================
--  Daag · 002 · Let moderators edit the rows that predate 001
-- ============================================================================
--  Bug introduced by 001.
--
--  001 added two CHECK constraints with NOT VALID:
--
--      submissions_needs_evidence   screenshot_url is not null
--      submissions_needs_comment    comment_text   is not null
--
--  NOT VALID means "do not re-check the rows already in the table WHEN THE
--  CONSTRAINT IS CREATED". It does NOT mean "never check those rows again".
--  Postgres still evaluates the constraint on every UPDATE of a row, so the
--  47 rows that predate comment_text became permanently un-updatable:
--
--      ERROR: 23514 new row for relation "submissions"
--             violates check constraint "submissions_needs_comment"
--
--  That would have broken moderation outright. A moderator approving or
--  rejecting any of the existing entries in the admin panel would have hit
--  this and been unable to do their job.
--
--  The fix is to drop both table constraints. They were always redundant:
--  the RLS insert policy from 001 already refuses a public submission that
--  lacks a comment or a screenshot, and it only applies to new inserts, which
--  is exactly where the requirement belongs. Enforcement moves nowhere; it
--  simply stops being retroactive.
-- ============================================================================

begin;

alter table public.submissions drop constraint if exists submissions_needs_comment;
alter table public.submissions drop constraint if exists submissions_needs_evidence;

-- Same trap on the status constraint: it is satisfied by every existing row
-- today, but if a legacy row ever carried an unexpected status it would become
-- un-updatable in the same way. Validate it now so the situation is explicit
-- rather than latent.
alter table public.submissions validate constraint submissions_status_valid;

-- Belt and braces: make the requirement visible to anyone reading the schema,
-- without making it a constraint that can strand a row.
comment on column public.submissions.comment_text is
  'The archived comment, verbatim. Required on new submissions via the RLS insert policy submissions_anon_insert. Rows created before migration 001 predate this column and may be null.';

comment on column public.submissions.screenshot_url is
  'Public URL of the evidence screenshot. Required on new submissions via the RLS insert policy submissions_anon_insert.';

-- The empty strings that 001 was meant to tidy up. The old client wrote '' for
-- an untouched optional field instead of NULL, which made every "how many
-- submitters gave us an email" count read 47 when the true answer is 0.
update public.submissions
   set submitter_email = null
 where submitter_email is not null and trim(submitter_email) = '';

update public.submissions
   set submitter_relationship = null
 where submitter_relationship is not null and trim(submitter_relationship) = '';

update public.submissions
   set context_note = null
 where context_note is not null and trim(context_note) = '';

update public.submissions
   set translation = null
 where translation is not null and trim(translation) = '';

commit;

-- Expect: total 47, real_emails 0.
select count(*) as total,
       count(submitter_email)  as real_emails,
       count(comment_text)     as with_comment,
       count(screenshot_url)   as with_screenshot
from public.submissions;
