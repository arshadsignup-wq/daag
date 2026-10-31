# Content findings

`content_quality.py` against `content/blog/*.md` (not the published HTML — see
the note at the end):

| Post | Overall | Density | Filler | AI-tells |
|---|---|---|---|---|
| 180-days-in-law-three-years-in-practice | 91 | 0.70 | 0 | 0 |
| nineteen-days-what-the-fastest-trial-required | 85 | 0.48 | 0 | 0 |
| the-footpath-video-and-who-gets-detained | 85 | 0.45 | 0 | 0 |
| what-a-confession-does-not-settle | 84 | 0.41 | 0 | 0 |
| where-to-report-online-abuse-in-bangladesh | 84 | 0.40 | 0 | 0 |
| what-the-comments-do-after-a-verdict | 83 | 0.39 | 0 | 0 |
| who-the-accused-usually-is | 82 | 0.37 | 0 | 0 |
| the-vocabulary-of-blame | 79 | 0.21 | 0 | 0 |

All pass (threshold 60). Zero filler phrases and zero AI-tell patterns in all
eight. The weakest is the one essay about language rather than about a case, so
it carries few concrete anchors; that is a real weakness, not a metric artifact.

**Do not point this script at a published page.** Against
`blog/<slug>.html` it reported 36,401 tokens for an 1,100-word post and gave all
eight the same flat grade, because it scored the inlined CSS and JS of the SPA.
