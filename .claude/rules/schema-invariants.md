# Rule: schema invariants

> Enforced mechanically by `bin/validate_data.py` (run directly or via pre-commit). If you change a schema here, change the validator in the same commit.

The data files under `_data/` and the bibliography under `_bibliography/` are the structured backbone of this site. Adding a new entry by hand requires every required field listed below; missing a required field will silently drop the entry from the page or render it incorrectly.

## `_data/writing.yml`

Two top-level keys: `short_form:` and `reports:`. Each is a list. Every entry — in either list — requires:

- `title` (string, in quotes if it contains `:` or `?`)
- `url` (string, absolute URL)
- `outlet` (string — for short-form, this is "Agglomerations" or the guest publication's name; for reports, "Economic Innovation Group")
- `authors` (list of strings, full names; required even for solo work — pass `["Ben Glasner"]`)
- `published` (ISO 8601 date, e.g., `2025-09-22`; or a quoted month, `"2023-08"`, when the source gives only a month — see "ISO 8601 dates everywhere")
- `description` (one sentence, the central claim)

Each list (`reports`, `short_form`, `guest_posts`) must stay newest first by `published`; the pages render them in file order, and the validator enforces it.

Optional:

- `featured` (boolean, default false; sets the lead card on the writing page)
- `tags` (list of strings)
- `co_outlet` (string, used when a piece appears on more than one masthead)
- `pdf` (string URL, for reports with a stable PDF mirror)
- `bib_key` (string, reports only in practice) — the `papers.bib` citekey for the same work. The Policy page's Reports cards link that entry's permalink page (summary, coverage, code, and citation). The validator checks that the citekey exists.

A pre-commit hook (`bin/check_writing_authors.py`) blocks commits that introduce a `short_form` or `reports` entry without an `authors` field.

## `_data/media_page.yml`

Curated source of truth for the `/media/` page. Required top-level keys:

- `lead.primary` (string)
- `lead.coverage` (string)
- `sections` (list)
- `coverage_groups` (list)

Each entry in `sections` requires:

- `title` (string)
- `items` (list)

Each media item in `sections[*].items` requires:

- `outlet` (string)
- `title` (string)
- `url` (absolute URL)
- `description` (one sentence)

Optional:

- `published` (ISO 8601 date, or a quoted month `"YYYY-MM"` if only the month is known; omit if not even that is known)
- `related_work` (list of `papers.bib` citekeys) — see below

Each entry in `coverage_groups` requires:

- `title` (string)
- `description` (string)
- `items` (list)

Each cited-coverage item in `coverage_groups[*].items` requires:

- `outlet` (string)
- `published` (ISO 8601 date, or a quoted month `"YYYY-MM"`)
- `title` (string)
- `url` (absolute URL)
- `description` (one sentence explaining the relation to Ben's work)

Optional on any item in `sections` or `coverage_groups`:

- `related_work` (list of `papers.bib` citekeys) — the paper(s) the item is about. Each listed paper's permalink page renders the item under "Coverage and interviews". Add a key only when the item itself verifiably discusses that specific work (its title or description names the work, or the item is an interview about it); a thematic match is not enough. Every key must exist in `papers.bib`.

## `_bibliography/papers.bib`

Every entry uses one of: `@article`, `@techreport`, `@phdthesis`, `@mastersthesis`, `@misc` (used for the Vassar senior thesis), `@inproceedings`, `@book`, `@incollection`. Required fields by entry type:

- **`@article`** (peer-reviewed): `title`, `author`, `journal`, `year`, `month` (where known), `volume`, `number`, `pages`, plus `abbr` (the journal's short tag for the bib filter), `entry_group = {peer_reviewed}`, `bibtex_show = {true}`. Add `selected = {true}` for landing-page selected-papers display. Add `pdf` and/or `website` if a stable URL exists.
- **`@techreport`** (working paper or policy report): `title`, `author`, `institution`, `year`, `month`, `website`, `entry_group = {policy_report}` or `entry_group = {working_paper}`, `bibtex_show = {true}`. **Never `journal`** — the templates prefer `journal` over `institution` as the displayed venue, and it leaks into exported BibTeX and the Highwire `citation_journal_title` tag. The validator rejects it.
- **`@phdthesis`** / **`@mastersthesis`**: `title`, `author`, `school`, `year`.

`abbr` controls the colored journal/institution tag rendered next to the entry. Reuse the existing tag if one is already in use (e.g., `JPubE`, `JLE`, `Health Affairs`, `EIG`). Adding a new `abbr` value may require a corresponding entry in `_data/venues.yml`.

The `author = {…}` field uses `and` (lowercase, spaces) as the separator between names. Match the convention already in the file ("Last, First", e.g., `Glasner, Ben and Ozimek, Adam`); confirm before adding.

**`finding`** (added in the 2026 redesign, required on every entry regardless of type): one sentence, present tense, plain-language — the work-card anatomy's finding line and the permalink page's fallback when no abstract exists. Must be genuinely sourced (the paper's own abstract, or its institutional landing page) — never fabricated. For the two entries with no locatable source (`glasner2021impact`, `glasnerchinese`), `finding` is a purely descriptive, metadata-only line (topic and institution, not a claimed result) rather than an invented finding — this is the sanctioned exception, not a precedent for skipping sourcing elsewhere.

**`theme`** (required on every entry): exactly one key from `_data/research_themes.yml`. The Research page renders one section per theme, and within it orders cards peer-reviewed → working paper → policy report → dissertation → thesis, newest first. `theme` is in `_config.yml`'s `filtered_bibtex_keywords`, so it never appears in the exported BibTeX.

**`code`** (optional): absolute URL of the entry's replication repository, rendered as a Code link on the card and permalink page. Add it only for a confirmed match (the repository is the one behind this specific work, and it holds no co-author work outside Ben's scope). Already in `filtered_bibtex_keywords`.

**`abstract`** (added in the 2026 redesign, optional): a short paraphrased summary — not a verbatim copy of the published abstract — for the per-paper permalink page generated automatically by jekyll-scholar's `DetailsGenerator` (see `_layouts/bibtex.html`; it activates on the presence of that layout file, keyed off `details_layout` in `_config.yml`'s `scholar:` block, no other wiring needed). `bibtex_skip_fields` already excludes `abstract` from the raw "view BibTeX" text dump, so adding it does not clutter the copy-paste citation. Omit rather than fabricate when no real source exists — `finding` alone is required, `abstract` is not.

The permalink page labels `abstract` **"Summary"** with a note that it is a plain-language summary rather than the published abstract, and adds a formatted "Cite this" citation plus the BibTeX, each with a copy button.

## `_data/research_themes.yml`

Research agenda themes for the Research page. A list; each entry requires `key` (lowercase letters, digits, underscores; used in bib queries and `#theme-<key>` anchors), `title`, and `description` (a topic list, not a claimed finding). Keys are unique; every theme must be used by at least one `papers.bib` entry, and every entry's `theme` must be a key here. Order in the file is order on the page.

## `_data/socials.yml`

Single flat map. Existing keys (do not rename; templates reference them by these names): `cv_pdf`, `email`, `rss_icon`, `scholar_userid`, `github_username`, `linkedin_username`, `x_username`, `bluesky_url`, `instagram_id`, `tiktok_url`, `threads_url`, `substack_url`. The last three use the nested `{ url: <string> }` form because `jekyll-socials` does not natively support those platforms; the about-page "Find me elsewhere" block renders explicit links for each.

## `_data/cv.yml`

Top-level list of sections, each with `title:`, `type:` (one of `map`, `list`, `time_table`, `nested_list`), and `contents:`. Match the conventions of the existing entries when adding a new section. Order in the file is order on the page.

## `_data/venues.yml`

Maps `abbr` values from `papers.bib` to display names and (optionally) colors used on the publications page. If you introduce a new `abbr` in a bib entry, add the matching key here.

## `_data/coauthors.yml`

Currently `{}`. When populated, maps a co-author's `Last, First` name (matching the bib `author` field) to a profile URL. An empty map is preferable to template placeholder data; only populate when the link is genuine.

## `_data/homepage.yml`

Added in the 2026 redesign for the homepage's one personal note (headshot + a single "currently working on" line — see the design brief's negative-space principle). Required keys:

- `currently_working_on` (string, non-empty) — one sentence, present tense.
- `currently_working_on_updated` (ISO 8601 date) — bump whenever the line changes, so staleness is visible in the file itself.

Optional keys:

- `open_to` (string, non-empty when present) — one sentence signaling availability for collaborations, press, podcasts, and panels, rendered as the second line of the same home note. The template appends the "Email me or see past appearances" links; do not duplicate them in the sentence.
- `proof` (list, non-empty when present) — the text-only proof strip under the hero buttons (added 2026-09-23). Each line requires `label` (string), `kind` (one of `appearances`, `coverage`, `journals`), `url` (site-relative `/…` path or absolute URL), and `items` (non-empty list of strings). The validator cross-checks every item against its source so the strip cannot outrun the evidence:
  - `appearances` — must be an outlet in `media_page.yml` `sections`, excluding "Quoted in News Coverage" (direct appearances only).
  - `coverage` — must be an outlet anywhere in `media_page.yml`. Label these lines "covered", never "quoted in" or "featured in".
  - `journals` — must be the `journal` of a `peer_reviewed` entry in `papers.bib`.

Keep this to the one note the design calls for (the working-on line plus at most the availability line); do not grow it into a second bio or a projects list. The proof strip is separate from the note and stays at three lines.

## `_data/highlights.yml`

Added with the homepage headline wheel (2026-08-10): the five findings from Ben's short-form reel work rendered as site-token animated figures. A top-level list of 3–7 entries. Required fields per entry:

- `name` (string, unique) — asset stem. The wheel resolves four files from it, and the validator checks all four exist: `assets/video/highlights/<name>_{light,dark}.mp4` and `..._{light,dark}.png` (posters).
- `eyebrow` (string) — short topic label, rendered mono uppercase.
- `title` (string) — the card's serif headline.
- `hook` (string) — one sentence, the central claim. Numbers must be the source reel's fact-checked claims (see the reel's source-notes in the Style Guide repo); do not edit a number here without re-checking it there.
- `alt` (string) — full description of the animated figure for screen readers, including the source.
- `date` (ISO 8601) — the source reel's date.

The MP4/PNG assets are re-rendered from the Style Guide repo's reel pipeline data with the site's design tokens — they are build artifacts of that pipeline, not hand-edited files. Regenerate rather than retouch.

## `_data/citations.yml`

Auto-generated by `.github/workflows/update-citations.yml` (the weekly Monday Scholar cron). Do not edit by hand. The file may legitimately contain Scholar-deduplication artifacts (the four candidates flagged in `docs/audits/2026-05-03-portfolio-deep-dive.md`); the `bib-and-citations-sync` skill is responsible for triaging those, not for silently mirroring them into `papers.bib`.

## `_data/publications.json`, `_data/mentions.json`, `_data/media.json`, `_data/cv_assets.json`

These were generated by an external profile-sync pipeline that has been retired (`.profile_payload_sync_manifest.json` reads `"status": "retired"`, `"note": "Repo-local data and pages are now authoritative. Do not overwrite public site pages from an external sync pipeline."`). Treat them as repo-authoritative now: they may be edited by hand when a skill or Ben requests it, but no automated pipeline should overwrite them. They are listed in `.prettierignore` for the same reason.

## ISO 8601 dates everywhere

Every `published`, `date`, or `accessed` field should use `YYYY-MM-DD` format, unquoted (YAML parses it as a date). Avoid `MM/DD/YYYY` — Jekyll's date filters render it inconsistently across templates.

**Month precision (`published` only, in `_data/writing.yml` and `_data/media_page.yml`).** When the source gives only a month ("August 2023"), write a quoted `"YYYY-MM"` string — never invent a day. Liquid's `date` filter cannot parse `"YYYY-MM"`, so templates must render `published` through `_includes/pub-date.liquid` (formats without a day only, e.g. `"%Y"` or `"%B %Y"`), and any template that sorts by `published` must use string keys (see the coverage list in `_layouts/bibtex.html`; a month-only value keys as day `00`). `date` in `highlights.yml` and `currently_working_on_updated` stay full dates.
