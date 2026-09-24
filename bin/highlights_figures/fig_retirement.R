# fig_retirement.R — homepage wheel figure: retirement tax benefits by
# earnings decile. 16:9 re-layout of rff_tax_concentration.R (2026-09-15-
# retirement-help-misses-half-the-workforce; the original is 9:16 portrait).
# Claims (verified, that reel's source notes Claims 11-12, and matching the
# published EIG "The U.S. Retirement System: Fast Facts", 2026-09-18): the
# modeled average rises from $92 in the bottom worker-earnings decile to
# $5,084 in the top; the bottom half receives about 10 percent of worker
# tax-benefit dollars and the top decile 30 percent. Workers ages 18-64.
#
# Motion carries the idea: bars grow in decile order, so the climb is the
# build; then a bracket closes over the five lowest deciles.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

raw <- read.csv(file.path(SRC_DIR, "data", "tax_benefit_crosscuts.csv"),
                stringsAsFactors = FALSE)
d <- raw[raw$dimension == "Worker earnings decile", ]
d$decile <- as.integer(d$group)
d <- d[order(d$decile), ]
bottom_half <- sum(d$te_share[d$decile <= 5])
stopifnot(nrow(d) == 10,
          round(d$mean_te[1]) == 92, round(d$mean_te[10]) == 5084,
          round(bottom_half, 2) == 0.10, round(d$te_share[10], 2) == 0.30)

PX0 <- 0.105; PX1 <- 0.905
PY_TOP <- 0.130; PY_BOT <- 0.790
V_HI <- 6000
slot <- (PX1 - PX0) / 10
cx <- function(i) PX0 + (i - 0.5) * slot
BAR_HW <- slot * 0.31
vy <- function(v) yt(PY_BOT - v / V_HI * (PY_BOT - PY_TOP))

# deciles 6-9 recede: the neutral ramp at partial strength, so the two ends
# of the claim carry the accents
BAR_COL <- ifelse(d$decile <= 5, AMBER,
                  ifelse(d$decile == 10, TEAL, fade_col(MUTED_SOFT, 0.55)))
gridv <- seq(0, 5000, by = 1000)

frame <- function(t) {
  tb <- clamp01(t / 0.70)
  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Average modeled federal tax benefit from retirement saving, by worker earnings decile, 2024") +
    annotate("segment", x = PX0, xend = PX1, y = vy(gridv[-1]), yend = vy(gridv[-1]),
             colour = GRID, linewidth = 0.35) +
    annotate("segment", x = PX0, xend = PX1, y = vy(0), yend = vy(0),
             colour = RULE, linewidth = 0.6) +
    annotate("text", x = PX0 - 0.012, y = vy(gridv), hjust = 1, vjust = 0.5,
             size = 3.4, colour = MUTED_SOFT, family = MONO,
             label = ifelse(gridv == 0, "$0", paste0("$", gridv / 1000, "k"))) +
    annotate("text", x = cx(1:10), y = yt(PY_BOT + 0.026), hjust = 0.5, vjust = 1,
             size = 3.4, colour = MUTED_SOFT, family = MONO, label = as.character(1:10)) +
    annotate("text", x = cx(1) - BAR_HW, y = yt(PY_BOT + 0.080), hjust = 0, vjust = 1,
             size = 3.5, colour = MUTED, family = SANS, label = "\u2190 Lowest-paid tenth") +
    annotate("text", x = cx(10) + BAR_HW, y = yt(PY_BOT + 0.080), hjust = 1, vjust = 1,
             size = 3.5, colour = MUTED, family = SANS, label = "Highest-paid tenth \u2192")

  for (i in 1:10) {
    a <- ease_out_cubic(stagger(i, 10, tb, overlap = 0.60))
    if (a <= 0) next
    p <- p + annotate("rect", xmin = cx(i) - BAR_HW, xmax = cx(i) + BAR_HW,
                      ymin = vy(0), ymax = vy(d$mean_te[i] * a), fill = BAR_COL[i])
  }

  # the two ends of the claim, labelled once each bar has landed
  a92 <- appear(ease_out_cubic(stagger(1, 10, tb, overlap = 0.60)), 0.98, 0.02)
  if (a92 > 0) {
    p <- p + annotate("text", x = cx(1), y = vy(d$mean_te[1]) + 0.022, hjust = 0.5,
                      vjust = 0, size = 4.6, fontface = "bold",
                      colour = fade_col(AMBER, a92), family = SANS, label = "$92")
  }
  a_top <- appear(t, 0.72)
  if (a_top > 0) {
    p <- p +
      annotate("text", x = cx(10) - BAR_HW - 0.012, y = vy(d$mean_te[10]),
               hjust = 1, vjust = 0.75, size = 7.0, fontface = "bold",
               colour = fade_col(TEAL, a_top), family = SANS, label = "$5,084") +
      annotate("text", x = cx(10) - BAR_HW - 0.012, y = vy(d$mean_te[10]) - 0.062,
               hjust = 1, vjust = 1, size = 3.9, colour = fade_col(TEAL, a_top),
               family = SANS, label = "Top tenth: 30% of the dollars")
  }

  # bracket over the bottom half, drawn left to right
  a_br <- ease_out_cubic(clamp01((t - 0.76) / 0.12))
  if (a_br > 0) {
    bx0 <- cx(1) - BAR_HW; bx1 <- cx(5) + BAR_HW
    by <- vy(1500)
    p <- p +
      annotate("segment", x = bx0, xend = bx0 + (bx1 - bx0) * a_br, y = by, yend = by,
               colour = AMBER, linewidth = 0.6) +
      annotate("segment", x = bx0, xend = bx0, y = by, yend = by - 0.020,
               colour = AMBER, linewidth = 0.6)
    if (a_br >= 0.999) {
      p <- p + annotate("segment", x = bx1, xend = bx1, y = by, yend = by - 0.020,
                        colour = AMBER, linewidth = 0.6)
    }
    a_lab <- appear(t, 0.86)
    if (a_lab > 0) {
      p <- p + annotate("text", x = bx0, y = by + 0.020, hjust = 0, vjust = 0,
                        size = 4.4, fontface = "bold", colour = fade_col(AMBER, a_lab),
                        family = SANS, label = "Bottom half: about 10% of the dollars")
    }
  }

  finish_frame(
    p + source_line("Workers ages 18-64. Source: EIG analysis of the Census Bureau's 2025 SIPP.",
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "retirement", build_secs = 3.2, hold_secs = 2.0)
