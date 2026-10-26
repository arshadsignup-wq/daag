# দাগ · Facebook Page Setup Pack

Everything below is copy-paste ready. Field names match Meta's **New Pages Experience**
(Page → Settings → Page setup / Page details). Where Meta's character limit is tight,
multiple lengths are given, use the longest one that fits.

---

## 1. Identity

| Field | Value |
|---|---|
| **Page name** | `Daag · দাগ` |
| **Username (@handle)** | `daagarchive` — final, claimed |
| **Page URL** | facebook.com/daagarchive |
| **Primary category** | **Nonprofit organization** |
| **Secondary categories** | **Community organization**, **Social service** |
| **Website** | https://www.daag-bd.com |
| **Email** | hello@daag-bd.com *(set this up before launch, see §6)* |
| **Phone** | Leave blank |
| **Address** | Leave blank. Set **Service area → Bangladesh** instead |
| **CTA button** | **Learn more** → https://www.daag-bd.com |

> **Do not** pick a News/Media/Publisher category. It routes the Page into Meta's news
> policy surface, suppresses link reach in several markets, and invites a different
> class of review. Nonprofit/Community is both accurate and safer.

**Name discipline:** keep `Daag · দাগ` exactly. Meta restricts how often a Page name can
change and reviews each change; renaming later to something more descriptive is a slow,
uncertain process. Lock it now.

---

## 2. Bio and About

**All page-facing copy is Bangla, and it lives in `copy-paste.html`**, open that in a
browser and copy from it. Keeping one canonical source stops the Bangla drifting out of
sync between files.

| What | Where | Notes |
|---|---|---|
| Bio ×4 lengths | deck §02 | Meta's Bio field is ~101 chars; Bangla characters count the same as Latin |
| About (full) | deck §03 | Paste into About → Additional information, and post it in the feed too |
| Messenger auto-reply | deck §06 | |

Two deliberate choices in that copy:

- **It names the differentiator, not just the claim.** "সোর্স লিংকসহ যাচাই করা" appears
  wherever there is room. Anyone can say *যাচাইকৃত*; being able to say every entry is
  checked against a live source link, and that every entry can be disputed, is what
  separates a documentation project from a shaming board. That matters more now that
  there is at least one broader Bangla-language reporting platform in this space.
- **Loanwords stay in Bangla script**, কমেন্ট, পোস্ট, লিংক, স্ক্রিনশট, প্রোফাইল,
  আর্কাইভ, মডারেটর. That is how Bangladeshi digital Bangla is actually written. Forcing
  সংরক্ষণাগার or প্রতিমন্তব্য in their place is what makes copy read as translated.

**Internal docs stay in English** (this file, `content-plan.md`, `moderation-and-risk.md`), since they are instructions for you rather than anything the audience sees.
Say the word if you want them in Bangla too.

---

## 4. Images: what to upload where

All files are in `facebook/assets/`. Sources in `assets/templates/`, rebuild with `./build.sh`.

| File | Size | Upload to |
|---|---|---|
| `profile.png` | 1024×1024 | Page profile picture (displays as a circle, already circle-safe) |
| `cover-hero.png` | 1640×856 | **Page cover photo. Use this one** |
| `cover.png` · `cover-b-statement.png` · `cover-c-definition.png` | 1640×856 | Alternate covers (brand statements rather than explainers) |
| `og-image.png` | 1200×630 | **Website**, not Facebook. See §7 |
| `post-stat.png` | 1080×1080 | Template for Pattern Analytics posts |
| `post-quote.png` | 1080×1080 | Template for redacted archive-entry posts |

`cover-hero.png` is the explainer cover: headline, what the archive actually contains, and
the two things a visitor can do. All text sits inside the centre safe box, so Facebook's
desktop crop (820×312) and mobile crop (640×360) both stay legible, and every line below
the fold starts right of the profile picture that overlaps the bottom-left on desktop.

---

## 5. Settings to change before the first post

**Page → Settings → Privacy → Page and tagging**

| Setting | Set to | Why |
|---|---|---|
| Profanity filter | **Strong** | Your comment section will attract exactly what the archive documents |
| Page moderation (blocklist) | Paste list from `moderation-and-risk.md` §2 | The default filter does not catch Bangla or Banglish |
| Allow others to post on the Page | **Off** | Removes an unmoderated surface entirely |
| Allow tagging the Page | **Off** initially | Prevents tag-based brigading |
| Message replies / auto-reply | **On**, template in §6 | Submissions will arrive by DM; redirect them to the portal |
| Country / age restrictions | **Leave open** | |

**Page → Settings → New Page experience → Page access**

- Add **at least three** people with Facebook access, at least one outside Bangladesh.
- Everyone with Page access: 2FA **on** (personal profile → Accounts Centre → Password and security).
- Nobody posts from their personal profile about running the Page.

> **Page Transparency is public.** Anyone can open it and see the Page's creation date,
> previous names, and the **country** of the people who manage it. It does not show
> names, but decide now whether Daag is publicly attributed to a person at all, and
> keep that decision consistent across the site, the Page and any press.

**If you ever boost a post:** anything about harassment or gender will be classified as
a social issue ad. That requires Meta's social-issues authorization, ID verification and
a public "Paid for by" disclaimer naming a person or organisation. Decide whether you
are willing to put a legal name on that *before* you click Boost.

---

## 6. Supporting bits to set up

**Email**: `hello@daag-bd.com`. Do not use a personal address anywhere on the Page.

**Messenger auto-reply** (Inbox → Automations → Instant reply): copy it from the deck,
`copy-paste.html` §06. It is Bangla, and it routes submissions to the portal because a
DM carries no source link and cannot be verified.

> Verify 999 / 109 / 1098 are still the correct national numbers on the day you publish.

---

## 7. One website fix to ship before you post the link

`index.html:25` and `:34` point `og:image` / `twitter:image` at **`og-image.svg`**.
**Facebook does not render SVG in link previews.** Every share of daag-bd.com, including
from this Page, currently produces a card with no image, which badly hurts click-through.

`assets/og-image.png` (1200×630) is the replacement. To ship it:

```bash
cp facebook/assets/og-image.png og-image.png
# then point both meta tags at the .png
sed -i '' 's|og-image\.svg|og-image.png|g' index.html
```

Deploy, then run the URL through **developers.facebook.com/tools/debug/** and click
**Scrape Again**, Facebook caches previews aggressively and will otherwise keep serving
the broken card for days.
