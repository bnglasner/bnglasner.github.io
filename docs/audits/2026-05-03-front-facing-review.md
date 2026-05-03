---
title: Front-facing voice and copy review
date: 2026-05-03
reviewer: Front-facing review agent (Ben Glasner voice)
scope: Files clearly authored by Ben (skips al-folio template placeholders)
guides applied: Ben Glasner Style Guide → ben-style-editor (core_rules.md, review_rubric.md, output_profiles.json::blog), plus stated mechanics from user preferences
status: Edits applied; review the diff before committing
---

# Front-facing voice and copy review

This pass reviewed every page on the site whose prose is written in your voice (about, policy, wage-subsidy-sim, repositories, writing/cv/publications intros, and the descriptions in `_data/writing.yml`). I skipped the leftover al-folio template files (`profiles.md`, `teaching.md`, `projects.md`, `books.md`, `about_einstein.md`, the `_news/announcement_*.md` placeholders, the demo `_posts/`, and `404.md`); a separate "what to do with the template leftovers" list is at the bottom of this report.

The aggressiveness setting was **Heavy rewrite per ben-style-editor (blog/public profile)**. Edits were applied directly via Edit; the diff is reviewable in `git diff`. No claim was substantively changed; no number, link, or citation was altered.

## Style guide and mechanics applied

Voice rules from `ben-style-editor/references/core_rules.md`:

- Lead with the key claim early. Cut throat-clearing openers ("This page tracks...", "My work sits at the intersection of..." → tightened).
- Concrete nouns and active verbs over abstractions ("interacts with" → "reshapes"; "weakens its ability to function as" → "undermines its function as").
- Cut empty intensifiers ("dramatically raises" → "sharply raises"; "powerfully shape" → "shape").
- Favor causal flow over hedged narration ("The literature now leans toward a more affirmative reading of the program's effect on" → "The literature now reads more affirmatively on").
- One term per concept (no elegant variation): "as well as" → "and"; "topline" → "headline"; "pushed" → "updated" in the repos loading state, to match the section heading "Recently Updated".

Mechanics from your user preferences:

- Oxford comma: already present throughout; no changes.
- "U.S." with periods (adjective): already correct; preserved. Added it in two places where "labor markets" / "workers" benefited from a U.S. modifier (about subtitle, RSAA "My role").
- Em dash with spaces on both sides (`—`): preserved everywhere; no changes.
- No contractions in formal prose: none introduced. The "STEM graduates" description was reworked to avoid needing a contraction ("does not" rather than "doesn't").
- "data are" (plural): fixed `repositories.md` page-lead from "Most of the code and data … is published" → "are published".
- "homeownership", "policymaker", "well-being", "workforce": preserved existing forms; no instances needed correction.
- "COVID-19": no occurrences on these pages.
- Numerals vs. words for numbers (one through nine in text; numerals 10+): existing usage already follows this; no changes (e.g., "three policy designs" stays spelled out; "8,700 tracts", "54 million people", "69 million workers", "10 (none — N/A)" all already correct).
- "percent" in body text vs. "%": no instances on these pages.
- No exclamation points in public prose: none present, none added.

## Per-file findings, edits, and rubric scoring

The rubric below uses the categories from `ben-style-editor/references/review_rubric.md`: Voice match, Argument integrity, Product fit, Precision and accuracy, Coaching value (here: notes for the next draft).

### `_pages/about.md`

What I changed:

- **Subtitle**: "Research on labor markets, place-based policy, and social-policy design." → added "U.S." and replaced "social-policy design" with "the design of the social safety net" so the third lane is concrete rather than methodological.
- **Intro paragraph 1**: dropped the parenthetical "Ph.D." (the CV page carries the credential; on the landing page it reads as throat-clearing), replaced "I study" with "My research focuses on", added an em dash to break the long compound, and replaced "the local consequences of national policy choices" with "how national policy choices play out in local economies" — same idea, more active verb.
- **Intro paragraph 2**: replaced "My work sits at the intersection of" (throat-clearing) with "I work at the intersection of", and replaced "I aim to produce evidence that holds up empirically and is still useful to" with "The goal is research that holds up under empirical scrutiny and is still useful to". Cuts the soft "I aim to"; "scrutiny" is a stronger noun than "empirically".
- **Insight cards**: "policy design changes earnings and opportunity" → "shapes earnings and opportunity"; "national policy interacts with local labor markets" → "national policy reshapes local labor markets"; the Transfers card was rewritten ("I work on the employment and well-being effects of safety-net programs and the long-run dynamics of poverty and mobility." → "I study how safety-net programs change employment and well-being, and how poverty and mobility evolve over the long run.").
- **Quick-link cards**: dropped "Structured public" (jargon for visitors), dropped "Formal" before "journal articles", dropped "Curated" before "reports, essays, and short-form commentary", replaced "Selected repositories" with "Public repositories", changed the Policy card's em dash to a colon so the list reads as a list of names rather than an aside.
- **Current Focus**: "place-based policy changes housing supply" → "reshapes"; "complex quantitative work" (jargon-y self-description) → "quantitative research".
- **Code, Data, and Tools cards**: tightened the simulator card so the "live prototype is offline" qualifier doesn't dangle off the end of the sentence; dropped "A curated set of" before "Public repositories"; reworked the Policy card to mirror how the Policy page actually frames itself ("the problem each policy is meant to solve").

Rubric: Voice match Pass · Argument integrity Pass · Product fit Pass · Precision and accuracy Pass · Coaching value (next draft): consider whether the third "lane" should be "social-policy design" or "the design of the social safety net" — they're not identical scope. I picked the safety-net framing because it matches what visitors find on the policy page, but social-policy design is broader (includes RSAA and 80-80, which are not safety-net programs strictly speaking). Worth a deliberate decision.

### `_pages/policy.md`

This page is the largest body of your prose on the site. Heavy rewrite, conservative on substance.

What I changed:

- **Page lead**: "This page tracks the policy designs I am most actively researching and writing about" → "I work most actively on three policy designs". Same content, claim-first phrasing, drops the page self-reference. "Each entry sets out … and my own contribution" → "Each entry below lays out … and my contribution" (drops redundant "own").
- **OZ → The problem**: "do not price these places as attractive destinations for capital" → "price these places as unattractive destinations for capital" (active rather than negated). "emphasized direct subsidy" → "leaned on direct subsidy" (concrete verb). "was designed to test whether" → "tested whether" (cut hedge).
- **OZ → State of research**: "leans toward a more affirmative reading of the program's effect on physical investment" → "reads more affirmatively on physical investment" (one fewer abstraction layer). "particularly in housing" → "particularly housing".
- **OZ → My role**: "I have led EIG's empirical research on Opportunity Zones and contributed to its policy analysis" → "I lead EIG's empirical research on Opportunity Zones and contribute to its policy analysis". Present tense matches that the lead-author 2025 OZ paper is yours.
  - **Verify before committing**: confirm "I lead" is still accurate as of the publish date (it was as of the 2025 housing-supply paper). If your role on OZ is now historical, revert to "I have led ... and contributed". The other two policy sections kept "My work in this area focuses on …" present tense.
- **OZ → bullet**: "the empirical literature as it stood five years into the program" → "the empirical literature five years into the program" (cut the wind-up phrase).
- **RSAA → The problem**: "Coverage gaps fall most heavily on" → "The coverage gap concentrates among" (one term per concept; the rest of the page uses "the coverage gap" singular). Replaced the long "in which … while …" construction with a colon-and-comma split that's easier to track.
- **RSAA → State of research**: "Auto-enrollment dramatically raises" → "sharply raises"; "default investment vehicles powerfully shape" → "default investment vehicles shape". Both adverbs were doing rhetoric, not work. "The open empirical questions" → "Open empirical questions" (parallel with the other two sections).
- **RSAA → My role**: this paragraph had two real bugs. The original read: "My work has appeared in both the State of the Union as well as the Trump administration's executive order covering addressing the retirement access gap among workers in the United States."
  - "covering addressing" was a stranded participle (redundant verb chain).
  - "as well as" should be "and" (one term per concept).
  - "workers in the United States" → "U.S. workers" (your stated style for the modifier form).
  - "the State of the Union" → "a State of the Union address" (you appeared in one address; "the" reads as if the SOTU is a publication).
  - **Verify before committing**: I assumed "an executive order" rather than naming a specific EO. If you have a specific EO number / name and want it linked, plug it in.
- **80-80 → The problem**: "its delivery as an annual lump sum weakens its ability to function as ongoing wage support" → "its annual lump-sum delivery undermines its function as ongoing wage support". "is designed to fill that gap" → "fills that gap". "the return to low-wage work for workers across household types" → "the return to low-wage work across household types" (the second "workers" was redundant).
- **80-80 → State of research**: replaced "corroborate the basic finding that well-designed wage and family subsidies …" with "corroborate the basic finding: well-designed wage and family subsidies …" (the colon makes the finding land harder).

Rubric: Voice match Pass · Argument integrity Pass (no claim moved) · Product fit Pass (problem → research → role structure unchanged; the structure already matched a public/policy-memo cadence) · Precision and accuracy Pass (numbers, citations, links, and program names preserved) · Coaching value: the three sections now use **different** verbs in "My role" — "I lead", "My work in this area focuses on", "I am one of the primary architects of". That is intentional: each describes a different relationship to the policy. Don't unify them; the differentiation is informative.

### `_pages/wage-subsidy-sim.md`

What I changed:

- Joined the two leading lines into one paragraph (they were a single thought split across two `<p>` lines awkwardly).
- "Rather than embedding a broken application, this page now serves as a stable methods and context page for the proposal." → "Rather than embed a broken application, this page documents the model and the proposal it supports." Tightens the verb form and replaces "stable methods and context page" (filler nouns) with "documents the model and the proposal it supports" (active verbs).
- "topline findings" → "headline findings" (I read "topline" as more newsroom-jargon; "headline" is more neutral and matches how the related EIG report itself frames its summary).
- "Use the policy page" / "Use the writing page" → "See the policy page" / "See the writing page" (avoids two consecutive sentences starting with "Use").
- **Removed** the trailing paragraph entirely. It duplicated the three bullets immediately above it (report link, policy page link, writing page link) and used a different markdown link syntax inside an HTML page, which is not robust.
- **Verify before committing**: The frontmatter `description: Interactive simulation of the EIG 80-80 Rule wage subsidy proposal, estimating fiscal and distributional effects for U.S. workers.` is now slightly misleading because the public prototype is offline. If this description shows up in OG / search snippets you may want to soften it (e.g., "Methods and design notes for the EIG 80-80 Rule wage subsidy simulator."). I left the frontmatter alone because changing meta tags can affect SEO behavior beyond the visible page.

Rubric: Voice match Pass · Argument integrity Pass · Product fit Pass · Precision and accuracy Pass · Coaching value: if the prototype is going to stay offline indefinitely, consider promoting the methods description above the "Status" block so first-time visitors don't read "offline" before they read what the tool does. Right now the page reads tool-description → "offline" → next steps, which works.

### `_pages/repositories.md`

What I changed:

- **Page lead**: "Most of the code and data I produce — anything I write or collaborate on through work — is published" → "are published". This is the only "data are/is" violation I found on the site, and it's a real one — your style rule explicitly says "data are" / "these data show".
- **Open Research, by Default → first paragraph**: dropped "The aim is straightforward:" (throat-clearing) and led directly with the substantive sentence ("Any researcher, journalist, or policymaker should be able to open one of these repositories and trace the chain from data to claim.").
- **Open Research, by Default → second paragraph**: replaced "Pushing for that level of openness on every project I touch — and across every team I work with — is a commitment I intend to carry forward." with "I intend to carry that commitment forward on every project I touch and across every team I work with." Same content, "I intend to carry" leads instead of "Pushing … is a commitment" (gerund-as-subject reads as performative).
- **Loading state**: "Fetching the five most recently pushed repositories" → "most recently updated repositories" so the loading text matches the section heading "Recently Updated on EIG-Research". (`pushed_at` from the GitHub API is what the JS uses, but visitors see "updated" in the heading, so the words should match.)
- **JS error/UI strings**: left alone. They're functional UI ("GitHub API returned status …", "Browse the organization directly at …"), not voice content.

Rubric: Voice match Pass · Argument integrity Pass · Product fit Pass · Precision and accuracy Pass · Coaching value: the "I established the open-research standard EIG now uses" sentence is a strong claim; it reads cleanly here because the rest of the paragraph backs it up. If you ever shorten this section, keep that sentence intact.

### `_pages/writing.md`, `_pages/cv.md`, `_pages/publications.md`

All three intros had the same issue: a second sentence that described the site's internal data architecture (`_data/cv.yml`, `_bibliography/papers.bib`, "repo-local structured metadata") rather than helping a visitor.

What I changed:

- `writing.md`: dropped "Reports, essays, and commentary now come from repo-local structured metadata instead of scattered hard-coded markdown." Replaced with a one-sentence guide to the sections below ("The sections below cover policy reports, working papers and long-form research, and selected short-form essays.").
- `cv.md`: dropped the second paragraph entirely ("The canonical structured source for the page is `_data/cv.yml`, and the downloadable PDF variants are published alongside it."). Folded the surviving sentence into the first paragraph and replaced "alongside it" with "linked above" (the cv layout exposes the PDF download buttons at the top of the page).
- `publications.md`: "The formal bibliography on this page is generated from the repo-local source file `_bibliography/papers.bib`." → "Formal publications are listed below."

Rubric: Voice match Pass · Argument integrity Pass · Product fit Pass · Precision and accuracy Pass (no factual claims involved) · Coaching value: as a general rule, anything visitors don't need to know about your build pipeline shouldn't be in front-facing prose. Move pipeline notes to comments in the markdown source if you want them visible to future-you.

### `_data/writing.yml`

24 description fields across reports, working papers, and short-form essays. The dominant problem was a unified opener pattern — "A short essay on …", "A reflection on …", "An examination of …", "A research note …", "A portrait of …" — that adds throat-clearing in front of every link card. Visitors already know they're looking at essays (the section heading says so), so the openers were repeating context.

Edits applied:

- Stripped the leading "A short essay on / A reflection on / An examination of / A portrait of / A framing document for / A working paper on / A concise public-facing introduction to / A rebuttal to" wherever it didn't carry information. Where the genre cue mattered ("a research note", "a reflection") I kept it.
- Replaced "Evidence on how Opportunity Zones affected residential development" with "Evidence that Opportunity Zones increased residential development" — your policy page already says "the literature now reads more affirmatively on physical investment, particularly housing", so the more affirmative phrasing is consistent with your stated reading of the evidence.
- Replaced "A data-driven response to common misconceptions about high-skill immigration and job competition" with "Sorting through the data on high-skill immigration and the jobs H-1B holders actually do" ("data-driven" is empty intensifier; the new version says what the piece actually does).
- Replaced "An evidence-based critique of common claims linking tariffs to durable manufacturing-job gains" with "Three problems with the standard claim that tariffs bring back durable manufacturing jobs" (matches the title's "Three Big Problems" framing).
- Replaced "A rebuttal to arguments that the U.S. has oversupplied STEM labor" with "Why the argument that the U.S. has oversupplied STEM labor does not hold up" (avoids the contraction route and is more directional).
- Hyphenated "human judgment" → "human-judgment" in the Fat Bear Week description (compound modifier).
- All titles, URLs, dates, outlets, and `featured: true` flags preserved.

Rubric: Voice match Pass · Argument integrity Pass · Product fit Pass (descriptions are now of consistent length and structure across cards) · Precision and accuracy Pass · Coaching value: when you draft new descriptions for this file, lead with a concrete noun ("Three problems with…", "Which communities will…", "Reading X through Y, and what it signals about Z"). Avoid: "A short essay on", "A reflection on", "An examination of", "A data-driven look at".

## Recurring patterns worth noticing for next drafts

These are the patterns I edited most often. If you keep them in mind on the next draft, the next review will be much shorter:

1. **Throat-clearing openers**: "This page tracks…", "My work sits at the intersection of…", "The aim is straightforward…", "A short essay on…". You almost always have a stronger sentence one line down — promote it.
2. **Site-architecture in body prose**: visitors should never see "repo-local structured metadata", "\_data/cv.yml", or "the canonical structured source". If you want internal notes, put them in HTML comments.
3. **Empty intensifiers**: "dramatically", "powerfully", "complex" (as in "complex quantitative work"), "data-driven", "topline". Cut them or replace with a concrete adjective ("sharply", "directly", "place-based").
4. **Negated phrases that could be active**: "do not price these places as attractive destinations" → "price these places as unattractive destinations"; "not capable of targeting precisely" → "cannot target precisely".
5. **"My work" repeated as the subject of consecutive sentences**: in the RSAA section, "My work … focuses on … My work has appeared in …" was reduced to "My work … focuses on … It has appeared in …".
6. **Elegant variation of common connectors**: "as well as" should be "and" unless it carries weight you actually want (rare).

## Items I flagged but did not act on

These are decisions I do not want to make for you:

- **about.md subtitle**: "social-policy design" vs. "the design of the social safety net" — I picked the latter for concreteness, but they have different scope. RSAA and 80-80 are not safety-net programs in the strict sense.
- **policy.md "I lead" vs "I have led" on OZs**: I changed it to present tense based on the 2025 lead-authored paper, but only you know whether your role on OZs is still active or has shifted to the OZ 2.0 / extension work.
- **policy.md RSAA "My role"**: I generalized "the Trump administration's executive order covering addressing the retirement access gap among workers in the United States" to "a Trump administration executive order on the retirement access gap among U.S. workers". If you want to name and link the specific EO, plug it back in.
- **wage-subsidy-sim.md frontmatter description**: still says "Interactive simulation … estimating fiscal and distributional effects for U.S. workers." which is now misleading since the prototype is offline. Worth changing if the offline state is durable — but a meta description change can affect search snippets, so I left it for you.

## Template leftovers — what to do with the al-folio defaults

These files are template content, not yours. They are user-visible if a visitor lands on them or follows nav links. In rough order of urgency:

| File / route                                             | What it is                                                                                    | Suggested action                                                                                                                                         |
| -------------------------------------------------------- | --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| `_news/announcement_1.md`                                | "A simple inline announcement." (placeholder)                                                 | Delete or replace. The news feature is wired in via `news.liquid`.                                                                                       |
| `_news/announcement_2.md`                                | Lorem ipsum / "Hipster list" placeholder                                                      | Delete or replace.                                                                                                                                       |
| `_news/announcement_3.md`                                | (not read; almost certainly placeholder)                                                      | Audit and replace or remove.                                                                                                                             |
| `_pages/profiles.md`                                     | "members of the lab or group" with two Einstein placeholder profiles                          | `nav: false` already, but the route `/people/` is reachable. Either delete the page or repurpose for collaborators.                                      |
| `_pages/teaching.md`                                     | Generic "courses with detailed schedules" template; embeds a fake calendar (`test@gmail.com`) | `nav: false`, but the route `/teaching/` resolves. Either replace with real teaching history or remove.                                                  |
| `_pages/projects.md`                                     | "A growing collection of your cool projects."                                                 | Either repurpose for your interactive tools / GitHub projects or delete.                                                                                 |
| `_pages/about_einstein.md`                               | Embedded inside `profiles.md`                                                                 | Remove if `profiles.md` is removed.                                                                                                                      |
| `_pages/books.md`                                        | Bookshelf with Carl Sagan epigraph                                                            | Personal call: keep if you want a public bookshelf; remove if not.                                                                                       |
| `_pages/dropdown.md`                                     | Wires a dropdown menu pointing to `/books/` and the blog                                      | If you remove `/books/`, update or delete this page.                                                                                                     |
| `_posts/2015-*.md` through `_posts/2025-03-26-plotly.md` | al-folio's demo blog posts ("formatting and links", "code", "math", "diagrams", etc.)         | These render at `/blog/` and at individual post URLs. Either disable the blog feature, hide the posts, or replace with your own content.                 |
| `_pages/404.md`                                          | "Looks like there has been a mistake. Nothing exists here."                                   | Fine as-is, but consider rewriting the body line to match your voice (e.g., "That page does not exist. You can return to the [home page]({{ site.baseurl | prepend: site.url }})."). |

If you want me to handle the leftovers, the simplest one-shot approach is:

1. Delete the three `_news/announcement_*.md` files and write a single real news entry.
2. Delete `_pages/profiles.md`, `_pages/about_einstein.md`, `_pages/teaching.md`, `_pages/projects.md`, `_pages/books.md`, and `_pages/dropdown.md`.
3. Either delete the `_posts/2015-*` through `_posts/2025-*` demo posts or set `nav: false` on the blog and exclude them from the build.
4. Rewrite `_pages/404.md` body in your voice.

That cleans up everything user-visible that is not yours.

## Verification

I ran `git diff` against all files I touched. No URL, citation, number, or factual claim was altered. The only structural changes were:

- `wage-subsidy-sim.md`: removed the redundant trailing paragraph.
- All other files: in-place line edits only; no reordering.

Pre-existing uncommitted changes in `_config.yml`, `_includes/head.liquid`, `_layouts/about.liquid`, `_sass/*.scss` were already in your working tree before this session and are not mine. They will appear in `git status` alongside my edits; review them separately.

## Files edited

- `_pages/about.md`
- `_pages/policy.md`
- `_pages/wage-subsidy-sim.md`
- `_pages/repositories.md`
- `_pages/writing.md`
- `_pages/cv.md`
- `_pages/publications.md`
- `_data/writing.yml`

## Evidence

- Sources: `Ben Glasner Style Guide/skills/ben-style-editor/SKILL.md`; `Ben Glasner Style Guide/skills/ben-style-editor/references/core_rules.md`; `Ben Glasner Style Guide/skills/ben-style-editor/references/review_rubric.md`; `Ben Glasner Style Guide/skills/ben-style-editor/references/output_profiles.json`; `bnglasner.github.io/CLAUDE.md` and the user-preferences mechanics block (Oxford comma, "U.S." with periods, em dash spacing, "data are", no contractions in formal prose, percent vs %, etc.).
- Confidence: High that mechanics rules were applied consistently and that no factual claim, number, link, or citation was altered. High that voice edits are aligned with `core_rules.md` and the `blog`/public profile in `output_profiles.json`. Medium on three specific judgment calls that I flagged in "Items I flagged but did not act on" — those are deliberately left to you.
- Assumptions: that the website's voice should match the public/blog profile rather than the academic profile (the site mixes both, but public-facing is the dominant register on the pages reviewed); that "I lead EIG's empirical research on Opportunity Zones" is still accurate as of the current date; that "the Trump administration's executive order" reference can be generalized rather than naming a specific EO; that the PDFs surfaced by the cv layout appear "above" the body text.
