# Technical findings

## Prerendered files shipped the homepage as the visible section — High

`prerender.py` rewrote the head per route and left the body alone, so `pg-home`
was the only section without `display:none` in all 18 non-home files. With
JavaScript disabled, every URL rendered the homepage.

Both generators now set the route's own section active. Verified with JS
disabled: `/about` → "Why Daag Exists", `/terms` → "Terms of Use", `/archive` →
"The Record", each post → its own title.

**Limit, stated plainly.** This fixes clients that apply CSS. It does not fix
text extractors that ignore it: trafilatura still returns byte-identical
homepage text (sha256 `bc30e96b0c`, 17,666 chars) for all ten route URLs,
because every file still contains all eleven sections. The eight posts are
unaffected — the injected article wins trafilatura's density heuristic.

## Generator order matters

`build-blog.py` rewrites the blog listing **inside `index.html`**, so it must
run before `prerender.py`. Running them the other way silently ships a stale
listing — it happened during this audit and `prerender --check` caught it.

## Sound

- robots.txt 200, sitemap declared, valid urlset, 19 locs = 18 rewrites + `/`
- every URL 200 with a self-referencing canonical (except `/`, trailing slash)
- HSTS, nosniff, SAMEORIGIN, Referrer-Policy, Permissions-Policy
- `noindex, nofollow` on `/admin.html`
- Brotli 363 KB → 98 KB
- `migrations/verify.sh`: passed 19, failed 0
- `node --check` on 145 KB of extracted inline JS: OK
