#!/usr/bin/env bash
# verify_site.sh -- headless, non-interactive verification of the site
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - Give agents (and Ben) a single command that validates data schemas,
#           builds the site without starting a server, checks internal links, and
#           checks that the Font Awesome subset covers every icon in use.
#           Complements the interactive `bundle exec jekyll serve` path in
#           .claude/rules/build-and-verify.md, which remains the tool for visual
#           spot-checks (dark mode, images, layout).
# Usage   - bash bin/verify_site.sh          (from the repo root)
#
# Exit codes: 0 = all checks passed; non-zero = the failing step's exit code.

set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> 1/5 writing.yml authors check"
python3 bin/check_writing_authors.py

echo "==> 2/5 data schema validation"
python3 bin/validate_data.py

echo "==> 3/5 headless Jekyll build (no server)"
# Builds into _site_verify (gitignored) so the dev server's _site/ is untouched.
# Primary path: the local Ruby toolchain (bundle). Fallback: the al-folio Docker
# image, for machines that have Docker but no local Ruby.
if command -v bundle >/dev/null 2>&1 && bundle check >/dev/null 2>&1; then
  # UTF-8 locale: under LANG=C, jekyll-terser raises "\xE2 on US-ASCII" and
  # silently skips minifying the affected scripts.
  LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 bundle exec jekyll build \
    --strict_front_matter \
    --destination _site_verify
elif command -v docker >/dev/null 2>&1; then
  docker compose run --rm jekyll bundle exec jekyll build \
    --strict_front_matter \
    --destination _site_verify
else
  echo "verify_site.sh: need either a local Ruby toolchain ('bundle install') or Docker" >&2
  exit 1
fi

echo "==> 4/5 internal link check over the built site"
python3 bin/check_internal_links.py _site_verify

echo "==> 5/5 Font Awesome subset covers every icon used"
python3 bin/check_fa_icons.py _site_verify

echo "verify_site.sh: all checks passed"
