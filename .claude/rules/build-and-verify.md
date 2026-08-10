# Rule: build and verify

The site is built locally with Docker (the al-folio prebuilt image) and deployed to GitHub Pages. The pre-commit checklist below applies to every commit that touches site source.

## Pre-commit checklist

1. **Format.** From the repo root, run:

   ```bash
   npx prettier . --write
   ```

   First-time setup: `npm install --save-dev prettier @shopify/prettier-plugin-liquid`. The `.prettierrc` configures the Shopify Liquid plugin with `printWidth: 150` and `trailingComma: "es5"`.

2. **Validate data.** If the commit touches `_data/` or `_bibliography/`, run:

   ```bash
   python3 bin/validate_data.py
   ```

   It enforces the schemas in `schema-invariants.md` (also enforced at commit time by pre-commit). For a full non-interactive pass — schema validation, headless build, internal link check — run `bash bin/verify_site.sh` instead of steps 3–4.

3. **Build.** Run:

   ```bash
   docker compose up --build
   ```

   The site renders at `http://localhost:8080`. Wait for "Server running… press ctrl-c to stop." If the build errors, do not commit.

4. **Spot-check.** In the running site, verify:
   - Top-level navigation renders every page in `_pages/`.
   - Dark-mode toggle works on the page you edited.
   - Any new internal links resolve (no 404).
   - Any new image renders at the correct size.
   - The publications page bibliography filter still works if you touched `papers.bib`.

5. **Stop the container.** `docker compose down` to free port 8080.

## Files that must not be committed

`.gitignore` already excludes `_site/`, `.jekyll-cache/`, `.jekyll-metadata`, `.bundle/`, `node_modules/`, and `Gemfile.lock`. If you find one of these in `git status`, stop and check why before committing.

`.prettierignore` excludes a longer list of generated and template-residue files. The auto-generated data files (`_data/citations.yml`, `_data/publications.json`, `_data/mentions.json`, `_data/media.json`, `_data/cv_assets.json`) are listed there because their contents are pipeline outputs — Prettier should not touch them and Claude should not edit them by hand.

## `_config.yml` invariants

Two pairs of fields must be updated together, never one without the other:

- **Personal site (this site):** `url: https://bnglasner.github.io` + `baseurl: ""` (empty). This site is at `bnglasner.github.io`, the GitHub Pages personal site, so `baseurl` is empty.
- **YAML special characters:** any title or string containing `:`, `#`, `&`, `*`, `!`, `|`, `>`, `'`, or `"` must be quoted.

## CI workflows already running

Every push and pull request triggers Prettier, broken-link checks (lychee), CodeQL, and accessibility (axe). Lighthouse runs on a schedule (`lighthouse-badger.yml`) and on demand. `update-citations.yml` runs Monday/Wednesday/Friday and refreshes `_data/citations.yml` from Google Scholar.

If a CI job fails on a Claude-authored PR, fix the cause locally and push the fix. Do not paper over a failure by editing the workflow.

## When the build fails

- **`bundler: command not found: jekyll`** — rebuild with `docker compose up --build` (image needs to repull).
- **`Liquid Exception` on a page Claude edited** — almost always a YAML front-matter quote issue, an unclosed Liquid tag, or a bibliography entry with an unescaped `&` or `%`.
- **`No such file or directory @ rb_sysopen` for an image** — the front-matter `image:` field references a path that does not exist under `assets/img/`.
- **Port 8080 in use** — a previous container is still running. `docker compose down` then retry.
