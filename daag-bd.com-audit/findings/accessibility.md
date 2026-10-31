# Accessibility findings

## Hero invisible and untappable below 1024px — Critical, fixed

Measured at 390px with Playwright:

| | 390px (before) | 1440px |
|---|---|---|
| near-white pixels in the `h1` box | **0** | 50,118 |
| red pixels in the `h1` box | **0** | 65,070 |
| `elementFromPoint` over the search input | `DIV.cork` | `INPUT` |
| real `click()` + type | **timed out** | value `'test'` |

Width scan: zero text pixels at 320, 360, 390, 414, 480, 560, 600, 640, 700,
768, 820, 900; normal at 1024, 1200, 1440. The DOM reported the element
`visible: true`, `opacity: 1`, box 350x80 the whole time — only the pixels
disagreed.

Cause: `.lede{position:absolute;z-index:5}` base, overridden to
`position:static` in `@media(max-width:1000px)`. `z-index` does not apply to
static elements, so `.cork` (z-index 0) and `.vig` (z-index 1) painted over it.

Fixed with `position:relative` **plus** `.board>.lede{left:auto;top:auto}` —
the second rule is required, and specificity matters: `.board>.lede` is two
classes and a one-class `.lede` rule cannot override its `left`, media query or
not. Without it the hero shifted 32px right and overhung the screen by 12px.

## Horizontal scroll 740–880px — Critical, fixed

`A.nav-cta` reached 882px while the hamburger only engaged at 720px.
Pre-existing (confirmed identical on the live site before the change).
Breakpoint raised to 900px. Re-swept: 252 checks (21 widths x 12 pages), zero
overflow.

## Contrast — fixed

0 AA failures across 3,348 text elements x 12 pages x 2 themes x 2 languages.

Two were found and fixed: `.skip-link` (4.43:1) and two 10px `--umber` labels on
`/submit` (4.48:1). `.logo-mark` sits at 4.43:1 and was deliberately left —
WCAG 1.4.3 exempts a logotype.

**The first version of this sweep reported 0 failures across all 48
combinations and was wrong.** It called `applyLang()` after setting
`data-theme`, which reset the attribute, so every run tested light mode. The
working version asserts the theme actually stuck before measuring.
