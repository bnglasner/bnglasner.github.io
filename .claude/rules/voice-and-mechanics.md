# Rule: voice and mechanics

This is a snapshot of Ben Glasner's writing mechanics as of 2026-05-03, kept in the repo so a fresh agent walking into the project cold has the rules without depending on global preferences. Ben's global user preferences are authoritative if the two ever diverge — when in doubt, ask.

## Voice (public-facing prose)

Analytical confidence, not hype. Lead with the key claim, support with evidence quickly. Preserve the logic chain: claim → evidence → interpretation → implication. Caveats where warranted, not defensively.

Concrete nouns and active verbs. Cut throat-clearing openers ("This page tracks…", "My work sits at the intersection of…"). Cut empty intensifiers ("dramatically", "powerfully"). Favor causal connectors ("because", "so", "which means"). One term per concept — no elegant variation.

For heavier rewrites, defer to the external `ben-style-editor` skill (output profile: `blog` for landing pages, policy briefs, and writing intros; `academic` for the publications and CV pages; `social` for short-form summaries).

## Format defaults by page type

- **About / landing** — informed by EIG bio (institutional register), but not a paste of it.
- **Policy / publications / writing** — analytical, claim-first, evidence-second.
- **CV / repositories** — minimal prose; data-driven.
- **Substack short-form descriptions in `_data/writing.yml`** — one sentence, the central claim of the piece.

## Mechanics

The following are non-negotiable in any prose Claude generates for this site:

- Serial (Oxford) comma, always.
- "U.S." (with periods) as an adjective. "United States" as a noun. Never "US" in formal EIG content.
- Em dash with spaces on both sides — like this — in all contexts.
- "data are", "these data show" (data is plural).
- "percent" in body text. `%` only in charts, tables, and figures.
- Numerals one through nine spelled out in text; numerals for 10 and above.
- No exclamation points in public prose.
- No contractions in formal research, policy, or about-page prose. Contractions are acceptable in social/short-form summaries if the surrounding piece uses them.
- "COVID-19" — all caps, hyphen always.
- "homeownership" one word. "policymaker(s)" one word. "well-being" hyphenated. "workforce" one word.
- No "Retrieved from" in citations. Every citation ends with a period. Year is not parenthesized in EIG citation format. See `docs/audits/2026-05-03-portfolio-deep-dive.md` and the Infrastructure/style/docs reference cited in Ben's global preferences for the full citation format.

## Common drift to watch for

- "social-policy design" (broader, includes wage subsidy and retirement savings) vs. "the design of the social safety net" (narrower, programmatic). The about page currently uses the latter; make a deliberate choice if the framing comes up.
- "I aim to produce evidence that…" → "The goal is research that…" — strip soft hedges around stated goals.
- "interacts with" / "engages with" → use a concrete verb (reshapes, compresses, raises, undermines).
- "topline" → "headline" (one term per concept; site uses "headline" elsewhere).
- "pushed" / "merged" describing GitHub activity → "updated" (matches "Recently Updated" UI label on the repositories page).

## What this rule does _not_ cover

- EIG brand visual style (colors, fonts, figure labels, Datawrapper compliance) — that lives in `eig-template-version2/Infrastructure/style/`, not here.
- Heavy structural rewrites — defer to `ben-style-editor` review profiles.
- Tone for _other people's_ prose appearing on the site (e.g., quoted blurbs in the policy page) — preserve their voice, do not normalize it to Ben's.
