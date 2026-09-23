---
title: Multi-agent improvement pass — audit, implementation, and release gate
date: 2026-09-23
scope: Whole site (all pages, data, bibliography, design system, CI, build tooling)
status: Merged to site/integration; validated by an independent release gate; awaiting Ben's PR review
---

# 2026-09 multi-agent improvement pass

Ten agents ran this pass under one orchestrator. Nine specialists audited the site read-only, and Ben approved the resulting plan (all no-taste-call fixes plus every structural and visual option offered). The same specialists then implemented it in three isolated worktree tracks. A tenth agent, the release gate, validated the merged result independently.

| Agent                                  | Track    | Scope                                                                                                                                 |
| -------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Infrastructure & CI                    | plumbing | Local-bundle verify path, the silently failing Scholar cron, dead workflows, deploy gates, least privilege, Dependabot                |
| Performance & Code Health              | plumbing | 44 MB of template residue, MDB, Font Awesome subset, headshot sizes, cache-busting, unused gems and layouts                           |
| SEO & Discoverability                  | plumbing | JSON-LD parse failures, Person schema, Highwire tags, absolute social card, icons                                                     |
| Visual Designer                        | design   | Color-collapse bug, type scale and weights, warm palette, opsz Newsreader, wordmark, axis origin tick, social card, re-rendered wheel |
| Accessibility & QA                     | design   | Wheel pause and carousel semantics, forced-colors focus, obscured focus, landmarks, lazy wheel assets, CV print                       |
| Research Curator                       | content  | 13 verified missing items, 12 stale or incorrect items, Scholar-candidate triage                                                      |
| Research Presentation & Data Integrity | content  | All works reachable, theme-grouped Research page, coauthors, code links, Cite this, coverage links, search                            |
| Copy Editor                            | content  | Mechanical voice and mechanics fixes only (voice rewrites deferred)                                                                   |
| Brand Strategist / IA                  | content  | Nav restructure, proof strip, `/press/` kit, Columbia above the fold, cross-links, footer channels                                    |
| Release Gate                           | —        | Nine-gate independent validation                                                                                                      |

The full findings, handoffs, screenshots, and Lighthouse JSONs live in the session scratchpad, not in the repo. This report is the durable record.

## What changed, in one paragraph per track

**Plumbing.** `bin/verify_site.sh` now builds with the local bundle, and Docker is optional. It checks six things: authors, schema, build, internal links, Font Awesome coverage, and a production build with PurgeCSS. The Scholar cron had failed silently since 2026-08-28. It is fixed (`bibtexparser<2`), runs weekly, fails loudly, and commits only on change. Deploy now gates on schema, links, and icon coverage before publishing. Ten al-folio workflows were removed. The build dropped from 48 MB to 6.3 MB, and MDB, the badge scripts, ten gems, and the unused layouts are gone. JSON-LD parses on every page (14 paper pages failed before). Ben is described as a Person with a job title, an employer, and the Columbia affiliation. The social card is absolute and `summary_large_image`.

**Design.** The single biggest visual defect was a specificity bug that forced every eyebrow, muted caption, and accent to ink. It is fixed by moving the base rules into `:where()`. The warm newsprint palette clears 4.5:1 on every text pair. Headings use Newsreader's opsz axis, with italic decks and a drop cap on the policy narratives only. The navbar carries a monogram wordmark, and the axis rule has a teal origin tick. The headline wheel figures were re-rendered in the new tokens, with colors only and no data touched. The wheel gained a persistent pause control, APG carousel semantics, and lazy, theme-specific asset loading, cutting first-load cost from about 755 KB to about 187 KB.

**Content.** Thirteen verified items were added, including seven older EIG analyses, the "Babysitter Clause" post, Fast Facts, and the INET Oxford EITC paper. Twelve stale items were corrected, among them co-author order, a dead CBS link, and the retirement-coverage figure. The Research page lists all 15 works in four agenda themes, with coauthors, confirmed code links, a Cite this block, and coverage links. The nav is now Research · Policy · Writing · Media · CV. EIG reports live under `/policy/#reports`, Code moved off the nav, and every old URL still resolves. The homepage has a data-validated proof strip and the Columbia affiliation, and `/press/` carries sourced bios and speaking topics.

## Release gate

The first gate run returned **SHIP WITH FIXES**. It found two blockers that no track had caught, because every agent tested the development build rather than the production build.

1. **PurgeCSS stripped the `:where(body.redesign-2026)` base rules** in `deploy.yml`'s production pipeline, so headings would have lost their serif face, scale, and italic decks on the live site. The fix fences the block with `/*! purgecss start ignore */` comments.
2. **Prettier failed** on the newly added social-card source.

The gate also surfaced a bug already live on `main`. jekyll-minifier's CSS pass stripped the spaces inside `clamp()`, so the hero and page titles rendered at 17px in production. It is fixed with `compress_css: false`, since Sass already compresses.

All three are now caught mechanically. Step 6 of `verify_site.sh` builds in production mode, runs PurgeCSS, and fails if the redesign rules vanish or a `clamp()` loses its spaces. Negative tests confirmed both checks fail when the fix is reverted.

| Gate                                    | Result                                                                     |
| --------------------------------------- | -------------------------------------------------------------------------- |
| verify_site.sh / Prettier / pre-commit  | Pass (after fixes)                                                         |
| URL regressions                         | 0 of 22 sitemap URLs lost; only `/feed.xml` and al-folio leftovers removed |
| axe-core (14 pages × light/dark)        | 0 violations in 28 runs; keyboard, overflow, and wheel checks pass         |
| Lighthouse mobile, home (median of 3)   | 76 → 90; LCP 5.4 s → 3.3 s                                                 |
| Lighthouse mobile, inner pages          | 81–82 → 91–94                                                              |
| Lighthouse desktop                      | 98–99 → 100                                                                |
| JSON-LD                                 | 25 of 25 blocks parse                                                      |
| New or changed external links           | 28 of 28 return 200                                                        |
| Bylines and dates vs. sources           | 14 of 14 match                                                             |
| `_data/citations.yml`, generated output | Untouched; nothing generated committed                                     |

The gate also flagged "Research covered in · Business Insider" as the loosest homepage claim, because the Business Insider items quote Ben rather than cover a study. That outlet was removed from the coverage line. Whether to add a separate "Quoted in" line is Ben's call.

## Follow-up decisions (same day)

Ben resolved several open items after the first review.

- **New copy approved.** Ben approved all newly written copy: the proof strip, both press bios, speaking topics, the Reports intro, and the nav labels.
- **Voice rewrites applied.** He approved the eight voice-rewrite drafts, and the Copy Editor applied them, adapted to the new page structure.
  - The homepage `seo_title` is "Benjamin Glasner — Economist, Economic Innovation Group".
  - The seven report descriptions on `/policy/` reuse each report's sourced `finding`, verbatim.
- **Two findings tightened.** Two `papers.bib` findings were edited so they claim no more than their abstracts. OZ housing supply now says "designated" tracts instead of "eligible". The Hawaii noncompete finding now says the exemption "was associated with" more establishments instead of "raised". No numbers changed.
- **Headshot kept.** The current photo stays. `/press/` offers it as a full-resolution download.
- **Robin Hood date.** The report is dated "August 2023", with no day. `writing.yml` now accepts month-precision `published: "YYYY-MM"`. The validator, schema rule, display, and sorting all handle it, and the validator checks that each writing list stays newest first.
- **CV PDFs regenerated.**
  - The Overleaf sources, which match the February builds byte for byte, now live in `cv/`.
  - `cv/build.sh` builds with the user-owned TinyTeX; Ben approved the CTAN packages it needed.
  - The content now reads `benjamin@eig.org` and includes the Columbia affiliation, every publication and report on the site, and media consistent with `media_page.yml`.
  - Page counts: full is 5, two-page is 2, one-page is 1. Each file is under 250 KB.
  - `Ben_Glasner_CV.pdf` is now a copy of the full CV.
- **GitHub settings.** Ben set workflow permissions to read-only and enabled Dependabot alerts.
- **CI follow-up.** Auto-fix caught a failing Copilot setup job and fixed it by restoring a PyYAML install for its pip cache.

## Open items for Ben

**Content confirmations.**

- the food stamp paper's canonical title
- the Liquid Assets author order
- the two paywalled Forbes columns
- the OZ housing supply SSRN version
- the four personal-repo code links
- the `noncompete-income` mapping
- The New Bazaar podcast role
- whether press requests should route through EIG communications
- whether to add a "Quoted in · Business Insider" proof line

**GitHub (optional or after merge).**

- Optionally enable Dependabot security updates, not just alerts.
- Delete the stale remote branches listed in the infra handoff.
- After merge, run `gh workflow run update-citations.yml` once to confirm a green run.
- The first deploy installs from a committed `Gemfile.lock` for the first time. Watch that run.

**Discoverability.**

- The `bglasner.com` domain is dead but still ranks for Ben's name. Renew and redirect it, or request removal.
- Set up Search Console and submit the sitemap.
- Add the site URL to the Scholar profile, LinkedIn, X, Bluesky, and Linktree.

**Known cosmetic nit.** Prettier wraps long `<a>` titles on `/policy/` across lines, so the underline runs one space past a few link titles.
