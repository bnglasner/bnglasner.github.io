---
name: add-short-form
description: |
  Add a short-form piece (Substack post on Agglomerations, or guest post on another publication)
  to _data/writing.yml. Triggers on "add a Substack post", "log this Agglomerations piece",
  "add a guest post", "new short-form", or when Ben pastes a Substack URL.
inputs:
  - URL of the live post (required)
  - or: pasted text + outlet name (if no URL is available yet)
outputs:
  - One new entry appended to the appropriate list in _data/writing.yml (sorted descending by published date)
network: yes — fetches the post HTML to extract title, date, byline, and dek
---

# Skill: add a short-form piece to writing.yml

## Procedure

1. **Resolve the source.** If the input is a URL, fetch the page. If the URL is on `agglomerations.eig.org`, treat as a Substack post. Otherwise treat as a guest post on the host publication.

2. **Extract metadata.** From the fetched page, capture:
   - `title` — exact title as published, including any colon or subtitle
   - `published` — ISO 8601 date (Substack exposes this in the meta tags)
   - `authors` — every byline, in the order shown at the top of the post; full names; preserve the order Substack renders
   - `outlet` — "Agglomerations" for Substack, the publication name for guest posts
   - `description` — the post's dek (subtitle) if present; otherwise the first sentence of the post, tightened to one sentence per the voice rule
   - `co_outlet` — set only if the piece is cross-posted

3. **Apply the integrity check.** If the byline contains anyone besides Ben, the entry must list every co-author. If the byline is Ben alone, write `authors: ["Ben Glasner"]` — never omit the field.

4. **Decide the list.** Substack posts and guest posts go under `short_form:`. Policy reports go under `reports:` (use the `add-policy-report` skill for those).

5. **Insert in date order.** The list is sorted descending by `published`. Insert the new entry at the right position; do not append to the end if it predates an existing entry.

6. **Diff and confirm.** Show Ben the new entry as a YAML diff against `_data/writing.yml` before saving. Do not assume the dek is good copy — apply the voice rule (concrete nouns, active verbs, no throat-clearing) before committing.

7. **Run the pre-commit check.** Run `python bin/check_writing_authors.py` and confirm it passes.

## Outputs

- Modified `_data/writing.yml`.
- A short note for Ben summarizing what was added, including the byline as captured.

## Stop and ask

- The byline order is ambiguous (e.g., a Substack publication-byline override).
- The piece is cross-posted to a second publication and the right `co_outlet` framing is unclear.
- The post predates any existing entry by more than a year (probably backfill — confirm scope).
