# Rule: content integrity

This site is Benjamin Glasner's personal academic portfolio. The integrity rules below apply to every edit, no matter which skill or agent is active.

## Only-genuinely-Ben

Every page, bibliography entry, data-file entry, and surfaced repository must reflect work Ben Glasner actually authored, co-authored, or holds an institutional role in. The site is not a topic blog and not an institutional landing page. If you are unsure whether a piece of content is genuinely his, stop and ask before adding it.

## EIG-Research GitHub organization is the one institutional carve-out

The `EIG-Research` GitHub organization may be surfaced on the site (and is, on `_pages/repositories.md`, via a live API call to the org's most recently updated repositories). This is the single allowed exception to the only-Ben rule. No other institutional or third-party content gets a personal-site surface.

The personal `bnglasner` GitHub account contains repositories that are _not_ his research artifacts: `bnglasner.github.io` (the site source), `are213` (a UC Berkeley course fork), `policyengine-claude` (a fork of PolicyEngine's plugin), `policy-rules-database` (a fork of the Federal Reserve's database). These four repositories must not appear in any hand-curated personal-research-code section.

## Co-authored work is co-authored everywhere

Most of Ben's writing is co-authored. Every entry in `_data/writing.yml` (both `short_form:` and `reports:`) must carry an `authors` field listing each co-author by name. Solo authorship is signaled by `authors: ["Ben Glasner"]`, never by omitting the field. A pre-commit hook in `bin/check_writing_authors.py` enforces this. The same rule applies to bibliography entries: `papers.bib` `author = {...}` must list every co-author.

## Source verification before adding new content

Before adding a publication, working paper, or short-form piece, verify the source:

- **Peer-reviewed publication** — confirm the published version exists at the journal URL or DOI. Do not promote a working paper to "peer-reviewed" status until acceptance is in hand.
- **Working paper** — confirm the working-paper version exists at NBER, IZA, SSRN, the Equitable Growth working-paper series, or another verifiable host. The four Scholar-only candidates flagged in `docs/audits/2026-05-03-portfolio-deep-dive.md` should be verified before any addition, not assumed real.
- **Short-form piece** — confirm the live URL on Agglomerations (`https://agglomerations.eig.org`) or the host publication. Capture the publication date, all co-authors, and the outlet.
- **Policy report** — confirm the EIG URL and the byline order as it appears at the top of the published report.

## No template residue

Do not ship al-folio template placeholders (Albert Einstein bio prose, lorem ipsum, demo blog posts, demo news announcements, demo project cards). The repo's `_pages/`, `_news/`, and `_posts/` directories were cleaned in May 2026; do not reintroduce demo content during edits. If a new feature requires a placeholder, mark it explicitly (`<!-- TODO: Ben to populate -->`) and never commit the placeholder text to a published page.

## When the rule is unclear

If a request implies an exception to any of the above, stop and ask. Examples that warrant a stop-and-ask:

- A piece that mentions Ben in the body but is bylined to someone else (probably belongs on the byline-author's site, not Ben's).
- An EIG explainer he contributed to without a byline (does not belong on the personal site).
- A podcast or media appearance where Ben is the guest (belongs in `_data/mentions.json` or `_data/media.json`, not in `_data/writing.yml`).
- A co-authored piece where the co-author's name is uncertain (resolve the byline first).
