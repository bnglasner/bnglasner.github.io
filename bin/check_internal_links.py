#!/usr/bin/env python3
# check_internal_links.py -- dependency-free internal link check for a built site
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - Walk every HTML file in the built-site directory and confirm that each
#           internal href/src resolves to a file in the build output. External
#           links are CI's job (lychee); this catches broken internal paths fast
#           and offline.
# Usage   - python3 bin/check_internal_links.py _site_verify

from __future__ import annotations

import sys
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlparse

CHECK_ATTRS = {
    "a": "href",
    "link": "href",
    "img": "src",
    "script": "src",
    "source": "src",
}


class LinkCollector(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.links: list[str] = []

    def handle_starttag(self, tag: str, attrs) -> None:
        wanted = CHECK_ATTRS.get(tag)
        if not wanted:
            return
        for name, value in attrs:
            if name == wanted and value:
                self.links.append(value)


def is_internal(link: str) -> bool:
    if link.startswith(("#", "mailto:", "tel:", "javascript:", "data:")):
        return False
    parsed = urlparse(link)
    return not parsed.scheme and not parsed.netloc


def resolve(site_root: Path, page: Path, link: str) -> bool:
    path = unquote(urlparse(link).path)
    if not path:
        return True  # pure fragment/query on the same page
    if path.startswith("/"):
        target = site_root / path.lstrip("/")
    else:
        target = page.parent / path
    try:
        target = target.resolve()
        target.relative_to(site_root.resolve())
    except (OSError, ValueError):
        return False
    if target.is_file():
        return True
    if target.is_dir():
        return (target / "index.html").is_file()
    # Extensionless permalink: /writing -> /writing/index.html or writing.html
    if not target.suffix:
        return (
            Path(str(target) + ".html").is_file()
            or (target / "index.html").is_file()
        )
    return False


def main() -> int:
    if len(sys.argv) != 2:
        sys.stderr.write("usage: python3 bin/check_internal_links.py <built-site-dir>\n")
        return 2
    site_root = Path(sys.argv[1])
    if not site_root.is_dir():
        sys.stderr.write(f"{site_root} is not a directory — run the build first\n")
        return 2

    broken: list[str] = []
    pages = sorted(site_root.rglob("*.html"))
    for page in pages:
        collector = LinkCollector()
        try:
            collector.feed(page.read_text(encoding="utf-8", errors="replace"))
        except OSError as exc:
            broken.append(f"{page}: unreadable ({exc})")
            continue
        for link in collector.links:
            if is_internal(link) and not resolve(site_root, page, link):
                broken.append(f"{page.relative_to(site_root)}: {link}")

    if broken:
        sys.stderr.write(
            f"Internal link check failed ({len(broken)} broken):\n  - "
            + "\n  - ".join(broken)
            + "\n"
        )
        return 1

    print(f"check_internal_links.py: {len(pages)} pages checked, no broken internal links")
    return 0


if __name__ == "__main__":
    sys.exit(main())
