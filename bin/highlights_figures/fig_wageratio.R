# fig_wageratio.R — homepage wheel figure: wage ratios across the distribution,
# December 1982 = 100, 1982 to August 2026. Re-theme of Figure 6b lines
# (figure_f_era_bars.R) in the EIG-Wage-Figure-Explain-Everything repo, reading
# output/tables/figure_f_ratios_indexed_roll12.csv. Claims (that repo's
# figure_f_ratios_indexed_roll12.csv, latest month): 90/50 at 127.0, 90/10 at
# 115.6, 50/10 at 91.0 — i.e. +27%, +16%, and -9% since the December 1982 base.
# A falling 50/10 means the 10th percentile gained on the median. Era bars are
# left to the source figure; this card is lines only.
# Motion carries the idea: the three ratios leave 100 together, the top pulls
# away, and the bottom closes on the middle.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

d <- read.csv(file.path(SRC_DIR, "data", "wage_ratios_indexed_roll12.csv"),
              stringsAsFactors = FALSE)
d <- d[order(d$year_int, d$month_int), ]
d$x <- d$year_int + (d$month_int - 1) / 12
cols <- c("r50_10", "r90_50", "r90_10")
n <- nrow(d)
stopifnot(!anyNA(d[, cols]), d$year_int[1] == 1982, d$year_int[n] == 2026,
          d$month_int[n] == 8,
          round(d$r90_50[n] - 100) == 27, round(d$r90_10[n] - 100) == 16,
          round(d$r50_10[n] - 100) == -9)

PX0 <- 0.105; PX1 <- 0.720
PY_TOP <- 0.120; PY_BOT <- 0.800
X0 <- 1982; X1 <- 2026.67; V_LO <- 85; V_HI <- 135
sx <- function(x) PX0 + (x - X0) / (X1 - X0) * (PX1 - PX0)
sy <- function(v) yt(PY_BOT - (v - V_LO) / (V_HI - V_LO) * (PY_BOT - PY_TOP))

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

gridv <- c(90, 100, 110, 120, 130)
ticks <- c(1985, 1995, 2005, 2015, 2025)
MINUS <- "−"

frame <- function(t) {
  g <- ease_in_out(clamp01(t / 0.74))
  up <- max(2L, round(1 + (n - 1) * g))
  sr <- seg_rows(up)

  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Wage ratios across the distribution, indexed to December 1982 = 100") +
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
  draw("r90_10", fade_col(MUTED_SOFT, 0.8), 0.8)
  draw("r50_10", AMBER, 1.2)
  draw("r90_50", TEAL, 1.3)

  if (g >= 0.999) {
    a_end <- appear(t, 0.76)
    lx <- sx(d$x[n]) + 0.016
    lab <- function(k, num, txt, col) {
      list(annotate("text", x = lx, y = sy(d[[k]][n]), hjust = 0, vjust = 0.5, size = 5.8,
                    fontface = "bold", colour = fade_col(col, a_end), family = SANS, label = num),
           annotate("text", x = lx + 0.098, y = sy(d[[k]][n]), hjust = 0, vjust = 0.5, size = 3.6,
                    colour = fade_col(col, a_end), family = SANS, lineheight = 1.05, label = txt))
    }
    p <- p + lab("r90_50", "+27%", "90th percentile\nto median", TEAL) +
      lab("r90_10", "+16%", "90th to 10th", MUTED) +
      lab("r50_10", paste0(MINUS, "9%"), "median to\n10th percentile", AMBER)
  }

  finish_frame(
    p + source_line("Dashed: Mar 2020 to Dec 2021 (CPS sample shifts). Source: EIG analysis of CPS ORG.",
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "wageratio", build_secs = 3.6, hold_secs = 2.0)
