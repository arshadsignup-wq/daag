# দাগ · Facebook Page pack

| File | What it is |
|---|---|
| `reel-captions.html` | **Open this in a browser**, one Bangla caption per film with one-click copy, paired with its MP4 filename, plus the voice notes the captions follow |
| `copy-paste.html` | **Open this in a browser**, every field and caption with one-click copy buttons, live character counts against Meta's limits, and a saved setup checklist |
| `page-setup.md` | Every Page field, copy-paste ready: name, handle, category, bio (EN/BN), full About (EN/BN), CTA, settings, admin security |
| `content-plan.md` | Content pillars, cadence, pinned manifesto + first 4 weeks of bilingual posts, pre-post checklist |
| `moderation-and-risk.md` | Comment moderation SOP, Bangla/Banglish blocklist, reply templates, takedown & crisis playbook |
| `assets/cover-hero.png` | **Hero cover, recommended.** Explains the project in one glance, 1640×856 |
| `assets/cover.png` | Cover A: lockup, 1640×856 |
| `assets/cover-b-statement.png` | Cover B: statement, 1640×856 |
| `assets/cover-c-definition.png` | Cover C: definition, 1640×856 |
| `assets/profile.png` | 1024×1024 profile picture (circle-safe) |
| `assets/og-image.png` | 1200×630 link-preview card, **for the website**, already wired into `index.html` |
| `assets/post-01…08-*.png` | One 1080×1080 graphic per launch post, paired with its caption |
| `assets/template-stat.png` | Reusable Pattern Analytics blank |

All three covers keep their text inside both Facebook crops (desktop 820×312, mobile
640×360) and clear of the profile picture that overlaps the bottom-left on desktop.

## Working through it

Open `copy-paste.html` in Chrome and work top to bottom, it carries the same copy as the
markdown files, but clickable. The markdown files hold the reasoning behind each choice.

## Editing the images

Sources are HTML in `assets/templates/`, rendered with headless Chrome so Bangla and the
brand fonts (Playfair Display / Inter / DM Mono) shape correctly.

```bash
cd facebook/assets/templates
# edit the .html file you want to change
./build.sh          # re-renders all five PNGs into ../
```

`_base.css` holds the brand tokens from the design system (§14 of the project docs).

## Order of operations

1. Deploy the `og-image.png` change (already applied to `index.html`), then re-scrape the
   URL at developers.facebook.com/tools/debug/
2. Upload `profile.png` and `cover.png`; set name, handle, category, bio, About, CTA
3. Apply every setting in `page-setup.md` §5. **Blocklist before the first post**
4. Publish the pinned manifesto, then follow `content-plan.md`
