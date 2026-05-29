# Daag · দাগ
### Civic Accountability Archive · Bangladesh

> *"Every word leaves a mark."*
> A verified public archive documenting misogynistic, victim-blaming, and abusive online commentary surrounding gender violence in Bangladesh.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [The Problem](#2-the-problem)
3. [What Daag Is — and Is Not](#3-what-daag-is--and-is-not)
4. [Name & Branding](#4-name--branding)
5. [Core Features](#5-core-features)
6. [How It Works — End-to-End Flow](#6-how-it-works--end-to-end-flow)
7. [Evidence Submission Portal](#7-evidence-submission-portal)
8. [Moderation System](#8-moderation-system)
9. [Public Archive](#9-public-archive)
10. [Profile Search](#10-profile-search)
11. [Pattern Analytics](#11-pattern-analytics)
12. [Appeals & Dispute System](#12-appeals--dispute-system)
13. [Methodology & Ethics](#13-methodology--ethics)
14. [Design System](#14-design-system)
15. [Technical Architecture](#15-technical-architecture)
16. [Current Status](#16-current-status)
17. [Launch Guide — Netlify Drop](#17-launch-guide--netlify-drop)
18. [Full-Stack Launch Guide — AI-Assisted](#18-full-stack-launch-guide--ai-assisted)
19. [Deliverables Produced](#19-deliverables-produced)

---

## 1. Project Overview

**Daag** is a crowdsourced digital accountability archive. It was built to document, categorise, and preserve publicly visible harmful online comments — specifically misogynistic, victim-blaming, and violent rhetoric — that appear in Facebook comment sections surrounding incidents of gender violence in Bangladesh.

The platform allows contributors to submit evidence of such comments, routes submissions through a human-moderated review process, and publishes verified entries in a searchable public archive. It also features a dedicated **Profile Search** tool — allowing users to look up whether a specific Facebook profile has verified entries in the archive.

**Platform type:** Civic accountability archive  
**Primary geography:** Bangladesh  
**Primary language:** Bangla, English, Banglish  
**Status:** Fully functional interactive prototype — ready for Netlify deployment

---

## 2. The Problem

When news of a rape, acid attack, or domestic violence case spreads on Facebook, the comment sections frequently become a second site of violence:

- Victims are blamed for their clothing, behaviour, and character
- Perpetrators are defended and celebrated
- Survivors are silenced and dehumanised

These comments disappear quickly — moderated, deleted, or buried by new content. But while they exist, they shape public discourse, discourage survivors from speaking, and signal to perpetrators that their community supports them.

**No systematic archive exists** to document this discourse. Daag was built to fill that gap.

---

## 3. What Daag Is — and Is Not

### Daag IS
- A verified evidence archive
- A civic documentation project
- A public awareness and transparency platform
- A digital accountability record
- A tool for informed personal decisions

### Daag IS NOT
- A public shaming tool
- A vigilante platform
- A harassment engine
- A revenge forum
- A verdict engine

Every design, editorial, and architectural decision was made with this distinction at the centre.

---

## 4. Name & Branding

### Name Selection Process

Five candidate names were evaluated:

| Name | Meaning | Notes |
|---|---|---|
| **Nishaan** (নিশান) | Mark / Trace | Quiet, permanent, investigative |
| **Daag** (দাগ) | Stain | Sharp, culturally resonant, cross-cultural |
| **Mukhabir** (মুখবির) | The Witness / Reporter | Journalistic weight |
| **Choritra** (চরিত্র) | Character | Reclaims victim-blamer's language |
| **Chihnit** (চিহ্নিত) | Identified / Marked Out | Institutional, legal feel |

**Selected: Daag (দাগ)**

**Rationale:** In Bangla, দাগ means *stain* — the kind that doesn't wash off. The name is deliberately perpetrator-facing. One word, cross-cultural, immediately understood, emotionally accurate, and carries moral permanence without sounding aggressive. Works well visually as a brand.

### Tagline
> *"Every word leaves a mark."*

### Brand Identity
- **Logo mark:** দাগ in Bangla script, Playfair Display serif, crimson background
- **Full name display:** Daag · দাগ
- **Submission reference format:** `DG-2025-XXXX`

---

## 5. Core Features

### Feature Overview

| # | Feature | Description |
|---|---|---|
| 1 | Evidence Submission Portal | Two-URL intake with screenshot upload, category tagging, and validation |
| 2 | Editorial Moderation Console | Full review dashboard with approve/reject/hold workflow |
| 3 | Verified Public Archive | Searchable entries with blurred screenshots and contextual annotations |
| 4 | Profile Search | Look up any Facebook profile by name or URL against the archive |
| 5 | Pattern Analytics | Aggregated charts — monthly trends, category distribution, incident types |
| 6 | Appeals & Dispute System | Formal dispute process with separate review panel |
| 7 | Methodology & Ethics Page | Full transparency on standards, principles, and process |
| 8 | About Page | Project origin story, team, and timeline |
| 9 | Terms of Use | Legal terms covering permitted use, submission responsibilities, liability, and governing law |

---

## 6. How It Works — End-to-End Flow

```
01. SIGHTING
    Contributor spots a harmful public comment on a Facebook post
    related to a gender violence incident

          ↓

02. SUBMISSION
    Submits via the Evidence Submission Portal:
    · Perpetrator's Facebook profile URL (required)
    · Source post URL — the post where the comment was found (required)
    · Screenshot upload (required)
    · Abuse category (required)
    · Incident type (required)
    · Additional tags, contextual notes, language, translation (optional)

          ↓

03. MODERATION QUEUE
    Submission held privately. No public display.
    Trained moderator reviews:
    · Screenshot authenticity
    · URL verification
    · Category accuracy
    · Context and completeness

          ↓

04. AI-ASSISTED CLASSIFICATION (Advisory)
    NLP toxicity scoring provides a confidence signal.
    Displayed as a percentage. Clearly labelled as advisory.
    Human decision is always final.

          ↓

05. ARCHIVE PUBLICATION
    Approved entries published with:
    · Blurred screenshot
    · Category and incident badges
    · Severity rating
    · Archived date
    · Contextual notes
    · Verification status
```

---

## 7. Evidence Submission Portal

### URL Fields (Two Required)

The submission form captures two distinct URLs:

| Field | What It Is | Example |
|---|---|---|
| **Perpetrator's Facebook Profile URL** | Direct link to the profile of the person who made the abusive comment | `facebook.com/profile-name` |
| **Source Post URL** | The public post or news article where the comment was found and identified | `facebook.com/post/...` |

This two-URL design was added specifically for evidential clarity — moderators need both to verify the comment's authenticity and context.

### Form Fields

**Required:**
- Perpetrator's Facebook Profile URL
- Source Post URL
- Screenshot Upload (PNG, JPG, WEBP · Max 10MB)
- Abuse Category
- Incident Type

**Optional:**
- Additional Tags
- Contextual Notes
- Language of Comment
- English Translation
- Submitter Contact Email (never published; internal moderation follow-up only)
- Relationship to Incident (Witness / Bystander, Friend or Family of Survivor, Journalist / Researcher, NGO / Advocacy Worker, Survivor, Other)

### Abuse Categories

- Victim Blaming
- Misogyny
- Appearance Humiliation
- Violent Rhetoric
- Sexual Harassment
- Dehumanizing Language
- Threats
- Hate Speech

### Incident Types

- Rape / Sexual Violence
- Domestic Violence
- Acid Violence
- Cyber Harassment
- Gender-Based Violence
- Public Harassment

### Additional Tags

- Rape Joke
- Slut-Shaming
- "She Deserved It"
- Provocative Dress
- Character Attack
- Coordinated Mob
- Doxxing Threat
- Religious Framing

### Screenshot Upload Behaviour

- Clicking the upload zone opens the file browser
- Drag-and-drop is supported
- On valid upload: shows thumbnail preview with filename, file size, format, and a remove button
- On invalid file type: inline error message
- On file over 10MB: rejection with clear message
- PDFs (appeals only): shows text confirmation instead of thumbnail

### Submission Standards

- Only publicly visible comments from public posts are accepted
- Private groups, direct messages, and closed conversations are rejected
- Fabricated or manipulated screenshots result in permanent submission restriction

### Success State

On valid submission, the form is replaced by a confirmation screen showing:
- Green checkmark
- "Submission Received" heading
- Reference number: `DG-2025-XXXX`
- "Review within 3–5 working days" notice
- "Submit Another" button to reset the form

### Rate Limiting & Anti-Spam

- **Cooldown:** 30-second minimum interval between submissions
- **Session cap:** Maximum 10 submissions per browser session
- **Honeypot field:** Hidden field that catches automated bot submissions
- **Button state:** Submit button is disabled during the cooldown period

### Contributor Guidelines

A detailed guidelines box is displayed before the submission form, covering:
- **What to submit:** Publicly visible comments containing misogynistic, victim-blaming, threatening, or dehumanizing language related to gender violence incidents
- **What NOT to submit:** Private messages, closed group content, personal disputes, political disagreements, fabricated material
- **Screenshot requirements:** Unedited, uncropped, unannotated; must show comment text, commenter name, and post context
- **Accuracy expectations:** Select the most accurate category; add contextual notes if uncertain
- **Submitter responsibility:** Confirmation that evidence is genuine; repeated false submissions result in permanent restriction

### Validation Rules

All required fields are checked on submit. Inline error messages appear under each failing field. Page scrolls to the first error. Errors clear when the field is corrected.

---

## 8. Moderation System

### Principle

Nothing becomes public automatically. Every submission enters a moderation queue and remains private until a trained human moderator takes an explicit action.

### Moderation Console

The moderator dashboard includes:

- **Sidebar queue overview** — counts by status (Pending, Approved Today, Rejected Today, On Hold, Active Appeals) and by category
- **Review cards** — one per pending submission, showing:
  - Submission ID (DG-2025-XXXX)
  - Category and language badges
  - Submission timestamp
  - Moderator notes / context
  - AI toxicity confidence bar (with mandatory advisory disclaimer)
- **Action buttons:** Approve · Reject · Hold · AI Report
- **Audit feedback:** Card dims and shows status label when actioned

### AI Confidence Display

```
AI Toxicity Confidence                    87%
[████████████████████░░░]

AI analysis is advisory only.
Human review required before any decision.
```

This disclaimer is hardcoded and cannot be removed by moderators.

### Queue Status Definitions

| Status | Meaning |
|---|---|
| Pending | Awaiting first review |
| Approved | Published to public archive |
| Rejected | Removed from queue, not published |
| On Hold | Escalated for senior review |

---

## 9. Public Archive

### What It Shows

Each archive entry displays:
- Blurred screenshot (restricted by default)
- Abuse category badge
- Incident type badge
- Language badge
- Severity badge (Severe / High / Moderate) with colour coding
- Contextual summary
- Archive ID, date, and verification status
- Version number (v1, v2, etc.) — tracks editorial revisions
- Edit marker with date — shown when an entry has been modified after initial publication

### Severity Colour Coding

| Severity | Colour |
|---|---|
| Severe | Crimson (`var(--accent)`) |
| High | Amber (`#e0a030`) |
| Moderate | Muted grey |

### Filtering & Search

- Keyword search bar
- Filter pills: All Entries, Victim Blaming, Misogyny, Violent Rhetoric, Dehumanizing, Threats, This Week
- Advanced Filter button
- Pagination ("Load more")

### Archive Use Notice

> This archive is intended for research, advocacy, journalism, and public awareness. Redistribution of individual entries for purposes of harassment, pile-ons, or vigilante action is a violation of our Terms of Use and may constitute online abuse under applicable laws.

---

## 10. Profile Search

### Purpose

The Profile Search feature allows any user to search the verified archive by Facebook profile name or URL — to see if that person has documented entries.

### Primary Use Case

> Person X (female) has been introduced to a potential spouse Person Y (male). Before the marriage is finalised, X searches Y's Facebook profile name or URL on Daag. If Y has verified entries — victim-blaming comments, misogynistic rhetoric, or violent language — X sees them, categorised and dated. She uses this as one input — not a verdict — in her own judgment.

Other use cases include pre-employment checks, NGO partner vetting, and journalistic research.

### Search Behaviour

1. User enters a Facebook profile name or URL in the search bar
2. Pressing Enter or clicking "Search Archive" triggers the search
3. Brief loading state is shown
4. Results appear as profile cards, or a "no results" message

### Profile Card (on match)

Each matched profile displays:
- Initials avatar
- Full name
- Facebook URL
- All documented abuse categories as badges
- **Entry count pill:** N Verified Entries / No Verified Entries (colour classes unchanged)
- Four stat counters: Total Entries, Categories, First Entry Date, Most Recent Entry Date
- Every documented comment listed with:
  - Category badge
  - Incident type badge
  - Severity badge
  - Comment summary
  - Archive date and verification status
- "File a Dispute" link if the subject believes the record is wrong

### No-Match Behaviour

When no results are found:
> *"No archived comments linked to "[search term]" were found in our verified archive. This does not mean the person has not made harmful comments — only that none have been submitted and verified yet. If you have evidence, you can submit it for review."*

The submit link routes directly to the Evidence Submission Portal.

### Demo Profiles (Prototype)

The current prototype includes three searchable demo profiles:
- **Md Rahim Uddin** — 4 entries, High Risk
- **Karim Ahmed** — 2 entries, Moderate Risk
- **Arif Hossain Shuvo** — 3 entries, High Risk

### Privacy Notice

> This search covers only publicly visible comments that have been verified and approved by our moderation team. No private data, messages, or unverified submissions are included. Search queries are not logged or stored. Note: aggregate search patterns may be monitored to detect systematic surveillance, coordinated lookup campaigns, or potential misuse of the archive for targeted harassment purposes.

---

## 11. Pattern Analytics

### Summary Stats (displayed as cards)

| Metric | Demo Value |
|---|---|
| Total Archived | 1,284 |
| Verification Rate | 94% |
| Avg. Review Time | 3.2 days |
| Active Moderators | 38 |

### Charts

**Monthly Submissions Bar Chart (2025)**

```
250 │                                         ██
200 │                                      ██ ██
150 │                               ██  ██ ██ ██ ██
100 │            ██  ██          ██ ██  ██ ██ ██ ██
 50 │  ██  ██  ██ ██ ██  ██     ██ ██  ██ ██ ██ ██
    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
```

**Category Distribution (Doughnut)**

| Category | Share |
|---|---|
| Victim Blaming | 31% |
| Misogyny | 24% |
| Violent Rhetoric | 18% |
| Dehumanizing Language | 14% |
| Threats | 8% |
| Other | 5% |

**Incident Type Breakdown**

| Incident Type | Share |
|---|---|
| Rape / Sexual Violence | 38% |
| Cyber Harassment | 22% |
| Domestic Violence | 17% |
| Public Harassment | 12% |
| Acid Violence | 7% |
| Gender Violence | 4% |

### Analytics Disclaimer

> Data reflects verified entries only. Category assignments are made by trained human moderators. AI classification data is used internally to support moderators and is not included in these published figures.

---

## 12. Appeals & Dispute System

### Who Can Appeal

Any individual whose comment appears in the archive may file a formal dispute.

### Grounds for Appeal

- Screenshot is fabricated or manipulated
- Critical context is missing
- Comment was taken out of context
- Submission was made in bad faith
- Category assignment is incorrect
- Other

### Appeal Form Fields

- Archive Entry ID (required)
- Grounds for Appeal (required)
- Supporting Statement (required)
- Supporting Evidence upload (optional — PDF, PNG, JPG)
- Contact Email (for decision notification)

### Process

- Appeals reviewed by a **separate panel** from the original moderator
- Review completed within **14 working days**
- Decisions are documented and auditable
- Successful appeals result in **removal or reclassification**

### Removal Requests

Grounds for removal include:
- Submission made in bad faith
- Manipulated screenshot
- Missing context that materially changes meaning
- Demonstrable rehabilitation

**Not grounds for removal:**
- Subject finds the entry embarrassing
- Subject disagrees with the categorisation

All removal requests reassessed within **21 working days**.

### Appeal Status Tracker

Users can enter their appeal ID to check current review status.

---

## 13. Methodology & Ethics

### Guiding Principles

**01 — Evidence Over Outrage**
Every submission is evaluated on verifiable evidence. Context, source URL, and screenshot authenticity are assessed before any entry is published.

**02 — No Private Data**
We document only publicly visible comments from public posts. Private messages, closed groups, and direct messages are outside scope and will be rejected.

**03 — Moderated Before Published**
Nothing enters the public archive without editorial review. Automated intake is only for queue management, not for publication decisions.

**04 — Patterns, Not People**
Analytics focus on behavioural patterns and category trends. No leaderboards of individuals. No ranking by volume of comments from a single source.

**05 — Appeals Are Binding**
Successful appeals result in removal or reclassification. Appeals reviewed by a separate panel. All decisions documented and auditable.

**06 — Anti-Harassment Enforcement**
Daag will permanently revoke submission access and refer to authorities any user who submits false evidence, uses the platform to target individuals outside its scope, or coordinates use of the archive as part of a harassment campaign.

**Anti-Harassment Enforcement Mechanisms:**
1. **Submission Fingerprinting** — metadata, timing, and browser characteristics used to flag repeated bad-faith submissions
2. **Repeat Offender Tracking** — escalation tiers from warning through to permanent restriction and legal referral
3. **Archive Redistribution Monitoring** — detection of coordinated redistribution for harassment purposes across social platforms
4. **Referral to Authorities** — confirmed malicious use may be referred to Bangladesh Cyber Tribunal or relevant law enforcement
5. **Community Reporting** — dedicated channel for users to report suspected platform misuse; reviewed within 7 working days

### Moderator Standards

All moderators are held to rigorous standards:
1. **Language Proficiency** — Bangla fluency required; Banglish assessment for slang and coded language
2. **Training Programme** — 20-hour mandatory programme covering verification, category definitions, trauma-informed practices, and manipulation detection
3. **Operational Process** — logged decisions with written rationale; standardised severity rubric; 30-submission session limit; borderline case escalation
4. **Wellbeing Protocol** — mandatory rest intervals, session time limits, peer support groups, quarterly mental health check-ins
5. **Code of Conduct** — no personal use, no discussion of pending submissions externally, evidence-based decisions only; violations result in immediate suspension

### Legal Compliance

Daag operates with awareness of the Digital Security Act (DSA) 2018, Cyber Security Act 2023, and ICT Act:
1. **DSA Awareness** — all content from public posts; no interception of private communications
2. **Defamation Safeguards** — no editorialising; entries carry context and attribution to original public posts
3. **Right to Reply** — formal appeals process accessible without legal representation
4. **Cooperation with Authorities** — compliance with lawful court orders while safeguarding submitter confidentiality

### Data Retention Policy

1. **Published entries** — retained indefinitely unless removed through successful appeal
2. **Rejected submissions** — retained 90 days for pattern detection, then permanently deleted
3. **Appeal records** — retained 2 years post-resolution, then anonymised to aggregate form
4. **Submitter contact info** — retained 180 days for moderation follow-up, then permanently deleted

### Screenshot Handling

1. **Verification** — checked against source URL; moderators assess for manipulation signs
2. **Secure Storage** — encrypted, access-controlled; only authenticated moderators access raw files
3. **Metadata Stripping** — EXIF data and embedded metadata removed before storage
4. **Public Display** — blurred by default; requires explicit user action to reveal

### AI Classification Limitations

AI-assisted toxicity scoring is used as a supporting tool for human moderators — not as a decision-making engine. All AI outputs carry an explicit confidence rating and are clearly flagged as advisory.

Known limitations:
- May struggle with Bangla slang and regional idioms
- Coded language and culturally specific victim-blaming patterns may not match training data
- Human review is mandatory for all borderline cases and all Bangla/Banglish entries

**Mandatory disclosure on all AI-assisted entries:**
> *"AI analysis was used to support — not determine — this categorization. Final decision made by a human moderator."*

---

## 14. Design System

### Color Palette

| Role | Hex | Usage |
|---|---|---|
| Background | `#09090B` | Page background |
| Card Dark | `#0F0F12` | Primary cards |
| Card Mid | `#141418` | Secondary cards |
| Card Light | `#1A1A20` | Tertiary surfaces |
| Deep Ink | `#7A1520` | Dark crimson |
| Ink | `#9E1C2C` | Borders, accents |
| Accent | `#BF3347` | Primary accent, badges |
| Warm White | `#EDE5D4` | Headings |
| Body Text | `#EDE9E0` | Primary body |
| Muted Text | `#9C9890` | Secondary body |
| Faint Text | `#555250` | Labels, captions |
| Umber | `#8C6A3F` | Gold accent, disclaimers |

### Typography

| Role | Font | Weight |
|---|---|---|
| Headings / Display | Playfair Display | 400 (regular), 700 (bold), italic |
| Body / UI | Inter | 400, 500, 600 |
| Monospace / Code / Labels | DM Mono | 400, 500 |

### Type Scale

| Element | Size |
|---|---|
| Hero headline | 54–58pt (clamp 3.2rem–5.8rem) |
| Section title | 32–36pt |
| Form title | 26pt |
| Card title | 13.5–14pt |
| Body text | 13–14pt |
| Labels (monospace) | 9–11pt |
| Captions | 9–10pt |

### Visual Identity

- **Left ink bar:** 6px crimson vertical strip on key pages
- **দাগ watermark:** Large Bangla script ghost text behind hero content
- **Grid background:** Subtle 56px dot grid on hero
- **Radial vignette:** Darkens hero edges for depth
- **Card accent:** Left 4–5px crimson border on evidence entries and feature cards
- **Badge system:** Mono font, all-caps, 2px border-radius
- **No decorative lines under headings**
- **No colored header/footer bars**

### Component Patterns

- Cards: flat dark background, subtle border, left accent strip
- Badges: `b-cr` (crimson), `b-nv` (navy), `b-gr` (grey)
- Status pills: `s-ok` (green), `s-wait` (amber), `s-rev` (blue)
- Upload zone: dashed border, hover transitions, inline preview
- Forms: dark input fields with crimson focus border
- Buttons: `btn-p` (primary crimson), `btn-g` (ghost with border)

---

## 15. Technical Architecture

### Current Build

The current prototype is a **single self-contained HTML file** (`daag.html`) requiring no server, no database, and no build process.

| Layer | Current | Production |
|---|---|---|
| Frontend | Single HTML file | Same HTML, connected to backend |
| Database | None (demo data hardcoded) | Supabase (PostgreSQL) |
| File Storage | None (preview only) | Supabase Storage |
| Authentication | None | Supabase Auth (moderator login) |
| Hosting | Netlify Drop | Netlify / Vercel |

### Recommended Production Stack

| Component | Tool | Purpose |
|---|---|---|
| Database | Supabase | Submissions, entries, appeals, moderators |
| File Storage | Supabase Storage | Screenshot hosting |
| Authentication | Supabase Auth | Moderator role-based access |
| AI Toxicity | OpenAI Moderation API / Perspective API | Advisory classification |
| Hosting | Netlify | Static file serving |
| Domain | Namecheap | Custom domain (daag.org) |

### Database Schema (Recommended)

```sql
-- Submissions table
CREATE TABLE submissions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  perpetrator_url TEXT NOT NULL,
  source_post_url TEXT NOT NULL,
  screenshot_url  TEXT,
  profile_name    TEXT,
  category        TEXT NOT NULL,
  incident_type   TEXT NOT NULL,
  context_note    TEXT,
  language        TEXT,
  translation     TEXT,
  tags            TEXT[],
  ai_score        NUMERIC,
  status          TEXT DEFAULT 'pending',
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- Appeals table
CREATE TABLE appeals (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  submission_id   UUID REFERENCES submissions(id),
  grounds         TEXT NOT NULL,
  statement       TEXT NOT NULL,
  evidence_url    TEXT,
  contact_email   TEXT,
  status          TEXT DEFAULT 'pending',
  reviewer_notes  TEXT,
  created_at      TIMESTAMPTZ DEFAULT now()
);
```

---

## 16. Current Status

### What Works in the Prototype

| Feature | Status |
|---|---|
| All 9 pages and navigation (incl. Terms of Use) | ✅ Fully functional |
| Evidence submission form with validation | ✅ Fully functional |
| Two-URL intake (profile + source post) | ✅ Fully functional |
| Screenshot upload with preview | ✅ Fully functional |
| Submission success screen with reference ID | ✅ Fully functional |
| Profile search (3 demo profiles) | ✅ Functional with demo data |
| Public archive (8 demo entries) | ✅ Functional with demo data |
| Analytics charts and stats | ✅ Functional with demo data |
| Moderation console with actions | ✅ Functional (UI only) |
| Appeals form | ✅ Functional (UI only) |
| Ethics, About, Methodology pages | ✅ Complete (expanded with Legal Compliance, Data Retention, Screenshot Handling, Moderator Standards, Anti-Harassment Enforcement) |
| Terms of Use page | ✅ Complete |
| Rate limiting & anti-spam | ✅ Functional (30s cooldown, 10/session cap, honeypot) |
| Contributor guidelines | ✅ Complete |
| Submitter accountability fields | ✅ Complete (optional) |
| Audit trail / version markers | ✅ Functional with demo data |
| Mobile responsive | ✅ Fully responsive |

### What Requires a Backend

| Feature | Requires |
|---|---|
| Real submissions saved | Supabase database |
| Screenshots stored | Supabase Storage |
| Real moderation queue | Supabase + auth |
| Real profile search | Supabase query |
| Real archive entries | Supabase query |
| Moderator login | Supabase Auth |

### Project Timeline

| Date | Milestone |
|---|---|
| Jan 2024 | Research phase — literature review on online GBV documentation |
| Jun 2024 | Methodology and ethics framework drafted |
| Oct 2024 | Beta moderation team assembled |
| Mar 2025 | Full prototype built — all 8 features live |
| **Now** | **Prototype live on Netlify. Seeking partners.** |
| Next | Real backend with Supabase. Full production launch. |

---

## 17. Launch Guide — Netlify Drop

**For:** Presenting to audiences, sharing with collaborators, showcasing as a portfolio project.  
**Time required:** Under 5 minutes.  
**Cost:** Free.

### Steps

1. Download `daag.html` from this project
2. Open your browser → go to **netlify.com/drop**
3. Drag and drop `daag.html` onto the page
4. Netlify generates a live URL: e.g. `daag.netlify.app`
5. Share the link

### What Works After Netlify Drop

Everything in the prototype works perfectly — all pages, navigation, forms, search, charts, moderation console, and animations. The demo data is included. The site works on any device globally.

### What Doesn't Work

Submitted forms do not save data. Screenshot uploads do not persist. Profile search only finds the 3 hardcoded demo profiles.

### Custom Domain (Optional, Later)

1. Buy domain from **Namecheap** (~$12/year for `.org`)
2. In Netlify → Site Settings → Domain Management → Add custom domain
3. In Namecheap → paste Netlify nameservers
4. Wait up to 24 hours — site is live at your domain

---

## 18. Full-Stack Launch Guide — AI-Assisted

**For:** Making Daag fully functional with real data.  
**Tools required:** Cursor (AI code editor), Supabase, Netlify, Namecheap.  
**Cost:** Domain ~$12/year. Everything else free tier.  
**Time:** 5 days with consistent effort.

### Tools Setup (Day 1)

1. Download **Cursor** from cursor.com
2. Create account at **supabase.com** → new project "daag"
3. Create account at **netlify.com**

### Cursor AI Prompts (Days 2–4)

Open `daag.html` in Cursor. Run these prompts in order:

**Prompt 1 — Connect Supabase:**
> "I have a single HTML file called daag.html. I want to connect it to Supabase as my database. Here are my Supabase project URL and API key: [paste from Supabase dashboard]. Help me add the Supabase JavaScript client to my HTML file."

**Prompt 2 — Save form submissions:**
> "In my daag.html file, when the user clicks 'Submit for Review', I want the form data — perpetrator URL, source post URL, category, incident type, tags, notes, language — to be saved to a Supabase table called 'submissions' with status 'pending'."

**Prompt 3 — Real screenshot upload:**
> "In my daag.html, when a user uploads a screenshot, I want it saved to Supabase Storage in a bucket called 'screenshots'. After upload, save the public URL into the submissions table alongside the other form data."

**Prompt 4 — Real archive:**
> "In my daag.html, the archive page shows hardcoded entries. I want it to fetch approved submissions from Supabase where status = 'approved', and display them using the existing HTML structure."

**Prompt 5 — Real moderation:**
> "In my daag.html, the moderation console shows hardcoded items. I want it to fetch submissions where status = 'pending' from Supabase. When Approve is clicked, update status to 'approved'. When Reject is clicked, update to 'rejected'."

**Prompt 6 — Real profile search:**
> "In my daag.html, profile search currently uses hardcoded data. I want it to search the Supabase submissions table where status = 'approved', matching the search query against a 'profile_name' column."

**Prompt 7 — Moderator login:**
> "I want to protect the moderation console in my daag.html so only logged-in moderators can access it. Use Supabase Auth with email and password login."

### Database Setup (Day 3)

In Supabase SQL Editor, run:

```sql
CREATE TABLE submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  perpetrator_url TEXT NOT NULL,
  source_post_url TEXT NOT NULL,
  screenshot_url TEXT,
  profile_name TEXT,
  category TEXT NOT NULL,
  incident_type TEXT NOT NULL,
  context_note TEXT,
  language TEXT,
  translation TEXT,
  tags TEXT[],
  ai_score NUMERIC,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE appeals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  submission_id UUID REFERENCES submissions(id),
  grounds TEXT NOT NULL,
  statement TEXT NOT NULL,
  evidence_url TEXT,
  contact_email TEXT,
  status TEXT DEFAULT 'pending',
  reviewer_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

### Deploy (Day 5)

1. Drag updated `daag.html` to **netlify.com/drop**
2. Add custom domain in Netlify settings
3. Point Namecheap nameservers to Netlify

### Error Resolution

When something doesn't work, paste the error back into Cursor:
> "I got this error: [paste error]. Fix it."

---

## 19. Deliverables Produced

| # | Deliverable | Format | Description |
|---|---|---|---|
| 1 | Daag Platform | `daag (1).html` | Full interactive prototype — 9 pages, all features (including Terms of Use) |
| 2 | Pitch Deck | `daag-pitch-deck.pptx` | 10-slide dark editorial presentation deck |
| 3 | Project Documentation | `daag-project-documentation.md` | This document |
| 4 | User Personas | `persona.md` | 12 structured user personas covering all platform stakeholder types |

### Files

- `daag (1).html` — The complete Daag platform prototype
- `daag-pitch-deck.pptx` — Pitch presentation (10 slides)
- `daag-project-documentation.md` — Full project documentation (this file)
- `persona.md` — 12 user personas (submitter, searchers, moderator, researcher, journalist, NGO worker, subjects, bad actor, legal advisor, policymaker)

---

## Notes for Presentation

- **Before sharing the prototype:** The Netlify Drop URL is ready to share immediately after upload
- **Before presenting the deck:** Update slide 10's footer — replace `[your email]` with your actual email address
- **Prototype disclaimer:** When presenting, clarify that archive entries, analytics, and profile search results are demo data — not real submissions
- **Backend next step:** If the project gains traction, the Cursor + Supabase path (Section 18) converts the prototype to a fully functional platform without hiring a developer

---

*Documentation prepared: May 2025*  
*Platform: Daag · দাগ · Every word leaves a mark.*
