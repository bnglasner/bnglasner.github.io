# fig_wagepct.R — homepage wheel figure: real hourly wages by percentile,
# December 1982 = 100, 1982 to August 2026. Re-theme of Figure A
# (figure_a_percentiles.R) in the EIG-Wage-Figure-Explain-Everything repo,
# reading its output/tables/figure_a_percentiles_indexed_roll12.csv. Claims
# (that repo's drafts/figures_summary.md, Figure A): cumulative change since
# December 1982 of +53.6% (10th), +50.5% (25th), +39.7% (median), +45.4%
# (75th), +77.5% (90th). Lines are 12-month rolling averages of monthly
# weighted CPS ORG percentiles, deflated with the PCE price index; March 2020
# to December 2021 is dashed (CPS sample-composition shifts).
# Motion carries the idea: all five lines leave 100 together and the 90th
# percentile separates from the pack.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

d <- read.csv(file.path(SRC_DIR, "data", "wage_percentiles_indexed_roll12.csv"),
              stringsAsFactors = FALSE)
d <- d[order(d$year_int, d$month_int), ]
d$x <- d$year_int + (d$month_int - 1) / 12
cols <- c("p10", "p25", "p50", "p75", "p90")
for (k in cols) {
  cv <- d[[paste0(k, "_covid")]]
  d[[k]] <- ifelse(is.na(d[[k]]), cv, d[[k]])
}
n <- nrow(d)
stopifnot(!anyNA(d[, cols]), d$year_int[1] == 1982, d$year_int[n] == 2026,
          d$month_int[n] == 8,
          round(d$p90[n] - 100, 1) == 77.5, round(d$p50[n] - 100, 1) == 39.7,
          round(d$p10[n] - 100, 1) == 53.6)

PX0 <- 0.105; PX1 <- 0.720
PY_TOP <- 0.120; PY_BOT <- 0.800
X0 <- 1982; X1 <- 2026.67; V_LO <- 90; V_HI <- 190
sx <- function(x) PX0 + (x - X0) / (X1 - X0) * (PX1 - PX0)
sy <- function(v) yt(PY_BOT - (v - V_LO) / (V_HI - V_LO) * (PY_BOT - PY_TOP))

# one data frame of path segments: solid runs and dashed (covid) runs, each
# padded by one point so the dash joins the solid line.
runs <- cumsum(c(1, diff(d$covid_flag_int) != 0))
seg_rows <- function(upto) {
  out <- NULL
  for (r in unique(runs)) {
    idx <- which(runs == r)
    idx <- idx[idx <= upto]
    if (!length(idx)) next
    dashed <- d$covid_flag_int[idx[1]] == 1
    if (dashed) idx <- c(max(1, idx[1] - 1), idx, min(n, idx[length(idx)] + 1))
    out <- rbind(out, data.frame(i = idx, run = r, dashed = dashed))
  }
  out
}

gridv <- c(100, 125, 150, 175)
ticks <- c(1985, 1995, 2005, 2015, 2025)

frame <- function(t) {
  g <- ease_in_out(clamp01(t / 0.74))
  up <- max(2L, round(1 + (n - 1) * g))
  sr <- seg_rows(up)

  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Real hourly wage by percentile, indexed to December 1982 = 100") +
    annotate("segment", x = PX0, xend = PX1, y = sy(gridv), yend = sy(gridv),
             colour = GRID, linewidth = 0.35) +
    annotate("segment", x = PX0, xend = PX1, y = sy(100), yend = sy(100),
             colour = RULE, linewidth = 0.6) +
    annotate("text", x = PX0 - 0.014, y = sy(gridv), hjust = 1, vjust = 0.5,
             size = 3.6, colour = MUTED_SOFT, family = MONO,
             label = as.character(gridv)) +
    annotate("text", x = sx(ticks), y = yt(PY_BOT + 0.036), hjust = 0.5, vjust = 1,
             size = 3.6, colour = MUTED_SOFT, family = MONO, label = as.character(ticks))

  draw <- function(k, col, lw) {
    pd <- data.frame(x = sx(d$x[sr$i]), y = sy(d[[k]][sr$i]), run = sr$run,
                     dashed = sr$dashed)
    for (r in unique(pd$run)) {
      q <- pd[pd$run == r, ]
      p <<- p + annotate("path", x = q$x, y = q$y, colour = col, linewidth = lw,
                         linetype = if (q$dashed[1]) "22" else "solid",
                         lineend = "round", linejoin = "round")
    }
  }
  neutral <- fade_col(MUTED_SOFT, 0.75)
  for (k in c("p10", "p25", "p75")) draw(k, neutral, 0.7)
  draw("p50", AMBER, 1.1)
  draw("p90", TEAL, 1.3)

  if (g >= 0.999) {
    a_end <- appear(t, 0.76)
    lx <- sx(d$x[n]) + 0.016
    p <- p +
      annotate("text", x = lx, y = sy(d$p90[n]), hjust = 0, vjust = 0.5, size = 5.8,
               fontface = "bold", colour = fade_col(TEAL, a_end), family = SANS,
               label = "+78%") +
      annotate("text", x = lx + 0.098, y = sy(d$p90[n]), hjust = 0, vjust = 0.5, size = 3.6,
               colour = fade_col(TEAL, a_end), family = SANS, label = "90th percentile") +
      annotate("text", x = lx, y = sy(152), hjust = 0, vjust = 0.5, size = 3.6,
               colour = fade_col(MUTED, a_end), family = SANS, lineheight = 1.05,
               label = "10th, 25th, 75th\npercentiles: +45% to +54%") +
      annotate("text", x = lx, y = sy(137), hjust = 0, vjust = 0.5, size = 5.8,
               fontface = "bold", colour = fade_col(AMBER, a_end), family = SANS,
               label = "+40%") +
      annotate("text", x = lx + 0.098, y = sy(137), hjust = 0, vjust = 0.5, size = 3.6,
               colour = fade_col(AMBER, a_end), family = SANS, label = "median")
  }

  finish_frame(
    p + source_line("Dashed: Mar 2020 to Dec 2021 (CPS sample shifts). Source: EIG analysis of CPS ORG.",
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "wagepct", build_secs = 3.6, hold_secs = 2.0)
