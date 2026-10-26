#!/usr/bin/env bash
# Renders every template to PNG in ../ using headless Chrome.
# Edit a .html file, then re-run: ./build.sh   (or: ./build.sh cover  to match a subset)
set -euo pipefail
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
DIR="$(cd "$(dirname "$0")" && pwd)"; OUT="$DIR/.."
FILTER="${1:-}"

shot () { # shot <template> <out.png> <w> <h>
  [ -n "$FILTER" ] && case "$1" in *"$FILTER"*) ;; *) return 0;; esac
  "$CHROME" --headless --disable-gpu --no-sandbox --hide-scrollbars \
    --force-device-scale-factor=1 --virtual-time-budget=6000 \
    --screenshot="$OUT/$2" --window-size="$3,$4" "$DIR/$1" 2>/dev/null
  echo "  $2  ($3x$4)"
}

echo "Rendering Daag assets…"
# page identity
shot cover-hero.html          cover-hero.png          1640 856
shot cover.html               cover.png               1640 856
shot cover-b-statement.html   cover-b-statement.png   1640 856
shot cover-c-definition.html  cover-c-definition.png  1640 856
shot profile.html             profile.png             1024 1024
shot og-image.html            og-image.png            1200 630
# one graphic per launch post
shot post-01-manifesto.html   post-01-manifesto.png   1080 1080
shot post-02-name.html        post-02-name.png        1080 1080
shot post-03-methodology.html post-03-methodology.png 1080 1080
shot post-04-explainer.html   post-04-explainer.png   1080 1080
shot post-05-quote.html       post-05-quote.png       1080 1080
shot post-06-submit.html      post-06-submit.png      1080 1080
shot post-07-appeals.html     post-07-appeals.png     1080 1080
shot post-08-resources.html   post-08-resources.png   1080 1080
# reusable blanks
shot template-stat.html       template-stat.png       1080 1080
echo "Done → $OUT"
