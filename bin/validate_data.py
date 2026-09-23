#!/usr/bin/env python3
# validate_data.py -- pre-commit validator for the structured data behind the site
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - Enforce the schemas documented in .claude/rules/schema-invariants.md.
#           A missing required field silently drops an entry from the rendered
#           page; this script turns that silent failure into a blocked commit.
# Scope   - _data/writing.yml, _data/media_page.yml, _data/socials.yml,
#           _data/homepage.yml (incl. proof-strip source cross-check),
#           _data/highlights.yml (incl. asset existence),
#           _bibliography/papers.bib <-> _data/venues.yml abbr cross-check,
#           papers.bib <-> _data/research_themes.yml theme cross-check,
#           media_page.yml related_work -> papers.bib citekey cross-check,
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
HIGHLIGHTS_REQUIRED = {"name", "eyebrow", "title", "hook", "alt", "date"}
THEME_REQUIRED = {"key", "title", "description"}
BIB_ENTRY_GROUPS = {
    "peer_reviewed",
    "working_paper",
    "policy_report",
    "dissertation",
    "thesis",
}

failures: list[str] = []


def parse_bib() -> list[tuple[str, str, dict[str, str]]]:
    """Return (entry_type, citekey, fields) for every uncommented papers.bib entry."""
    if not BIB.exists():
        return []
    text = BIB.read_text(encoding="utf-8")
    # Strip comment lines so commented-out candidates are not parsed as entries.
    text = "\n".join(line for line in text.splitlines() if not line.lstrip().startswith("%"))
    parsed = []
    for entry_type, citekey, body in re.findall(r"@(\w+)\s*\{\s*([^,\s]+)\s*,(.*?)\n\}", text, flags=re.DOTALL):
        fields = dict(re.findall(r"(\w+)\s*=\s*\{(.*?)\}\s*,?\s*\n", body, flags=re.DOTALL))
        parsed.append((entry_type, citekey, fields))
    return parsed


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
            if "bib_key" in entry:
                # Optional: the papers.bib citekey for the same work. The Policy
                # page's Reports cards link that entry's permalink page.
                if entry["bib_key"] not in {key for _, key, _ in parse_bib()}:
                    fail(f"{label}: bib_key `{entry['bib_key']}` is not a papers.bib citekey")


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
                if "related_work" in item:
                    # Optional: citekeys of papers.bib entries this item covers or
                    # discusses. Rendered as "Coverage and interviews" on each
                    # paper's permalink page, so every key must exist.
                    related = item["related_work"]
                    bib_keys = {key for _, key, _ in parse_bib()}
                    if not isinstance(related, list) or not related or not all(isinstance(k, str) for k in related):
                        fail(f"{i_label}: related_work must be a non-empty list of papers.bib citekeys")
                    else:
                        for key in related:
                            if key not in bib_keys:
                                fail(f"{i_label}: related_work citekey `{key}` is not in papers.bib")


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
    if "open_to" in data:
        open_to = data.get("open_to")
        if not isinstance(open_to, str) or not open_to.strip():
            fail("homepage.yml: open_to, when present, must be a non-empty string")
    if "proof" in data:
        check_homepage_proof(data.get("proof"))


PROOF_KINDS = {"appearances", "coverage", "journals"}
QUOTED_SECTION_TITLE = "Quoted in News Coverage"


def check_homepage_proof(proof) -> None:
    """The homepage proof strip may only name outlets and journals the site documents."""
    if not isinstance(proof, list) or not proof:
        fail("homepage.yml: proof, when present, must be a non-empty list")
        return
    if len(proof) > 3:
        fail(f"homepage.yml: proof has {len(proof)} lines; the strip is capped at three")
    media = load_yaml(DATA / "media_page.yml") or {}
    appearance_outlets: set[str] = set()
    all_outlets: set[str] = set()
    for section in media.get("sections") or []:
        for item in (section or {}).get("items") or []:
            outlet = (item or {}).get("outlet")
            all_outlets.add(outlet)
            if section.get("title") != QUOTED_SECTION_TITLE:
                appearance_outlets.add(outlet)
    for group in media.get("coverage_groups") or []:
        for item in (group or {}).get("items") or []:
            all_outlets.add((item or {}).get("outlet"))
    journals = {
        fields.get("journal", "").strip()
        for _, _, fields in parse_bib()
        if fields.get("entry_group") == "peer_reviewed" and fields.get("journal")
    }
    allowed = {"appearances": appearance_outlets, "coverage": all_outlets, "journals": journals}
    sources = {
        "appearances": "a direct-appearance outlet in media_page.yml sections",
        "coverage": "an outlet in media_page.yml",
        "journals": "the journal of a peer_reviewed papers.bib entry",
    }
    for idx, line in enumerate(proof):
        label = f"homepage.yml proof[{idx}]"
        if not isinstance(line, dict):
            fail(f"{label}: expected a mapping")
            continue
        missing = {"label", "kind", "url", "items"} - set(line)
        if missing:
            fail(f"{label}: missing required fields {sorted(missing)}")
        if not isinstance(line.get("label"), str) or not line.get("label", "").strip():
            fail(f"{label}: label must be a non-empty string")
        url = line.get("url")
        if not isinstance(url, str) or not (url.startswith("/") or is_absolute_url(url)):
            fail(f"{label}: url must be a site-relative path (/...) or an absolute URL")
        kind = line.get("kind")
        if kind not in PROOF_KINDS:
            fail(f"{label}: kind must be one of {sorted(PROOF_KINDS)}")
            continue
        items = line.get("items")
        if not isinstance(items, list) or not items or not all(isinstance(i, str) and i.strip() for i in items):
            fail(f"{label}: items must be a non-empty list of strings")
            continue
        for item in items:
            if item not in allowed[kind]:
                fail(f"{label}: `{item}` is not {sources[kind]}")


# 5) _data/highlights.yml — homepage headline wheel
def check_highlights() -> None:
    data = load_yaml(DATA / "highlights.yml")
    if not isinstance(data, list):
        fail("highlights.yml: did not parse to a list")
        return
    if not (3 <= len(data) <= 7):
        fail(f"highlights.yml: expected 3-7 entries, found {len(data)}")
    names: set[str] = set()
    for idx, entry in enumerate(data):
        if not isinstance(entry, dict):
            fail(f"highlights.yml [{idx}]: expected a mapping")
            continue
        label = f"highlights.yml [{idx}] '{entry.get('title', '<no title>')}'"
        missing = HIGHLIGHTS_REQUIRED - set(entry)
        if missing:
            fail(f"{label}: missing required fields {sorted(missing)}")
        name = entry.get("name")
        if isinstance(name, str) and name:
            if name in names:
                fail(f"{label}: duplicate name `{name}`")
            names.add(name)
            # The include builds four asset paths from `name`; a missing file
            # renders as a broken slide, so check all four exist.
            for suffix in ("_light.mp4", "_dark.mp4", "_light.png", "_dark.png"):
                asset = REPO_ROOT / "assets" / "video" / "highlights" / f"{name}{suffix}"
                if not asset.exists():
                    fail(f"{label}: missing asset {asset.relative_to(REPO_ROOT)}")
        if "date" in entry and not is_iso_date(entry["date"]):
            fail(f"{label}: date must be an ISO 8601 date (YYYY-MM-DD)")
        for text_field in ("eyebrow", "title", "hook", "alt"):
            value = entry.get(text_field)
            if text_field in entry and (not isinstance(value, str) or not value.strip()):
                fail(f"{label}: {text_field} must be a non-empty string")


# 6) papers.bib <-> venues.yml abbr cross-check, plus basic bib field checks
def check_bib_and_venues() -> None:
    venues = load_yaml(DATA / "venues.yml")
    venue_keys = set(venues.keys()) if isinstance(venues, dict) else set()

    theme_keys = load_theme_keys()

    if not BIB.exists():
        fail("_bibliography/papers.bib: expected file not found")
        return
    entries = parse_bib()
    if not entries:
        fail("papers.bib: no BibTeX entries parsed — check for syntax damage")
        return

    seen_keys: set[str] = set()
    used_themes: set[str] = set()
    for entry_type, citekey, fields in entries:
        label = f"papers.bib @{entry_type}{{{citekey}}}"
        if citekey in seen_keys:
            fail(f"{label}: duplicate citekey")
        seen_keys.add(citekey)

        for required in ("title", "author", "year", "finding", "theme"):
            if required not in fields:
                fail(f"{label}: missing required field `{required}`")
        if "finding" in fields and not fields["finding"].strip():
            fail(f"{label}: finding must be non-empty")
        if "abstract" in fields and not fields["abstract"].strip():
            fail(f"{label}: abstract must be non-empty if present (omit the field instead of leaving it blank)")
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
        theme = fields.get("theme")
        if theme is not None:
            used_themes.add(theme)
            if theme_keys and theme not in theme_keys:
                fail(f"{label}: theme `{theme}` is not a key in _data/research_themes.yml")
        if entry_type.lower() == "techreport" and "journal" in fields:
            fail(
                f"{label}: @techreport must not carry `journal` (it overrides `institution` "
                "as the displayed venue and leaks into exported BibTeX)"
            )
        code = fields.get("code")
        if code is not None and not is_absolute_url(code):
            fail(f"{label}: code must be an absolute URL to the replication repository")

    for unused in sorted(theme_keys - used_themes):
        fail(f"research_themes.yml: theme `{unused}` is used by no papers.bib entry (it would render an empty section)")


def load_theme_keys() -> set[str]:
    """Validate _data/research_themes.yml and return its keys."""
    data = load_yaml(DATA / "research_themes.yml")
    if not isinstance(data, list) or not data:
        fail("research_themes.yml: did not parse to a non-empty list")
        return set()
    keys: set[str] = set()
    for idx, theme in enumerate(data):
        if not isinstance(theme, dict):
            fail(f"research_themes.yml [{idx}]: expected a mapping")
            continue
        label = f"research_themes.yml [{idx}] '{theme.get('key', '<no key>')}'"
        missing = THEME_REQUIRED - set(theme)
        if missing:
            fail(f"{label}: missing required fields {sorted(missing)}")
        for field in THEME_REQUIRED & set(theme):
            if not isinstance(theme[field], str) or not theme[field].strip():
                fail(f"{label}: {field} must be a non-empty string")
        key = theme.get("key")
        if isinstance(key, str):
            if not re.fullmatch(r"[a-z][a-z0-9_]*", key):
                fail(f"{label}: key must be lowercase letters, digits, and underscores (it is used in bib queries and anchors)")
            if key in keys:
                fail(f"{label}: duplicate key `{key}`")
            keys.add(key)
    return keys


# 7) run everything
def main() -> int:
    check_writing()
    check_media_page()
    check_socials()
    check_homepage()
    check_highlights()
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
