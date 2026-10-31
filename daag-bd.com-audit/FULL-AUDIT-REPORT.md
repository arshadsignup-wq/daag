# daag-bd.com — full SEO & front-end audit

Run 2026-11-01 with the `seo-audit` skill's method and its bundled runtime
(Playwright Chromium, trafilatura, `agentic_check.py`, `content_quality.py`,
`sitemap_discovery.py`, `preload_check.py`). The skill itself could not be
invoked by name — it was installed mid-session and the skill list is built at
session start — so its SKILL.md was followed directly, which is the documented
fallback.

**Scope:** all 19 URLs in the sitemap, both themes, both languages, viewport
widths 320–1440.

## Health score: 78 / 100 (before fixes) → 91 / 100 (after)

| Category | Weight | Before | After | Note |
|---|---|---|---|---|
| Technical SEO | 22% | 85 | 92 | headers, sitemap, robots all sound; canonical nit remains |
| Content Quality | 23% | 86 | 86 | 8 posts score 79–91, zero filler, zero AI-tells |
| On-Page SEO | 20% | 55 | 95 | 9 of 11 routes had **no h1** at all |
| Schema | 10% | 80 | 88 | posts had no BreadcrumbList; FAQPage over-ships |
| Performance | 10% | [U] | [U] | **unavailable** — PSI quota exhausted, no API key |
| AI Search Readiness | 10% | 88 | 92 | llms.txt present and passing; no llms-full.txt |
| Images | 5% | 90 | 90 | 1 image, alt present; 5 SVGs all aria-hidden |

Performance is marked **[U] unavailable**, not estimated. `lighthouse_agentic.py`
returned HTTP 429 (shared PSI quota, no key configured) and no CrUX field data
is reachable. No number is reported for LCP/INP/CLS because none was measured.

## Critical — fixed this session

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
