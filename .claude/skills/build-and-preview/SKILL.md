---
name: build-and-preview
description: |
  Run the Docker-based local build, capture Lighthouse and axe locally, and report diffs
  against the previous lighthouse_results/. Triggers on "build the site", "preview locally",
  "run Lighthouse", "check accessibility", or as the final step of content-publisher and
  release-readiness agents.
inputs:
  - optional: list of pages to spot-check (default: every page in _pages/)
outputs:
  - A short report naming build status, broken links, axe violations, and Lighthouse deltas
network: no (Docker pulls the image once; everything else is local)
---

# Skill: build and preview

## Procedure

1. **Format.** Run `npx prettier . --write` from the repo root.

2. **Build.** Run `docker compose up --build` and wait for the "Server running" line. If the build errors, capture the error, do not proceed, report back to Ben.

3. **Spot-check the navigation.** Fetch `http://localhost:8080/` and confirm:
   - Each entry in `_pages/` resolves to a non-404 response.
   - The about page renders without missing-image errors.
   - The publications page bibliography loads.
   - The repositories page loads (the live GitHub API call is rate-limited but cached).

4. **Run Lighthouse if invoked from release-readiness.** Use the al-folio container's bundled Lighthouse if present, or run `npx lighthouse http://localhost:8080/ --output=html --output-path=lighthouse_results/$(date +%F)-home.html`. Compare to the most recent prior file in `lighthouse_results/`; report deltas in performance, accessibility, best practices, and SEO.

5. **Run axe if invoked from release-readiness.** The CI workflow `.github/workflows/axe.yml` is the authoritative check; this skill runs `axe-core` locally for fast feedback. Report any new violations not present in the prior run.

6. **Report.** Output a short markdown block:
   - Build: pass/fail
   - Broken links: count, list
   - axe: count, summary
   - Lighthouse: per-category score, delta vs. prior
   - Pages spot-checked: count

7. **Stop the container.** `docker compose down`.

## Outputs

- Report block in chat.
- Optional: new file in `lighthouse_results/`.

## Stop and ask

- Build fails for a reason that cannot be auto-diagnosed (e.g., a Liquid exception with no obvious source).
- Lighthouse performance drops > 5 points vs. the prior run.
- A new axe violation appears in a page Ben did not edit (suggests an upstream regression worth investigating before the commit).
