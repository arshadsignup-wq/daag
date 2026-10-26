# দাগ · Comment Moderation & Risk Playbook

The Page's own comment section will fill with exactly what the archive documents.
That is predictable, so handle it by procedure rather than by mood at 1am.

---

## 1. Comment moderation SOP

**Before hiding anything, capture it.** A victim-blaming comment on a Daag post is
itself archivable evidence, publicly posted. Screenshot it with the profile visible and
log it to the submission portal like any other entry, *then* hide it.

Then, in order:

| Comment type | Action |
|---|---|
| Slurs, sexualised abuse, threats | Capture → **Hide** → **Ban user from Page** |
| Victim-blaming, "what was she wearing" | Capture → **Hide**. Do not ban, they are the subject of the work, not an attacker |
| "This is just public shaming" | **Reply once**, with the §4 template. Never reply twice |
| Doxxing: anyone posting a name or profile link in your comments | **Delete immediately**, do not hide. Ban. This is the one that takes the Page down |
| Someone naming a specific accused person | **Delete.** Reply: evidence goes through the portal, not the comments |
| Legal threat | **Do not reply.** Screenshot, escalate to §5 |

**Hide, don't delete** for most things: hidden comments stay visible to their author and
their friends, so the author does not know to escalate. Delete only doxxing and anything
naming an individual, those create liability while they sit there.

**Two-hour rule:** someone moderates for two hours after every post. If nobody is
available, do not post.

---

## 2. Page blocklist

**Settings → Privacy → Page and tagging → Page moderation.** Paste as a comma-separated
list. Any comment containing these is auto-hidden. Also set **Profanity filter → Strong**
(it only covers English, the list below is the part that matters here).

```
মাগি, মাগী, বেশ্যা, বেশ্যামি, খানকি, খানকী, রেন্ডি, ছিনাল, নষ্টা, চরিত্রহীন, গণিকা,
চুদ, চোদা, চুদি, বাল, খাঙ্কি, মাগীবাজ, ধান্দাবাজ মহিলা,
magi, magee, beshya, beshsha, khanki, khanky, rendi, chinal, noshta, choda, chud, chudi,
maal, item, bazari, slut, whore, bitch, hoe, prostitute, randi
```

Add to it weekly from what actually turns up, attackers reshape spellings fast
(`m@gi`, `ma gi`, `মা গি`). The list is maintenance, not a one-time setup.

**Also blocklist, to stop doxxing in your own comments:**
```
facebook.com/, fb.com/, m.facebook.com/, profile.php, @gmail.com, 01
```
`01` catches Bangladeshi mobile numbers being posted. It will produce false positives,
check the hidden queue weekly and restore anything innocent.

---

## 3. What actually gets the Page removed

In rough order of likelihood:

1. **You post a screenshot with a visible name.** Meta's bullying and harassment
   standards prohibit content that exposes a private individual to shaming. This is the
   most likely cause and the most avoidable.
2. **A commenter doxxes someone in your comments and you leave it up.** The Page carries
   responsibility for its comment section.
3. **Coordinated mass-reporting.** Volume alone can trigger an automated restriction
   before a human ever looks. You cannot prevent this, only survive it (§5).
4. **Linking to the archive is construed as directing harassment.** Lower risk, but the
   reason the site's framing, methodology page and appeals process matter: they are the
   evidence that the destination is a documentation project.

Mitigation is structural, not tonal: no identifying evidence on Facebook, ever.

---

## 4. Reply templates

Write these once, use them verbatim, never improvise.

**"This is just public shaming / vigilantism."**
```
A fair challenge, and we have tried to build for it. Daag publishes only publicly
visible comments, verified against a source link. We publish no private messages, no
unverified claims, and no call to action against anyone. Every entry can be disputed
and reviewed by a panel separate from the moderators who approved it, and the full
standard is public: www.daag-bd.com/#methodology

If you think a specific entry is wrong, please file a dispute, that process exists
precisely for this.
```

**"What about false accusations / what if someone's account was hacked?"**
```
We don't publish accusations, we publish comments that are publicly visible at a
verifiable link, which a moderator has independently opened and confirmed. If an
account was compromised, that is exactly what the dispute process is for, and entries
can be amended or removed with the change recorded in the version history.
```

**Someone claiming an entry about them is wrong, in public comments:**
```
Please file a dispute at www.daag-bd.com so a review panel can look at it properly,
we can't verify identity or resolve this in a comment thread. Disputes are reviewed
by people who were not involved in approving the entry.
```
Then stop replying. Do not argue in a thread an opponent controls.

**Press enquiry:** `hello@daag-bd.com`. Never answer substantive press questions in comments.

---

## 5. Crisis playbook

### Page restricted or unpublished

1. Don't create a replacement Page immediately, evading enforcement with a duplicate
   gets both removed and can flag the admin accounts.
2. Appeal: **Business Support Home → Account Quality → the restriction → Request review.**
3. Appeal text: state the Page is a civic documentation project run under a published
   methodology, that no identifying evidence is posted on Facebook, and point to the
   site's methodology and appeals pages.
4. Post the status on Instagram and to the email list within 24 hours, factually.
5. Escalate through a partner organisation if you have one. A women's-rights NGO or a
   journalist with a Meta contact moves an appeal faster than a form.

**Prepare now so this is survivable:** download a Page data export monthly, keep the
caption archive in this repo, and have Instagram plus the email list already running.

### Mass-reporting wave

Do not respond publicly or post about "being attacked", it is fuel. Switch comments on
sensitive posts to off, hold the posting schedule 48 hours, keep capturing evidence of
the coordination (it is itself documentable), and let it pass.

### An admin is doxxed or threatened

Treat as the serious thing it is, not a comms problem. Everyone with Page access locks
down personal profiles (friends-only, profile picture guard, no location-tagged posts),
preserves evidence, files a police report under the relevant cyber-harassment provision,
and removes the exposed person's Page access *temporarily*, so the Page is not the route
to them while it is live.

### Legal notice or a cyber-security-law complaint

**Do not reply, delete the entry, or post about it.** Preserve everything, take the
specific entry out of public view pending review, this is defensible and looks
responsible, and get a lawyer who has handled cyber-law matters in Bangladesh before
you respond to anything.

Get a legal read on the project **before** the Page has an audience, not after the
first notice. A named public Page makes Daag an easy target to identify in a complaint,
and the governing cyber-security legislation has been used against documentation and
journalism projects. This is worth real money and a real lawyer.

---

## 6. Weekly maintenance

- [ ] Review the hidden-comments queue; restore false positives
- [ ] Add new slur spellings to the blocklist
- [ ] Log archivable abuse from your own comment section into the portal
- [ ] Check Page Quality for violations or warnings
- [ ] Confirm all admins still have 2FA active
