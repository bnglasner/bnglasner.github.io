---
name: front-facing-copy-review
description: |
  Voice and mechanics pass over front-facing prose on the site. Triggers on "copy review",
  "voice check", "review my prose", "front-facing review", "polish the about page", or
  before any commit that touches a public-facing page. Defers heavier rewrites to the
  external ben-style-editor skill.
inputs:
  - file paths to review (default: every page in _pages/ except 404.md)
  - aggressiveness: light (mechanics only) | medium (mechanics + obvious voice fixes) | heavy (full rewrite per ben-style-editor)
outputs:
  - Edits applied directly to the reviewed files
  - A dated report at docs/audits/YYYY-MM-DD-front-facing-review.md noting what changed and why
---

# Skill: front-facing copy review

## Procedure

1. **Scope.** Default scope is every file in `_pages/` whose prose is in Ben's voice. Skip al-folio template residue (none currently present in `_pages/`; verify before assuming) and skip auto-generated pages listed in `.prettierignore` (`_pages/blog.md`, `_pages/media.md`, `_pages/research.md`, etc.). Optional inclusion: prose introductions and dek strings inside `_data/writing.yml`, `_data/cv.yml` `Description` fields, and the policy and writing page intros.

2. **Apply mechanics first.** From `voice-and-mechanics.md`:
   - Oxford comma, "U.S." with periods, em dash with spaces, "data are", "percent" not %, no contractions in formal prose, no exclamation points, "COVID-19", "homeownership", "policymaker", "well-being", "workforce".
   - Numerals one through nine spelled out; 10+ as numerals.
   - Year never parenthesized in EIG citation format.
   - Find common drift: "topline" → "headline"; "pushed" / "merged" → "updated"; "interacts with" → concrete verb; "I aim to produce evidence that…" → "The goal is research that…".

3. **Apply voice for medium / heavy aggressiveness.**
   - **Medium**: lead with the key claim, cut throat-clearing openers, replace empty intensifiers ("dramatically", "powerfully") with concrete ones, use one term per concept.
   - **Heavy**: defer to `ben-style-editor` (output profile: `blog` for landing/policy/writing intros; `academic` for publications and CV pages; `social` for short-form descriptions). Capture the editor's edits, apply them, and credit the rubric in the report.

4. **Preserve the logic chain.** Do not delete a caveat, change a number, or remove a citation. Edits are stylistic; substance is untouched. If a substantive change seems warranted, flag it in the report rather than applying it.

5. **Write the report.** Create `docs/audits/YYYY-MM-DD-front-facing-review.md` mirroring the structure of the May 2026 review: per-file findings, edits, rubric scoring (Voice match / Argument integrity / Product fit / Precision and accuracy / Coaching value).

6. **Verify build.** Run `docker compose up --build` to confirm no Liquid or YAML break.

## Outputs

- Edits applied to the reviewed pages.
- `docs/audits/YYYY-MM-DD-front-facing-review.md`.

## Stop and ask

- A page introduces a concept that needs a deliberate framing choice (e.g., "social-policy design" vs. "the design of the social safety net").
- A substantive claim in the prose is unsupported by an evidence source you can find.
- A page uses prose written by a co-author or a third party (do not normalize their voice to Ben's).
