# Daag (দাগ) — daag-bd.com

A public archive of misogynistic and victim-blaming comments posted under
Bangladeshi news about gender violence. Every entry is a real comment by a real,
named person, with a screenshot. Treat it accordingly: this is a record people's
reputations hang on, and a record the people in it have reason to attack.

## The rule that matters most

**Never tell anyone something happened when it did not.**

Most of the serious bugs found in this codebase were variants of one mistake:

- the contact, submit and appeal forms each showed a success screen when the
  database was unreachable, two of them inventing a `DEMO-xxxx` reference;
- the appeal tracker answered *any* well-formed `AP-` reference with "Under
  Review … an independent moderation panel … 14 working days", including
  references that never existed;
- the archive footer reported the fetched page size as the published total.

If a write fails, say so. If a lookup finds nothing, say nothing was found. If a
number is not known, do not print a number. The same applies to anything written
*about* the archive — never generate a headline, a quote, a reference number or a
statistic. Fetch it, or leave it out.

## Shape

Single-file static site. No build step, no framework.

| Path | What it is |
|---|---|
| `index.html` | the entire public site (~345 KB): markup, CSS, JS, the Bengali dictionary |
| `admin.html` | moderation panel, gated by Supabase Auth |
| `404.html` | a real 404 page, with its own copy of the palette |
| `vercel.json` | per-route rewrites + security headers |
| `api/analytics.js` | Vercel function, GA4 reporting for the admin panel |
| `migrations/*.sql` | the database schema, applied by hand in the Supabase SQL editor |
| `migrations/verify.sh` | 16 probes against the live DB as an anonymous stranger |
| `tools/` | build scripts, never served (see `.vercelignore`) |

Deploys are automatic from GitHub `main`.

## Routing

`pages[]` in `index.html` lists every route. A route needs **four** things or it
breaks in a way that is invisible locally:

1. an entry in `pages[]`
2. an entry in `PAGE_META` (title + description; applied by JS on navigation)
3. a rewrite in `vercel.json` — without it the URL returns **404** in production
   even though the SPA renders fine after a client-side click
4. a `<loc>` in `sitemap.xml`

Known limitation, raised with the user and deferred: all routes serve the same
HTML, so per-route `<title>`/`og:` tags are applied by JavaScript. Google renders
JS and sees them; Facebook and WhatsApp do not, so every shared link previews as
the homepage. Fixing it means pre-rendering one file per route.

## Bengali and i18n

Bengali is the default and the primary audience. English is the fallback.

- **The markup is the English source of truth.** `EN_CACHE` captures it from the
  DOM on first `applyLang()`. The `BN{}` dictionary (~500 keys) holds Bengali.
- `applyLang()` sets `el.innerHTML = translation`. **So `data-i18n` must sit on
  the leaf element that holds only text.** Putting it on a parent destroys the
  children — this is exactly how all four nav icons vanished in Bengali while
  surviving in English (English survived only because `EN_CACHE` had captured
  the `<svg>` as part of the innerHTML).
- Attribute variants: `data-i18n-ph` → `BN['ph:' + key]`, `data-i18n-aria` →
  `ARIA_BN`, `data-vocab` → `tv()`.
- Dynamic strings use `t('key', 'English fallback', {vars})`. Every `t()` key
  needs a `BN` entry or a Bengali reader gets English.
- Numbers shown to readers go through `bnNum()`. Reference numbers (`DG-2026-…`),
  phone numbers and URLs stay in Latin digits.
- `currentLang()` reads the `data-lang` attribute off `<html>`, not
  localStorage, so it can never disagree with the markup `applyLang()` just set.

### Editing Bengali text

`sed` fails on these byte sequences on macOS (`RE error: illegal byte sequence`)
and leaves a truncated `.!NNNNN!index.html` behind. **Use Python**, and normalise:
the file stores য় precomposed (U+09DF) while typed text decomposes to
U+09AF+U+09BC, so a literal string match silently finds nothing. Normalise both
sides with `unicodedata.normalize('NFC', …)` and assert the match count before
writing.

Typography: never negative letter-spacing on Bengali; display leading ≥ 1.3.
Baloo Da 2 covers Bengali — Poppins does not.

## Design

The look is a corkboard: pinned paper, red thread, warm paper palette. The user
specified it precisely and asked twice for exact replication. **Do not restyle on
your own initiative.** Fixing an accessibility defect is fine, but say plainly
what changed visually so they can veto it.

Theming is CSS custom properties on `:root` and `html[data-theme="dark"]`.
Several components carry their own literal colours instead of tokens — the
corkboard, the helpline band, the footer — so a token change does not reach them.

Note `.pin` and `.who` keep a white paper background in dark mode **on purpose**
(they are photographs of pinned paper). Dark-mode overrides must not touch them.

### Auditing contrast

The in-browser audit used throughout this project had two blind spots that each
hid a real failure for a whole pass:

- giving up when any ancestor painted a `background-image` — which excluded every
  section carrying the SVG noise texture, and hid an entire stepper running at
  1.89:1 in dark mode;
- ignoring text nodes shorter than three characters — which is exactly what a
  step number is, and hid one at 1.91:1 in light mode.

A correct audit composites translucent layers onto an opaque base, treats
near-transparent SVG noise as see-through, counts short labels, and skips only
the hero (which sits on a genuine dark wood texture). The site currently passes
AA across every page × both themes × both languages.

## Database

Supabase. The public site reads only through `public_entries`, `public_appeals`
and `public_stats` — never the base tables, which `anon` cannot read.

Invariants worth not breaking:

- an entry cannot be `approved` without a screenshot (constraint + the view
  filters on it again);
- `ref_id` comes from a database sequence, never `Math.random()`;
- `moderation_log` records every status change.

Run `bash migrations/verify.sh` after any schema change. It reads the anon key
out of `index.html` and tests what a stranger on the internet can actually do;
its writes are filtered to a UUID that matches nothing, so a pass and a fail both
touch zero rows. It should report **passed 16, failed 0**.

## Gotchas that have already cost time

- `.gitignore` has a blanket `*.json`. Any JSON that must be committed needs an
  explicit `!` exception — this is why `vercel.json` nearly never shipped.
- A Google Cloud **service-account private key** sits untracked in the repo root.
  It is covered by `.gitignore` *and* `.vercelignore`; keep it that way.
- `.vercelignore` is what stops `design-directions/` reaching production. Twelve
  of those prototypes contain **fabricated** archive entries with invented quotes
  and invented `DG-2026-xxxx` reference numbers.
- When splitting `index.html` to syntax-check the JS, extracted IIFEs need
  explicit semicolons or ASI parses `})()\n(function(){` as a call and the board
  silently dies at load.
- Verify claims about the live database empirically before stating them. An
  earlier "47 submitter emails exposed" was wrong — the column held empty
  strings, and nobody's email was ever leaked.
