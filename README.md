# Benjamin Glasner Website

This repository contains the source for Benjamin Glasner's public website, built with Jekyll on top of the `al-folio` theme.

The site is intentionally opinionated: it prioritizes a small set of real public pages backed by repo-local structured data, not the full upstream demo surface of the theme.

## What Lives Here

The public site centers on seven areas:

- `about` — research focus, selected outputs, and public profile
- `cv` — structured CV rendered from `_data/cv.yml`
- `publications` — formal bibliography rendered from `_bibliography/papers.bib`
- `writing` — policy reports, working papers, and curated short-form essays from `_data/writing.yml`
- `media` — curated appearances, quoted coverage, and selected cited coverage from `_data/media_page.yml`
- `code + data` — selected repositories from `_data/repositories.yml`
- `tools` — interactive tools, including the 80-80 wage subsidy simulator

## Source Of Truth

The repository now treats repo-local files as authoritative:

- `_data/cv.yml` — canonical CV content for the website
- `_data/cv_assets.json` — published PDF variants for the CV
- `_bibliography/papers.bib` — formal publications, working papers, and reports
- `_data/writing.yml` — public-facing reports, essays, and commentary
- `_data/media_page.yml` — curated media appearances and selected cited coverage
- `_data/repositories.yml` — curated repository metadata
- `_data/socials.yml` — public contact/profile links

Legacy generated snapshots such as `_data/media.json`, `_data/repos.json`, and `_data/repositories.json` may still exist, but they are not the primary editorial source for the live site.

## Demo Content Policy

This repo still contains some upstream `al-folio` sample files for reference, but the build excludes them from the public site. In particular, demo content under:

- `_books/`
- `_news/`
- `_posts/`
- `_projects/`
- `_teachings/`

is not part of the published site unless you intentionally re-enable it.

## Local Development

Docker remains the recommended development path.

```bash
docker compose pull
docker compose up
```

The site is served at [http://localhost:8080](http://localhost:8080).

If you prefer a local Ruby environment, install the bundle dependencies first and then run:

```bash
bundle exec jekyll serve --port 4000
```

## Key Maintenance Tasks

### Update the CV

Edit:

- `_data/cv.yml`
- `_data/cv_assets.json` if PDF filenames change

### Update formal publications

Edit:

- `_bibliography/papers.bib`

Use the `entry_group` field to control which section a publication appears in on the site:

- `peer_reviewed`
- `working_paper`
- `dissertation`
- `thesis`
- `policy_report`

### Update writing and commentary

Edit:

- `_data/writing.yml`

### Update featured repositories

Edit:

- `_data/repositories.yml`

## Search Behavior

The site search is intentionally curated. It indexes:

- navigation pages
- writing entries
- featured repositories
- key profile/contact links

It does not index excluded demo collections or sample posts.

## Quality Checks

Before shipping changes:

```bash
npx prettier . --write
docker compose up
```

Then manually verify:

- homepage layout and navigation
- CV rendering and PDF links
- publications sections and bibliography search
- writing page links
- repository links
- search behavior

## Legacy Notes

- `.profile_payload_sync_manifest.json` has been retired; repo-local source files are now authoritative.
- The old RenderCV GitHub Actions workflow has been removed because the live site no longer depends on that path.
