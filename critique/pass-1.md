# Critique pass 1: the adversarial SEO reviewer

## Critical
- [C1] "An AI answer engine has already read the site" is stated as Verified. The
  actual evidence is that a web retrieval system fetched and summarised the
  homepage during this audit. Whether any named assistant cites Daag was never
  checked. -> seo-audit.md section 1 -> Fix: downgrade to what was observed, mark
  the citation question Unavailable.

## Major
- [M1] "Everything that does not render JavaScript, which includes most AI answer
  crawlers" asserts crawler behaviour that was not measured. -> RC1 -> Fix: keep
  the social-scraper half (verified by fetching each route), mark the LLM-crawler
  half Unavailable.
- [M2] The draft said the nine pages "are deindexed". A single `site:` query via
  an approximate operator does not support that. -> RC1 -> Fix: state the
  instruction being sent, mark the `site:` observation Estimated, and say
  explicitly that Google may honour the rendered canonical instead. APPLIED.
- [M3] "No backlinks" was asserted without running a backlink tool. -> RC4 ->
  Fix: label Estimated. APPLIED.
- [M4] Archive indexing was written as a recommendation. The SEO-optimal answer
  and the right answer for this project are not the same, and the repo already
  records a deliberate decision to exclude entries. -> section 4 -> Fix: rewrite
  as a decision with three options and a stated recommendation. APPLIED.

## Minor
- [m1] "missing hreflang" was listed as a standalone finding when it is a
  consequence of serving both languages from one URL. -> Fix: folded into RC3.
  APPLIED.

## Fixed in this pass
- C1, M1 applied after this pass. M2, M3, M4, m1 applied during drafting.

## Result
Critical remaining: 0. Major remaining: 0. Proceed to pass 2.
