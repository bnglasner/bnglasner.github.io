#!/usr/bin/env python3
"""check_fa_icons.py -- fail if the built site uses a Font Awesome icon the subset lacks.

Author  - Ben Glasner (scaffolded 2026-09-23)
Purpose - assets/webfonts/fa-{solid,brands}-*.woff2 are subset to the icons listed
          in bin/fontawesome-icons.txt (see bin/subset_fontawesome.sh). An icon
          missing from the subset renders as an empty box without any build
          error. This check scans the built HTML and JS for
          `fa-solid fa-*` / `fa-brands fa-*` classes and exits 1 on any icon
          not in the list.
Usage   - python3 bin/check_fa_icons.py _site_verify
"""

import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
LIST = ROOT / "bin" / "fontawesome-icons.txt"
PATTERN = re.compile(r"\bfa-(solid|brands)((?:\s+fa-[a-z0-9-]+)+)")
# Font Awesome utility classes that are not glyphs.
UTILITIES = {"fw", "sm", "lg", "xs", "2x", "3x", "spin", "pulse", "border", "inverse", "stack", "stack-1x", "stack-2x"}


def allowed() -> set[tuple[str, str]]:
    out = set()
    for line in LIST.read_text().splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            style, name = line.split()
            out.add((style, name))
    return out


def main() -> int:
    site = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "_site")
    if not site.is_dir():
        print(f"check_fa_icons: {site} is not a directory", file=sys.stderr)
        return 2
    ok = allowed()
    missing: dict[tuple[str, str], str] = {}
    for path in list(site.rglob("*.html")) + list(site.rglob("*.js")):
        text = path.read_text(encoding="utf-8", errors="ignore")
        for style, tail in PATTERN.findall(text):
            for name in re.findall(r"fa-([a-z0-9-]+)", tail):
                if name in UTILITIES or (style, name) in ok:
                    continue
                missing.setdefault((style, name), str(path.relative_to(site)))
    if missing:
        for (style, name), where in sorted(missing.items()):
            print(f"check_fa_icons: fa-{style} fa-{name} (first seen in {where}) is not in bin/fontawesome-icons.txt")
        print("Add it to bin/fontawesome-icons.txt and run: bash bin/subset_fontawesome.sh", file=sys.stderr)
        return 1
    print(f"check_fa_icons: every Font Awesome icon in {site} is in the subset")
    return 0


if __name__ == "__main__":
    sys.exit(main())
