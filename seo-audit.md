# Daag SEO, AEO and GEO audit

Site: https://www.daag-bd.com
Audited: 28 October 2026
Method: seo-guru-turnaround, Phases 0 to 3 (discovery, diagnosis, strategy)
Mode: B (Claude Code, repo access). Nothing implemented yet.

Every figure below is labelled:
**[V]** verified by fetching the site, **[E]** estimated, **[U]** unavailable.

---

## 0. Intake gap

You have not said what ranking success means for Daag, and the right strategy
differs a lot by answer. The audit assumes the goal implied by the site's own
copy: that someone checking a person before they trust them finds the record,
and that journalists, researchers and survivors can find the archive and the
submission form. If your actual priority is different, say so, because it
changes the order of the roadmap below.

This is not a commercial site. There is no product, no service area and no
Google Business Profile to optimise, so the usual local and e-commerce levers
do not apply. **[V]**

---

## 1. What is already right

Worth stating plainly, because the technical base is better than most sites
that are not ranking:

- `robots.txt` is open and points at the sitemap. No `noindex` anywhere. **[V]**
- All 10 routes return 200. No redirect chains. No soft 404s. **[V]**
- Sitemap is valid and lists all 10 routes. **[V]**
- 93 KB gzipped, one external stylesheet, no synchronous scripts in `<head>`. **[V]**
- Viewport set, no horizontal overflow at 390 px. **[V]**
- Zero images missing alt text. **[V]**
- Open Graph and Twitter card tags complete, `og:image` serves at 200. **[V]**
- A web retrieval system fetched the homepage during this audit and summarised
  Daag's submission, review, classification and appeals process accurately.
  **[V]** That tells us the homepage is reachable and legible to machines. It
  is not proof that any named AI assistant cites Daag, which would need
  checking inside each assistant. **[U]**

The problem is not that the site is broken. It is that nine of its ten pages
are telling Google they do not exist, and the content that makes Daag worth
citing never reaches a crawler at all.

---

## 2. Root causes, ranked

### RC1. Nine of ten pages declare themselves duplicates of the homepage

**Evidence [V]:** every route serves byte-identical HTML. In that HTML:

| | value |
|---|---|
| canonical on `/archive`, `/search`, `/submit`, `/appeals`, `/analytics`, `/about`, `/contact`, `/terms`, `/privacy` | `https://www.daag-bd.com` |
| distinct `<title>` values across 11 fetched URLs | 1 |
| distinct meta descriptions | 1 |

The SPA rewrites title, description and canonical with JavaScript after load, so
the correct per-route values exist in the rendered DOM but never in the served
HTML.

**Why it matters most:** a canonical pointing at another URL is not a hint, it
is an instruction to consolidate. Google does render JavaScript and may honour
the rendered canonical instead, so this does not guarantee the pages are gone
from the index. But it is a contradictory signal the site is sending about
itself for no benefit, and `site:daag-bd.com` currently surfaces only the
homepage **[E, the `site:` operator is approximate]**, which is consistent with
consolidation having already happened.

Any consumer that does not execute JavaScript sees nine pages that all claim to
be the homepage. Social scrapers demonstrably do not, which is why every shared
link already previews as the homepage **[V, confirmed by fetching each route]**.
LLM retrieval crawlers generally fetch raw HTML with limited or no rendering,
though their exact behaviour is undocumented and was not measured here. **[U]**

**Share of the gap: large. This is the first thing to fix.**

### RC2. The archive's unique content is invisible to crawlers

**Evidence [V]:** `curl https://www.daag-bd.com/archive` returns zero of the 27
published entries. No profile names, no entry nodes. The records load from
Supabase by XHR after render.

There are 27 approved entries across 13 distinct profiles. **[V, read from
`public_stats`]**

**Why it matters:** this is the only content on daag-bd.com that exists nowhere
else. Verified, dated, screenshotted records of who wrote what. Right now every
page's indexable text is the same static explanatory and policy copy, so there
is no topical depth to rank and nothing specific for an AI engine to cite.

**Share of the gap: large, and it interacts with a decision only you can make.
See section 4.**

### RC3. The site declares Bengali and serves English, with no hreflang

**Evidence [V]:** `<html lang="bn">` and `og:locale: bn_BD`, but the served
HTML body contains 20,969 Latin characters against 103 Bengali. Zero `hreflang`
tags. Both languages live on the same URL, switched by JavaScript and
`localStorage`.

**Why it matters:** the primary audience searches in Bengali. The Bengali text
only exists after `applyLang()` runs. There is no separate URL for either
language, so there is no mechanism to tell a search engine that a Bengali
version exists or to rank it. The declared language and the served language
contradict each other on every page.

**Share of the gap: moderate to large for Bengali queries specifically.**

### RC4. No entity footprint for an organisation making public accusations

**Evidence [V]:** the only structured data on the site is one `WebSite` object
with a stub `Organization` publisher: no `logo`, no `sameAs`, no `contactPoint`,
no founding date, no named people. Searches for the brand return the homepage
but no third-party coverage of Daag. **[E]**

**Why it matters:** Daag publishes accusations against named private
individuals. For that kind of site, E-E-A-T is not a ranking nicety, it is the
question of whether Google trusts the domain enough to surface it at all. A
reader, a quality rater and an AI engine all need to answer "who runs this and
are they accountable" and right now the site does not say.

**Share of the gap: moderate now, large over time.**

### RC5. No schema for the content types the site actually has

**Evidence [V]:** only `WebSite`. A genuine structured dataset with no
`Dataset`, no `BreadcrumbList`, and no `Organization` detail beyond a name and
a URL.

**Correction, found during implementation.** This section originally said the
site has 5 FAQ blocks with no `FAQPage` schema. That was wrong. All five
`faq-item` matches are CSS selectors inside `<style>`; there is no FAQ markup on
any page. What does exist is six complete Bengali question and answer pairs in
the dictionary (`faq.1q` through `faq.6a`), a `toggleFaq` handler and about 839
bytes of CSS, none of it referenced by anything. The FAQ was built, translated,
then lost when a section was replaced. So the finding is better than it looked:
the content is already written and simply is not on the page. **[V]**

**Share of the gap: small on its own, but it is cheap and it compounds RC4.**

### Ruled out

Not causes here, checked and clear: indexability blocks, `noindex` leaks,
redirect chains, page speed, mobile usability, missing alt text, thin pages,
duplicate-content penalties from scraping. **[V]**

---

## 3. Winnability, honestly

Daag is a new domain with no external link profile. **[E]** Some targets are
not realistic soon and it is better to say so now.

| Target | Realistic? | Why |
|---|---|---|
| Brand: "Daag", "দাগ archive", "daag-bd" | Yes, weeks | You own the entity, you just need the pages indexed and the Organization schema to disambiguate from the Hindi films and other Daags that currently dominate that word |
| Long-tail: a specific person's name | Yes, if entries are indexed | Nobody else holds this content. See section 4 first |
| "online harassment Bangladesh", "cyber violence women Bangladesh" | Not soon | Currently held by The Daily Star, academic journals and research institutions with decades of authority. **[V, observed in SERP]** Expect 12 months or more and a real link profile |
| Method and process queries: how to report an abusive comment, how to appeal an entry | Yes, months | Nobody is writing these for a Bangladeshi audience. This is your realistic organic entry point |
| AI citation for "what is Daag" | Plausible, partly there | The homepage is reachable and machine-legible **[V]**. Whether assistants actually cite it is unmeasured **[U]**. Organization schema and llms.txt are the levers |

No ranking is guaranteed by any of this. The actions below improve the
probability.

---

## 4. The decision only you can make

The single highest-impact SEO action available is to give each archive entry its
own indexable URL with its own title, description and schema. It is also the
most consequential decision this project can take, and your own `sitemap.xml`
already carries a comment saying entries are excluded on purpose:

> indexing an accusation under a real person's name is a decision to make on
> purpose, not a side effect of a sitemap

That judgement still looks right to me. Making entries indexable means a search
for a person's name could return Daag's record of what they wrote. That is
precisely the site's stated purpose, and it is also the point at which the
archive stops being a reference someone consults and starts being a search
result that follows a person around.

Three options, in increasing order of exposure:

**Option A, keep entries out of the index.** Accept that organic growth comes
from the explanatory and process pages only. Nothing changes here.

**Option B, index entries but not under names.** Give each entry a URL and
schema, set the title to the reference number and category rather than the
person ("DG-2025-5370: victim blaming, Facebook"), and `noindex` nothing. The
archive becomes crawlable and citable as a body of evidence. Name searches still
do not surface individuals.

**Option C, index entries under names.** Maximum reach, maximum consequence,
and the option most likely to attract legal attention. If you ever choose it,
do it after the appeals process has been load-tested and after legal review,
not as an SEO experiment.

**My recommendation: B.** It captures most of the search value, it makes the
archive genuinely citable by AI answer engines, and it does not turn the site
into a reputational weapon, which your own Terms page says it is not meant to
be. But this is your call and I have not implemented any of it.

Everything in the roadmap below works under Option A or B.

---

## 5. Roadmap

Impact and effort are H/M/L. Nothing here has been implemented.

### Week 1, quick wins

| Action | Impact | Effort |
|---|---|---|
| Serve per-route `<title>`, meta description and canonical in the HTML, not via JavaScript | H | M |
| Add `Organization` schema: logo, `sameAs`, `contactPoint` with daagarchive@gmail.com, founding date, language | H | L |
| Restore the orphaned FAQ to the About page, then add `FAQPage` schema over it | M | M |
| Add `BreadcrumbList` to the non-home routes | L | L |
| Publish `/llms.txt` describing what Daag is, what it records and what it does not | M | L |
| Shorten the title to under 60 characters and the description to under 155 | L | L |

The first row is the one that matters. For a 10-route static site the cleanest
fix is a small build step that writes one HTML file per route with the right
head tags baked in, which also fixes the link previews that currently show the
homepage for every shared URL.

### Month 1

| Action | Impact | Effort |
|---|---|---|
| Decide Option A, B or C above | H | M |
| If B: entry URLs, per-entry head tags, `Dataset` schema, sitemap for entries | H | H |
| Split Bengali and English onto distinct URLs (`/bn/...`, `/en/...`) with `hreflang` and self-referencing canonicals | H | H |
| Write a real About page naming who runs Daag and the editorial standard | H | M |
| Server-render the archive list, even just headline, category and date | H | M |

### Month 2 to 3

| Action | Impact | Effort |
|---|---|---|
| Process and method pages: how to document a comment, how to appeal, what counts as evidence. These are the queries you can actually win | H | M |
| Earn the first external links: Bangladeshi women's rights organisations, BLAST, Naripokkho, ASK, digital rights groups, university gender studies departments | H | H |
| Pitch the archive to a journalist at one of the two papers already covering this beat | H | M |
| Set up Search Console, submit the sitemap, watch coverage and the Bengali queries | M | L |

### Ongoing

Watch in Search Console: indexed page count (should go from roughly 1 to 10,
then higher under Option B), impressions on Bengali queries, and whether the
non-home routes ever appear. At 30 days the honest success measure is "all ten
pages indexed with their own titles", not traffic.

---

## 6. What the self-critique changed

Two passes, recorded in `critique/`. The draft originally stated that the nine
pages "are deindexed"; the evidence supports "are instructed to consolidate and
the `site:` result is consistent with that", so it was downgraded and labelled.
The draft also listed "missing hreflang" as a standalone technical finding
before it was folded into RC3 as a consequence of one-URL bilingualism, which is
the actual cause. A claim about the site having no backlinks was softened to
**[E]** because no backlink tool was run. The archive-indexing recommendation
was rewritten from a recommendation into a decision with three options, because
the SEO-optimal answer and the right answer for this project are not obviously
the same.
