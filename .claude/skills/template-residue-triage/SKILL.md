---
name: template-residue-triage
description: |
  Enumerate and triage al-folio template-residue files (placeholder pages, demo posts, demo
  news, Einstein bio prose, lorem ipsum) and propose keep / delete / replace per file.
  Triggers on "find template residue", "what placeholders are still here", "are there any
  al-folio leftovers", or runs as part of release-readiness.
inputs:
  - none
outputs:
  - A markdown table with one row per residue candidate: file, evidence, recommendation,
    blast radius if removed
network: no
---

# Skill: template-residue triage

## Procedure

1. **Enumerate candidates.** Walk these directories and grep for residue signals:
   - `_pages/`: any file matching `profiles.md`, `teaching.md`, `projects.md`, `books.md`, `about_einstein.md`. (As of 2026-05-03 these are gone — confirm.)
   - `_news/`: any file matching `announcement_*.md`. (As of 2026-05-03 the directory is empty — confirm.)
   - `_posts/`: any file with a year prefix in 2015-2020 not authored by Ben. (As of 2026-05-03 the directory is empty — confirm.)
   - `_projects/`, `_books/`, `_teachings/`: any contents not authored by Ben. (As of 2026-05-03 these directories are empty — confirm.)
   - `404.md`: not residue, but still carries template prose; flag for customization.
   - `_includes/`, `_layouts/`: grep for `Albert Einstein`, `lorem ipsum`, `John Doe`, `example.com`, `your-name-here`. Layout files are largely fine — flag any prose strings that hardcode placeholder content.
   - `assets/img/`: flag any image not used by a current page. Do not delete; just list.

2. **Confirm each is residue.** For every hit, open the file and look for:
   - Lorem ipsum or visible placeholder prose.
   - Einstein bio language.
   - YAML front-matter `published: false` or `permalink:` pointing at a demo URL.
   - Demo author names or institutions.

3. **Score blast radius.** For each candidate:
   - Grep the rest of the repo for inbound links to the file (Liquid `{% include %}`, `{% link %}`, markdown links, `_config.yml` `nav:` entries).
   - Count inbound references. Zero references = safe to delete; ≥1 = "delete" requires updating each referencing file.

4. **Recommend per file.** Choose one of:
   - **Delete** — pure residue, zero inbound references.
   - **Replace** — Ben might want a real version of this page eventually (e.g., a Projects page); delete now or stub to avoid orphan link.
   - **Keep, customize** — file is load-bearing but the prose needs Ben's voice (`404.md`).
   - **Keep as-is** — false positive.

5. **Write the table and stop.** Output the table to chat (or to a file in `docs/audits/` if invoked from `release-readiness`). Do not delete anything. Hand control back to Ben.

## Outputs

- A per-file table with: file path, evidence, recommendation, blast-radius count, list of files referencing it.

## Stop and ask

- Always. This skill never deletes; it proposes. Ben must approve each deletion before the `apply approved residue pruning` step runs.
