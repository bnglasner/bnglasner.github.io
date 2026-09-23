#!/usr/bin/env bash
# subset_fontawesome.sh -- rebuild the subset Font Awesome webfonts
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - The site uses about 15 Font Awesome glyphs. The full solid and brands
#           woff2 files are 214 KB and were downloaded on every page. This
#           script downloads the pristine Font Awesome Free woff2 files
#           (same version as _sass/font-awesome) and keeps only the icons
#           listed in bin/fontawesome-icons.txt.
# Usage   - bash bin/subset_fontawesome.sh   (from the repo root)
# Requires - curl, and python3 with fonttools and brotli:
#            python3 -m pip install fonttools brotli
set -euo pipefail
cd "$(dirname "$0")/.."

FA_VERSION="7.0.0" # keep in sync with the header of _sass/font-awesome/fontawesome.scss
LIST="bin/fontawesome-icons.txt"
VARS="_sass/font-awesome/_variables.scss"
OUT="assets/webfonts"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

command -v pyftsubset >/dev/null || {
  echo "pyftsubset not found: python3 -m pip install fonttools brotli" >&2
  exit 1
}

codepoints() { # $1 = solid|brands -> comma-separated U+XXXX list
  local style="$1" out="" name cp
  while read -r s name; do
    [[ -z "${s:-}" || "$s" == \#* || "$s" != "$style" ]] && continue
    cp="$(grep -m1 -E "^\\\$var-${name}: " "$VARS" | sed -E 's/.*: \\([0-9a-f]+);/\1/')"
    if [[ -z "$cp" ]]; then
      echo "unknown icon in $LIST: $style $name" >&2
      exit 1
    fi
    out="${out:+$out,}U+${cp}"
  done <"$LIST"
  echo "$out"
}

for pair in "solid:fa-solid-900" "brands:fa-brands-400"; do
  style="${pair%%:*}"
  font="${pair#*:}"
  curl -fsSL "https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@${FA_VERSION}/webfonts/${font}.woff2" -o "$TMP/${font}.woff2"
  pyftsubset "$TMP/${font}.woff2" \
    --unicodes="$(codepoints "$style")" \
    --flavor=woff2 --layout-features='*' --no-hinting \
    --output-file="$OUT/${font}.woff2"
  printf '%-16s %6d bytes -> %5d bytes\n' "$font" "$(wc -c <"$TMP/${font}.woff2")" "$(wc -c <"$OUT/${font}.woff2")"
done
