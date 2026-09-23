# Site facts (load-bearing, repo-scoped memory)

This file is the first thing any agent walking into the repo cold should read. It records facts about Ben's portfolio that no one should have to rediscover each session. When a fact changes, update it in place. Do not append.

**Last verified: 2026-09-23.** The 2026-09 multi-agent improvement pass reconciled both the repo structure and the source-facing facts. Its Research Curator re-checked EIG, Agglomerations, Scholar, NBER, and GitHub. The final step of the `portfolio-audit` skill refreshes this stamp and any changed facts.

## Identity and current role (as of 2026-09-23)

- **Name on the site:** Benjamin Glasner. Substack and informal contexts use "Ben Glasner", and both forms are correct.
  - Listing author rows on the site display "Benjamin Glasner".
  - Data files and citations keep each byline exactly as published.
- **Title:** Senior Economist, Economic Innovation Group (EIG). The EIG bio was unchanged as of 2026-09-23 (last modified 2026-05-04).
- **Affiliation:** Affiliate, Center on Poverty and Social Policy, Columbia University.
  - The affiliation is current, not historical. Write it in the present tense.
  - It appears on the homepage's second eyebrow line.
  - It also appears in the JSON-LD `person:` block in `_config.yml`.
- **Location:** Washington, D.C.
- **CV PDF:** `assets/pdf/Ben_Glasner_CV_full.pdf`.
  - The CV is the spine of the portfolio, and cross-source audits use it as the comparison base.
  - All four CV PDFs date from 2026-02-22 and are stale. They lack the Columbia affiliation and use the gmail address.
  - `Ben_Glasner_CV.pdf` differs from `_full.pdf`.
  - `assets/resume.pdf` is a byte-identical copy of `_full.pdf` that no page links to. It is kept so outside links keep working.
  - Regenerating the PDFs is Ben's job.
- **Coauthors:** Thomas Cronin (EIG Research Assistant) is new as of the 2026-05-22 "Babysitter Clause" post.

## Three bio registers

The about page's lead is closer to the EIG bio register than to the Substack or Linktree registers, and that is the right call. Keep the three voices distinct, and do not paste any of them verbatim.

- **EIG (institutional):** third person, role and history. Source: `https://eig.org/about-us/executive-team-staff/ben-glasner/`.
- **Substack (practitioner):** short, two sentences. Source: the Agglomerations profile.
- **Linktree (casual):** ironic and brief. Source: `https://linktr.ee/bglasner`. Its "Personal Website" link points to `bnglasner.github.io`.

The `/press/` page carries the site's own short and long bios, drafted in 2026-09 and sourced from the repo and the EIG bio.

## Channels and handles

`_data/socials.yml` is the source of truth for which links exist on the site.

- **Footer channels:** email, X, LinkedIn, Scholar, GitHub, Agglomerations, and Bluesky.
- **Substack publication URL:** `https://agglomerations.eig.org`. Used by `add-short-form` and `portfolio-audit`.
- **Scholar user ID:** `ZvG1rc8AAAAJ`. Used by `update-citations.yml` (the cron) and `bib-and-citations-sync`.
- **Needs Ben:** `bglasner.com` still ranks in search, but Ben's control of the domain is unconfirmed. Search Console is not set up.

## EIG-Research GitHub organization (the one institutional carve-out)

The `EIG-Research` GitHub org is the single allowed third-party surface on the personal site. It had 41 public repos as of 2026-09-23. `_pages/repositories.md` calls the GitHub API to list the most recently updated ones; the call has a timeout and a session cache. These repositories map directly to publications on the site:

- `oz-housing-supply` ↔ 2025 OZ housing supply report. `EIG-Opportunity-Zones-and-Housing-Supply` is its 2026-08-05 port; the legacy repo stays live, so existing links still work.
- `EIG-Great-Transfer-Mation` ↔ 2024 Great "Transfer"-mation report.
- `Retirement-Analysis-Urban-Rural`, `Retirement-data-summary-2024`, `Retirement-data-summary-2025`, `EIG-Savers-match-sipp` ↔ RSAA policy work.
- `EIG-Retirement-Fast-Facts` and `EIG-Retirement-Fast-Facts-replication` ↔ "The U.S. Retirement System: Fast Facts" (2026-09-18).
- `noncompete-income` covers income-threshold noncompete work (a 2023 ACS dashboard created 2025-03-26). It does **not** map to the 2023 Hawaii/Oregon note, and may relate to the 2026 Babysitter piece. Ben should confirm.

Only the OZ housing and Transfer-mation bib entries carry `code =` links. When `add-publication` or `add-policy-report` runs, check this list, or call the GitHub API live, for a matching repo.

## Personal `bnglasner` GitHub account — the do-not-include list

These four repositories on `bnglasner` must NOT appear in any hand-curated personal-research-code section:

- `bnglasner.github.io` (the site source itself)
- `are213` (a UC Berkeley course fork)
- `policyengine-claude` (a fork of PolicyEngine's plugin)
- `policy-rules-database` (a fork of the Federal Reserve's database)

The remaining six personal-account repos are genuine research artifacts and may be surfaced (`eig-wagesubsidy-policy-sim`, `hours-working-for-median-home`, `telework-ASEC-analysis`, `MinimumWage-SelfEmp`, `QCEW`, `CTC-MentalHealth`). Linking them as a paper's `code` needs Ben's confirmation first.

## Scholar-only candidates (triaged 2026-09-23)

1. "Tax Evasion Among the Self-Employed: Medicaid Expansion": no source found. Do not add.
2. "Evaluating the (short-lived) US experiment with a child benefit": an LSE CASE-at-25 slide deck (Waldfogel et al.), not a publication. Do not add.
3. "The Earned Income Tax Credit and the Intergenerational Persistence of Poverty": **resolved**. It is INET Oxford WP 2025-22 and is now in `papers.bib`.
4. "Nonstandard Work Arrangements across Metropolitan and Nonmetropolitan Areas of the United States": an unpublished 2019 manuscript (Haskett and Glasner). Do not add unless Ben asks.

Correction to the May audit: NBER lists w29823 (March 2022), the working-paper version of the JPubE CTC paper. Ben is not an NBER affiliate.

## Data file authority

- **Authoritative, hand-edited:** `_data/writing.yml`, `_data/media_page.yml`, `_data/socials.yml`, `_data/cv.yml`, `_data/venues.yml`, `_data/coauthors.yml`, `_data/highlights.yml`, `_data/homepage.yml`, `_data/research_themes.yml`, `_bibliography/papers.bib`.
  - Every bib entry requires a `theme` that is a key in `research_themes.yml`.
  - `writing.yml` reports may carry a validated `bib_key`.
  - `media_page.yml` items may carry `related_work`, which feeds "Coverage and interviews" on paper pages.
  - `homepage.yml` has a validated `proof:` strip. Every outlet in it must be in `media_page.yml`, and every journal must be in `papers.bib`.
- **Generated from source scripts, never retouched.** Regenerate each with its script:
  - `assets/video/highlights/`: the headline wheel's MP4/PNG pairs. Regenerate with `bash bin/highlights_figures/render_all.sh`; provenance is in `bin/highlights_figures/README.md`. They were re-rendered 2026-09-23 with the warm palette, and only colors changed.
  - `assets/img/og-card.png`: the 1200×630 social card and the site-wide `og_image`. Regenerate with `bash bin/og_card/render.sh`. Its deck is `_pages/about.md`'s `headline`, verbatim, so re-render when the headline changes.
  - `assets/img/apple-touch-icon.png` and `/favicon.ico`: regenerate with `bash bin/render_icons.sh`.
  - `assets/img/prof_pic_color-sq*.webp` and `-sq80.jpg`: the homepage headshot. Regenerate with `bash bin/make_headshot.sh`. The current photo is a casual shot. Ben will supply a professional portrait, and the `/press/` headshot download is waiting on it.
- **Site mark / favicon:** `assets/img/bg-monogram.svg`, consumed via `icon:` in `_config.yml`.
  - The same paths are inlined and token-colored in `_includes/site-mark.liquid` for the navbar wordmark.
  - The "BG" is **outlined paths** from Newsreader at wght 600. A favicon SVG loads outside the page and cannot use a webfont, so do not convert it back to `<text>`.
  - Colors are the warm tokens: light `#1b1d1f`/`#0f5f55`, dark `#ece9e1`/`#3fb3a0`.
  - `head.liquid` declares the ICO, then the SVG, then the apple-touch-icon.
- **JSON-LD Person facts:** `_config.yml` `person:` (jobTitle, worksFor, affiliation, sameAs). Keep it in sync with the CV and the EIG bio.
- **Cron-managed:** `_data/citations.yml`, updated by the Scholar cron weekly on Mondays.
  - The cron now fails loudly: `bibtexparser<2` is pinned, and it commits only on change. It had failed silently from 2026-08-28 to 2026-09-23.
  - No page renders the file; only `bib-and-citations-sync` reads it.
- **Repo-authoritative but pipeline-history:** `_data/publications.json`, `_data/mentions.json`, `_data/media.json`, `_data/cv_assets.json`.
  - The external profile-sync pipeline that produced them is retired (`.profile_payload_sync_manifest.json` reads `"status": "retired"`).
  - Edits are allowed when explicitly requested. No automation should overwrite them.

## Design system (as of 2026-09-23)

- **Palette (warm newsprint and warm ink):**
  - Light: paper `#f8f6f0`, ink `#1b1d1f`, teal `#0f5f55`, amber `#935a0b`.
  - Dark: paper `#171a1c`, ink `#ece9e1`, teal `#3fb3a0`, amber `#d38a2c`.
  - Every text pair is at least 4.5:1. The legacy `--global-*` tokens alias the paper tokens.
  - Teal marks academic work and amber marks policy and media work.
- **Type:**
  - Upright Newsreader is the opsz-axis file (wght 400–700), with `font-optical-sizing: auto`. Italic is wght-only.
  - Newsreader has no old-style figures or small caps.
  - Public Sans is the body face at 400, and IBM Plex Mono sets eyebrows and meta.
  - The drop cap appears on the policy narratives only.
- **Signature elements:**
  - The navbar wordmark is the monogram plus the name.
  - The axis rule has one teal "origin" tick.
- **Color bug fixed 2026-09-23:** base text rules in `_sass/_system.scss` are wrapped in `:where()` so component colors win. Before the fix, every eyebrow and muted tier rendered as plain ink.
- **Accessibility:**
  - The fixed navbar relies on `html { scroll-padding-top: 5rem }`.
  - The dark tokens sit inside `@media screen`, so print always uses light tokens.
  - As of 2026-09-23, axe finds 0 violations on every page in both themes.

## Page roster and IA (as of 2026-09-23)

- **Nav:** Home · Research · Policy · Writing · Media · CV.
  - `/policy/` hosts the three policy narratives (`#opportunity-zones`, `#retirement`, `#wage-subsidy`) plus the `writing.yml` Reports list (`#reports`).
  - `/writing/` holds Agglomerations and guest essays only.
  - Code (`/repositories/`) is off-nav, linked from Research, the footer, and 404.
- **Real pages in `_pages/`:** `about.md`, `cv.md`, `media.md`, `policy.md`, `press.md` (off-nav; linked from the homepage hero, Media, and the footer), `publications.md`, `repositories.md`, `wage-subsidy-sim.md`, `writing.md`, `404.md` (noindex).
- **Research page (`publications.md`):**
  - It is grouped into theme sections from `_data/research_themes.yml` and lists every entry group, including policy reports. Cards show coauthors and type labels.
  - The keyword filter is inline in `_includes/bib_search.liquid`. `assets/js/bibsearch.js` is unused.
  - Paper permalink pages label the bib `abstract` "Summary" and include a Cite this block.
- **Homepage:**
  - Hero, then the proof strip, then the headline wheel, then the "Currently" note, then three selected-work cards. The third card is the C-SPAN appearance.
  - The headline wheel (`_includes/headline-wheel.liquid` plus `_data/highlights.yml`) follows the APG carousel pattern. It has a pause/play control whose choice persists in `localStorage` (`headline-wheel-paused`).
  - Wheel assets load lazily, and only for the active theme's variant.
  - Videos play only while visible and never under prefers-reduced-motion, and the wheel never advances on its own. This is the sitewide motion budget.
- `_pages/media.md` renders from `_data/media_page.yml`. It is hand-authored, and Prettier checks it.
- **Removed pages:** `blog.md`, `media_full_snapshot.md`, `repositories_full_snapshot.md`, and `research.md` do not exist. Any reference to them is stale.
- **Removed layouts and collections:** the post, distill, archive, book, course, and profiles layouts were deleted in 2026-09, along with the unused al-folio includes. `_news/`, `_posts/`, `_projects/`, `_books/`, and `_teachings/` are empty. A future blog would need `post.liquid` restored from git history and `redesign_2026: true`.
- **The `redesign_2026` flag:** every real page, plus jekyll-scholar's permalink layout, carries `redesign_2026: true`. The pre-redesign CSS branch is gone, so a page without the flag renders with un-restyled Bootstrap defaults.
- **No feed:** the site publishes no `/feed.xml`, because `jekyll-feed` was removed.

## Build and CI

- **Dev:** `LC_ALL=en_US.UTF-8 bundle exec jekyll serve --port 4000`, the same as `.claude/launch.json`. Docker is optional and not installed on Ben's machine. The UTF-8 locale avoids Terser encoding errors.
- **Headless verify:** `bash bin/verify_site.sh` runs five steps and falls back to Docker only if it is present:
  1. Authors check.
  2. Schema validation.
  3. Local bundle build into `_site_verify/`.
  4. Internal link check.
  5. `bin/check_fa_icons.py`.
- **Font Awesome:** the woff2 files are subsets. The icon list is `bin/fontawesome-icons.txt`; regenerate with `bin/subset_fontawesome.sh` after adding an icon.
- **Plugins:**
  - Gems: jekyll-3rd-party-libraries, jekyll-cache-bust, jekyll-email-protect, jekyll-link-attributes, jekyll-minifier, jekyll-scholar, jekyll-sitemap, jekyll-socials, jekyll-terser.
  - Local plugins: `details.rb`, `hide-custom-bibtex.rb`, `sass-cache-bust.rb`. The last provides the `bust_sass_cache` filter for main.css.
- **Third-party requests:**
  - MDB is gone and publication badges are off.
  - Site search loads on first intent.
  - The only sitewide CDN request is jQuery from jsDelivr.
- **Format:** `npx prettier . --write`, also automated per edit by the PostToolUse hook in `.claude/settings.json`.
- **CI:**
  - `deploy.yml`: schema, link, and icon gates run before publish.
  - `prettier.yml`: runs on push and PR.
  - `codeql.yml`: first-party code only.
  - `update-citations.yml`: weekly on Mondays.
  - `axe.yml`: manual dispatch only.
  - `copilot-setup-steps.yml`.
  - Dependabot covers actions, bundler, and npm.
  - The lychee and Lighthouse workflows were removed.
- **Needs Ben, in GitHub settings:** set workflow permissions to read-only and enable Dependabot alerts.
- **Pre-commit:**
  - Standard hooks: trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files.
  - Local hooks: `bin/check_writing_authors.py` and `bin/validate_data.py`.

## Audits

Dated audit reports live in `docs/audits/`. The two anchor reports:

- `2026-05-03-portfolio-deep-dive.md` (formerly `PORTFOLIO_DEEP_DIVE.md` at repo root).
- `2026-05-03-front-facing-review.md` (formerly `REVIEW_REPORT.md` at repo root).

Both are reference documents. Do not edit them; re-run the corresponding skill to produce a new dated report.

Two later reports follow the same do-not-edit convention, though no skill regenerates them:

- `2026-08-10-2026-redesign-completion.md` closes out the visual and structural redesign.
- `2026-09-23-multi-agent-improvement-pass.md` records the nine-specialist audit, what shipped, validation results, and the open needs-Ben list.
