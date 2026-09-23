#!/usr/bin/env bash
# render_icons.sh -- raster favicon fallbacks from the site mark
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - assets/img/bg-monogram.svg is the primary favicon, but iOS home-screen
#           and share sheets ignore SVG icons, crawlers request /favicon.ico
#           directly, and Google's search-result favicon wants a square icon
#           at a multiple of 48 px (favicon.ico carries 48/32/16). This script
#           renders the SVG once in headless Chrome (so its CSS custom
#           properties and outlined Newsreader paths render exactly as a
#           browser draws them; ImageMagick's built-in SVG
#           renderer ignores the <style> block) and derives:
#             assets/img/apple-touch-icon.png   180x180, opaque, padded
#             favicon.ico                       16/32/48 multi-size, repo root
#           The background is the light theme's --paper-bg, read from
#           _sass/_themes.scss so a palette change carries through. Light-theme
#           colors are used because raster icons cannot follow
#           prefers-color-scheme.
#           Re-run whenever bg-monogram.svg or the palette changes.
# Usage   - bash bin/render_icons.sh
# Requires - Google Chrome (headless) and ImageMagick 7 (`magick`) or 6 (`convert`).
set -euo pipefail
cd "$(dirname "$0")/.."

SVG="assets/img/bg-monogram.svg"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
IM="$(command -v magick || command -v convert || true)"
[[ -f "$SVG" ]] || { echo "render_icons.sh: $SVG not found" >&2; exit 1; }
[[ -x "$CHROME" ]] || command -v "$CHROME" >/dev/null 2>&1 || {
  echo "render_icons.sh: Chrome not found (set CHROME=/path/to/chrome)" >&2
  exit 1
}
[[ -n "$IM" ]] || { echo "render_icons.sh: ImageMagick not found" >&2; exit 1; }

# First --paper-bg declaration in the theme file is the light theme.
BG="$(grep -m1 -oE -- '--paper-bg: *#[0-9a-fA-F]{3,8}' _sass/_themes.scss | grep -oE '#[0-9a-fA-F]+')"
[[ -n "$BG" ]] || { echo "render_icons.sh: could not read --paper-bg from _sass/_themes.scss" >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cp "$SVG" "$TMP/mark.svg"
# 512 px canvas; the mark fills 84 percent of it so the iOS corner mask and
# small-size downsampling do not clip the rule under the letters.
cat >"$TMP/icon.html" <<HTML
<!doctype html>
<html><head><meta name="color-scheme" content="light"><style>
html,body{margin:0;width:512px;height:512px;background:$BG;overflow:hidden}
img{display:block;width:430px;height:430px;margin:41px}
</style></head><body><img src="mark.svg" alt=""></body></html>
HTML

"$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --force-prefers-color-scheme=light --window-size=512,512 \
  --screenshot="$TMP/icon-512.png" "file://$TMP/icon.html" >/dev/null 2>&1

"$IM" "$TMP/icon-512.png" -crop 512x512+0+0 +repage "$TMP/icon-512.png"
"$IM" "$TMP/icon-512.png" -resize 180x180 -strip assets/img/apple-touch-icon.png
"$IM" "$TMP/icon-512.png" -define icon:auto-resize=48,32,16 favicon.ico

echo "render_icons.sh: wrote assets/img/apple-touch-icon.png, favicon.ico (background $BG)"
