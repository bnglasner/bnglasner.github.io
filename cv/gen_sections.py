#!/usr/bin/env python3
# gen_sections.py -- emit the CV's data-driven LaTeX rubrics from the site's data
# Author  - Ben Glasner (scaffolded 2026-09-23)
# Purpose - Keep the CV PDFs in sync with the site: the Agglomerations index,
#           guest writing, EIG analyses, and media sections are generated from
#           _data/writing.yml and _data/media_page.yml rather than hand-copied.
#           Publications come from _bibliography/papers.bib via biblatex.
# Usage   - python3 cv/gen_sections.py <out_dir>
#           Writes gen-agglomerations.tex, gen-agglomerations-selected.tex,
#           gen-guest.tex, gen-analysis.tex, gen-media.tex, gen-media-short.tex.

from __future__ import annotations

import re
import sys
from pathlib import Path

import yaml

REPO = Path(__file__).resolve().parent.parent
BEN = {"Ben Glasner", "Benjamin Glasner"}

# Agglomerations pieces surfaced in the two-page CV (by URL slug), newest first.
SELECTED_SHORT_FORM = [
    "the-babysitter-clause-and-the-problem",
    "fixing-the-us-retirement-system-a",
    "how-to-end-low-wage-work-forever-4a4",
    "the-jobs-chart-that-really-has-us",
    "how-to-end-low-wage-work-forever",
]

TEX_ESCAPES = {
    "\\": r"\textbackslash{}",
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
    "{": r"\{",
    "}": r"\}",
    "~": r"\textasciitilde{}",
    "^": r"\textasciicircum{}",
}


def tex(s: str) -> str:
    s = "".join(TEX_ESCAPES.get(c, c) for c in str(s))
    s = s.replace(" — ", " --- ").replace("—", "---").replace("–", "--")
    # Curly quotes for straight double quotes inside titles.
    s = re.sub(r'"([^"]*)"', r"``\1''", s)
    return s


def url(u: str) -> str:
    return u.replace("%", r"\%").replace("#", r"\#")


def coauthors(authors: list[str]) -> str:
    others = [a for a in authors if a not in BEN]
    if not others:
        return ""
    if len(others) == 1:
        names = others[0]
    elif len(others) == 2:
        names = f"{others[0]} and {others[1]}"
    else:
        names = ", ".join(others[:-1]) + f", and {others[-1]}"
    return f" (with {tex(names)})"


def entry(key: str, body: str) -> str:
    return f"\\entry*[{key}]%\n    {body}\n"


def writing_rubric(title: str, items: list[dict]) -> str:
    out = [f"\\begin{{rubric}}{{{title}}}\n"]
    for it in items:
        date = str(it["published"])
        body = f"\\href{{{url(it['url'])}}}{{{tex(it['title'])}}}{coauthors(it['authors'])}"
        out.append(entry(date, body))
    out.append("\\end{rubric}\n")
    return "".join(out)


def bib_urls() -> set[str]:
    text = (REPO / "_bibliography" / "papers.bib").read_text(encoding="utf-8")
    return {u.rstrip("/") for u in re.findall(r"(?:website|url|pdf)\s*=\s*\{(https?://[^}]+)\}", text)}


def media_rubric(media: dict, short: bool) -> str:
    out = ["\\begin{rubric}{Policy, News, and Media}\n"]
    labels = {
        "Broadcast and Video": "Broadcast",
        "Podcasts and Radio": "Podcast",
        "Interviews and Features": "Interview",
        "Quoted in News Coverage": "Quoted",
    }
    keep = {"Broadcast and Video", "Podcasts and Radio"} if short else set(labels)
    for section in media["sections"]:
        if section["title"] not in keep:
            continue
        label = labels.get(section["title"], section["title"])
        for it in section["items"]:
            year = f" ({it['published'].year})" if it.get("published") else ""
            body = f"{tex(it['outlet'])} --- \\href{{{url(it['url'])}}}{{{tex(it['title'])}}}{year}"
            out.append(entry(label, body))
        # The UW Political Economy Forum appearance is carried over from the
        # pre-2026-09 CV; it has no stable episode URL in _data/media_page.yml.
        if section["title"] == "Podcasts and Radio" and not short:
            out.append(entry(label, "Political Economy Forum Podcast (University of Washington)"))
    outlets: list[str] = []
    for group in media["coverage_groups"]:
        for it in group["items"]:
            if it["outlet"] not in outlets:
                outlets.append(it["outlet"])
    out.append(entry("Coverage", "Research cited in " + tex("; ".join(outlets)) + "."))
    if not short:
        # Carried over verbatim from the pre-2026-09 CV's "Print / Online" line.
        out.append(
            entry(
                "Print / Online",
                "New York Times; Wall Street Journal; Financial Times; Washington Post; "
                "Bloomberg; CBS News; Yahoo Finance; MarketWatch; and others.",
            )
        )
    out.append("\\end{rubric}\n")
    return "".join(out)


def main() -> None:
    out_dir = Path(sys.argv[1])
    out_dir.mkdir(parents=True, exist_ok=True)
    writing = yaml.safe_load((REPO / "_data" / "writing.yml").read_text(encoding="utf-8"))
    media = yaml.safe_load((REPO / "_data" / "media_page.yml").read_text(encoding="utf-8"))

    short_form = writing["short_form"]
    (out_dir / "gen-agglomerations.tex").write_text(
        writing_rubric("Agglomerations Writing Index", short_form), encoding="utf-8"
    )
    by_slug = {it["url"].rstrip("/").rsplit("/", 1)[-1]: it for it in short_form}
    selected = [by_slug[s] for s in SELECTED_SHORT_FORM if s in by_slug]
    missing = [s for s in SELECTED_SHORT_FORM if s not in by_slug]
    if missing:
        sys.exit(f"gen_sections.py: selected Agglomerations slugs not in writing.yml: {missing}")
    (out_dir / "gen-agglomerations-selected.tex").write_text(
        writing_rubric("Selected Agglomerations Writing", selected), encoding="utf-8"
    )
    (out_dir / "gen-guest.tex").write_text(
        writing_rubric("Guest Writing", writing.get("guest_posts", [])), encoding="utf-8"
    )

    # Reports already in papers.bib print with the bibliography; the rest are
    # EIG analyses that live only in writing.yml.
    in_bib = bib_urls()
    analyses = [r for r in writing["reports"] if r["url"].rstrip("/") not in in_bib]
    (out_dir / "gen-analysis.tex").write_text(
        writing_rubric("Policy Analysis (Economic Innovation Group)", analyses), encoding="utf-8"
    )

    (out_dir / "gen-media.tex").write_text(media_rubric(media, short=False), encoding="utf-8")
    (out_dir / "gen-media-short.tex").write_text(media_rubric(media, short=True), encoding="utf-8")


if __name__ == "__main__":
    main()
