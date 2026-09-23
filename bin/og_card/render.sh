#!/usr/bin/env bash
# render.sh -- re-render assets/img/og-card.png (the 1200x630 social card)
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - The card's deck is _pages/about.md's `headline`, verbatim, and its
#           fonts are the site's own woff2 files. Re-run this whenever the
#           headline, role, or palette changes, so the share preview matches.
# Usage   - bash bin/og_card/render.sh   (from the repo root; needs a build in _site_verify)

set -euo pipefail
cd "$(dirname "$0")/../.."

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
PORT=8299

# Serve the built site so the card's absolute /assets/fonts/ URLs resolve.
cp bin/og_card/og-card.html _site_verify/og-card.html
python3 -m http.server "$PORT" -d _site_verify >/dev/null 2>&1 &
SERVER=$!
trap 'kill $SERVER; rm -f _site_verify/og-card.html' EXIT
sleep 1

"$CHROME" --headless=new --hide-scrollbars --force-device-scale-factor=1 \
  --window-size=1200,630 --virtual-time-budget=3000 \
  --screenshot="$PWD/assets/img/og-card.png" "http://localhost:$PORT/og-card.html" 2>/dev/null

echo "render.sh: wrote assets/img/og-card.png"
