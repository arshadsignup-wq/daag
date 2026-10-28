# Critique pass 2: the implementation reviewer, then the quality rater

## Implementation review

1. Specificity: Week 1 rows name the exact artefacts (Organization fields,
   FAQPage over the 5 existing blocks, llms.txt, length limits). The first row
   names the mechanism (build step emitting one file per route). Acceptable for
   an audit; the actual edits are Phase 4 and were deliberately not done, since
   the user asked to audit and analyse.
2. Every number re-verified against crawl/pages.json and live curl output:
   5 FAQ blocks, 1 distinct title, 1 distinct meta, 9 non-self canonicals,
   title 64, meta 195, jsonld ['WebSite'], 0 hreflang, 27 approved / 13 profiles.
   All match. No unsourced figure remains.
3. Punctuation: 0 em dashes, 0 en dashes. Checked with grep, not by eye.
4. Fact preservation: no existing site copy was rewritten in this phase, so
   nothing could be lost.
5. No schema was proposed that describes content the site does not have.
   FAQPage maps to 5 real FAQ blocks; Dataset is conditional on Option B.

## Quality rater and AI answer engine

1. Does the report lead with root causes rather than a symptom list? Yes, five
   ranked causes with evidence, and an explicit "ruled out" list so the reader
   knows what was checked and found healthy.
2. Is any recommendation risky? The only risky one is archive indexing, and it
   is framed as the user's decision with the legal exposure stated.
3. Is any claim a guarantee? No. Section 3 says explicitly that no ranking is
   guaranteed.
4. Would the owner be embarrassed by any sentence? The winnability table says
   plainly that broad head terms are not reachable soon. That is uncomfortable
   and correct, and better said now than discovered in six months.

## Remaining gap, declared rather than hidden
- No backlink tool, no Search Console access, no Core Web Vitals field data.
  Those would sharpen RC4 and confirm RC1. Named in the report as [E] / [U].
- The intake question (what does success mean to you) is unanswered and is
  flagged at the top, because it changes the roadmap order.

## Result
Critical remaining: 0. Major remaining: 0. Deliver.

## Addendum, found while writing pass 2
- [M5] After downgrading the AI-citation claim in section 1, the winnability
  table still read "Already happening" for the same claim. A report that
  contradicts itself two sections apart is worse than one that overclaims
  consistently. -> section 3 -> Fix: table row now matches the evidence.
  APPLIED.

## Addendum 2, found during implementation (pass 3 in effect)
- [C2] RC5 claimed "5 FAQ blocks with no FAQPage schema". I counted the string
  `faq-item` in the fetched HTML without checking whether it was markup or CSS.
  All five are CSS selectors; there is no FAQ on the site. Had this gone
  unchecked I would have added FAQPage schema describing content that does not
  exist, which is the exact practice the skill forbids in rule 3 and which
  Google treats as structured data spam. -> RC5 and the Week 1 table -> Fix:
  correction written into RC5, roadmap row changed to restore the FAQ first.
  APPLIED.
- Lesson for the remaining work: grep counts are not evidence of markup. Strip
  <style> and <script> before counting anything that is supposed to be content.
