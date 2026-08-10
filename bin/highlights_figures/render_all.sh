#!/usr/bin/env bash
# render_all.sh — regenerate every homepage headline-wheel asset from source.
# Author - Ben Glasner (scaffolded 2026-08-10, with Claude)
# Purpose - The MP4/PNG pairs in assets/video/highlights/ are build artifacts:
#           never retouch them, re-run this. See README.md here for the
#           pipeline's design decisions and data provenance.
# Needs   - Rscript (ggplot2, ragg, systemfonts), python3, ffmpeg.
#
# Usage: bash bin/highlights_figures/render_all.sh   (from anywhere)

set -euo pipefail
cd "$(dirname "$0")"
REPO_ROOT="$(cd ../.. && pwd)"

echo "==> 1/4 instance site woff2 fonts to static TTFs (ragg cannot read woff2)"
mkdir -p fonts
python3 - "$REPO_ROOT" <<'EOF'
import sys, os
try:
    from fontTools.ttLib import TTFont
    from fontTools.varLib.instancer import instantiateVariableFont
except ImportError:
    sys.exit("needs fonttools + brotli: pip install fonttools brotli --break-system-packages")
root = sys.argv[1]
fonts_dir = os.path.join(root, "assets", "fonts")
out_dir = os.path.join(os.getcwd(), "fonts")  # cwd is bin/highlights_figures
jobs = [
    ("newsreader/newsreader-latin-wght-normal.woff2", "newsreader", [400, 500]),
    ("public-sans/public-sans-latin-wght-normal.woff2", "public-sans", [400, 500, 600]),
    ("ibm-plex-mono/ibm-plex-mono-latin-400-normal.woff2", "ibm-plex-mono-400", None),
    ("ibm-plex-mono/ibm-plex-mono-latin-500-normal.woff2", "ibm-plex-mono-500", None),
]
for rel, stem, weights in jobs:
    src = os.path.join(fonts_dir, rel)
    if weights is None:
        f = TTFont(src); f.flavor = None
        f.save(os.path.join(out_dir, stem + ".ttf"))
        continue
    for w in weights:
        f = TTFont(src); f.flavor = None
        if "fvar" in f:
            instantiateVariableFont(f, {"wght": w}, inplace=True)
        f.save(os.path.join(out_dir, f"{stem}-{w}.ttf"))
print("fonts ready")
EOF

echo "==> 2/4 render frame sequences + posters (5 figures x 2 themes)"
for fig in fig_ladder fig_wages fig_rpp fig_socsec fig_california; do
  for theme in light dark; do
    SITE_THEME=$theme Rscript "$fig.R"
  done
done

echo "==> 3/4 stitch H.264 MP4s"
for d in out/frames/*/; do
  stem=$(basename "$d")
  ffmpeg -y -loglevel error -framerate 30 -start_number 1 -i "$d/f_%04d.png" \
    -c:v libx264 -pix_fmt yuv420p -crf 27 -preset slow -movflags +faststart \
    "out/$stem.mp4"
done

echo "==> 4/4 install into assets/video/highlights/"
mkdir -p "$REPO_ROOT/assets/video/highlights"
cp out/*.mp4 out/*.png "$REPO_ROOT/assets/video/highlights/"
ls -la "$REPO_ROOT/assets/video/highlights/"
echo "render_all.sh: done"
