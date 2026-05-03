---
name: bib-and-citations-sync
description: |
  Reconcile _bibliography/papers.bib against _data/citations.yml (Google Scholar) and
  _data/publications.json (ORCID, retired pipeline). Surface entries that exist in one but
  not the other for triage. Triggers on "sync the bibliography", "check Scholar against the
  bib", "reconcile citations", or as part of release-readiness.
inputs:
  - none
outputs:
  - A markdown report listing: bib-only entries, scholar-only entries, orcid-only entries,
    and citekey ↔ EIG-Research repo mappings
network: yes — refreshes citation counts via scholarly (mirrors update-citations.yml) and
  optionally pulls the EIG-Research repo list via the GitHub API
---

# Skill: bib and citations sync

## Procedure

1. **Load the three sources.**
   - `_bibliography/papers.bib` — parse with python-bibtexparser. Build a dict by citekey, capturing title, authors, year, DOI, website.
   - `_data/citations.yml` — load YAML; the file is the output of `bin/update_scholar_citations.py`. Each entry maps a citekey or title to citation count and Scholar metadata.
   - `_data/publications.json` — load JSON; an empty `items` list is acceptable (the ORCID pipeline is retired).

2. **Reconcile.**
   - **Bib-only**: bib entries with no matching Scholar or ORCID record. Expected for very recent or unpublished work; flag as "verify Scholar indexing has caught up."
   - **Scholar-only**: Scholar records with no matching bib citekey. The four candidates from the May 2026 audit live here (the Medicaid evasion paper, the alternate-listing of the JPubE CTC paper, the EITC intergenerational paper, and the Nonstandard Work Arrangements paper). Each requires Ben's verification before adding to `papers.bib` — do not auto-add.
   - **ORCID-only**: any record. Currently expected to be empty.

3. **Cross-link replication code.** For every bib entry, check the EIG-Research GitHub org for a repository whose name matches the title slug or contains a recognizable keyword. Build a mapping table. Flag bib entries that have a likely matching repo but no `code = {…}` field set.

4. **Write the report.** Output to chat or to `docs/audits/YYYY-MM-DD-bib-citations-sync.md` if invoked from `release-readiness`. Sections:
   - Bib-only entries (count, list)
   - Scholar-only entries (count, list, with verification status: confirmed / suspected duplicate / needs Ben)
   - ORCID-only entries (count, list)
   - Citekey ↔ replication-repo mappings (count, table)

5. **Do not modify any data file.** This skill is read-only. Adding a new bib entry is the `add-publication` skill's job; updating `citations.yml` is the cron's job.

## Outputs

- Report in chat or `docs/audits/YYYY-MM-DD-bib-citations-sync.md`.

## Stop and ask

- A Scholar-only entry looks plausibly real (verify the source URL).
- A bib entry's `code` field would point to a repo that includes co-author work outside Ben's scope (confirm before linking).
