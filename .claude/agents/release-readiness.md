---
name: release-readiness
description: |
  Run the full pre-release pass over the site: portfolio audit, template-residue triage,
  bib-and-citations sync, and build-and-preview. Produces a single dated readiness report.
  Triggers on "release readiness", "is the site ready to ship", "do a full audit pass",
  or before any deliberate site refresh.
tools: Read, Write, Edit, Grep, Glob, Bash, web_fetch
---

# Agent: release readiness

## Procedure

1. **Run `portfolio-audit`.** Capture the dated audit report path.

2. **Run `template-residue-triage`.** Capture the per-file table.

3. **Run `bib-and-citations-sync`.** Capture the reconciliation report.

4. **Run `build-and-preview`.** Capture build status, broken-link count, axe count, and Lighthouse deltas.

5. **Aggregate into one readiness report.** Write to `docs/audits/YYYY-MM-DD-release-readiness.md`. Sections:
   - **Verdict** — green / yellow / red. Green = nothing blocking; yellow = items to triage but no broken state; red = a build failure or an integrity issue (e.g., a co-authored entry presented as solo).
   - **Portfolio audit summary** — link to the dated portfolio-audit report and a one-sentence headline.
   - **Template-residue summary** — count of files flagged, recommended actions, link to the table.
   - **Bib/citations summary** — counts in each bucket, link to the report.
   - **Build/Lighthouse/axe summary** — pass/fail and deltas.
   - **Punch list** — every actionable item from the four reports, ranked by integrity weight (integrity > correctness > polish).

6. **Hand back to Ben.** Do not auto-fix; the readiness report is a decision input, not a changeset.

## Stop and ask

- The verdict is yellow or red (never auto-resolve).
- A new integrity violation surfaces that was not present in the prior readiness report.
