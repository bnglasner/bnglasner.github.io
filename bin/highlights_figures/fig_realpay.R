# fig_realpay.R — homepage wheel figure: pay after inflation below its
# year-earlier level for five straight months. 16:9 port of
# v6_real_earnings.R (2026-09-11-jobs-came-back-raises-did-not; the original
# is 9:16 portrait with a presenter cutout). Claim (verified, that reel's
# source notes Claim 11): BLS constant-dollar average hourly earnings, all
# private employees (CES0500000013), fell year over year in April-August 2026
# (-0.27, -0.80, -0.09, -0.09, -0.26 percent); March (+0.18) is the last
# positive month. Card hook also uses Claims 7 and 9 (pay +3.1, prices +3.4).
#
# True zero baseline: the whole claim is a sign, so the window carries zero
# with headroom on both sides. October 2025 is missing from the source (the
# whole BLS vintage lacks it), so the line breaks there instead of bridging.
# Motion carries the idea: the line draws in time order and each negative
# month lights up as the line reaches it, so the viewer counts the run.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

raw <- read.csv(file.path(SRC_DIR, "data", "real_earnings_2023_2026.csv"),
                stringsAsFactors = FALSE)
raw <- raw[raw$basis == "Inflation adjusted", ]
raw$d <- as.Date(raw$date)
raw <- raw[order(raw$d), ]
dat <- tail(raw, 24)
full <- data.frame(d = seq(min(dat$d), max(dat$d), by = "month"))
dat <- merge(full, dat[, c("d", "yoy_pct")], by = "d", all.x = TRUE)

neg_i <- which(format(dat$d, "%Y-%m") %in%
                 c("2026-04", "2026-05", "2026-06", "2026-07", "2026-08"))
mar_i <- which(format(dat$d, "%Y-%m") == "2026-03")
stopifnot(nrow(dat) == 25, sum(is.na(dat$yoy_pct)) == 1,
          format(dat$d[is.na(dat$yoy_pct)], "%Y-%m") == "2025-10",
          length(neg_i) == 5, all(dat$yoy_pct[neg_i] < 0),
          dat$yoy_pct[mar_i] > 0,
          round(dat$yoy_pct[nrow(dat)], 2) == -0.26)

PX0 <- 0.105; PX1 <- 0.830
PY_TOP <- 0.120; PY_BOT <- 0.800
V_LO <- -1.2; V_HI <- 2.0
n <- nrow(dat)
sx <- function(i) PX0 + (PX1 - PX0) * (i - 1) / (n - 1)
sy <- function(v) yt(PY_BOT - (PY_BOT - PY_TOP) * (v - V_LO) / (V_HI - V_LO))
xs <- sx(seq_len(n)); ys <- sy(dat$yoy_pct)

# Partial path up to position pos (1..n), interpolating the tip, split into
# runs at the missing month so the line never bridges it.
path_runs <- function(pos) {
  k <- floor(pos); fr <- pos - k
  px <- xs[seq_len(k)]; py <- ys[seq_len(k)]
  if (k < n && fr > 0 && !is.na(ys[k]) && !is.na(ys[k + 1])) {
    px <- c(px, xs[k] + fr * (xs[k + 1] - xs[k]))
    py <- c(py, ys[k] + fr * (ys[k + 1] - ys[k]))
  }
  run <- cumsum(is.na(py))
  ok <- !is.na(py)
  split(data.frame(x = px[ok], y = py[ok]), run[ok])
}

gridv <- c(-1, 1, 2)
yr_i <- which(format(dat$d, "%m") == "01")

frame <- function(t) {
  g <- ease_in_out(clamp01(t / 0.70))
  pos <- 1 + (n - 1) * g
  landed <- g >= 0.999

  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Average hourly earnings after inflation, private-sector employees, change from a year earlier") +
    annotate("segment", x = PX0, xend = PX1, y = sy(gridv), yend = sy(gridv),
             colour = GRID, linewidth = 0.35) +
    annotate("segment", x = PX0, xend = PX1, y = sy(0), yend = sy(0),
             colour = RULE, linewidth = 0.8) +
    annotate("text", x = PX0 - 0.014, y = sy(c(gridv, 0)), hjust = 1, vjust = 0.5,
             size = 3.6, colour = MUTED_SOFT, family = MONO,
             label = c("\u22121%", "+1%", "+2%", "0")) +
    annotate("text", x = sx(yr_i), y = yt(PY_BOT + 0.036), hjust = 0.5, vjust = 1,
             size = 3.6, colour = MUTED_SOFT, family = MONO,
             label = format(dat$d[yr_i], "%Y"))

  for (run in path_runs(pos)) {
    if (nrow(run) >= 2) {
      p <- p + annotate("path", x = run$x, y = run$y, colour = TEAL,
                        linewidth = 1.7, lineend = "round", linejoin = "round")
    }
  }

  # each negative month lights as the line reaches it
  for (i in neg_i) {
    a <- clamp01((pos - i) / 0.6 + 1)
    if (pos >= i - 0.001 && a > 0) {
      p <- p + annotate("point", x = xs[i], y = ys[i], colour = AMBER,
                        size = 3.8 * ease_out_cubic(a))
    }
  }

  if (landed) {
    a_end <- appear(t, 0.72)
    p <- p +
      annotate("text", x = xs[n] + 0.016, y = ys[n], hjust = 0, vjust = 0.5,
               size = 7.2, fontface = "bold", colour = fade_col(AMBER, a_end),
               family = SANS, label = "\u22120.3%") +
      annotate("text", x = xs[n] + 0.018, y = ys[n] - 0.050, hjust = 0, vjust = 1,
               size = 3.6, colour = fade_col(MUTED, a_end), family = SANS,
               label = "August 2026")
  }

  # bracket under the five-month run, then its label
  a_br <- ease_out_cubic(clamp01((t - 0.76) / 0.10))
  if (a_br > 0) {
    bx0 <- xs[neg_i[1]] - 0.008; bx1 <- xs[neg_i[5]] + 0.008
    by <- sy(-1.02)
    p <- p +
      annotate("segment", x = bx0, xend = bx0 + (bx1 - bx0) * a_br, y = by, yend = by,
               colour = AMBER, linewidth = 0.6) +
      annotate("segment", x = bx0, xend = bx0, y = by, yend = by + 0.018,
               colour = AMBER, linewidth = 0.6)
    if (a_br >= 0.999) {
      p <- p + annotate("segment", x = bx1, xend = bx1, y = by, yend = by + 0.018,
                        colour = AMBER, linewidth = 0.6)
    }
    a_lab <- appear(t, 0.84)
    if (a_lab > 0) {
      p <- p + annotate("text", x = bx0 - 0.014, y = by, hjust = 1, vjust = 0.5,
                        size = 4.4, fontface = "bold", colour = fade_col(AMBER, a_lab),
                        family = SANS, label = "Five straight months below zero")
    }
  }

  finish_frame(
    p + source_line(paste0("October 2025 missing from source data. Source: BLS, ",
                           "Employment Situation and CPI, August 2026."),
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "realpay", build_secs = 3.4, hold_secs = 2.0)
