# Rule: build and verify

The site is built locally with the Ruby toolchain (`bundle exec jekyll`, Ruby 3.3 via Homebrew; CI pins 3.3.5) and deployed to GitHub Pages by `.github/workflows/deploy.yml`. Docker (the al-folio prebuilt image) is an optional alternative for machines without local Ruby; it is not installed on Ben's machine. The pre-commit checklist below applies to every commit that touches site source.

## Pre-commit checklist

1. **Format.** From the repo root, run:

   ```bash
   npx prettier . --write
   ```

   First-time setup: `npm ci` (installs the Prettier and Liquid-plugin versions pinned in `package-lock.json`). The `.prettierrc` configures the Shopify Liquid plugin with `printWidth: 150` and `trailingComma: "es5"`.

2. **Validate data.** If the commit touches `_data/` or `_bibliography/`, run:

   ```bash
   python3 bin/validate_data.py
   ```

   It enforces the schemas in `schema-invariants.md` (also enforced at commit time by pre-commit). For a full non-interactive pass — schema validation, headless build, internal link check — run `bash bin/verify_site.sh` instead of steps 3–4.

3. **Build.** Run:

   ```bash
   LC_ALL=en_US.UTF-8 bundle exec jekyll serve --port 4000
   ```

   The site renders at `http://localhost:4000` (the same command `.claude/launch.json` runs). Wait for "Server running… press ctrl-c to stop." If the build errors, do not commit. First-time setup: `bundle install`. The UTF-8 locale matters: under the macOS default `LANG=C`, jekyll-terser prints `Terser Exception: "\xE2" on US-ASCII` and skips minifying those scripts.

   Docker alternative (only if Docker is installed): `docker compose up --build`, served at `http://localhost:8080`.

4. **Spot-check.** In the running site, verify:
   - Top-level navigation renders every page in `_pages/`.
   - Dark-mode toggle works on the page you edited.
   - Any new internal links resolve (no 404).
   - Any new image renders at the correct size.
   - The publications page bibliography filter still works if you touched `papers.bib`.

5. **Stop the server.** `ctrl-c` (or `docker compose down` if you used Docker).

## Files that must not be committed

`.gitignore` already excludes `_site/`, `_site_verify/`, `.jekyll-cache/`, `.jekyll-metadata`, `.bundle/`, and `node_modules/`. (`Gemfile.lock` is tracked on purpose: it pins gem versions and the jekyll-terser git revision.) If you find one of these in `git status`, stop and check why before committing.

`.prettierignore` excludes a longer list of generated and template-residue files. The auto-generated data files (`_data/citations.yml`, `_data/publications.json`, `_data/mentions.json`, `_data/media.json`, `_data/cv_assets.json`) are listed there because their contents are pipeline outputs — Prettier should not touch them and Claude should not edit them by hand.

## `_config.yml` invariants

Two pairs of fields must be updated together, never one without the other:

- **Personal site (this site):** `url: https://bnglasner.github.io` + `baseurl: ""` (empty). This site is at `bnglasner.github.io`, the GitHub Pages personal site, so `baseurl` is empty.
- **YAML special characters:** any title or string containing `:`, `#`, `&`, `*`, `!`, `|`, `>`, `'`, or `"` must be quoted.

## CI workflows already running

- **`deploy.yml`** (push to `main` and PRs): validates data schemas (`check_writing_authors.py`, `validate_data.py`), builds with Ruby 3.3.5, purges CSS, runs `check_internal_links.py` over the production `_site`, then publishes to `gh-pages`. PRs run every gate but skip the publish. A schema or link failure blocks the deploy.
- **`prettier.yml`** (push to `main` and PRs): `prettier . --check` with the lockfile versions.
- **`codeql.yml`** (push, PR, weekly): JavaScript and Ruby, ignoring vendored `assets/js/distillpub/` and `assets/libs/`.
- **`update-citations.yml`** (weekly, Monday): refreshes `_data/citations.yml` from Google Scholar and commits only when counts changed. A Scholar or dependency failure now fails the run (red) instead of reporting success. Its commits use `GITHUB_TOKEN`, so they do not trigger a deploy; that is fine because no page renders `citations.yml`.
- **`axe.yml`** (manual dispatch only): accessibility scan of the built site.
- **Dependabot** (`.github/dependabot.yml`): monthly grouped version-update PRs for Actions, Bundler, npm, and pip.

There is no Lighthouse workflow; run Lighthouse locally via the `build-and-preview` skill.

If a CI job fails on a Claude-authored PR, fix the cause locally and push the fix. Do not paper over a failure by editing the workflow.

## When the build fails

- **`bundler: command not found: jekyll`** or `Could not find gem` — run `bundle install` (Docker users: `docker compose up --build` to repull the image).
- **`Liquid Exception` on a page Claude edited** — almost always a YAML front-matter quote issue, an unclosed Liquid tag, or a bibliography entry with an unescaped `&` or `%`.
- **`No such file or directory @ rb_sysopen` for an image** — the front-matter `image:` field references a path that does not exist under `assets/img/`.
- **Port 4000 in use** — a previous `jekyll serve` is still running; stop it (`lsof -ti :4000 | xargs kill`) and retry. Docker users: port 8080, `docker compose down`.
- **`Terser Exception: ... on US-ASCII`** — not a site bug; set `LC_ALL=en_US.UTF-8` (as `bin/verify_site.sh` and `.claude/launch.json` do).
