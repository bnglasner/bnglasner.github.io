# fig_minwage.R — homepage wheel figure: the federal minimum and the higher
# federal-or-state floor split apart. 16:9 port of
# 02_aw_minwage_federal_vs_prevailing_animation.R (2026-09-01-federal-
# minimum-wage-misses-workers; the original is 9:16 portrait). Claims
# (verified, that reel's source notes Claims 1, 6, 6a, 7): in 2025, 1 percent
# of hourly workers earned at or below the federal minimum and 7 percent at or
# below the higher federal-or-state floor; in 1982 both were about 14 percent.
#
# Wording constraint from the source notes: "earned at or below", never
# "covered" — this is an observed-wage share, not FLSA legal coverage. Local
# minimums are excluded, so the 7 percent is a lower bound.
# Motion carries the idea: both lines draw together from 1982 and the gap
# between them fills as they split.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

d <- read.csv(file.path(SRC_DIR, "data", "minwage_share_annual.csv"),
              stringsAsFactors = FALSE)
d <- d[order(d$year_int), ]
d$fed <- 100 * d$at_below_federal_share
d$prev <- 100 * d$at_below_prevailing_share
stopifnot(min(d$year_int) == 1982, max(d$year_int) == 2025,
          all(diff(d$year_int) == 1),
          round(d$fed[d$year_int == 2025]) == 1,
          round(d$prev[d$year_int == 2025]) == 7,
          round(d$fed[1]) == 14, round(d$prev[1]) == 14)

PX0 <- 0.105; PX1 <- 0.700
PY_TOP <- 0.120; PY_BOT <- 0.800
Y0 <- 1982; Y1 <- 2025; V_HI <- 15
sx <- function(y) PX0 + (y - Y0) / (Y1 - Y0) * (PX1 - PX0)
sy <- function(v) yt(PY_BOT - v / V_HI * (PY_BOT - PY_TOP))
n <- nrow(d)
xs <- sx(d$year_int); yf <- sy(d$fed); yp <- sy(d$prev)

# series up to fractional index pos, with an interpolated tip
upto <- function(v, pos) {
  k <- floor(pos); fr <- pos - k
  out <- v[seq_len(k)]
  if (k < n && fr > 0) out <- c(out, v[k] + fr * (v[k + 1] - v[k]))
  out
}

gridv <- c(5, 10, 15)
ticks <- c(1985, 1995, 2005, 2015, 2025)

frame <- function(t) {
  g <- ease_in_out(clamp01(t / 0.74))
  pos <- 1 + (n - 1) * g
  px <- upto(xs, pos); pf <- upto(yf, pos); pp <- upto(yp, pos)

  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Share of hourly workers earning at or below the minimum wage, 1982 to 2025") +
    annotate("segment", x = PX0, xend = PX1, y = sy(gridv), yend = sy(gridv),
             colour = GRID, linewidth = 0.35) +
    annotate("segment", x = PX0, xend = PX1, y = sy(0), yend = sy(0),
             colour = RULE, linewidth = 0.6) +
    annotate("text", x = PX0 - 0.014, y = sy(c(0, gridv)), hjust = 1, vjust = 0.5,
             size = 3.6, colour = MUTED_SOFT, family = MONO,
             label = paste0(c(0, gridv), "%")) +
    annotate("text", x = sx(ticks), y = yt(PY_BOT + 0.036), hjust = 0.5, vjust = 1,
             size = 3.6, colour = MUTED_SOFT, family = MONO, label = as.character(ticks))

  if (length(px) >= 2) {
    p <- p +
      annotate("polygon", x = c(px, rev(px)), y = c(pp, rev(pf)),
               fill = fade_col(TEAL, 0.14)) +
      annotate("path", x = px, y = pf, colour = AMBER, linewidth = 1.5,
               lineend = "round", linejoin = "round") +
      annotate("path", x = px, y = pp, colour = TEAL, linewidth = 1.7,
               lineend = "round", linejoin = "round")
  }

  a_start <- appear(t, 0.04, 0.10)
  if (a_start > 0) {
    p <- p +
      annotate("point", x = xs[1], y = yp[1], colour = fade_col(INK, a_start), size = 2.6) +
      annotate("text", x = xs[1] + 0.016, y = yp[1] + 0.012, hjust = 0, vjust = 0,
               size = 3.9, colour = fade_col(MUTED, a_start), family = SANS,
               label = "1982: both measures about 14%")
  }

  if (g >= 0.999) {
    a_end <- appear(t, 0.76)
    lx <- xs[n] + 0.018
    p <- p +
      annotate("text", x = lx, y = yp[n], hjust = 0, vjust = 0.5, size = 7.2,
               fontface = "bold", colour = fade_col(TEAL, a_end), family = SANS,
               label = "7%") +
      annotate("text", x = lx + 0.064, y = yp[n], hjust = 0, vjust = 0.5, size = 3.6,
               colour = fade_col(TEAL, a_end), family = SANS, lineheight = 1.05,
               label = "at or below the higher\nfederal-or-state floor") +
      annotate("text", x = lx, y = yf[n], hjust = 0, vjust = 0.5, size = 7.2,
               fontface = "bold", colour = fade_col(AMBER, a_end), family = SANS,
               label = "1%") +
      annotate("text", x = lx + 0.064, y = yf[n], hjust = 0, vjust = 0.5, size = 3.6,
               colour = fade_col(AMBER, a_end), family = SANS, lineheight = 1.05,
               label = "at or below the\nfederal $7.25")
  }

  finish_frame(
    p + source_line(paste0("Local minimums excluded, so 7% is a lower bound. ",
                           "Source: EIG analysis of CPS Outgoing Rotation Groups."),
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "minwage", build_secs = 3.4, hold_secs = 2.0)
