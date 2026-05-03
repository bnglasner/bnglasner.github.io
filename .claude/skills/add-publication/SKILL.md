---
name: add-publication
description: |
  Add a peer-reviewed paper, working paper, or thesis to _bibliography/papers.bib. Triggers on
  "add a publication", "add a paper to the bib", "new working paper", "add this NBER paper",
  "log this JPubE acceptance", or when Ben provides a DOI, NBER number, or pasted citation.
inputs:
  - DOI (preferred), or NBER/IZA/SSRN number, or pasted citation, or PDF URL
outputs:
  - One new BibTeX entry appended to _bibliography/papers.bib in the appropriate position
network: yes — fetches DOI metadata (via crossref.org), NBER metadata, or the working-paper landing page
---

# Skill: add a publication to papers.bib

## Procedure

1. **Resolve the source.** Map the input to a fetch:
   - DOI → `https://api.crossref.org/works/{doi}` for canonical metadata
   - NBER number → `https://www.nber.org/papers/{w-number}` for metadata
   - IZA / SSRN / Equitable Growth number → the working-paper landing page
   - Pasted citation → ask Ben to provide a DOI or URL if any field is ambiguous

2. **Pick the entry type.** `@article` for peer-reviewed (must have a journal and a publication date in the journal). `@techreport` for working papers, NBER papers, and policy reports. `@phdthesis` / `@mastersthesis` for theses. Match `entry_group`: `peer_reviewed`, `working_paper`, or `policy_report`.

3. **Generate a citekey.** Use `{firstauthor_lastname}_{year}_{shortslug}` in lowercase, mirroring existing keys (`ozimek_glasner_2025_wage_subsidy`, `glasner_2025_oz_housing_supply`). Confirm the key does not already exist in `papers.bib` before writing.

4. **Required fields per entry type.** Populate the fields listed in `.claude/rules/schema-invariants.md` for the chosen entry type. Required for everything: `title`, `author` (Last, First, joined by `and`), `year`, `abbr`, `bibtex_show = {true}`, `entry_group`. Add `selected = {true}` if Ben wants this on the landing-page selected-papers list (ask if unclear).

5. **Reuse `abbr` where possible.** Check existing entries for the journal/institution tag (`JPubE`, `JLE`, `Health Affairs`, `EIG`, `NBER`). Use the existing tag if one matches. If introducing a new `abbr`, also add it to `_data/venues.yml`.

6. **Replication code link.** If the EIG-Research GitHub organization (or Ben's `bnglasner` account) has a replication repository for this paper, add a `code` field with the repo URL. The `bib-and-citations-sync` skill has a helper to enumerate these mappings.

7. **Diff and confirm.** Show the BibTeX block as a diff against `papers.bib`. Verify it parses by running the build (`docker compose up --build`) — `jekyll-scholar` will fail loudly on a malformed entry.

## Outputs

- Modified `_bibliography/papers.bib`.
- Optional: modified `_data/venues.yml` if a new `abbr` was introduced.
- A note for Ben naming the new citekey and any replication repo linked.

## Stop and ask

- The paper is a working-paper version of an already-accepted article (handle as one entry that supersedes the other, not two parallel entries).
- The author order on the published version differs from the working-paper version (use the published order; flag the change).
- The `abbr` would conflict with an existing tag (e.g., a second journal abbreviating the same way).
- The paper might be one of the four Scholar-only candidates flagged in `docs/audits/2026-05-03-portfolio-deep-dive.md` — verify the source before treating it as a real publication.
