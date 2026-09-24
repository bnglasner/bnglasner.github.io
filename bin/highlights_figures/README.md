# Homepage headline-wheel figures

Source for every asset in `assets/video/highlights/` — the animated
figures on the homepage headline wheel (`_includes/headline-wheel.liquid`,
fed by `_data/highlights.yml`). The MP4/PNG pairs are **build artifacts**:
regenerate with `bash bin/highlights_figures/render_all.sh`, never retouch.

## What these are

Re-renders of figures from Ben's short-form reel pipeline (the
`Ben Glasner Style Guide` repo, `projects/reels/`), re-themed from the EIG
reel tokens (cream field, Tiempos/Polaris) to this site's 2026 redesign
tokens (`_sass/_themes.scss`: paper, teal, amber, Newsreader/Public
Sans/IBM Plex Mono). Each script renders chart-only — the card's HTML
carries the title and hook — at 1280x720, in a light and a dark variant
(`SITE_THEME=light|dark`), as a frame sequence stitched to H.264 plus a
final-frame poster PNG.

| Script             | Source reel                                           | Claim provenance                                                                                                                      |
| ------------------ | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `fig_retirement.R` | 2026-09-15-retirement-help-misses-half-the-workforce  | 16:9 re-layout of `rff_tax_concentration.R` (portrait); source-notes Claims 11-12, matching the published EIG Fast Facts (2026-09-18) |
| `fig_realpay.R`    | 2026-09-11-jobs-came-back-raises-did-not              | 16:9 port of `v6_real_earnings.R` (portrait, presenter cutout); source-notes Claims 7, 9, 11                                          |
| `fig_minwage.R`    | 2026-09-01-federal-minimum-wage-misses-workers        | 16:9 port of `02_aw_minwage_federal_vs_prevailing_animation.R`; source-notes Claims 1, 6, 6a, 7 ("at or below", never "covered")      |
| `fig_prices.R`     | 2026-08-06-inflation-series-pt3-what-drives-inflation | 16:9 re-layout of `r3_component_growth.R`, reading the upstream CSV the reel typed its values from; source-notes Claim 1              |
| `fig_ladder.R`     | 2026-08-03-intergenerational-wage-ladder              | port of `gen_ladder_hero_x16x9.R` (reveal schedule, label anchors, dashed partly-observed runs)                                       |
| `fig_rpp.R`        | 2026-07-17-rpp-harris-vote-share                      | 16:9 re-layout of `render_rpp_scatter.R` (portrait)                                                                                   |

`data/` holds copies of each reel's verified CSV/TSV inputs. The numbers
are the reels' fact-checked claims — if a number changes, change it in the
Style Guide repo's source notes first, then re-copy the data here.

## Design contract

- Colour grammar: the claim carries the two site accents (teal = the
  series the claim is about, amber = the comparison or the anomaly);
  everything else recedes into the site's neutral ramp (bars at partial
  strength). No hues outside the site token set.
- Type: Public Sans for labels and annotations, IBM Plex Mono for axis
  values and the source line. Site fonts are instanced from the repo's own
  woff2 files at render time (step 1 of `render_all.sh`); nothing is
  fetched from outside the repo. Bold IBM Plex Mono has broken advances
  after instancing — use Public Sans bold for emphasis numbers.
- Every figure bakes in a small mono source line: attribution travels
  with the pixels.
- Motion must carry an idea (the reel pipeline's rule): draws show
  accumulation or decline in data order, the RPP outlier drops from its
  trend prediction, the real-pay line lights each negative month as it
  reaches it, and the all-items reference line drops through the CPI rows.

## Requirements

`Rscript` with ggplot2 + ragg + systemfonts; `python3` with fonttools +
brotli (font instancing); `ffmpeg` (stitching). `fonts/` and `out/` are
generated and gitignored.

Layout iteration without the full frame sequence (after step 1 has built
`fonts/`): `SITE_POSTER_ONLY=1 SITE_THEME=dark Rscript fig_<name>.R` writes
only the poster to `out/`; add `SITE_PEEK=0.5` to also write the frame at
t = 0.5 as `out/<name>_<theme>_peek.png`. Write non-ASCII labels as `\u`
escapes so the scripts render the same under any locale.

## Retired figures

`fig_california.R`, `fig_wages.R` (July 2026 wage growth, superseded by
`fig_realpay.R`), and `fig_socsec.R` left the wheel on 2026-09-23. Restore
any of them, with its `data/` input, from git history.
