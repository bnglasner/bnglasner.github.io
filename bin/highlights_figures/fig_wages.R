# fig_wages.R — homepage wheel figure 2: July 2026 wage-growth five-year low.
# Port of v4_wage_growth_5yr_low_x.R (2026-08-07-july-jobs-wage-squeeze),
# chart-only, site tokens. Claim (verified, that reel's source notes Claims
# 8-9): AHE total private rose 3.2% YoY in July 2026; last lower reading was
# May 2021 (2.32%).
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

raw <- read.csv(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])),
  "data", "ahe_yoy_2021_2026.csv"), stringsAsFactors = FALSE)
raw$d <- as.Date(raw$date)
dat <- raw[raw$d >= as.Date("2021-05-01"), ]
stopifnot(nrow(dat) > 50,
          round(dat$yoy_pct[nrow(dat)], 2) == 3.15,
          round(dat$yoy_pct[1], 2) == 2.32)
latest <- dat$yoy_pct[nrow(dat)]

px0 <- 0.105; px1 <- 0.885
py0 <- 0.090; py1 <- 0.800
v_lo <- 2.0;  v_hi <- 6.0

sx <- function(i) px0 + (px1 - px0) * (i - 1) / (nrow(dat) - 1)
sy <- function(v) yt(py1 - (py1 - py0) * (v - v_lo) / (v_hi - v_lo))
xs <- sx(seq_len(nrow(dat)))
ys <- sy(dat$yoy_pct)

reveal <- function(x, y, t) {
  n <- length(x); tt <- clamp01(t)
  pos <- 1 + (n - 1) * tt
  k <- floor(pos)
  if (k >= n) return(data.frame(x = x, y = y))
  fr <- pos - k
  data.frame(x = c(x[1:k], x[k] + fr * (x[k + 1] - x[k])),
             y = c(y[1:k], y[k] + fr * (y[k + 1] - y[k])))
}

yr_i <- which(format(dat$d, "%m") == "01")
yr_l <- format(dat$d[yr_i], "%Y")
gridv <- 2:6

frame <- function(t) {
  g    <- ease_in_out(clamp01(t / 0.76))
  path <- reveal(xs, ys, g)
  tipx <- path$x[nrow(path)]; tipy <- path$y[nrow(path)]
  landed <- g >= 0.999
  a_ref  <- appear(t, 0.80)
  a_src  <- appear(t, 0.90, 0.08)

  p <- ggplot() +
    annotate("segment", x = px0, xend = px1, y = sy(gridv), yend = sy(gridv),
             colour = GRID, linewidth = 0.35) +
    annotate("segment", x = px0, xend = px1, y = yt(py1), yend = yt(py1),
             colour = RULE, linewidth = 0.5) +
    annotate("text", x = px0 - 0.014, y = sy(gridv), hjust = 1, vjust = 0.5,
             size = 3.6, colour = MUTED_SOFT, family = MONO,
             label = paste0(gridv, "%")) +
    annotate("text", x = sx(yr_i), y = yt(py1 + 0.036), hjust = 0.5, vjust = 1,
             size = 3.6, colour = MUTED_SOFT, family = MONO, label = yr_l) +
    annotate("text", x = px0, y = yt(0.030), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Average hourly earnings, private sector, year-over-year growth") +
    annotate("segment", x = px0, xend = px1, y = sy(latest), yend = sy(latest),
             colour = fade_col(AMBER, a_ref * 0.9), linewidth = 0.55,
             linetype = "31") +
    geom_path(data = path, aes(x, y), colour = TEAL, linewidth = 1.7,
              lineend = "round", linejoin = "round") +
    annotate("point", x = tipx, y = tipy, colour = TEAL, size = 3.6)

  if (landed) {
    p <- p +
      annotate("text", x = tipx + 0.013, y = tipy, hjust = 0, vjust = 0.5,
               size = 7.2, fontface = "bold", colour = TEAL, family = SANS,
               label = "3.2%") +
      annotate("point", x = xs[1], y = ys[1],
               colour = fade_col(AMBER, a_ref), size = 3.2) +
      annotate("text", x = px0 + 0.012, y = sy(latest) - 0.020, hjust = 0,
               vjust = 1, size = 4.6, colour = fade_col(AMBER, a_ref),
               family = SANS, fontface = "bold",
               label = "Last month below this line: May 2021")
  }

  finish_frame(
    p + source_line("Source: BLS Employment Situation, August 7, 2026.",
                    a = a_src)
  )
}

site_anim(frame, "wages", build_secs = 2.6, hold_secs = 1.8)
