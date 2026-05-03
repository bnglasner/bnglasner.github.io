---
title: Ben Glasner — Portfolio Deep Dive
date: 2026-05-03
author: Site review pass (CV + EIG bio + Linktree + NBER + Equitable Growth + Substack + GitHub)
purpose: Identify every element of Ben Glasner's professional portfolio worth carrying on the personal site, and flag what should not appear because it is not genuinely his.
status: Reference document. No site files were edited in producing this report.
---

# Portfolio deep dive

The CV in `assets/pdf/Ben_Glasner_CV_full.pdf` is the spine. This document cross-checks it against every public footprint that surfaced in the audit (EIG staff page, Substack, Linktree, NBER, Equitable Growth, Google Scholar, GitHub on `bnglasner` and `EIG-Research`) and against the existing site to surface gaps, duplications, and template residue. The user's rule applied throughout: only content genuinely from Ben Glasner belongs on the site, with the EIG-Research GitHub organization carved out as the one institutional exception.

## 1. Identity, current role, and bio inputs the site can draw from

The site has three sources of bio prose available, written for three different audiences. They should not be merged into one paragraph because the audiences differ, but the site landing page should be informed by all three.

EIG's official bio (https://eig.org/about-us/executive-team-staff/ben-glasner/, last modified 2026-02-10) is the conservative institutional version: "Ben Glasner is a Senior Economist at EIG. Prior to joining EIG, he was a Postdoctoral Research Scientist with the Center on Poverty and Social Policy at Columbia University, where he conducted analyses of the effects of major social policies and reforms on the poverty rate and other key indicators of well-being. These include long-term studies of the intergenerational transmission of poverty, but also studies of contemporary policies and their effects, including the child tax credit. He holds a Ph.D. in Public Policy and Management from the Daniel J. Evans School of Public Policy and Governance at the University of Washington."

Substack's bio is the practitioner-to-practitioner version: "Senior Economist at EIG. Affiliate at the Center on Poverty and Social Policy at Columbia University. Check the links for the important stuff."

Linktree's bio is the casual version: "Senior economist. Ex-post doc. Ex-Ex grad student. Ph.D. from the Daniel J. Evans School of Public Policy and Governance."

The site's current `_pages/about.md` opener is closer in voice to the EIG bio than the Substack or Linktree versions, which is the right register. Two facts from the Substack bio are not yet anywhere on the site or CV and should be added: the **affiliate appointment at the Center on Poverty and Social Policy at Columbia** is current, not historical, and is meaningful for an academic-leaning visitor. Treat it as a present-tense affiliation alongside the EIG role.

## 2. Full publication and writing portfolio

### 2.1 Peer-reviewed and academic record (already on the site)

The bibliography in `_bibliography/papers.bib` carries the three peer-reviewed pieces (the 2024 _JPubE_ CTC employment paper, the 2023 _JLE_ minimum-wage paper, and the 2022 _Health Affairs_ CTC well-being paper), the dissertation, the Vassar senior thesis, and the policy reports. Google Scholar (`citations.yml`, 16 records) confirms the bibliography is complete on peer-reviewed and dissertation work but turns up four titles that do not yet have bib entries. These appear to be early-stage work or external indexing artifacts, not necessarily missing publications, and should be triaged before being added:

- "Tax Evasion Among the Self-Employed: Medicaid Expansion" — likely a working-paper draft from the dissertation period.
- "Evaluating the (short-lived) US experiment with a child benefit" — likely an alternate listing of the _JPubE_ CTC paper or a related book chapter.
- "The Earned Income Tax Credit and the Intergenerational Persistence of Poverty" (2025) — possibly an in-progress companion to the SNAP intergenerational mobility paper.
- "Nonstandard Work Arrangements across Metropolitan and Nonmetropolitan Areas of the United States" — likely a dissertation-chapter publication or a working paper.

Confidence: Medium. Scholar surfaces these from EIG's Scholar profile, but Scholar can deduplicate poorly and can reflect drafts shared internally. Worth confirming each before adding to the site.

### 2.2 Policy reports, working papers, and EIG bylined work

The bibliography covers his eight policy reports (the 80-80 wage subsidy, OZ housing supply, OZ literature review, the Great "Transfer"-mation, the American Worker Project, the Hawaii/Oregon noncompete note, the SNAP intergenerational mobility working paper, and the Robin Hood liquid assets spotlight). One genuine EIG byline is missing from the bibliography:

- **"Full vs. Hybrid: Examining the Consequences of How Americans Work Remotely"** — Carlson, Glasner, and Ozimek, EIG, 2023-11-16, https://eig.org/full-vs-hybrid-remote-work/. Co-authored with Eric Carlson and Adam Ozimek.

The EIG team-page archive at his staff URL surfaces fifteen analysis-type pieces. Of those, the audit confirms only the OZ literature review (already in the bib) and the full-versus-hybrid piece above carry his byline. The remaining thirteen are bylined to other EIG staff and surface on his page only because EIG's CMS attaches contributors and team members to the team archive. Per the strict-byline rule, none of those thirteen belong on the personal site.

### 2.3 Short-form Agglomerations record

Substack's profile API returns sixteen pieces under his byline. The site's `_data/writing.yml` carries twelve of them. Six pieces are missing or under-attributed:

- 2026-04-30 — "Fixing the U.S. Retirement System: A Q&A" (solo). New since the file was last refreshed; this is the most recent piece and a natural lead card on the writing page.
- 2025-12-22 — "How to end low-wage work forever, Part 2: the FAQ" (solo). The CV references it; the data file does not.
- 2025-12-08 — "How many manufacturing workers are there?" with Adam Ozimek and Jiaxin (Jason) He.
- 2025-02-07 — "Transfers, deficits, and your community: How will you know?" with Sarah Eckhardt and Cardiff Garcia.
- 2024-11-15 — "The economic geography of the 2024 elections" with Sarah Eckhardt and Connor O'Brien.
- 2024-11-08 — "An inflation puzzle of the 2024 election" with Cardiff Garcia.
- 2024-10-03 — "Who's left out of America's retirement savings system?" with Sarah Eckhardt.

There is also a guest post not on Agglomerations that the data file omits:

- 2024-03-28 — "Minimum Wage Laws and App-Based Workers" on the _Labor Market Matters_ Substack (Liya Palagashvili and Revana Sharfuddin's publication), https://www.labormarketmatters.com/p/minimum-wage-laws-and-app-based-workers. This is genuine Ben Glasner work, on a different masthead. It should be listed alongside the Agglomerations posts but tagged as a guest piece, mirroring how the EIG bio treats outside speaking and writing.

Separately, the existing twelve `short_form` entries in `writing.yml` are presented as solo authorship. Most are co-authored, sometimes with three EIG colleagues. The data file should carry an `authors` field on each entry so the site can render co-bylines accurately. This is an integrity issue, not a stylistic one — presenting a co-authored Substack post as solo work runs into the user's own rule about not presenting non-genuine attribution.

## 3. Code and data portfolio

The personal `bnglasner` GitHub account holds ten repositories. Six are genuine research artifacts that belong on the personal site under a Code/Data section: `eig-wagesubsidy-policy-sim` (the underlying engine for the 80-80 simulator page), `hours-working-for-median-home`, `telework-ASEC-analysis`, `MinimumWage-SelfEmp` (the _JLE_ paper's replication code), `QCEW`, and `CTC-MentalHealth` (the _Health Affairs_ paper's replication code). Four are infrastructure or forks that should not appear on the portfolio: `bnglasner.github.io` (the site source itself), `are213` (a UC Berkeley course fork), `policyengine-claude` (a fork of PolicyEngine's plugin), and `policy-rules-database` (a fork of the Federal Reserve's database).

The current `_pages/repositories.md` page lists the five most recently updated repos in the EIG-Research organization via a live GitHub API call and links out to the org page. That treatment is correct for the institutional carve-out — it surfaces the institutional work without claiming sole authorship. The personal-account research repos are a separate category and currently have no surface on the site. They are worth surfacing as a small, hand-curated section on the same page (named, for example, "Personal research code"), distinct from the live EIG-Research feed.

The EIG-Research organization currently has 29 repositories, all R or Stata-heavy replication code for EIG papers and briefs. Several map directly to publications already on Ben's site:

- `oz-housing-supply` ↔ the 2025 OZ housing supply report.
- `EIG-Great-Transfer-Mation` ↔ the 2024 Great "Transfer"-mation report.
- `Retirement-Analysis-Urban-Rural`, `Retirement-data-summary-2024`, `Retirement-data-summary-2025`, and `EIG-Savers-match-sipp` ↔ the RSAA policy work documented on the policy page.
- `noncompete-income` ↔ the 2023 Hawaii/Oregon noncompete note.

Cross-linking individual policy and publication entries to their replication repos would reinforce the open-research narrative the repositories page already makes.

## 4. Public profiles, social channels, and broadcast presence

The site's current `_data/socials.yml` exposes email, GitHub, LinkedIn, and Google Scholar. Linktree (`linktr.ee/bglasner`) broadcasts a much larger portfolio. With the directive to surface all of them, the following handles should be added to the site footer or social block:

- X / Twitter — https://x.com/BenGlasner
- Bluesky — https://bsky.app/profile/benglasner.bsky.social
- TikTok — https://www.tiktok.com/@microfamousben
- Instagram — https://www.instagram.com/microfamousben
- Threads — https://www.threads.com/@microfamousben
- Substack (Agglomerations) — https://agglomerations.eig.org (canonical) and https://agglomerations.substack.com (alias)

Two cross-platform identities are in play: `BenGlasner` for the professional X handle and `microfamousben` for the consumer-creator stack on TikTok, Instagram, and Threads. The site should carry both because the user has confirmed surfacing all of them; visitors should be able to recognize that the same person is behind the research outputs and the explainer-video presence. The al-folio social block supports custom icons and labels and can render the creator stack in a separate row from the academic stack if visual hierarchy matters.

Two profiles already in `socials.yml` are stale or partial. The Equitable Growth profile at `equitablegrowth.org/people/benjamin-glasner/` still lists him as "Postdoctoral Research Scientist" — it is an external page he likely cannot edit, and the site should not link to it as a current bio. The NBER person page (`nber.org/people/benjamin_glasner`) is a stub with no listed program, no bio, and no statically rendered NBER working papers. He is not a Research Associate. Linking it from the site would suggest an NBER affiliation that does not exist; it should not be added to socials. The "Podcast - The New Bazaar" link on Linktree points to EIG's podcast, but Ben is neither host nor guest on any episode in the public archive. It should not appear on the personal site as "his podcast."

## 5. Speaking, media, and outreach record

The CV's "Policy, News, and Media" section is currently the only place these are captured, and it is a narrative listing rather than a structured record. The site has no media or speaking page. Given that the CV references CBS MoneyWatch, _Money with Katie_ (Morning Brew), _The Ross Kaminsky Show_, _Spotlight on Poverty & Opportunity_, the _Political Economy Forum_ podcast, and a list of print outlets including _NYT_, _WSJ_, _FT_, _Washington Post_, _Bloomberg_, _CBS News_, _Yahoo Finance_, and _MarketWatch_, there is enough volume to justify a dedicated `/media/` page, even if it starts thin and grows.

The CV also lists three policy-advisory roles that do not appear on the website: the Seattle Mayor's Office and Senator Mark Warner advisory team work on nonstandard work arrangements and COVID-19 labor markets; the Utah Legislative Session report on SB 233 (the Flexible Benefits Working Group); and the data-tools work for the Washington State Employment Security Department and the World Bank. These are exactly the kind of credentials a policy-facing visitor would scan for, and the policy page is the right home for them — either as a sidebar of "earlier policy advisory work" or folded into a new "Public service and consulting" section.

The CV awards (Pi Alpha Alpha Doctoral Manuscript Award 2020; NASPAA Staats Emerging Scholar; Agnes Reynolds Jackson Prize 2016) appear in `_data/cv.yml` and render on the CV page. They have no surface elsewhere on the site, which is fine; awards belong on the CV.

## 6. Template residue to remove or repurpose

The site is built on al-folio and inherits a substantial body of demo content. The companion review (`docs/audits/2026-05-03-front-facing-review.md`) catalogs most of this and recommends specific deletions; that recommendation list still stands. To restate it concisely: every file in `_projects/` (1_project through 9_project) is template content with placeholder text and lorem ipsum descriptions. Every file in `_news/` (announcement_1 through announcement_3) is template placeholder. Both files in `_teachings/` describe courses taught by "Prof. Data" and "Prof. Example", not Ben. The only file in `_books/` is a Godfather entry with lorem ipsum. The al-folio demo posts in `_posts/` (formatting-and-links, code, math, diagrams, jupyter-notebook, plotly, and the rest) are theme feature demonstrations, not Ben's writing. `_pages/about_einstein.md`, `_pages/profiles.md`, `_pages/teaching.md`, `_pages/projects.md`, `_pages/books.md`, and `_pages/dropdown.md` either render template content or expose template routes (`/people/`, `/teaching/`, `/projects/`, `/books/`).

The right disposition for each is a separate decision. The minimum bar for the rule the user articulated is removing every demo file and every page that points to demo content. The narrower bar — repurposing some pages for real Ben content — is also defensible: `_pages/teaching.md` could become a record of his MPA microeconomics instruction at the University of Washington and his Dean's RA work; `_pages/projects.md` could host the wage-subsidy simulator and the personal-account GitHub research repos as a structured project gallery; `_pages/books.md` could become a reading list if there is one to surface. Without that repurposing decision, deletion is the cleaner default.

## 7. What the site does not currently capture but should

Five capturable items are missing from the site entirely:

1. **The Columbia affiliate appointment** — current, named in the Substack bio, and absent from the website and the CV.
2. **The "Full vs. Hybrid" EIG analysis (2023-11-16)** — genuine co-byline, missing from the bibliography.
3. **The "Fixing the U.S. Retirement System: A Q&A" Substack post (2026-04-30)** — newest piece; not on the writing page.
4. **The "Minimum Wage Laws and App-Based Workers" guest post on Labor Market Matters (2024-03-28)** — genuine work on an external publication; not on the writing page.
5. **The six personal-account research repositories** — `eig-wagesubsidy-policy-sim`, `hours-working-for-median-home`, `telework-ASEC-analysis`, `MinimumWage-SelfEmp`, `QCEW`, and `CTC-MentalHealth` — none surfaced on the repositories page, which currently shows only the EIG-Research org feed.

Two structural additions would carry the rest of the portfolio:

6. **A `/media/` page** for podcast appearances, broadcast interviews, and major print citations, drawn from the CV's "Policy, News, and Media" section and grown over time.
7. **An expanded socials block** that surfaces the six handles enumerated in section 4.

## 8. What the site should not include

Per the rule and the byline audit:

- The thirteen EIG team-page items where Ben is not bylined (families-exodus, left-behind-places, immigrant-retention-estimates, hsi-voter-survey, immigrants-patents, 2023-business-formation, aging-population-impact, new-york-declining-dynamism, most-dynamic-states-post-pandemic, tech-hubs-designations, prime-age-employment-recompetes, remote-work-in-2022, pandemic-business-dynamism). These should never be presented as Ben's work even though they appear on his EIG team page.
- The New Bazaar podcast, in any framing that suggests it is his.
- The Equitable Growth and NBER profile pages as current bios — both are stale or empty.
- Any of the al-folio template demo pages (sections 6 above).
- Forks on the personal GitHub account (`are213`, `policyengine-claude`, `policy-rules-database`) presented as portfolio work.

The EIG-Research organization remains the single carved-out exception and is correctly framed on the existing repositories page as institutional code, not personal authorship.

---

## Evidence

**Sources**

- `assets/pdf/Ben_Glasner_CV_full.pdf` (full CV, four pages, current as of 2026 hire-promotion line).
- `_data/cv.yml`, `_data/writing.yml`, `_data/citations.yml`, `_data/socials.yml`, `_data/cv_assets.json`, `_data/venues.yml`, `_data/coauthors.yml` (empty), `_data/publications.json` (empty), `_data/mentions.json` (empty), `_data/media.json` (30 ingested feed items).
- `_bibliography/papers.bib` (13 entries).
- `_pages/about.md`, `_pages/policy.md`, `_pages/repositories.md`, `_pages/wage-subsidy-sim.md`, `_pages/writing.md`, `_pages/cv.md`, `_pages/publications.md` (all genuine Ben content).
- `docs/audits/2026-05-03-front-facing-review.md` (the 2026-05-03 voice-and-copy review pass — its template-leftover list is consistent with this audit).
- https://eig.org/about-us/executive-team-staff/ben-glasner/ (and pages 2 through 5 of the team-archive feed).
- https://linktr.ee/bglasner (parsed from the embedded Linktree JSON blob).
- https://www.nber.org/people/benjamin_glasner.
- https://equitablegrowth.org/people/benjamin-glasner/.
- https://agglomerations.substack.com (Substack profile API for the complete byline list, profile_user_id 219318610).
- https://eig.org/newbazaar/ and https://eig.org/all-episodes/ (host/guest verification).
- GitHub REST API for `users/bnglasner/repos` and `orgs/EIG-Research/repos`.

**Confidence**

- High — the byline structure of the 15 EIG team-page items (verified directly against each EIG post page).
- High — the inventory of the 16 Substack posts (pulled directly from Substack's profile API).
- High — the GitHub repository inventories on both accounts (REST API).
- High — the absence of Ben Glasner as host or guest on The New Bazaar (verified across all five archive pages plus the show landing page).
- High — the staleness of the Equitable Growth profile (still labels him a Columbia postdoc) and the emptiness of the NBER stub (no working papers, no program).
- Medium — the four Google-Scholar-only titles ("Tax Evasion Among the Self-Employed: Medicaid Expansion", "Evaluating the (short-lived) US experiment with a child benefit", "The Earned Income Tax Credit and the Intergenerational Persistence of Poverty", "Nonstandard Work Arrangements across Metropolitan and Nonmetropolitan Areas of the United States"). Scholar deduplicates poorly; some of these may be the same paper as an existing bib entry under a different listing.
- Medium — the fitness of the Substack guest post on _Labor Market Matters_ for the writing page; it is genuine Ben work but on an external masthead, and the user may want to render it with a "guest" label.

**Assumptions**

- The user wants to keep the al-folio template framework rather than rebuild on a different system. All recommendations are scoped to additions and removals within al-folio's existing data and page structure.
- The EIG-Research carve-out applies to the org as a whole; any individual repo within it is treated as institutional regardless of who pushed the most recent commit.
- "Genuinely from Ben Glasner" means bylined by Ben, not merely surfaced on his EIG team page or attributed to him by an external indexer.
- The `microfamousben` creator stack is intended to be broadcast on the site (per the user's answer to the social-profiles question). If that intent changes, those four handles should come back off the site.
- The Columbia "Affiliate at the Center on Poverty and Social Policy" appointment named in the Substack bio is current, not historical. Worth confirming before adding it to the CV under "Affiliations" or to the about page as a present-tense line.
