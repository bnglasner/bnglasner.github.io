#!/usr/bin/env python3
# check_writing_authors.py -- pre-commit guard for _data/writing.yml integrity
# Author - Ben Glasner (scaffolded 2026-05-03)
# Purpose - Block commits that introduce a short_form or reports entry without an authors field.
# Reason  - PORTFOLIO_DEEP_DIVE flagged that several short_form entries presented co-authored
#           pieces as solo work because authors: was simply omitted. Site templates render the
#           absence as solo authorship by default; this hook closes the integrity gap.

from __future__ import annotations

import sys
from pathlib import Path

try:
    import yaml  # type: ignore
except ImportError:
    sys.stderr.write(
        "check_writing_authors.py requires PyYAML. Install via:\n"
        "  pip install pyyaml --break-system-packages\n"
    )
    sys.exit(2)


REPO_ROOT = Path(__file__).resolve().parent.parent
WRITING_YML = REPO_ROOT / "_data" / "writing.yml"

REQUIRED_FIELDS = {"title", "url", "outlet", "authors", "published", "description"}
LISTS_TO_CHECK = ("short_form", "reports")


def main() -> int:
    if not WRITING_YML.exists():
        sys.stderr.write(f"Expected file not found: {WRITING_YML}\n")
        return 2

    with WRITING_YML.open("r", encoding="utf-8") as fh:
        data = yaml.safe_load(fh)

    if not isinstance(data, dict):
        sys.stderr.write(
            f"{WRITING_YML} did not parse to a mapping; got {type(data).__name__}.\n"
        )
        return 2

    failures: list[str] = []

    for list_name in LISTS_TO_CHECK:
        entries = data.get(list_name, [])
        if entries is None:
            continue
        if not isinstance(entries, list):
            failures.append(
                f"{list_name}: expected a list, got {type(entries).__name__}"
            )
            continue
        for idx, entry in enumerate(entries):
            if not isinstance(entry, dict):
                failures.append(
                    f"{list_name}[{idx}]: expected a mapping, got {type(entry).__name__}"
                )
                continue
            title = entry.get("title", "<no title>")
            missing = REQUIRED_FIELDS - set(entry.keys())
            if missing:
                failures.append(
                    f"{list_name}[{idx}] '{title}' is missing required fields: "
                    f"{sorted(missing)}"
                )
            authors = entry.get("authors")
            if "authors" in entry and (
                not isinstance(authors, list)
                or len(authors) == 0
                or not all(isinstance(a, str) and a.strip() for a in authors)
            ):
                failures.append(
                    f"{list_name}[{idx}] '{title}': authors must be a non-empty list of "
                    "non-empty strings (use ['Ben Glasner'] for solo work)"
                )

    if failures:
        sys.stderr.write(
            "writing.yml integrity check failed:\n  - "
            + "\n  - ".join(failures)
            + "\n"
        )
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
