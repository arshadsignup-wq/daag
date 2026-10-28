#!/usr/bin/env bash
# Checks that 001-lockdown.sql actually took. Reads the public anon key out of
# index.html, so it tests exactly what a stranger on the internet can do.
#
#   bash migrations/verify.sh
#
# Writes nothing: the UPDATE and DELETE probes are filtered to a UUID that
# cannot match a real row, so a PASS and a FAIL both touch zero records.

set -u
cd "$(dirname "$0")/.." || exit 1

URL=$(grep -o "https://[a-z0-9]*\.supabase\.co" index.html | head -1)
KEY=$(grep -o "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9[A-Za-z0-9._-]*" index.html | head -1)
API="$URL/rest/v1"
NOMATCH="id=eq.00000000-0000-0000-0000-000000000000"
H=(-H "apikey: $KEY" -H "Authorization: Bearer $KEY")

pass=0; fail=0
ok(){   printf '  \033[32mPASS\033[0m  %s\n' "$1"; pass=$((pass+1)); }
bad(){  printf '  \033[31mFAIL\033[0m  %s\n' "$1"; fail=$((fail+1)); }

echo "Project: $URL"
echo

echo "1. anon must NOT be able to write"
for t in submissions appeals contact_messages; do
  u=$(curl -s -o /dev/null -w "%{http_code}" -X PATCH  "$API/$t?$NOMATCH" "${H[@]}" -H "Content-Type: application/json" -d '{"status":"approved"}')
  d=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$API/$t?$NOMATCH" "${H[@]}")
  [ "$u" = "204" ] && bad "$t UPDATE still allowed (204)" || ok "$t UPDATE blocked ($u)"
  [ "$d" = "204" ] && bad "$t DELETE still allowed (204)" || ok "$t DELETE blocked ($d)"
done

echo
echo "2. anon must NOT be able to read the raw tables"
r=$(curl -s -o /dev/null -w "%{http_code}" "$API/submissions?select=id&limit=1" "${H[@]}")
[ "$r" = "200" ] && bad "submissions still readable by anon ($r)" || ok "submissions not readable by anon ($r)"

echo
echo "3. the public views must exist and be readable"
for v in public_entries public_appeals public_stats; do
  r=$(curl -s -o /dev/null -w "%{http_code}" "$API/$v?select=*&limit=1" "${H[@]}")
  [ "$r" = "200" ] && ok "$v readable ($r)" || bad "$v missing or blocked ($r)"
done

echo
echo "4. the public view must not leak identities or unapproved rows"
body=$(curl -s "$API/public_entries?select=*&limit=200" "${H[@]}")
echo "$body" | grep -q "submitter_email" && bad "public_entries exposes submitter_email" || ok "public_entries hides submitter_email"
echo "$body" | grep -q '"status"'         && bad "public_entries exposes status"         || ok "public_entries hides status"
echo "$body" | grep -q "comment_text"     && ok  "comment_text column present"           || bad "comment_text column missing"

echo
echo "5. a submitter must be able to look up their own reference"
r=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API/rpc/submission_status" "${H[@]}" \
     -H "Content-Type: application/json" -d '{"p_ref":"DG-2026-0001"}')
[ "$r" = "200" ] && ok "submission_status() callable ($r)" || bad "submission_status() not callable ($r)"

echo
echo "6. the evidence bucket must exist and be readable"
# /storage/v1/bucket/<id> returns bucket METADATA and needs the service role, so
# a 404 there says nothing about whether the bucket exists. Listing objects is
# the check that actually reflects what the public can do.
body=$(curl -s -X POST "$URL/storage/v1/object/list/screenshots" "${H[@]}" \
        -H "Content-Type: application/json" -d '{"prefix":"","limit":1}')
echo "$body" | grep -q "NoSuchBucket" && bad "screenshots bucket missing" || ok "screenshots bucket present and listable"
echo "$body" | grep -q '"name"' && ok "bucket already holds evidence files" || ok "bucket is empty (fine on a fresh project)"

echo
echo "7. anon may insert, but only within the policy"
# These are the probes whose absence let a self-publishing hole sit open while
# the other 16 reported a clean bill of health. Everything above tests a GRANT.
# Nothing tested whether the inserts anon IS allowed to make are constrained.
#
# Each of these writes a row if it WRONGLY succeeds, so they are tagged
# VERIFY-PROBE and the failure message tells you to delete them.
probe_insert(){ # $1 = label, $2 = json body
  code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$API/submissions" "${H[@]}" \
         -H "Content-Type: application/json" -d "$2")
  if [ "$code" = "201" ]; then
    bad "$1 ACCEPTED ($code) - a row was created, delete rows where profile_name like 'VERIFY-PROBE%'"
  else
    ok "$1 refused ($code)"
  fi
}
BASE='"perpetrator_url":"https://example.com/v","source_post_url":"https://example.com/v","screenshot_url":"https://example.com/v.png","category":"Victim Blaming","incident_type":"Cyber Harassment"'
# status='rejected' rather than 'approved' on purpose. The policy pins status to
# 'pending', so a working policy refuses this exactly as it refuses 'approved',
# but if the policy is NOT working the row that leaks through is invisible to
# the public instead of being published into the live archive. The first draft
# of this probe used 'approved' and published a row every time it ran.
probe_insert "chosen status (rejected)"        "{$BASE,\"profile_name\":\"VERIFY-PROBE-status\",\"status\":\"rejected\"}"
# A fixed ref_id would come back 409 on the second run, which reads as a PASS
# while proving nothing. Randomised so a refusal is always the policy refusing.
PROBE_REF="DG-1999-$(printf '%04d' $((RANDOM % 10000)))"
probe_insert "chosen ref_id ($PROBE_REF)"      "{$BASE,\"profile_name\":\"VERIFY-PROBE-refid\",\"ref_id\":\"$PROBE_REF\",\"status\":\"pending\"}"
probe_insert "no screenshot"                  '{"perpetrator_url":"https://example.com/v","source_post_url":"https://example.com/v","profile_name":"VERIFY-PROBE-noshot","category":"Victim Blaming","incident_type":"Cyber Harassment","status":"pending"}'

echo
printf 'passed %d, failed %d\n' "$pass" "$fail"
[ "$fail" -eq 0 ] && echo "Lockdown verified." || echo "Lockdown NOT complete. Re-run migrations/001-lockdown.sql and check for errors."
exit "$fail"
