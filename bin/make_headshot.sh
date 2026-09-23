#!/usr/bin/env bash
# make_headshot.sh -- build the small square headshot variants the homepage uses
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - The homepage note shows the headshot in a 40x40 CSS px circle
#           (.home-note__photo in _sass/_system.scss). Shipping the full-size
#           portrait (1765x2648, 575 KB) for that slot is wasteful, so this
#           script center-crops the source to a square (matching the CSS
#           `object-fit: cover`) and writes 1x/2x/3x WebP files plus a 2x JPEG
#           fallback. _layouts/about.liquid picks them via <picture>/srcset.
#           The 240 px WebP is the 2x source for the 120 px headshot on
#           /press/ (_pages/press.md), which also links the full original.
#           When the portrait is replaced, re-run this script. The large
#           original stays in place as the Open Graph image.
# Usage   - bash bin/make_headshot.sh [source.jpg]
#           (default source: assets/img/prof_pic_color.jpg; outputs sit next to
#           the source as <stem>-sq{40,80,120,240}.webp and <stem>-sq80.jpg)
# Requires - ImageMagick 7 (`magick`) or 6 (`convert`).
set -euo pipefail
cd "$(dirname "$0")/.."

SRC="${1:-assets/img/prof_pic_color.jpg}"
STEM="${SRC%.*}"
IM="$(command -v magick || command -v convert || true)"
[[ -n "$IM" ]] || {
  echo "make_headshot.sh: ImageMagick not found" >&2
  exit 1
}

# Crop geometry. Default: a centered square (the full-width top-to-bottom
# middle of a portrait). A full-length photo leaves the face a few pixels
# wide at 40 px, so HEADSHOT_CROP (ImageMagick WxH+X+Y, in source pixels)
# can name a head-and-shoulders square instead. For the current
# prof_pic_color.jpg (1765x2648, face upper right), use
#   HEADSHOT_CROP=820x820+905+590 bash bin/make_headshot.sh
if [[ -n "${HEADSHOT_CROP:-}" ]]; then
  CROP=(-crop "$HEADSHOT_CROP" +repage)
else
  CROP=(-gravity center -crop "%[fx:min(w,h)]x%[fx:min(w,h)]+0+0" +repage)
fi

for px in 40 80 120 240; do
  "$IM" "$SRC" -auto-orient "${CROP[@]}" \
    -resize "${px}x${px}" -strip -quality 82 "${STEM}-sq${px}.webp"
done
"$IM" "$SRC" -auto-orient "${CROP[@]}" \
  -resize 80x80 -strip -quality 82 -interlace Plane "${STEM}-sq80.jpg"

ls -l "${STEM}"-sq*.{webp,jpg}
