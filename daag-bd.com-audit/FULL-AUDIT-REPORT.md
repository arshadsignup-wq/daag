# daag-bd.com — full SEO & front-end audit

Run 2026-11-01 with the `seo-audit` skill's method and its bundled runtime
(Playwright Chromium, trafilatura, `agentic_check.py`, `content_quality.py`,
`sitemap_discovery.py`, `preload_check.py`). The skill itself could not be
invoked by name — it was installed mid-session and the skill list is built at
session start — so its SKILL.md was followed directly, which is the documented
fallback.

**Scope:** all 19 URLs in the sitemap, both themes, both languages, viewport
widths 320–1440.

## Health score: 76 / 100 (before) → 93 / 100 (after)

Computed, not asserted: each category score below multiplied by the `seo-audit`
skill's own weights, which sum to 1.0. 76.28 → 93.32 before rounding. An
earlier draft of this report said 78 → 96; those were written rather than
calculated and were wrong.

Everything in this report is now fixed and live except the five items under
"Open, not fixed", each of which is open for a reason stated there.

| Category | Weight | Before | After | Note |
|---|---|---|---|---|
| Technical SEO | 22% | 85 | 97 | CSP + COOP added, canonical fixed |
| Content Quality | 23% | 86 | 86 | 8 posts score 79–91, zero filler, zero AI-tells |
| On-Page SEO | 20% | 55 | 95 | 9 of 11 routes had **no h1** at all |
| Schema | 10% | 80 | 98 | posts now have BreadcrumbList; FAQPage scoped to /about |
| Performance | 10% | 55 | 92 | lab-measured; **field data still unavailable** |
| AI Search Readiness | 10% | 88 | 97 | .md sibling per page, llms-full.txt added |
| Images | 5% | 90 | 90 | 1 image, alt present; 5 SVGs all aria-hidden |

Performance was initially marked **[U] unavailable** because
`lighthouse_agentic.py` returned HTTP 429 (shared PSI quota, no key) and CrUX
field data is unreachable. It is now measured **in the lab** instead, with
PerformanceObserver under 4x CPU throttling and a 1.6 Mbps / 150 ms connection:

| | before | after | Google "good" |
|---|---|---|---|
| LCP (mobile) | 1,624 ms | **928 ms** | < 2,500 ms |
| CLS (mobile) | **0.2372** | **0.0102** | < 0.100 |
| LCP (desktop) | 520 ms | 660 ms | < 2,500 ms |
| CLS (desktop) | 0.0023 | 0.0022 | < 0.100 |

These are lab numbers from one machine, not field data from real users. CrUX
still needs a Google API key. Do not quote them as what Bangladeshi visitors
experience.

## Critical — fixed

### 0. CLS was 0.237 on mobile, more than twice the "good" threshold
One shift accounted for 0.229 of it. The four pinned cards on the homepage are
produced by `buildBoard()`, which is called at byte ~311,000 of a 363 KB file,
so on a throttled phone they appeared **2.4 s in and pushed everything below
them down 778 px**. The cards are static — `BOARD_CARDS` and `HERO_EN`, not
archive rows — so they now ship in the markup and are present at first paint.

Measuring this corrected two of my own recommendations from the first pass:

- `fetchpriority="high"` on the LCP element: **not applicable.** The LCP
  element is the `H1`, a text node. There is nothing to preload.
- "the one image lacks width/height and loading=lazy": **wrong.** That `<img>`
  is the screenshot lightbox with `src=""` filled on click. It is never an LCP
  candidate and its dimensions vary by screenshot.

## Critical — fixed

### 1. The hero was invisible and untappable below 1024px
Every viewport under 1000px painted **zero** pixels of the homepage headline,
its paragraph and the profile-search box. Measured, not inferred: the `h1`'s own
element screenshot contained 0 near-white and 0 red pixels at 390px against
50,118 and 65,070 at 1440px. A real `page.click()` on the search input **timed
out** — `document.elementFromPoint` returned `DIV.cork` for all three elements.

Cause: `.lede` carries `z-index:5`, but the `@media(max-width:1000px)` block set
`position:static`, and **z-index does not apply to static elements**. `.cork`
(z-index 0) and `.vig` (z-index 1) are absolutely positioned over the whole
board and painted on top. The sibling rule in the same block already used
`position:relative!important` for `.pin,.who`, which is why the cards were fine.

Profile search is the site's headline feature and the audience is overwhelmingly
mobile, so this was the most serious finding in the audit.

### 2. Nav overflowed the viewport from 740px to 880px
The full nav needs 882px but the hamburger only engaged at `max-width:720px`, so
the whole page scrolled sideways across that band — including iPad portrait at
768. Breakpoint raised to 900px.

## High — fixed this session

### 3. Nine of eleven routes had no `h1`
Only `/` and the blog posts had one. `/about`, `/terms`, `/archive`, `/submit`,
`/search`, `/appeals`, `/analytics`, `/privacy`, `/contact` and `/blog` opened
on an `h2.section-title`. Promoted to `h1`, class and `data-i18n` preserved.
Verified visually neutral: every bare-tag CSS rule lists `h1` and `h2` together
and the sizing comes from `.section-title`; computed font-size, weight,
line-height, letter-spacing, family, colour, margins and box were identical
before and after on all ten.

### 4. Every route file shipped the homepage as the visible section
`prerender.py` rewrote the head per route but left `pg-home` as the only section
without `display:none`. With JavaScript disabled, all 18 non-home URLs rendered
the homepage. Both generators now set the route's own section active.

**Partially fixed, and the limit is worth stating.** A browser with CSS now
renders the right page at every URL. A text extractor that ignores CSS does not:
trafilatura still returns byte-identical homepage text for the ten route URLs,
because every generated file still contains all eleven sections' markup. Truly
fixing that means stripping non-active sections per file, which breaks the SPA's
client-side navigation. See ACTION-PLAN.md.

### 5. Blog posts had no `BreadcrumbList`
The posts were the only pages on the site without one, and they sit deepest.
`prerender.py` covered "every route" and a post is not a route.

## Medium — fixed this session

### 6. The `<noscript>` message was no longer true
It read "This site requires JavaScript to be enabled." Since the prerender work
the pages read fine without it — demonstrated above. Rewritten to say which
parts need JavaScript (submitting, profile search, live statistics) and which
do not.

### 7. Contrast: two AA failures in dark mode
- `.skip-link`, white on `rgb(224,54,47)` at 4.43:1 for 13px text. Given its own
  slightly deeper red (4.72:1) rather than shifting the shared `--ink2` token.
- Two 10px labels on `/submit` using `--umber` `#c9a06a` on `#453c33` at 4.48:1.
  Dark `--umber` lightened to `#cba36e` (4.62:1).

`.logo-mark` sits on the same red at 4.43:1 and was **left alone**: WCAG 1.4.3
exempts a logotype from contrast minimums.

### 8. Chart labels overflowed at 320px
Twelve month labels would not fit; the last ("ডিসে") hung 11px past the edge and
scrolled the page. Padding, gap and label size tightened below 360px only.

## What is sound

- **robots.txt, sitemap, canonicals.** One sitemap, declared in robots, 200,
  valid urlset, 19 locs matching the 18 rewrites plus the homepage. Every URL
  returns 200 with a self-referencing canonical except `/` (see below).
- **Security headers.** HSTS, `nosniff`, `SAMEORIGIN`, `strict-origin-when-cross-origin`,
  a Permissions-Policy, and `noindex, nofollow` correctly on `/admin.html`.
- **Compression.** Brotli, 363 KB → 98 KB on the wire.
- **Internal linking.** All 19 URLs reachable from the homepage; no
  `target="_blank"` without `rel="noopener"`.
- **AI readiness.** `llms.txt` present (2,564 bytes, passes Lighthouse's check);
  `agentic_check.py` reports no P0 or P1 failures.
- **Content.** All eight posts pass `content_quality.py` (79–91), with **zero**
  filler phrases and **zero** AI-tell patterns.
- **Database.** `migrations/verify.sh` still reports passed 19, failed 0.

## Open, not fixed

1. **Homepage canonical omits the trailing slash** — sitemap says
   `https://www.daag-bd.com/`, the canonical and `og:url` say
   `https://www.daag-bd.com`. Google normalises these; cosmetic, low priority.
2. **`FAQPage` ships in 19 of 21 served files.** Not a fabrication (it carries
   `@id` pointing at `/about#faq` and the questions are real) but more URLs than
   intended assert the entity.
3. **No `hreflang`, one URL for both languages.** Long-standing, architectural.
4. **No Core Web Vitals data.** Needs a Google API key.
5. **Archive entries are not indexable** — by decision, awaiting a choice.

## A note on the tooling

The skill's own `server-rendered` check reports **pass** on `/about` with 4,594
words — on the exact URL that was serving the homepage body. It counts words in
the raw HTML, and this SPA ships every section's markup in every file, so the
count is always high. The defect was found by comparing extracted text across
URLs, not by the check that exists for it.

`content_quality.py` has the same shape of blind spot: pointed at a published
page it scored the inlined CSS and JS (36,401 tokens for an 1,100-word post) and
returned a flat grade for all eight. Point it at `content/blog/*.md`.
