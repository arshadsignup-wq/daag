-- ============================================================================
--  Daag · 001 · Lock down the archive
-- ============================================================================
--  BEFORE THIS MIGRATION the anon key (which is published in the page source)
--  could UPDATE and DELETE every row in every table, read unapproved entries,
--  and read every submitter's email address. Verified against the live project:
--
--      submissions       UPDATE=204  DELETE=204
--      appeals           UPDATE=204  DELETE=204
--      contact_messages  UPDATE=204  DELETE=204
--
--  After this migration anon can do exactly one thing per table: insert a new
--  pending report. Everything the public reads comes from a view that cannot
--  expose an unapproved row or a submitter's identity.
--
--  Run in the Supabase SQL editor. It is written to be re-runnable.
-- ============================================================================

begin;

-- ---------------------------------------------------------------------------
-- 1 · Who counts as an admin
-- ---------------------------------------------------------------------------
-- Admins are real Supabase Auth users. There is no shared password any more.

create table if not exists public.admin_users (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  email      text not null,
  role       text not null default 'moderator'
             check (role in ('moderator','admin')),
  created_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;

-- is_admin() is called from inside RLS policies on other tables, so it must be
-- SECURITY DEFINER: a moderator cannot read admin_users directly, but policies
-- evaluated on their behalf still need to look the answer up.
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select exists (select 1 from public.admin_users where user_id = auth.uid());
$$;

revoke all on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;

drop policy if exists admin_users_self_read on public.admin_users;
create policy admin_users_self_read on public.admin_users
  for select to authenticated
  using (user_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 2 · Server-generated reference numbers
-- ---------------------------------------------------------------------------
-- The client used to build these as 'DG-2025-' || random(1000..9999) against a
-- UNIQUE column. Collisions were already running at a few percent and threw an
-- error the client swallowed, so the submitter saw a success screen for a
-- report that was never stored. The database owns the number now.

create sequence if not exists public.submission_ref_seq start 1000;
create sequence if not exists public.appeal_ref_seq     start 1000;

create or replace function public.next_submission_ref()
returns text language sql volatile as $$
  select 'DG-' || to_char(now() at time zone 'Asia/Dhaka', 'YYYY')
              || '-' || lpad(nextval('public.submission_ref_seq')::text, 4, '0');
$$;

create or replace function public.next_appeal_ref()
returns text language sql volatile as $$
  select 'AP-' || to_char(now() at time zone 'Asia/Dhaka', 'YYYY')
              || '-' || lpad(nextval('public.appeal_ref_seq')::text, 4, '0');
$$;

-- Start the sequence past anything already in the table so we never collide
-- with the rows that are in there from the old client-side scheme.
select setval('public.submission_ref_seq',
  greatest(1000, coalesce((select max(nullif(regexp_replace(ref_id,'\D','','g'),'')::bigint % 10000)
                           from public.submissions), 0) + 1));

alter table public.submissions alter column ref_id set default public.next_submission_ref();
alter table public.appeals     alter column ref_id set default public.next_appeal_ref();

-- ---------------------------------------------------------------------------
-- 3 · Evidence is required, not optional
-- ---------------------------------------------------------------------------
-- The form demanded a screenshot; the database accepted rows without one
-- because the client ignored a failed upload. Enforce it where it counts.
-- NOT VALID so existing rows are left alone; new rows must comply.

alter table public.submissions drop constraint if exists submissions_needs_evidence;
alter table public.submissions add constraint submissions_needs_evidence
  check (screenshot_url is not null and length(trim(screenshot_url)) > 0) not valid;

alter table public.submissions drop constraint if exists submissions_status_valid;
alter table public.submissions add constraint submissions_status_valid
  check (status in ('pending','approved','rejected','hold')) not valid;

-- ---------------------------------------------------------------------------
-- 3b · The archived comment itself
-- ---------------------------------------------------------------------------
-- The table had no column for the quote. context_note described the situation
-- and translation held an English rendering, but the sentence the person
-- actually wrote was never stored, which is why the archive could only show
-- auto-generated headlines like "Verified case of Victim Blaming related to
-- Rape". The entire point of the site is this column.

alter table public.submissions add column if not exists comment_text text;

comment on column public.submissions.comment_text is
  'The archived comment, verbatim, in the language it was posted in. This is what the archive exists to publish.';

-- Required going forward; the rows already in the table predate the column.
alter table public.submissions drop constraint if exists submissions_needs_comment;
alter table public.submissions add constraint submissions_needs_comment
  check (comment_text is not null and length(trim(comment_text)) > 0) not valid;

-- ---------------------------------------------------------------------------
-- 4 · submissions · RLS
-- ---------------------------------------------------------------------------
alter table public.submissions enable row level security;
alter table public.submissions force row level security;

drop policy if exists "anon read approved"      on public.submissions;
drop policy if exists "public read"             on public.submissions;
drop policy if exists "anon insert"             on public.submissions;
drop policy if exists "anon update"             on public.submissions;
drop policy if exists "anon delete"             on public.submissions;
drop policy if exists "Enable read access for all users"    on public.submissions;
drop policy if exists "Enable insert for all users"         on public.submissions;
drop policy if exists "Enable update for all users"         on public.submissions;
drop policy if exists "Enable delete for all users"         on public.submissions;
drop policy if exists submissions_anon_insert   on public.submissions;
drop policy if exists submissions_admin_all     on public.submissions;

-- The public may file a report. It lands pending, and that is all they can do:
-- no SELECT policy for anon exists, so they cannot read back even their own row.
create policy submissions_anon_insert on public.submissions
  for insert to anon, authenticated
  with check (
    coalesce(status, 'pending') = 'pending'
    and screenshot_url is not null
    and comment_text is not null
    and perpetrator_url is not null
    and source_post_url is not null
  );

create policy submissions_admin_all on public.submissions
  for all to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- ---------------------------------------------------------------------------
-- 5 · appeals · RLS
-- ---------------------------------------------------------------------------
alter table public.appeals enable row level security;
alter table public.appeals force row level security;

drop policy if exists "anon read"   on public.appeals;
drop policy if exists "anon insert" on public.appeals;
drop policy if exists "anon update" on public.appeals;
drop policy if exists "anon delete" on public.appeals;
drop policy if exists "Enable read access for all users" on public.appeals;
drop policy if exists appeals_anon_insert on public.appeals;
drop policy if exists appeals_admin_all   on public.appeals;

create policy appeals_anon_insert on public.appeals
  for insert to anon, authenticated
  with check (coalesce(status,'under_review') = 'under_review');

create policy appeals_admin_all on public.appeals
  for all to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- ---------------------------------------------------------------------------
-- 6 · contact_messages · RLS
-- ---------------------------------------------------------------------------
create table if not exists public.contact_messages (
  id         uuid primary key default gen_random_uuid(),
  name       text,
  email      text,
  subject    text,
  message    text not null,
  created_at timestamptz not null default now()
);

alter table public.contact_messages enable row level security;
alter table public.contact_messages force row level security;

drop policy if exists "anon read"   on public.contact_messages;
drop policy if exists "anon insert" on public.contact_messages;
drop policy if exists "Enable read access for all users" on public.contact_messages;
drop policy if exists contact_anon_insert on public.contact_messages;
drop policy if exists contact_admin_all   on public.contact_messages;

create policy contact_anon_insert on public.contact_messages
  for insert to anon, authenticated with check (true);

create policy contact_admin_all on public.contact_messages
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- ---------------------------------------------------------------------------
-- 7 · What the public is actually allowed to see
-- ---------------------------------------------------------------------------
-- A plain (security definer) view. It filters to approved rows and simply does
-- not select the identity columns, so there is no column-level mistake to make
-- on the client. The site reads from this and never from `submissions`.

drop view if exists public.public_entries;
create view public.public_entries as
  select
    ref_id,
    perpetrator_url,
    source_post_url,
    screenshot_url,
    profile_name,
    comment_text,
    category,
    incident_type,
    context_note,
    language,
    translation,
    tags,
    severity,
    version,
    last_edit,
    created_at
  from public.submissions
  where status = 'approved';

-- Appeal outcomes are public; the appellant's email and the reviewer's private
-- notes are not.
drop view if exists public.public_appeals;
create view public.public_appeals as
  select ref_id, entry_id, grounds, status, created_at
  from public.appeals;

-- Counts the homepage needs without handing out rows.
drop view if exists public.public_stats;
create view public.public_stats as
  select
    count(*) filter (where status = 'approved')                    as approved,
    count(*) filter (where status = 'pending')                     as pending,
    count(distinct profile_name) filter (where status = 'approved') as profiles,
    (select count(*) from public.appeals where status = 'under_review') as open_appeals
  from public.submissions;

revoke all on public.submissions, public.appeals, public.contact_messages from anon;
grant insert on public.submissions, public.appeals, public.contact_messages to anon, authenticated;
grant select on public.public_entries, public.public_appeals, public.public_stats to anon, authenticated;

-- ---------------------------------------------------------------------------
-- 7b · Letting a submitter check on their own report
-- ---------------------------------------------------------------------------
-- The site hands people a reference number and then gives them nowhere to use
-- it. anon has no SELECT on submissions and must not get one, so expose the
-- single fact they are entitled to: the status of a reference they already
-- hold. No content, no identities, nothing enumerable (the refs are sequential,
-- but all a guess returns is a word that is already implied by the archive).

create or replace function public.submission_status(p_ref text)
returns table (ref_id text, status text, created_at timestamptz, last_edit timestamptz)
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select s.ref_id, s.status, s.created_at, s.last_edit
  from public.submissions s
  where upper(s.ref_id) = upper(trim(p_ref))
  limit 1;
$$;

revoke all on function public.submission_status(text) from public;
grant execute on function public.submission_status(text) to anon, authenticated;

-- ---------------------------------------------------------------------------
-- 8 · Moderation audit log
-- ---------------------------------------------------------------------------
-- Without this there is no way to prove an entry was not tampered with, and no
-- way to tell which moderator approved what.

create table if not exists public.moderation_log (
  id         bigserial primary key,
  ref_id     text not null,
  actor      uuid references auth.users(id),
  actor_email text,
  action     text not null,
  old_status text,
  new_status text,
  note       text,
  created_at timestamptz not null default now()
);

alter table public.moderation_log enable row level security;

drop policy if exists moderation_log_admin_read on public.moderation_log;
create policy moderation_log_admin_read on public.moderation_log
  for select to authenticated using (public.is_admin());

-- Writes come from the trigger only; nobody inserts here by hand.
create or replace function public.log_moderation()
returns trigger
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  if tg_op = 'UPDATE' and old.status is distinct from new.status then
    insert into public.moderation_log(ref_id, actor, actor_email, action, old_status, new_status)
    values (new.ref_id, auth.uid(),
            (select email from public.admin_users where user_id = auth.uid()),
            'status_change', old.status, new.status);
  elsif tg_op = 'DELETE' then
    insert into public.moderation_log(ref_id, actor, actor_email, action, old_status, new_status)
    values (old.ref_id, auth.uid(),
            (select email from public.admin_users where user_id = auth.uid()),
            'delete', old.status, null);
  end if;
  return coalesce(new, old);
end;
$$;

drop trigger if exists trg_log_moderation on public.submissions;
create trigger trg_log_moderation
  after update or delete on public.submissions
  for each row execute function public.log_moderation();

-- ---------------------------------------------------------------------------
-- 9 · Evidence bucket
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('screenshots','screenshots', true, 8388608,
        array['image/png','image/jpeg','image/webp','image/gif'])
on conflict (id) do update
  set public = true,
      file_size_limit = 8388608,
      allowed_mime_types = array['image/png','image/jpeg','image/webp','image/gif'];

drop policy if exists "screenshots public read"   on storage.objects;
drop policy if exists "screenshots anon upload"   on storage.objects;
drop policy if exists "screenshots admin manage"  on storage.objects;

create policy "screenshots public read" on storage.objects
  for select using (bucket_id = 'screenshots');

-- Anyone may add evidence; nobody but an admin may overwrite or remove it.
create policy "screenshots anon upload" on storage.objects
  for insert to anon, authenticated
  with check (bucket_id = 'screenshots');

create policy "screenshots admin manage" on storage.objects
  for all to authenticated
  using (bucket_id = 'screenshots' and public.is_admin())
  with check (bucket_id = 'screenshots' and public.is_admin());

commit;

-- ============================================================================
--  AFTER RUNNING THIS
-- ============================================================================
--  1. Create your admin user in Authentication > Users (email + password),
--     then register them:
--
--        insert into public.admin_users (user_id, email, role)
--        select id, email, 'admin' from auth.users where email = 'you@example.com';
--
--  2. Backfill comment_text on the 25 existing rows. Until you do, those
--     entries show their context note instead of the quote:
--
--        update public.submissions set comment_text = <the archived comment>
--        where ref_id = 'DG-...';
--
--  3. Decide what happens to submitter_email on the 27 existing rows. If they
--     are seed data, clear them:
--
--        update public.submissions set submitter_email = null;
--
--     If any are real, they are already compromised: the column was world
--     readable. Those people should be told.
--
--  4. Re-run the probe to confirm the hole is closed. Expect 401/403, not 204:
--
--        curl -s -o /dev/null -w "%{http_code}\n" -X DELETE \
--          "$SUPABASE_URL/rest/v1/submissions?id=eq.00000000-0000-0000-0000-000000000000" \
--          -H "apikey: $ANON_KEY" -H "Authorization: Bearer $ANON_KEY"
--
--  5. Rotate the anon key in Supabase (Settings > API) and paste the new one
--     into index.html and admin.html. The old key is in your git history and in
--     every browser cache that has loaded the site.
-- ============================================================================
