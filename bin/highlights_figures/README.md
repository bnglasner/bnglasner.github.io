# Homepage headline-wheel figures

Source for every asset in `assets/video/highlights/` — the five animated
figures on the homepage headline wheel (`_includes/headline-wheel.liquid`,
fed by `_data/highlights.yml`). The MP4/PNG pairs are **build artifacts**:
regenerate with `bash bin/highlights_figures/render_all.sh`, never retouch.

## What these are

Re-renders of five figures from Ben's short-form reel pipeline (the
`Ben Glasner Style Guide` repo, `projects/reels/`), re-themed from the EIG
reel tokens (cream field, Tiempos/Polaris) to this site's 2026 redesign
tokens (`_sass/_themes.scss`: paper, teal, amber, Newsreader/Public
Sans/IBM Plex Mono). Each script renders chart-only — the card's HTML
carries the title and hook — at 1280x720, in a light and a dark variant
(`SITE_THEME=light|dark`), as a frame sequence stitched to H.264 plus a
final-frame poster PNG.

| Script             | Source reel                              | Claim provenance                                                                                                                                       |
| ------------------ | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `fig_ladder.R`     | 2026-08-03-intergenerational-wage-ladder | port of `gen_ladder_hero_x16x9.R` (reveal schedule, label anchors, dashed partly-observed runs)                                                        |
| `fig_wages.R`      | 2026-08-07-july-jobs-wage-squeeze        | port of `v4_wage_growth_5yr_low_x.R`                                                                                                                   |
| `fig_rpp.R`        | 2026-07-17-rpp-harris-vote-share         | 16:9 re-layout of `render_rpp_scatter.R` (portrait)                                                                                                    |
| `fig_socsec.R`     | 2026-06-23-social-security-payroll-cap   | animated rebuild of the static `r1_antipoverty_breakdown` card                                                                                         |
| `fig_california.R` | 2026-05-28-california-healthcare-jobs    | ground-up build from the reel's High-confidence source-notes numbers only (the original 8-state dumbbell's non-headline values are not recorded there) |

`data/` holds copies of each reel's verified CSV/TSV inputs. The numbers
are the reels' fact-checked claims — if a number changes, change it in the
Style Guide repo's source notes first, then re-copy the data here.

## Design contract

- Colour grammar: the claim carries the two site accents (teal = the
  series the claim is about, amber = the comparison or the anomaly);
  everything else recedes into the site's neutral ramp. No hues outside
  the site token set.
- Type: Public Sans for labels and annotations, IBM Plex Mono for axis
  values and the source line. Site fonts are instanced from the repo's own
  woff2 files at render time (step 1 of `render_all.sh`); nothing is
  fetched from outside the repo. Bold IBM Plex Mono has broken advances
  after instancing — use Public Sans bold for emphasis numbers.
- Every figure bakes in a small mono source line: attribution travels
  with the pixels.
- Motion must carry an idea (the reel pipeline's rule): draws show
  accumulation or decline in data order, the RPP outlier drops from its
  trend prediction, the California ex-healthcare bar crosses zero.

## Requirements

`Rscript` with ggplot2 + ragg + systemfonts; `python3` with fonttools +
brotli (font instancing); `ffmpeg` (stitching). `fonts/` and `out/` are
generated and gitignored.
