#!/usr/bin/env bash
# verify_site.sh -- headless, non-interactive verification of the site
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - Give agents (and Ben) a single command that validates data schemas,
#           builds the site without starting a server, and checks internal links.
#           Complements the interactive `docker compose up` path in
#           .claude/rules/build-and-verify.md, which remains the tool for visual
#           spot-checks (dark mode, images, layout).
# Usage   - bash bin/verify_site.sh          (from the repo root)
#
# Exit codes: 0 = all checks passed; non-zero = the failing step's exit code.

set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> 1/4 writing.yml authors check"
python3 bin/check_writing_authors.py

echo "==> 2/4 data schema validation"
python3 bin/validate_data.py

echo "==> 3/4 headless Jekyll build (docker compose run, no server)"
# Builds into _site_verify (gitignored) so the dev server's _site/ is untouched.
docker compose run --rm jekyll bundle exec jekyll build \
  --strict_front_matter \
  --destination _site_verify

echo "==> 4/4 internal link check over the built site"
python3 bin/check_internal_links.py _site_verify

echo "verify_site.sh: all checks passed"
