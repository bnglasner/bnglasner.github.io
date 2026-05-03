---
name: add-policy-report
description: |
  Add a new EIG policy report (or other report bylined to Ben) across both _data/writing.yml
  reports list and the policy page narrative. Triggers on "add a new EIG report", "log this
  policy report", "we just published X — add it", or when Ben provides an eig.org URL.
inputs:
  - eig.org URL (or other publisher URL) of the live report
outputs:
  - One new entry in _data/writing.yml under reports:
  - One new BibTeX entry in _bibliography/papers.bib (entry_group = policy_report)
  - Optional: a paragraph in _pages/policy.md when the report fits an existing policy thread
network: yes — fetches the eig.org report page for title, date, authors, dek, PDF URL
---

# Skill: add a policy report

## Procedure

1. **Fetch the report page.** From the URL, capture the title, byline order as printed at the top of the report, publication date, dek (the page's subhead), and the canonical PDF URL.

2. **Add to `_data/writing.yml` `reports:`.** Required fields (per `schema-invariants.md`): `title`, `url`, `outlet: "Economic Innovation Group"`, `authors`, `published`, `description`. Add `featured: true` if this is one of the lead reports the writing page should surface; ask Ben if unclear. Add `pdf:` for the canonical PDF URL.

3. **Add to `_bibliography/papers.bib`.** Mirror the existing `@techreport` policy-report pattern (see `ozimek_glasner_2025_wage_subsidy`, `glasner_2025_oz_housing_supply`, `fikri_eckhardt_glasner_2024_great_transfermation`). Required: `title`, `author`, `institution = {Economic Innovation Group}`, `year`, `month`, `website`, `entry_group = {policy_report}`, `bibtex_show = {true}`, `abbr = {EIG}`. Add `pdf:` if a canonical PDF mirror exists. Add `selected = {true}` if Ben wants it on the landing-page selected-papers list.

4. **Cross-link to the EIG-Research replication repo.** Run the EIG-Research GitHub org search for a repository whose name matches the report's slug (e.g., `oz-housing-supply` for the OZ housing report). If found, add the repo URL to the bib entry as `code = {…}` and surface it on the policy page paragraph.

5. **Update `_pages/policy.md` if relevant.** If the report extends an existing policy thread (low-wage work / 80-80, OZ housing, the American Worker Project, Great "Transfer"-mation, RSAA, noncompetes), draft a paragraph that fits the existing thread's structure: problem → finding → policy implication. Apply the voice rule. If the report opens a new thread, ask Ben before adding a section.

6. **Diff and confirm.** Show all three diffs together (`writing.yml`, `papers.bib`, optional `policy.md`).

## Outputs

- Modified `_data/writing.yml`, `_bibliography/papers.bib`, and (optionally) `_pages/policy.md`.
- A note naming the new entry, the new citekey, and the replication repo if linked.

## Stop and ask

- Ben is not the lead author and the policy page treatment is unclear (lead-author position changes how the report fits the policy narrative).
- The report is co-published with a partner organization (ask whether the partner gets a `co_outlet` tag).
- The report's policy thread is genuinely new (do not silently add a new section to `policy.md`).
