# Site facts (load-bearing, repo-scoped memory)

This file is the first thing any agent walking into the repo cold should read. It captures facts about Ben's portfolio that should not have to be rediscovered every session. Update — do not append — when a fact changes.

**Last verified: 2026-08-10** (structure reconciled against the repo; source-facing facts last verified by the 2026-05-03 audit). The final step of the `portfolio-audit` skill refreshes this stamp and any changed facts.

## Identity and current role (as of 2026-05-03)

- **Name on the site**: Benjamin Glasner. Substack and informal contexts use "Ben Glasner". Both forms are correct.
- **Title**: Senior Economist, Economic Innovation Group (EIG).
- **Affiliation**: Affiliate, Center on Poverty and Social Policy, Columbia University. Current, not historical — present-tense on the about page.
- **Location**: Washington, D.C.
- **CV PDF**: `assets/pdf/Ben_Glasner_CV_full.pdf`. The CV is the spine of the portfolio; cross-source audits use it as the comparison base.

## Three bio registers

The site's about-page lead is closer to the EIG bio register than the Substack or Linktree registers, which is the right call. Keep the three voices distinct; do not paste any of the three verbatim.

- **EIG (institutional)**: third-person, role-and-history. Source: `https://eig.org/about-us/executive-team-staff/ben-glasner/`.
- **Substack (practitioner)**: short, two sentences. Source: Agglomerations profile.
- **Linktree (casual)**: ironic and brief. Source: `https://linktr.ee/bglasner`.

## Channels and handles

Source of truth for what links exist on the site: `_data/socials.yml`. Linktree carries a longer set; the site exposes those that map cleanly to a `jekyll-socials` icon plus the three nested-form keys (`tiktok_url`, `threads_url`, `substack_url`) for platforms not natively supported.

- **Substack publication URL**: `https://agglomerations.eig.org`. Used by `add-short-form` and `portfolio-audit`.
- **Scholar user ID**: `ZvG1rc8AAAAJ`. Used by `update-citations.yml` (the cron) and `bib-and-citations-sync`.

## EIG-Research GitHub organization (the one institutional carve-out)

The `EIG-Research` GitHub org is the single allowed third-party surface on the personal site. `_pages/repositories.md` calls the GitHub API to list the org's most recently updated repos. Repositories that map directly to publications on the site:

- `oz-housing-supply` ↔ 2025 OZ housing supply report.
- `EIG-Great-Transfer-Mation` ↔ 2024 Great "Transfer"-mation report.
- `Retirement-Analysis-Urban-Rural`, `Retirement-data-summary-2024`, `Retirement-data-summary-2025`, `EIG-Savers-match-sipp` ↔ RSAA policy work.
- `noncompete-income` ↔ 2023 Hawaii/Oregon noncompete note.

When `add-publication` or `add-policy-report` runs, check this list (or call the GitHub API live) for a matching repo.

## Personal `bnglasner` GitHub account — the do-not-include list

These four repositories on `bnglasner` must NOT appear in any hand-curated personal-research-code section:

- `bnglasner.github.io` (the site source itself)
- `are213` (a UC Berkeley course fork)
- `policyengine-claude` (a fork of PolicyEngine's plugin)
- `policy-rules-database` (a fork of the Federal Reserve's database)

The remaining six personal-account repos are genuine research artifacts and may be surfaced (`eig-wagesubsidy-policy-sim`, `hours-working-for-median-home`, `telework-ASEC-analysis`, `MinimumWage-SelfEmp`, `QCEW`, `CTC-MentalHealth`).

## Scholar-only candidates flagged for verification (May 2026 audit)

Four titles surface in `_data/citations.yml` (Google Scholar) but are not in `papers.bib`. None should be auto-added — verify each before treating as a real publication:

1. "Tax Evasion Among the Self-Employed: Medicaid Expansion" — likely a working-paper draft from the dissertation period.
2. "Evaluating the (short-lived) US experiment with a child benefit" — possibly an alternate listing of the JPubE CTC paper or a related book chapter.
3. "The Earned Income Tax Credit and the Intergenerational Persistence of Poverty" (2025) — possibly an in-progress companion to the SNAP intergenerational mobility paper.
4. "Nonstandard Work Arrangements across Metropolitan and Nonmetropolitan Areas of the United States" — likely a dissertation-chapter publication or a working paper.

## Data file authority

- **Authoritative, hand-edited**: `_data/writing.yml`, `_data/media_page.yml`, `_data/socials.yml`, `_data/cv.yml`, `_data/venues.yml`, `_data/coauthors.yml`, `_data/highlights.yml`, `_bibliography/papers.bib`.
- **Generated from source scripts, never retouched**: `assets/video/highlights/` (the homepage headline wheel's MP4/PNG pairs). Regenerate with `bash bin/highlights_figures/render_all.sh`; see `bin/highlights_figures/README.md` for provenance (each figure is a re-themed port of a fact-checked reel from the Style Guide repo).
- **Site mark / favicon**: `assets/img/bg-monogram.svg`, wired via both `logo:` and `icon:` in `_config.yml` (only `icon:` is actually consumed — by `_includes/head.liquid`; no template references `site.logo`, and the navbar brand is text). Replaced `bg-hex-logo.svg` on 2026-08-10, which used the pre-redesign palette and a `Cabin` font that was never installed. The "BG" is **outlined paths** extracted from the site's own `assets/fonts/newsreader/newsreader-latin-wght-normal.woff2` at `wght 600` — a favicon SVG loads outside the page and cannot use a self-hosted webfont, so live `<text>` would silently fall back to a system serif. Do not convert it back to `<text>`. Colors are `--paper-text`/`--accent-teal` inlined, with a `prefers-color-scheme` block carrying the dark complement.
- **Cron-managed**: `_data/citations.yml` (Scholar Mon/Wed/Fri).
- **Repo-authoritative but pipeline-history**: `_data/publications.json`, `_data/mentions.json`, `_data/media.json`, `_data/cv_assets.json`. (No `_data/repositories.*` file exists — the code + data page is `_pages/repositories.md`: a live GitHub API call for EIG-Research plus hand-curated personal-repo HTML.) The external profile-sync pipeline that produced these is retired (`.profile_payload_sync_manifest.json` reads `"status": "retired"`). Edits are allowed when explicitly requested; no automation should overwrite them.

## Page roster (as of 2026-05-03)

Real, intentional pages in `_pages/`:
`about.md`, `cv.md`, `media.md`, `policy.md`, `publications.md`, `repositories.md`, `wage-subsidy-sim.md`, `writing.md`, `404.md`.

`_pages/media.md` now renders from `_data/media_page.yml`, which separates direct appearances and quoted coverage from selected cited coverage of Ben's research. It is genuinely hand-authored — `.prettierignore` no longer lists it (fixed 2026-08-10; it had wrongly carried a "do not edit, auto-generated" marker left over from an earlier pipeline iteration).

`blog.md`, `media_full_snapshot.md`, `repositories_full_snapshot.md`, and `research.md` do not exist in this repo — they were removed in an earlier cleanup along with the rest of the al-folio template residue. If you see them referenced elsewhere (an old audit report, a stale `.prettierignore` entry), that reference is stale.

`_news/`, `_posts/`, `_projects/`, `_books/`, `_teachings/` are empty as of 2026-05-03. Template residue was removed in May 2026.

The homepage hero's illustrative event-study SVG (`_includes/hero-figure.liquid`) was replaced on 2026-08-10 by the **headline wheel** (`_includes/headline-wheel.liquid` + `_data/highlights.yml`): a user-driven scroll-snap carousel of five findings from Ben's short-form reels, rendered as site-token animated figures in light/dark MP4 pairs. The sitewide motion-budget rule now lives there — videos play only while visible and never under prefers-reduced-motion; the wheel never advances on its own.

All 9 real pages (plus jekyll-scholar's per-paper permalink layout) carry `redesign_2026: true` as of the 2026-08-10 visual/structural redesign — see `docs/audits/2026-08-10-2026-redesign-completion.md`. Because every generatable page has the flag, the pre-redesign CSS branch (`body:not(.redesign-2026)` in `_sass/_layout.scss`/`_typography.scss`/`_site-custom.scss`) was removed rather than kept as a fallback. A future page added without the flag (e.g. a blog post, since `_posts/` is empty but not disabled) will render with un-restyled Bootstrap defaults, not the old palette.

## Build and CI

- Dev: `docker compose up --build`, runs at `http://localhost:8080`.
- Headless verify: `bash bin/verify_site.sh` (authors check, schema validation via `bin/validate_data.py`, headless Jekyll build into `_site_verify/`, internal link check).
- Format: `npx prettier . --write` (also automated per-edit by the PostToolUse hook in `.claude/settings.json`).
- CI: Prettier, lychee broken-link check, axe accessibility, CodeQL, Lighthouse (scheduled), `update-citations.yml` (Mon/Wed/Fri Scholar cron).
- Pre-commit: trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files, plus two local hooks: `bin/check_writing_authors.py` (added 2026-05-03) and `bin/validate_data.py` (added 2026-08-10, full schema validation).

## Audits

Dated audit reports live in `docs/audits/`. The two anchor reports:

- `2026-05-03-portfolio-deep-dive.md` (formerly `PORTFOLIO_DEEP_DIVE.md` at repo root).
- `2026-05-03-front-facing-review.md` (formerly `REVIEW_REPORT.md` at repo root).

Both are reference documents — do not edit; re-run the corresponding skill to produce a new dated report.

A third report, `2026-08-10-2026-redesign-completion.md`, closes out the visual/structural redesign (design system, per-page definition-of-done, verified contrast ratios, axe-core accessibility results). It is not an "anchor" in the above sense — no skill regenerates it — but is otherwise the same do-not-edit reference-document convention.
