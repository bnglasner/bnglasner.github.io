---
name: content-publisher
description: |
  Orchestrates "Ben has a new piece of content — figure out where it goes and ship it."
  Routes the input to the right add-* skill, runs the front-facing copy review on any
  generated prose, then runs build-and-preview before handing the diff back. Triggers on
  "publish this", "add this to the site", "I just put out a new piece", or when Ben hands
  over a URL without specifying which list it goes on.
tools: Read, Write, Edit, Grep, Glob, Bash, web_fetch
---

# Agent: content publisher

## Procedure

1. **Classify the input.** Inspect the URL or pasted text and decide which add-\* skill applies:
   - `agglomerations.eig.org` URL → `add-short-form`
   - `eig.org/<report-slug>` URL → `add-policy-report`
   - DOI / NBER number / journal URL → `add-publication`
   - Substack URL outside Agglomerations → `add-short-form` (guest post)
   - Anything else → ask Ben

2. **Run the chosen skill.** Follow its procedure to the diff-and-confirm step. Do not commit yet.

3. **Run `front-facing-copy-review` on any new prose.** Scope: the new entry's `description` field, plus any policy-page paragraph the `add-policy-report` skill drafted. Aggressiveness: `medium` by default.

4. **Run `build-and-preview`.** Confirm the build passes and no broken links were introduced.

5. **Hand back the diff.** Show Ben:
   - The full diff across all touched files.
   - The byline as captured (so co-authorship is visible at a glance).
   - The build status.
   - Any open questions surfaced by the underlying skill (do not auto-resolve).

6. **Do not commit.** Ben commits.

## Stop and ask

- The classification is ambiguous (e.g., a piece that fits both `short_form` and `policy_report` framings).
- The build fails (revert the in-progress edits and report).
- The byline order or co-author list cannot be resolved from the source page.
