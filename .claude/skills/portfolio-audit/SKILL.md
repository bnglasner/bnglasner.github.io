---
name: portfolio-audit
description: |
  Re-run the cross-source audit that produced docs/audits/2026-05-03-portfolio-deep-dive.md:
  reconcile what is on the site against what is on Ben's CV, EIG bio, Substack, Linktree,
  Google Scholar, NBER, Equitable Growth, and his GitHub accounts. Triggers on "audit my
  portfolio", "what is missing from the site", "cross-check sources", "redo the deep dive",
  or before any deliberate site refresh.
inputs:
  - none required (skill enumerates sources automatically)
outputs:
  - A dated report at docs/audits/YYYY-MM-DD-portfolio-deep-dive.md
network: yes — fetches EIG staff page, Substack profile, Linktree, NBER, Equitable Growth,
  Google Scholar, GitHub (bnglasner and EIG-Research orgs)
---

# Skill: cross-source portfolio audit

## Procedure

1. **Enumerate sources.** Pull current contents from:
   - EIG staff page: `https://eig.org/about-us/executive-team-staff/ben-glasner/`
   - Substack profile: `https://agglomerations.eig.org` (`/api/v1/archive` for the post list)
   - Linktree: `https://linktr.ee/bglasner`
   - NBER author page (search by name)
   - Equitable Growth working-paper series (search by name)
   - Google Scholar profile (`scholar_userid` from `_data/socials.yml`)
   - GitHub: `https://api.github.com/users/bnglasner/repos`, `https://api.github.com/orgs/EIG-Research/repos`
   - The CV PDF at `assets/pdf/Ben_Glasner_CV_full.pdf` (parse with the `pdf` skill)

2. **Compare against site state.** Build dictionaries from:
   - `_bibliography/papers.bib` (by citekey and DOI)
   - `_data/writing.yml` `short_form:` and `reports:` (by URL)
   - `_data/socials.yml` (handle list)
   - `_data/citations.yml` (Scholar, generated)

3. **Surface six categories of finding.**
   - **Missing from site** — pieces present in the source but not in `papers.bib` or `writing.yml`.
   - **Source-only candidates** — items appearing in Scholar or NBER that look like working-paper drafts and need verification before adding (the four candidates flagged in the May 2026 audit are the canonical examples).
   - **Attribution drift** — entries on the site missing the right `authors` field, or co-authored pieces presented as solo.
   - **Stale facts** — bio prose, role title, or affiliation that has changed at the source but not on the site.
   - **Channel coverage** — social handles present on Linktree but missing from `_data/socials.yml`, or vice versa.
   - **Repository coverage** — repos in EIG-Research that map to a paper on the site but are not cross-linked.

4. **Apply the integrity rule.** Per `content-integrity.md`, do not list anything that is not genuinely Ben's. Items in the EIG team-page archive bylined to other staff do not count as missing publications.

5. **Write the report.** Create `docs/audits/YYYY-MM-DD-portfolio-deep-dive.md` (today's date). Mirror the structure of the May 2026 audit: identity & bio inputs, full publication and writing portfolio (peer-reviewed, working papers, policy reports, Substack, guest), code and data portfolio, public profiles. End with a punch list of recommended additions/corrections, ranked by integrity weight.

6. **Refresh repo memory.** Update `.claude/memory/site-facts.md`: correct any fact the audit found stale (role, affiliation, channels, repo mappings, Scholar-only candidates) and set the **Last verified** stamp to today's date. Update — do not append.

## Outputs

- `docs/audits/YYYY-MM-DD-portfolio-deep-dive.md`.
- An updated `.claude/memory/site-facts.md` with today's **Last verified** stamp.
- A short note for Ben naming the deltas vs. the prior audit.

## Stop and ask

- A source returns content that conflicts with what is on the site in a non-trivial way (e.g., the EIG bio updates Ben's title or affiliation).
- A new co-authored piece surfaces with a byline order that needs Ben's confirmation.
