# Daag — User Journey & Pain Point Resolution Map

> For each of the 12 user personas, this document maps the complete journey through the platform and shows exactly how Daag's features resolve every documented frustration.

---

## How to Read This Document

Each persona section contains:
1. **Trigger** — the event that brings the persona to the platform
2. **Journey Steps** — numbered touchpoints (pages visited, actions taken)
3. **Pain Point Resolution Table** — maps each frustration (P1–P36) to the specific feature and page that addresses it
4. **Outcome** — what the persona walks away with

**Feature abbreviations used in the resolution tables:**

| Abbreviation | Feature | Primary Location |
|---|---|---|
| **PA** | Permanent Archive | Archive page (`pg-archive`) |
| **PS** | Profile Search | Profile Search page (`pg-search`) |
| **SA** | Submitter Anonymity + Optional Reference | Submit page (`pg-submit`), Submitter Reference section |
| **ECP** | Entry Count Pills | Profile card in search results |
| **PAN** | Pattern Analytics | Analytics page (`pg-analytics`) |
| **M&E** | Methodology & Ethics | Methodology page (`pg-ethics`) |
| **ToU** | Terms of Use | Terms page (`pg-terms`) |
| **LC** | Legal Compliance section | Methodology page (`pg-ethics`), Legal Compliance subsection |
| **APP** | Appeals System | Appeals page (`pg-appeals`) |
| **MS** | Moderator Standards | Methodology page (`pg-ethics`), Moderator Standards subsection |
| **MW** | Moderator Wellbeing Protocol | Methodology page (`pg-ethics`), Standard 04 |
| **AID** | AI Limitations Disclosure | Methodology page (`pg-ethics`), AI Classification subsection |
| **RL** | Rate Limiting + Honeypot + Anti-Harassment Enforcement | Submit page backend; Anti-Harassment Policy in Methodology |
| **DRP** | Data Retention Policy | Methodology page (`pg-ethics`), Data Retention subsection |
| **CG** | Contributor Guidelines | Submit page (`pg-submit`), guidelines panel |
| **VM** | Version Markers / Audit Trail | Archive entries and profile card entries |
| **AUN** | Archive Use Notice + Redistribution Monitoring | Archive page notice; Anti-Harassment Enforcement Mechanism 03 |

---

## 1. Fatima Akter — Evidence Submitter (Survivor's Friend)

**Role:** Private university lecturer, 26, Dhaka. Moderate digital literacy.

### Trigger
Fatima's colleague was raped. A widely-shared Facebook post about the case attracted dozens of victim-blaming comments. One commenter wrote "she went out at midnight, what did she expect?" and received 200 reactions. The comments begin disappearing within days. Fatima screenshots the comment, the commenter's profile, and the source post before they vanish.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Home** (`pg-home`) | Arrives at the landing page. Reads the hero tagline — "Every word leaves a mark." Understands the platform documents public abuse. |
| 2 | **Submit Evidence** (`pg-submit`) | Clicks the "Submit Evidence" CTA button in the navigation bar. |
| 3 | **Contributor Guidelines** (panel on Submit page) | Reads what to submit (publicly visible comments from public posts) and what not to submit (private messages, personal disputes, fabricated material). Confirms her evidence qualifies. |
| 4 | **Submission Form — URLs** | Enters the perpetrator's Facebook profile URL and the source post URL in the two required URL fields. |
| 5 | **Submission Form — Screenshot** | Drags and drops the unedited screenshot into the upload zone. Sees a thumbnail preview. File validated as PNG under 10 MB. |
| 6 | **Submission Form — Classification** | Selects "Victim Blaming" as the abuse category and "Rape / Sexual Violence" as the incident type. Adds the "She Deserved It" tag. |
| 7 | **Submission Form — Context** | Writes a contextual note explaining the coordinated nature of the comments and the incident background. |
| 8 | **Submitter Reference** (optional section) | Optionally provides her email. Selects relationship: "Friend or Family of Survivor." Notes the privacy assurance: "Never displayed publicly. Used only for moderation follow-up." |
| 9 | **Submission Confirmation** | Receives reference number (DG-2025-XXXX). Sees notice that the submission will be reviewed by a trained moderator. |
| 10 | **Post-submission** | Can later search the Archive or Profile Search to confirm the entry was published after moderation. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P1** | Comments disappear — evidence is lost | **PA** (Permanent Archive) | Once verified and published, the entry is retained indefinitely in the archive regardless of whether the original Facebook comment is deleted. The archive preserves the screenshot, source URLs, category, and context permanently. |
| **P2** | No consequence for public abuse | **PA** + **AUN** (Archive Use Notice + Redistribution Monitoring) | The permanent archive creates a documented, searchable record tied to the commenter's identity. The Archive Use Notice ensures this record serves accountability (research, journalism, advocacy) without enabling vigilantism. Redistribution Monitoring detects and reports any attempts to weaponise entries for harassment. |
| **P3** | Fears identity exposure when submitting | **SA** (Submitter Anonymity + Optional Reference) | The submitter's email is optional, never displayed publicly, and used only for moderation follow-up. No submitter identity appears on published entries. The Data Retention Policy deletes submitter contact info after 180 days. |

### Outcome
Fatima successfully documents the victim-blaming comment before it disappears from Facebook. The evidence enters the moderation queue, and if verified, becomes a permanent, searchable record. Her identity is never exposed. She receives a reference number to track the submission.

---

## 2. Nusrat Jahan — Profile Searcher (Pre-Matrimonial)

**Role:** Bank officer, 24, Chittagong. High digital literacy.

### Trigger
Nusrat's family has arranged a meeting with a prospective spouse. She has his Facebook profile name. Before the formal introduction, she wants to check whether he has any documented history of misogynistic or abusive online behaviour.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Home** (`pg-home`) | Arrives at the platform. Sees "Profile Search" in the navigation. |
| 2 | **Profile Search** (`pg-search`) | Navigates to Profile Search. Reads the search tips showing example name formats. |
| 3 | **Search Query** | Enters the prospective partner's Facebook name into the search field. Clicks "Search Archive." |
| 4 | **Results — Profile Card** | Finds a profile card showing 2 verified entries. The entry count pill displays "2 Verified Entries." Sees category badges (e.g., "Victim Blaming"), incident types, and severity ratings for each entry. |
| 5 | **Entry Details** | Reads the documented comments listed on the profile card — each showing the comment summary, category, severity, version marker, and verification status. |
| 6 | **Privacy Notice** (bottom of search page) | Reads the notice that search covers verified entries only and that the platform monitors for surveillance-pattern queries. |
| 7 | **Methodology** (`pg-ethics`) | Optionally navigates to Methodology to understand how entries are verified and categorised. Reads the Guiding Principles, especially "Patterns, Not People" and "Evidence Over Outrage." |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P4** | No visibility into online behaviour during matchmaking | **PS** (Profile Search) | Profile Search allows Nusrat to look up any individual by Facebook name or URL and see all verified entries associated with that person, providing visibility that traditional matchmaking processes lack. |
| **P5** | Family pressure limits time for due diligence | **PS** (Profile Search) | A single search query returns the full profile card with entry count, categories, and severity — a fast, structured check that fits within the compressed timeline of arranged marriage introductions. |
| **P6** | Women discover abusive views only after marriage | **PS** (Profile Search) | The archive surfaces documented abusive comments that would otherwise remain invisible until post-marriage. Verified entries show the actual comment text, category, and incident context — providing concrete evidence before commitment. |

### Outcome
Nusrat finds 2 verified entries showing victim-blaming comments from 2024. She uses this as one input in her decision — not as a verdict. She discusses the findings with a trusted family member before the formal introduction. The search was fast and private.

---

## 3. Rafiq Islam — Profile Searcher (Professional / Employment)

**Role:** HR Director at a multinational, 42, Dhaka. High digital literacy.

### Trigger
A candidate for a Director-level role has passed all technical interviews. Before the final offer, Rafiq wants to screen the candidate's publicly known social media profile as part of expanded due diligence.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Profile Search** (`pg-search`) | Navigates directly to Profile Search. Enters the candidate's name and Facebook URL. |
| 2 | **Results — No Match** | The search returns no results. Sees the "no results" message with the disclaimer: absence of entries does not mean absence of behaviour. Sees a link to submit evidence if he encounters relevant content. |
| 3 | **Methodology** (`pg-ethics`) | Navigates to Methodology to understand the verification standards and data source methodology — needs to document the search as part of a defensible hiring process. |
| 4 | **Documentation** | Notes the "no results" outcome and the methodology standards in his hiring file as a documented due diligence step. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P7** | Background checks don't cover online behaviour | **PS** (Profile Search) | Profile Search extends due diligence beyond traditional background checks by providing a searchable archive of verified online abuse entries tied to specific individuals. |
| **P8** | Workplace harassment preventable with better screening | **PS** (Profile Search) | The profile card shows entry counts, categories, severity, and documented comment text — giving HR a concrete signal about documented patterns of misogynistic behaviour before making hiring decisions. |
| **P9** | Needs defensible, evidence-based source | **ECP** (Entry Count Pills) + **M&E** (Methodology & Ethics) | Entry count pills present factual data ("N Verified Entries") rather than subjective risk judgments. The Methodology page documents verification standards, moderator training, evidence requirements, and guiding principles — providing the methodological foundation Rafiq needs to defend the data source in a professional context. |

### Outcome
Rafiq finds no entries for the candidate. He documents the search and the "no results" disclaimer as part of the hiring file. The Methodology page gives him confidence that the data source is rigorous enough to include in a professional due diligence process. He proceeds with the hire with this data point noted.

---

## 4. Sadia Jahan — Moderator (Trained Volunteer)

**Role:** Sociology graduate student, 29, Rajshahi. Very high digital literacy.

### Trigger
Sadia logs into the Moderation Console and sees 47 pending submissions in the queue. She begins her review session.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Moderation Console** (`pg-moderation`) | Opens the console. Reviews the sidebar queue: Pending Review, Approved Today, Rejected Today, On Hold, Active Appeals. |
| 2 | **Queue Review** | Sorts queue by submission time. Each review card shows: Submission ID, category badge, language badge, timestamp, contextual notes, and AI toxicity confidence bar. |
| 3 | **Per-Submission Review** | For each item: checks screenshot against the source URL, verifies the Facebook profile URL, reads the contextual notes, and reviews the AI confidence score. |
| 4 | **AI Confidence Score** | Reads the mandatory disclaimer below the confidence bar: "AI analysis is advisory only. Human review required before any decision." Treats the score as one input, not a decision. |
| 5 | **Action** | Takes action on each submission: Approve (queued for archive publication), Reject (removed from queue), or Hold (escalate for senior review). |
| 6 | **Decision Logging** | Each action generates a status message and dims the card. Rationale is logged per the Moderator Standards (Standard 03: logged decisions). |
| 7 | **Mandatory Break** | After 30 submissions, the Wellbeing Protocol (Standard 04) mandates a break with mental health check-in. |
| 8 | **Borderline Cases** | For submissions where accountability vs. vendetta is unclear, refers to the Contributor Guidelines (what qualifies) and Moderator Standards (severity rubric, escalation to Hold). |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P10** | Psychological toll from distressing content | **MW** (Moderator Wellbeing Protocol) | Standard 04 mandates: 30-submission session limits, mandatory rest periods, mental health check-ins, and peer support access. The protocol treats moderator wellbeing as a structural requirement, not an afterthought. |
| **P11** | Borderline submissions — accountability vs. vendetta unclear | **MS** (Moderator Standards) + **CG** (Contributor Guidelines) | Standard 03 provides a severity rubric and operational process for consistent decisions. The Contributor Guidelines define what qualifies for submission and what doesn't (explicitly excluding personal disputes and political disagreements). The Hold/escalate action exists specifically for borderline cases that need senior review. |
| **P12** | AI scores inaccurate for Bangla content | **AID** (AI Limitations Disclosure) | The AI Classification section explicitly discloses known limitations: struggles with Bangla slang, regional idioms, and coded language. The confidence score is hardcoded as "advisory only" with mandatory human review. Published entries carry the disclosure: "AI analysis was used to support — not determine — this categorization." |

### Outcome
Sadia reviews submissions with clear standards, a severity rubric, and structural wellbeing protections. She treats AI scores as advisory, escalates borderline cases, and takes a mandatory break after 30 reviews. Her decisions are logged and consistent.

---

## 5. Dr. Tahsin Rahman — Researcher / Academic

**Role:** Associate Professor of Digital Sociology, 38, London (Bangladeshi diaspora). Expert digital literacy.

### Trigger
Dr. Rahman is writing a paper on the relationship between high-profile rape cases and spikes in online victim-blaming. He needs temporal data showing submission patterns before and after major incidents, and he needs a methodologically sound data source he can cite in a peer-reviewed journal.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Methodology & Ethics** (`pg-ethics`) | First stop — assesses the platform's rigour. Reviews: Guiding Principles (Evidence Over Outrage, No Private Data, Moderated Before Published, Patterns Not People, Appeals Are Binding), verification standards, moderator training requirements, AI limitations disclosure, and data retention policy. |
| 2 | **Pattern Analytics** (`pg-analytics`) | Explores aggregate data: monthly submission trends (12-month bar chart), category distribution (Victim Blaming 31%, Misogyny 24%, etc.), incident type breakdown (Rape/Sexual Violence 38%, Cyber Harassment 22%, etc.), and summary statistics (1,284 archived, 94% verification rate). |
| 3 | **Analytics Disclaimer** | Reads the disclaimer: "Data reflects verified entries only. Category and incident type assignments are made by trained human moderators." Notes this for his methodology section. |
| 4 | **Public Archive** (`pg-archive`) | Browses individual entries to assess data quality. Reads comment text, categories, severity ratings, version markers, and contextual notes. Uses keyword search and filter pills to narrow by category and time period. |
| 5 | **About** (`pg-about`) | Reviews the project's origins, team, and institutional backing. |
| 6 | **Contact** | Contacts the Daag team to discuss data access for academic research and any additional ethical review requirements. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P13** | Online abuse undocumented — no systematic dataset | **PAN** (Pattern Analytics) | The analytics dashboard provides aggregate statistics, monthly trends, category distributions, and incident type breakdowns — a systematic, structured dataset of verified online abuse that did not previously exist. |
| **P14** | Research relies on self-reported surveys | **PAN** (Pattern Analytics) | The archive contains verified, evidence-based entries (screenshots checked against source URLs by trained moderators) rather than self-reported data. Each entry has documented provenance: original comment, source URL, verification status, and moderator review. |
| **P15** | Needs methodologically sound, ethically managed source | **M&E** (Methodology & Ethics) | The Methodology page documents: 5 guiding principles, moderator training requirements (20-hour programme), operational standards (logged decisions, severity rubric), AI limitations disclosure, data retention tiers, screenshot handling procedures, and anti-harassment enforcement — providing the methodological transparency required for academic citation. |

### Outcome
Dr. Rahman finds a structured, transparent data source with documented methodology. He uses the analytics trends for temporal analysis, cites individual archive entries (anonymised) as case studies, and references the Methodology page in his paper's data source section. The platform gives him evidence-based data that replaces reliance on self-reported surveys.

---

## 6. Meher Afroz — Journalist

**Role:** Investigative journalist at a national daily, 31, Dhaka. High digital literacy with OSINT skills.

### Trigger
Meher is investigating a coordinated harassment campaign against a female politician. She needs documented evidence to support the story — but Facebook comments are disappearing faster than she can report on them.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Public Archive** (`pg-archive`) | Searches the archive by incident type and date range. Uses filter pills (e.g., "This Week") and keyword search to find entries linked to the harassment campaign. |
| 2 | **Entry Review** | Finds 6 verified entries from different commenters, all posted within 48 hours. Each entry shows: comment text, category, incident type, severity, screenshot (blurred for public display), source URLs, archive date, verification status, and version markers. |
| 3 | **Cross-Reference** | Cross-references archive entries with her own reporting notes. The two-URL verification (profile + source post) gives her confidence in the provenance of each entry. |
| 4 | **Methodology & Ethics** (`pg-ethics`) | Reviews verification standards, moderator training, and the "Evidence Over Outrage" principle to assess the archive's editorial credibility. |
| 5 | **Terms of Use** (`pg-terms`) | Checks Section 4 (Intellectual Property): confirms fair use for journalistic purposes is explicitly permitted. Notes Section 1 (Purpose & Permitted Use): journalism is listed as a permitted use. |
| 6 | **Legal Compliance** (on Methodology page) | Reviews the Defamation Safeguards section: the platform does not editorialise, maintains context and attribution. Reviews the DSA awareness section. This helps her assess defamation risks when reporting on named individuals from the archive. |
| 7 | **Publication** | Publishes her investigation with references to documented archive entries, citing the platform's verification methodology. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P16** | Comments disappear before stories are written | **PA** (Permanent Archive) | The archive preserves verified entries indefinitely, independent of whether the original Facebook comments are deleted. By the time Meher writes her story, the evidence is permanently documented with screenshots, URLs, and metadata. |
| **P17** | Needs editorially reviewed source, not uncertain screenshots | **M&E** (Methodology & Ethics) | Every entry is reviewed by a trained moderator (20-hour training programme, logged decisions, severity rubric) before publication. The Methodology page documents the verification process: screenshot checked against source URL, profile verification, category assessment. This gives Meher a curated, editorially reviewed source — not raw screenshots of uncertain provenance. |
| **P18** | Defamation risks when reporting on named individuals | **ToU** (Terms of Use) + **LC** (Legal Compliance) | The Terms of Use explicitly permit journalistic fair use. The Legal Compliance section details defamation safeguards: no editorialising, context and attribution maintained, right to reply through appeals. The platform's "No Verdict" clause (Terms Section 3) clarifies entries are documentation, not legal judgments — which provides a defensible framing for journalists citing the archive. |

### Outcome
Meher finds 6 verified entries documenting a coordinated harassment campaign. The archive gives her an editorially reviewed evidence base that survives Facebook deletions. She publishes her investigation with confidence in the provenance of her sources and clarity on defamation safeguards.

---

## 7. Rumana Begum — NGO / Advocacy Worker

**Role:** Programme Coordinator at a women's rights NGO, 35, Sylhet. Moderate digital literacy.

### Trigger
Rumana is preparing a policy brief for a parliamentary committee on cyber violence against women. She needs verified data showing the scale and patterns of online abuse — not anecdotes or raw datasets.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Pattern Analytics** (`pg-analytics`) | Reviews the analytics dashboard: total archived entries (1,284), monthly submission trends (bar chart), category distribution (Victim Blaming 31%, Misogyny 24%, etc.), and incident type breakdown (Rape/Sexual Violence 38%). |
| 2 | **Visual Data Extraction** | Uses the bar charts, percentage breakdowns, and summary statistics directly in her policy brief. The visual format (horizontal bars with percentages, monthly trend chart) is presentation-ready. |
| 3 | **Public Archive** (`pg-archive`) | Browses individual entries to select anonymised case studies for the brief. Each entry provides the comment text, category, and incident context she needs. |
| 4 | **Methodology & Ethics** (`pg-ethics`) | References the Methodology page in her brief to demonstrate the data source's credibility: verification standards, moderator training, guiding principles. |
| 5 | **Recommendation** | Recommends the platform to partner organisations as a documentation tool for online abuse. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P19** | Policymakers dismiss abuse as "just comments" | **PAN** (Pattern Analytics) | The analytics dashboard transforms individual comments into aggregate patterns: 1,284 archived entries, category distributions, temporal trends, severity breakdowns. This shifts the frame from "just comments" to documented, quantified abuse — harder for policymakers to dismiss. |
| **P20** | Data sources are anecdotal or too academic | **PAN** (Pattern Analytics) | The analytics provide structured, verified data (94% verification rate) in an accessible format. Each data point traces back to a specific verified entry, not a self-reported survey or secondhand account. The data is evidence-based but presented without academic jargon. |
| **P21** | Needs accessible, visual data | **PAN** (Pattern Analytics) | The analytics page provides presentation-ready visuals: monthly bar charts, horizontal category distribution bars with percentages, summary statistic cards, and incident type breakdowns. These are designed for inclusion in policy briefs and advocacy materials without requiring data processing. |

### Outcome
Rumana includes the analytics data — bar charts, category distributions, and summary statistics — directly in her policy brief. She cites the Methodology page to establish credibility. The parliamentary committee receives verified, visual evidence of online abuse patterns instead of anecdotal claims.

---

## 8. Imran Chowdhury — Subject of Entry (Wrongly Archived — Appeals)

**Role:** Software developer, 33, Dhaka. Very high digital literacy.

### Trigger
Imran receives a message from a friend: "Did you know you're on Daag?" A prospective employer has found the entry during a background search. The entry categorises a comment he posted sarcastically on a friend's satirical thread as "Victim Blaming."

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Profile Search** (`pg-search`) | Searches his own name. Finds 1 verified entry categorised as "Victim Blaming." |
| 2 | **Entry Review** | Reads the archived entry on his profile card: comment text, category, severity, version marker (v1), archive date, verification status. Sees the original screenshot and source URL. |
| 3 | **Methodology** (`pg-ethics`) | Reviews the verification standards and guiding principles. Notes the "Appeals Are Binding" principle and the removal request criteria. |
| 4 | **Appeals** (`pg-appeals`) | Navigates to the Appeals page. Reads the process: 14 working days, separate review panel from the original moderator, documented decisions. |
| 5 | **Dispute Form** | Files a formal appeal: enters the Archive Entry ID, selects grounds "Out of context" (comment was satirical), writes a supporting statement explaining the satirical thread context. |
| 6 | **Evidence Upload** | Uploads a screenshot showing the full satirical thread — establishing that his comment was a reply in a satirical context, not a response to a genuine news post. |
| 7 | **Contact & Tracking** | Provides his email for decision notification. Receives an Appeal ID. |
| 8 | **Appeal Status Tracker** | Uses the tracker on the Appeals page to check review progress with his Appeal ID. |
| 9 | **Decision** | Receives a decision within 14 working days. If upheld: entry is removed or reclassified. If denied: the rationale is documented and communicated. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P22** | Entry submitted in bad faith by rival | **APP** (Appeals System) | The appeals form includes "Bad faith" as an explicit ground for dispute. A separate review panel re-examines the submission, including the submitter's evidence and the appellant's counter-evidence. Confirmed bad-faith submissions are removed and the submitter's fingerprint is flagged. |
| **P23** | Comment was satirical / out of context | **APP** (Appeals System) + **VM** (Version Markers / Audit Trail) | The "Out of context" ground allows Imran to upload the full satirical thread as evidence. Version markers track any reclassification or modification that results from the appeal, maintaining an audit trail that documents the correction. |
| **P24** | Permanent reputational damage from unjust entry | **APP** (Appeals System) + **VM** (Version Markers / Audit Trail) | Successful appeals result in removal or reclassification of the entry. The audit trail (version markers with edit dates) ensures corrections are transparent. The 14-day timeline and binding decision process prevent indefinite reputational exposure from contested entries. |

### Outcome
Imran files a formal appeal with supporting evidence showing the satirical context. The separate review panel re-evaluates the entry. If the appeal is upheld, the entry is removed or reclassified, and the version markers document the correction. The process is transparent, timed, and independent of the original moderator.

---

## 9. Shakib Hasan — Subject of Entry (Legitimately Archived)

**Role:** Small business owner, 28, Comilla. Moderate digital literacy.

### Trigger
Shakib wrote "she should have known better than to go out dressed like that" on a news post about a rape case. The comment was submitted, verified, and archived. He finds out when a family member mentions seeing his name on the platform.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Profile Search** (`pg-search`) | Searches his own name. Finds 1 verified entry. |
| 2 | **Entry Review** | Reads the entry on his profile card: category "Victim Blaming", severity "High", the documented comment, source URL, and archive date. The entry count pill shows "1 Verified Entry." |
| 3 | **Severity Assessment** | Sees the severity rating displayed as a badge. Notes this is a factual classification based on documented criteria, not a subjective judgment. |
| 4 | **Appeals** (`pg-appeals`) | Considers filing an appeal. Reviews the available grounds: screenshot fabricated, missing context, out of context, bad faith, incorrect category. Realises none apply — the screenshot is genuine, the context is accurate, the category fits. |
| 5 | **Methodology** (`pg-ethics`) | Reads the Methodology page to understand how severity is assigned and what the guiding principles are. Notes the verification standards and moderator rubric that determined his entry's classification. |
| 6 | **Permanent Archive** (`pg-archive`) | Understands that the entry is retained as long-term documentation. The archive preserves the comment as a record, not as a punishment — per the "Patterns, Not People" principle. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P25** | Didn't think comment would have lasting consequences | **PA** (Permanent Archive) | The archive's existence makes the consequence tangible: public comments are documented permanently. This is precisely the platform's purpose — creating accountability for speech that the commenter assumed would be consequence-free. The archive does not add consequences; it makes existing public speech findable. |
| **P26** | Severity rating feels disproportionate | **ECP** (Entry Count Pills) + **APP** (Appeals System) | The entry count pill shows factual data ("1 Verified Entry") rather than an inflammatory label. The appeals system provides a formal channel to contest the categorisation if Shakib believes the classification is incorrect — though in this case, the grounds don't apply. The Methodology page documents the severity rubric, making the classification transparent rather than arbitrary. |
| **P27** | Embarrassed but unwilling to acknowledge harm | **M&E** (Methodology & Ethics) | The Methodology page presents the guiding principle "Patterns, Not People" — the platform documents speech patterns, not character judgments. It does not require or expect rehabilitation. The archive is documentation, not a moral verdict. This framing does not demand acknowledgment from Shakib; it simply maintains the record. |

### Outcome
Shakib finds his entry, considers an appeal, and determines that the grounds don't apply — the screenshot is genuine and the context is accurate. He reads the Methodology page and understands the classification criteria. The platform does not require him to acknowledge harm — it documents what was publicly said. Whether he reflects on his behaviour is his decision.

---

## 10. Anonymous / Pseudonymous — Bad Actor (Weaponisation Attempt)

**Role:** Unknown identity, variable digital literacy. Attempting to misuse the platform.

### Trigger
A man wants to damage his ex-wife's new partner's reputation. He fabricates a screenshot showing a victim-blaming comment and attempts to submit it through the platform.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Submit Evidence** (`pg-submit`) | Opens the submission form. |
| 2 | **Honeypot Check** | If using a bot: the hidden honeypot field (`id="honeypotField"`) is filled automatically. The submission is silently accepted but flagged and discarded — the bad actor receives no indication of failure. |
| 3 | **Rate Limiting** | If attempting mass submissions: hits the 30-second cooldown between submissions and the 10-submission-per-session cap. Cannot flood the queue. |
| 4 | **Submission** | Enters the fabricated screenshot, a target's Facebook URL, and a source post URL. Submits. |
| 5 | **Moderation Queue** | The submission enters the moderation queue. A trained moderator checks the screenshot against the source URL — the URL shows no such comment. |
| 6 | **Rejection** | The submission is rejected as fabricated. The moderator logs the rationale. |
| 7 | **Fingerprinting** | The submitter's fingerprint (metadata, timing, browser characteristics) is recorded by the Submission Fingerprinting system. |
| 8 | **Repeat Offender Tracking** | If a pattern of bad-faith submissions is detected, the escalation tiers apply: warning → suspension → permanent restriction → legal referral. |
| 9 | **Referral** | For confirmed fabrication or coordinated targeting, evidence is referred to the Bangladesh Cyber Tribunal or law enforcement. |

### Pain Point Resolution

These are "frustrations" from the Bad Actor's perspective — the platform *intends* for these to remain frustrations. The resolution is the defence mechanism working as designed.

| # | Pain Point (Bad Actor's Frustration) | Feature | How the Platform Defends |
|---|---|---|---|
| **P28** | Wants to submit fabricated evidence | **RL** (Rate Limiting + Honeypot + Anti-Harassment Enforcement) + **CG** (Contributor Guidelines) | Honeypot fields catch automated bots. Trained moderators verify every screenshot against the source URL before publication. The Contributor Guidelines explicitly state that false submissions result in permanent restriction. The Anti-Harassment Enforcement Mechanism 01 (Submission Fingerprinting) tracks metadata, timing, and browser characteristics to identify fabrication attempts. |
| **P29** | Wants to weaponise archive for personal disputes | **AUN** (Archive Use Notice + Redistribution Monitoring) + **RL** | The Archive Use Notice warns that redistribution for harassment violates the Terms and may constitute online abuse under law. Redistribution Monitoring (Enforcement Mechanism 03) detects coordinated campaigns. The Contributor Guidelines exclude personal disputes as a valid submission category. Moderator training (Standard 03) includes assessment for personal vendetta patterns. |
| **P30** | Wants to mass-submit or scrape data | **RL** (Rate Limiting + Honeypot) | Rate limiting enforces a 30-second cooldown and 10-submission-per-session cap. Honeypot fields detect automated tools. Repeat Offender Tracking (Enforcement Mechanism 02) escalates from warning to permanent restriction to legal referral. The combination of technical and procedural barriers makes mass submission or automated scraping impractical. |

### Outcome
The bad actor's fabricated submission is caught during moderation. Their fingerprint is recorded. Repeated attempts trigger escalation. The platform's layered defence — honeypot, rate limiting, moderator verification, fingerprinting, and referral to authorities — prevents weaponisation while maintaining the archive's integrity.

---

## 11. Barrister Nasreen Sultana — Legal Advisor

**Role:** Advocate, Supreme Court of Bangladesh; digital rights specialist, 45, Dhaka. High digital literacy.

### Trigger
A client contacts Barrister Sultana after discovering they have an entry in the Daag archive. The client wants to know if the entry can be removed through legal action and whether the platform itself is operating lawfully under Bangladeshi law.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Terms of Use** (`pg-terms`) | Reviews all 6 sections: Purpose & Permitted Use, Submission Responsibilities, No Verdict / No Guarantee, Intellectual Property, Limitation of Liability, and Governing Law (Bangladesh law, Dhaka courts jurisdiction). |
| 2 | **Methodology & Ethics** (`pg-ethics`) | Reviews the Guiding Principles, verification standards, and moderator training to assess whether the platform meets evidentiary standards. |
| 3 | **Legal Compliance** (on Methodology page) | Examines: DSA 2018 Awareness, Defamation Safeguards (no editorialising, context maintained), Right to Reply (appeals accessible without legal representation), and Cooperation with Authorities (lawful court orders, submitter confidentiality). |
| 4 | **Data Retention Policy** (on Methodology page) | Reviews all 4 retention tiers: published entries (indefinite), rejected submissions (90 days), appeal records (2 years then anonymised), submitter contact info (180 days then deleted). |
| 5 | **Appeals** (`pg-appeals`) | Examines the appeals process: formal dispute form, 6 grounds for appeal, supporting evidence upload, 14-day review timeline, separate panel, binding decisions. |
| 6 | **Screenshot Handling** (on Methodology page) | Reviews: verification against source URL, secure encrypted storage, EXIF metadata stripping, blurred public display. |
| 7 | **Advisory** | Advises her client on whether an appeal (platform process) or legal action (court process) is the appropriate route, based on the platform's documented procedures and legal framework. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P31** | Legal framework unclear and evolving | **LC** (Legal Compliance) | The Legal Compliance section addresses the platform's position under Bangladeshi law: DSA 2018 awareness, defamation safeguards, cooperation with court orders, and governing law declaration (Bangladesh, Dhaka courts). While the legal framework is evolving, the platform documents its compliance posture transparently — giving Barrister Sultana the information she needs to assess legality and advise her client. |
| **P32** | Clients conflate embarrassing with defamatory | **ToU** (Terms of Use) + **LC** (Legal Compliance) | The Terms of Use (Section 3: No Verdict / No Guarantee) clarify that entries are documentation, not legal verdicts. The Defamation Safeguards section documents that the platform does not editorialise — it preserves the original comment with context and attribution. This distinction helps Barrister Sultana explain to clients that a documented true statement is not defamation, even if it is embarrassing. |
| **P33** | Needs detailed data handling / retention / appeals info | **DRP** (Data Retention Policy) + **APP** (Appeals System) | The Data Retention Policy provides specific, timed retention rules for each data category (published entries, rejected submissions, appeal records, submitter info). The Appeals page documents the full dispute process with defined grounds, timelines, and outcomes. Together, these give Barrister Sultana the procedural detail she needs to advise clients on their options and rights. |

### Outcome
Barrister Sultana finds comprehensive legal, procedural, and data handling documentation across the Terms of Use, Legal Compliance, Data Retention Policy, and Appeals sections. She can advise her client with specificity on the platform's legal posture, the distinction between embarrassment and defamation, and the available remedy (appeal vs. court action).

---

## 12. MP Tahmina Akhter — Policymaker

**Role:** Member of Parliament, 50, Dhaka. Low-to-moderate digital literacy; relies on staff for technical details.

### Trigger
MP Akhter's office is preparing a briefing on online violence against women. An advocacy NGO (Rumana's organisation) has referenced Daag's analytics data in a submitted policy brief. The MP wants to verify the source before citing it in a committee hearing.

### Journey Steps

| Step | Page / Action | What Happens |
|---|---|---|
| 1 | **Home** (`pg-home`) | Visits the platform via the link in the NGO's brief. Reads the hero section and project summary. |
| 2 | **About** (`pg-about`) | Reviews the project's origins, team, and institutional backing. Assesses whether the platform is a credible, non-partisan source. |
| 3 | **Pattern Analytics** (`pg-analytics`) | Examines the analytics dashboard: summary statistics (1,284 archived, 94% verification rate), monthly trends (bar chart), category distribution, and incident type breakdown. The visual format — bar charts with percentages and summary cards — is accessible without technical expertise. |
| 4 | **Methodology & Ethics** (`pg-ethics`) | Reviews the Guiding Principles (especially "Evidence Over Outrage" and "Moderated Before Published"), verification standards, and moderator training. Assesses whether the platform is methodologically responsible. |
| 5 | **Terms of Use** (`pg-terms`) | Reviews the platform's legal framework: governing law (Bangladesh), permitted uses, no-verdict clause. |
| 6 | **Legal Compliance** (on Methodology page) | Reviews DSA awareness, defamation safeguards, cooperation with authorities. Confirms the platform is operating within a legal compliance framework before citing it publicly. |
| 7 | **Staff Briefing** | Directs her staff to prepare a summary of the analytics data and methodology for the committee briefing. |
| 8 | **Committee Hearing** | May invite the Daag team to present at a committee hearing on cyber violence. |

### Pain Point Resolution

| # | Pain Point | Feature | How It Resolves |
|---|---|---|---|
| **P34** | Evidence is anecdotal or politically motivated | **PAN** (Pattern Analytics) | The analytics dashboard presents verified, aggregate data — not anecdotes. Each statistic traces back to individually verified entries with documented provenance. The Guiding Principle "Evidence Over Outrage" and the 94% verification rate demonstrate that the data is evidence-based, not politically curated. |
| **P35** | Needs clear visual data, not jargon | **PAN** (Pattern Analytics) | The analytics page presents data as: summary statistic cards (total archived, verification rate), monthly bar charts, horizontal category bars with percentages, and incident type breakdowns. No academic jargon, no raw datasets. The visual format is designed for inclusion in policy briefs and committee presentations. |
| **P36** | Must confirm platform is responsible before citing | **M&E** (Methodology & Ethics) + **ToU** (Terms of Use) + **LC** (Legal Compliance) | The Methodology page documents guiding principles, verification standards, and moderator training. The Terms of Use establish the legal framework and governing law. The Legal Compliance section addresses DSA awareness, defamation safeguards, and cooperation with authorities. Together, these demonstrate that the platform is methodologically responsible and legally compliant — giving MP Akhter the confidence to cite it in a public committee hearing. |

### Outcome
MP Akhter verifies that the analytics data cited in the NGO's brief comes from a methodologically sound, legally compliant, and non-partisan source. She directs her staff to include the data in the committee briefing. The visual analytics format requires no technical translation for committee members.

---

## Complete Pain Point Coverage Matrix

The following matrix confirms that every pain point (P1–P36) is explicitly addressed in the journey sections above.

| Pain Point | Persona | Primary Resolving Feature(s) | Addressed In Section |
|---|---|---|---|
| P1 | Fatima | Permanent Archive | §1 |
| P2 | Fatima | Permanent Archive + Archive Use Notice | §1 |
| P3 | Fatima | Submitter Anonymity | §1 |
| P4 | Nusrat | Profile Search | §2 |
| P5 | Nusrat | Profile Search | §2 |
| P6 | Nusrat | Profile Search | §2 |
| P7 | Rafiq | Profile Search | §3 |
| P8 | Rafiq | Profile Search | §3 |
| P9 | Rafiq | Entry Count Pills + Methodology & Ethics | §3 |
| P10 | Sadia | Moderator Wellbeing Protocol | §4 |
| P11 | Sadia | Moderator Standards + Contributor Guidelines | §4 |
| P12 | Sadia | AI Limitations Disclosure | §4 |
| P13 | Dr. Rahman | Pattern Analytics | §5 |
| P14 | Dr. Rahman | Pattern Analytics | §5 |
| P15 | Dr. Rahman | Methodology & Ethics | §5 |
| P16 | Meher | Permanent Archive | §6 |
| P17 | Meher | Methodology & Ethics | §6 |
| P18 | Meher | Terms of Use + Legal Compliance | §6 |
| P19 | Rumana | Pattern Analytics | §7 |
| P20 | Rumana | Pattern Analytics | §7 |
| P21 | Rumana | Pattern Analytics | §7 |
| P22 | Imran | Appeals System | §8 |
| P23 | Imran | Appeals System + Version Markers | §8 |
| P24 | Imran | Appeals System + Version Markers | §8 |
| P25 | Shakib | Permanent Archive | §9 |
| P26 | Shakib | Entry Count Pills + Appeals System | §9 |
| P27 | Shakib | Methodology & Ethics | §9 |
| P28 | Bad Actor | Rate Limiting + Honeypot + Contributor Guidelines | §10 |
| P29 | Bad Actor | Archive Use Notice + Redistribution Monitoring | §10 |
| P30 | Bad Actor | Rate Limiting + Honeypot | §10 |
| P31 | Barrister Sultana | Legal Compliance | §11 |
| P32 | Barrister Sultana | Terms of Use + Legal Compliance | §11 |
| P33 | Barrister Sultana | Data Retention Policy + Appeals System | §11 |
| P34 | MP Akhter | Pattern Analytics | §12 |
| P35 | MP Akhter | Pattern Analytics | §12 |
| P36 | MP Akhter | Methodology & Ethics + Terms of Use + Legal Compliance | §12 |

**Coverage: 36/36 pain points resolved. All 12 personas have complete journeys (trigger → steps → resolution → outcome).**

---

*Document prepared: May 2025*
*Platform: Daag · Every word leaves a mark.*
