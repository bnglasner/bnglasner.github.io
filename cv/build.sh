#!/usr/bin/env bash
# build.sh -- compile the three CV variants and publish them to assets/pdf/
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - Single, repo-local build for the CV PDFs that the site links:
#             assets/pdf/Ben_Glasner_CV_full.pdf  (full CV, N pages)
#             assets/pdf/Ben_Glasner_CV_2p.pdf    (must be exactly 2 pages)
#             assets/pdf/Ben_Glasner_CV_1p.pdf    (must be exactly 1 page)
#             assets/pdf/Ben_Glasner_CV.pdf       (download alias = copy of full)
# Sources - cv/{full,2p,1p}/ variant .tex files, cv/shared/ (settings.sty,
#           photo), _bibliography/papers.bib (publications, via biblatex), and
#           _data/writing.yml + _data/media_page.yml (via cv/gen_sections.py).
#           Provenance: imported 2026-09-23 from the retired job-market-materials
#           pipeline's resume/build/overleaf_variants/, whose compiled PDFs were
#           byte-identical to the 2026-02-22 assets.
# TeX     - Prefers the user-owned TinyTeX (~/Library/TinyTeX/bin/<arch>) when
#           present, where the packages below were installed on 2026-09-23 with
#           `tlmgr install biber curve biblatex biblatex-ieee cochineal cabin
#           inconsolata fontawesome5 silence relsize comment csquotes xpatch
#           fontaxes mweights`; falls back to /Library/TeX/texbin (MacTeX /
#           BasicTeX), which must then carry the same packages.
# Needs   - TeX Live with pdflatex + biber and the packages curve, biblatex
#           (+ biblatex-ieee), cochineal, cabin, inconsolata (zi4), fontawesome5,
#           silence, relsize, comment, csquotes, xpatch, pgf/tikz; python3 + PyYAML.
# Usage   - bash cv/build.sh            # build all variants and publish
#           bash cv/build.sh --no-copy  # build into cv/_build only
# Build artifacts go to cv/_build/ (gitignored). The directory cv/ is excluded
# from the Jekyll build in _config.yml.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CV="$REPO/cv"
BUILD="$CV/_build"
OUT="$REPO/assets/pdf"
COPY=1
[[ "${1:-}" == "--no-copy" ]] && COPY=0

TINYTEX_BIN="$(ls -d "$HOME"/Library/TinyTeX/bin/*/ 2>/dev/null | head -n 1 || true)"
if [[ -n "$TINYTEX_BIN" && -x "${TINYTEX_BIN}pdflatex" ]]; then
  export PATH="${TINYTEX_BIN%/}:$PATH"
else
  export PATH="/Library/TeX/texbin:$PATH"
fi
echo "build.sh: using $(command -v pdflatex)"

for tool in pdflatex biber kpsewhich python3 pdfinfo; do
  command -v "$tool" >/dev/null 2>&1 || { echo "build.sh: missing required tool: $tool" >&2; exit 1; }
done
for pkg in curve.cls biblatex.sty ieee.bbx cochineal.sty cabin.sty zi4.sty fontawesome5.sty silence.sty relsize.sty comment.sty csquotes.sty xpatch.sty; do
  [[ -n "$(kpsewhich "$pkg")" ]] || { echo "build.sh: missing TeX package file: $pkg (install with tlmgr)" >&2; exit 1; }
done

# variant -> required page count ("" = no limit); bash 3.2-safe (macOS /bin/bash)
limit_for() { case "$1" in 2p) echo 2 ;; 1p) echo 1 ;; *) echo "" ;; esac; }

for v in full 2p 1p; do
  dir="$BUILD/$v"
  rm -rf "$dir"
  mkdir -p "$dir"
  cp "$CV/shared/"* "$dir/"
  cp "$CV/$v/"*.tex "$dir/"
  cp "$REPO/_bibliography/papers.bib" "$dir/papers.bib"
  python3 "$CV/gen_sections.py" "$dir"

  name="Ben_Glasner_CV_$v"
  (
    cd "$dir"
    pdflatex -interaction=nonstopmode -halt-on-error "$name.tex" >/dev/null
    biber --quiet "$name" >/dev/null
    pdflatex -interaction=nonstopmode -halt-on-error "$name.tex" >/dev/null
    pdflatex -interaction=nonstopmode -halt-on-error "$name.tex" >/dev/null
  ) || { echo "build.sh: $v failed; see $dir/$name.log" >&2; exit 1; }

  pages="$(pdfinfo "$dir/$name.pdf" | awk '/^Pages:/{print $2}')"
  limit="$(limit_for "$v")"
  if [[ -n "$limit" && "$pages" != "$limit" ]]; then
    echo "build.sh: $v is $pages pages; must be $limit" >&2
    exit 1
  fi
  echo "build.sh: $v -> $pages page(s), $(du -k "$dir/$name.pdf" | cut -f1) KB"
done

if [[ "$COPY" == 1 ]]; then
  for v in full 2p 1p; do
    cp "$BUILD/$v/Ben_Glasner_CV_$v.pdf" "$OUT/Ben_Glasner_CV_$v.pdf"
  done
  cp "$OUT/Ben_Glasner_CV_full.pdf" "$OUT/Ben_Glasner_CV.pdf"
  echo "build.sh: published to assets/pdf/ (Ben_Glasner_CV.pdf = full)"
fi
