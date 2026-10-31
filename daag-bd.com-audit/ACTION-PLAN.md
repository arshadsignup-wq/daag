# daag-bd.com — action plan

Everything in Phase 1 is **already done and pushed**. The rest is yours to
decide on; nothing below has been implemented.

## Phase 1 — Critical & High (done 2026-11-01)

| # | Fix | Where |
|---|---|---|
| 1 | Hero visible and tappable below 1024px | `.lede{position:relative}` + `.board>.lede{left:auto;top:auto}` |
| 2 | No horizontal scroll 740–880px | nav breakpoint 720 → 900 |
| 3 | An `h1` on every route | ten `h2.section-title` promoted |
| 4 | Correct section active per URL | `prerender.py`, `build-blog.py` |
| 5 | `BreadcrumbList` on posts | `build-blog.py` |
| 6 | Truthful `<noscript>` | `index.html` |
| 7 | Two dark-mode AA failures | `.skip-link`, dark `--umber` |
| 8 | Chart fits 320px | `@media(max-width:360px)` |

## Phase 2 — worth doing, needs a decision

**Decide whether non-rendering crawlers should see per-page text.**
Today every generated file contains all eleven sections, so a CSS-blind
extractor reads the homepage at the ten route URLs. Three options:

- **A. Leave it.** Google renders JS and CSS, so Google is fine. Social and
  retrieval crawlers are not. Zero work, zero risk.
- **B. Strip non-active sections per file** and have the router fetch a page it
  does not have. Correct, and the biggest change: it turns the SPA into a
  multi-page app with client-side enhancement.
- **C. Ship a `.md` sibling per route** (`/about.md`). `agentic_check.py` flags
  the absence already, it is additive, and it gives retrieval crawlers clean
  per-page text without touching the SPA. **Recommended** — most of the benefit
  for a fraction of B's risk.

**Get Core Web Vitals.** Configure a Google API key
(`claude-seo run google_auth.py --check` shows the tiers). Until then
performance is genuinely unmeasured, not merely unreported.

**Decide on the `FAQPage` block** now shipping in 19 of 21 files. Scoping it to
`/about` means stripping it per-route in `prerender.py`.

## Phase 3 — small, safe, unglamorous

- Make the homepage canonical `https://www.daag-bd.com/` so it matches the
  sitemap exactly.
- `preconnect` to `https://fonts.gstatic.com`. Only `fonts.googleapis.com` is
  preconnected today, and the font files come from gstatic — a full connection
  setup sits on the critical path. One line, measurable win.
- `fetchpriority="high"` on the LCP element (`preload_check.py` scores 50/100
  and names this).
- Consider `llms-full.txt` (currently 404).

## Phase 4 — standing

- Re-run `bash migrations/verify.sh` after any schema change (19/19 today).
- Re-run `python3 tools/build-blog.py && python3 tools/prerender.py` after any
  `index.html` edit — **in that order**; build-blog rewrites the blog listing
  inside `index.html`, so running prerender first ships a stale listing.
- Re-run the contrast sweep after any palette change, and **assert the theme
  attribute actually stuck**: an earlier version of that sweep reported 0
  failures across 48 combinations because `applyLang()` reset the theme and
  every run silently tested light mode.
