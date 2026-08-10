#!/usr/bin/env python3
# validate_data.py -- pre-commit validator for the structured data behind the site
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - Enforce the schemas documented in .claude/rules/schema-invariants.md.
#           A missing required field silently drops an entry from the rendered
#           page; this script turns that silent failure into a blocked commit.
# Scope   - _data/writing.yml, _data/media_page.yml, _data/socials.yml,
#           _bibliography/papers.bib <-> _data/venues.yml abbr cross-check,
#           and ISO 8601 date checks throughout.
# Note    - bin/check_writing_authors.py remains the focused authors-field guard;
#           this script is the broader schema check. Both run in pre-commit.

from __future__ import annotations

import datetime
import re
import sys
from pathlib import Path

try:
    import yaml  # type: ignore
except ImportError:
    sys.stderr.write(
        "validate_data.py requires PyYAML. Install via:\n"
        "  pip install pyyaml --break-system-packages\n"
    )
    sys.exit(2)


REPO_ROOT = Path(__file__).resolve().parent.parent
DATA = REPO_ROOT / "_data"
BIB = REPO_ROOT / "_bibliography" / "papers.bib"

ISO_DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")

WRITING_REQUIRED = {"title", "url", "outlet", "authors", "published", "description"}
MEDIA_ITEM_REQUIRED = {"outlet", "title", "url", "description"}
COVERAGE_ITEM_REQUIRED = {"outlet", "published", "title", "url", "description"}
SOCIALS_REQUIRED_KEYS = {
    "cv_pdf",
    "email",
    "rss_icon",
    "scholar_userid",
    "github_username",
    "linkedin_username",
    "x_username",
    "bluesky_url",
    "instagram_id",
    "tiktok_url",
    "threads_url",
    "substack_url",
}
SOCIALS_NESTED_KEYS = {"tiktok_url", "threads_url", "substack_url"}
BIB_ENTRY_GROUPS = {
    "peer_reviewed",
    "working_paper",
    "policy_report",
    "dissertation",
    "thesis",
}

failures: list[str] = []


def fail(msg: str) -> None:
    failures.append(msg)


def load_yaml(path: Path):
    if not path.exists():
        fail(f"{path.relative_to(REPO_ROOT)}: expected file not found")
        return None
    with path.open("r", encoding="utf-8") as fh:
        return yaml.safe_load(fh)


def is_iso_date(value) -> bool:
    # YAML parses an unquoted YYYY-MM-DD as datetime.date; quoted stays str.
    if isinstance(value, datetime.date):
        return True
    return isinstance(value, str) and bool(ISO_DATE_RE.match(value))


def is_absolute_url(value) -> bool:
    return isinstance(value, str) and value.startswith(("http://", "https://"))


# 1) _data/writing.yml
def check_writing() -> None:
    data = load_yaml(DATA / "writing.yml")
    if not isinstance(data, dict):
        fail("writing.yml: did not parse to a mapping")
        return
    for list_name in ("short_form", "reports"):
        entries = data.get(list_name) or []
        if not isinstance(entries, list):
            fail(f"writing.yml {list_name}: expected a list")
            continue
        for idx, entry in enumerate(entries):
            if not isinstance(entry, dict):
                fail(f"writing.yml {list_name}[{idx}]: expected a mapping")
                continue
            label = f"writing.yml {list_name}[{idx}] '{entry.get('title', '<no title>')}'"
            missing = WRITING_REQUIRED - set(entry)
            if missing:
                fail(f"{label}: missing required fields {sorted(missing)}")
            if "published" in entry and not is_iso_date(entry["published"]):
                fail(f"{label}: published must be an ISO 8601 date (YYYY-MM-DD)")
            if "url" in entry and not is_absolute_url(entry["url"]):
                fail(f"{label}: url must be an absolute URL")
            authors = entry.get("authors")
            if "authors" in entry and (
                not isinstance(authors, list)
                or len(authors) == 0
                or not all(isinstance(a, str) and a.strip() for a in authors)
            ):
                fail(f"{label}: authors must be a non-empty list of non-empty strings")


# 2) _data/media_page.yml
def check_media_page() -> None:
    data = load_yaml(DATA / "media_page.yml")
    if not isinstance(data, dict):
        fail("media_page.yml: did not parse to a mapping")
        return
    lead = data.get("lead")
    if not isinstance(lead, dict) or not all(
        isinstance(lead.get(k), str) and lead.get(k).strip() for k in ("primary", "coverage")
    ):
        fail("media_page.yml: lead.primary and lead.coverage are required strings")

    for section_key, item_required, published_required in (
        ("sections", MEDIA_ITEM_REQUIRED, False),
        ("coverage_groups", COVERAGE_ITEM_REQUIRED, True),
    ):
        groups = data.get(section_key)
        if not isinstance(groups, list):
            fail(f"media_page.yml: {section_key} must be a list")
            continue
        for g_idx, group in enumerate(groups):
            if not isinstance(group, dict):
                fail(f"media_page.yml {section_key}[{g_idx}]: expected a mapping")
                continue
            g_label = f"media_page.yml {section_key}[{g_idx}] '{group.get('title', '<no title>')}'"
            if not isinstance(group.get("title"), str):
                fail(f"{g_label}: title is required")
            if section_key == "coverage_groups" and not isinstance(group.get("description"), str):
                fail(f"{g_label}: description is required")
            items = group.get("items")
            if not isinstance(items, list):
                fail(f"{g_label}: items must be a list")
                continue
            for i_idx, item in enumerate(items):
                if not isinstance(item, dict):
                    fail(f"{g_label} items[{i_idx}]: expected a mapping")
                    continue
                i_label = f"{g_label} items[{i_idx}] '{item.get('title', '<no title>')}'"
                missing = item_required - set(item)
                if missing:
                    fail(f"{i_label}: missing required fields {sorted(missing)}")
                if "url" in item and not is_absolute_url(item["url"]):
                    fail(f"{i_label}: url must be an absolute URL")
                if "published" in item and not is_iso_date(item["published"]):
                    fail(f"{i_label}: published must be an ISO 8601 date (YYYY-MM-DD)")
                if published_required and "published" not in item:
                    pass  # already caught by the missing-fields check above


# 3) _data/socials.yml
def check_socials() -> None:
    data = load_yaml(DATA / "socials.yml")
    if not isinstance(data, dict):
        fail("socials.yml: did not parse to a mapping")
        return
    missing = SOCIALS_REQUIRED_KEYS - set(data)
    if missing:
        fail(f"socials.yml: missing keys {sorted(missing)} (templates reference these by name)")
    for key in SOCIALS_NESTED_KEYS & set(data):
        value = data[key]
        if not isinstance(value, dict) or not is_absolute_url(value.get("url")):
            fail(f"socials.yml {key}: must be a mapping with an absolute `url` (nested form)")


# 4) _data/homepage.yml
def check_homepage() -> None:
    data = load_yaml(DATA / "homepage.yml")
    if not isinstance(data, dict):
        fail("homepage.yml: did not parse to a mapping")
        return
    note = data.get("currently_working_on")
    if not isinstance(note, str) or not note.strip():
        fail("homepage.yml: currently_working_on must be a non-empty string")
    if not is_iso_date(data.get("currently_working_on_updated")):
        fail("homepage.yml: currently_working_on_updated must be an ISO 8601 date (YYYY-MM-DD)")


# 5) papers.bib <-> venues.yml abbr cross-check, plus basic bib field checks
def check_bib_and_venues() -> None:
    venues = load_yaml(DATA / "venues.yml")
    venue_keys = set(venues.keys()) if isinstance(venues, dict) else set()

    if not BIB.exists():
        fail("_bibliography/papers.bib: expected file not found")
        return
    text = BIB.read_text(encoding="utf-8")
    # Strip comment lines so commented-out candidates are not parsed as entries.
    text = "\n".join(line for line in text.splitlines() if not line.lstrip().startswith("%"))

    entries = re.findall(r"@(\w+)\s*\{\s*([^,\s]+)\s*,(.*?)\n\}", text, flags=re.DOTALL)
    if not entries:
        fail("papers.bib: no BibTeX entries parsed — check for syntax damage")
        return

    seen_keys: set[str] = set()
    for entry_type, citekey, body in entries:
        label = f"papers.bib @{entry_type}{{{citekey}}}"
        if citekey in seen_keys:
            fail(f"{label}: duplicate citekey")
        seen_keys.add(citekey)

        fields = dict(re.findall(r"(\w+)\s*=\s*\{(.*?)\}\s*,?\s*\n", body, flags=re.DOTALL))
        for required in ("title", "author", "year"):
            if required not in fields:
                fail(f"{label}: missing required field `{required}`")
        entry_group = fields.get("entry_group")
        if entry_group and entry_group not in BIB_ENTRY_GROUPS:
            fail(
                f"{label}: entry_group `{entry_group}` is not one of {sorted(BIB_ENTRY_GROUPS)}"
            )
        abbr = fields.get("abbr")
        if abbr and venue_keys and abbr not in venue_keys:
            fail(
                f"{label}: abbr `{abbr}` has no matching key in _data/venues.yml "
                "(add one so the tag renders with a display name/color)"
            )


# 6) run everything
def main() -> int:
    check_writing()
    check_media_page()
    check_socials()
    check_homepage()
    check_bib_and_venues()

    if failures:
        sys.stderr.write(
            "Data schema validation failed:\n  - " + "\n  - ".join(failures) + "\n"
        )
        return 1

    print("validate_data.py: all checks passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
