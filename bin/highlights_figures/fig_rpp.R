# fig_rpp.R — homepage wheel figure 3: the RPP break in 2024 vote share.
# 16:9 re-layout of render_rpp_scatter.R (2026-07-17-rpp-harris-vote-share):
# the portrait original stacks title over plot; here the plot takes the left
# ~70% of the frame and the callout column sits right. Chart-only, site
# tokens. Verified numbers from that reel's fact-checked still: top price
# bin -4.35 pp actual vs -1.14 pp trend, 27 counties, 17.4M people.
#
# Reveal semantics ported: t in [0, 0.9] sweeps cloud + trend left to right;
# (0.9, 1] drops the top-bin outlier from the trend estimate to its actual
# value while the callout fades in.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

raw <- read.delim(file.path(SRC_DIR, "data", "rpp_bins.tsv"),
                  check.names = FALSE, stringsAsFactors = FALSE)
d <- data.frame(
  bin        = as.integer(raw[["RPP Percentile"]]),
  change_pp  = as.numeric(raw[["Change in the Dem. Vote Share"]]) * 100,
  counties   = as.integer(raw[["count_counties"]]),
  population = as.numeric(raw[["Population"]])
)
fit <- lm(change_pp ~ bin, data = subset(d, bin < 100))
slope <- coef(fit)[["bin"]]; intercept <- coef(fit)[["(Intercept)"]]
pred100 <- slope * 100 + intercept
stopifnot(abs(pred100 - (-1.14)) < 0.05)
top <- d[d$bin == 100, ]
stopifnot(abs(top$change_pp - (-4.35)) < 0.05)

PX0 <- 0.085; PX1 <- 0.680
PY0 <- 0.115; PY1 <- 0.780
YMAX <- 0; YMIN <- -5
xmap <- function(b) PX0 + (b - 1) / 99 * (PX1 - PX0)
ymap <- function(v) yt(PY0 + (YMAX - v) / (YMAX - YMIN) * (PY1 - PY0))
d$px <- xmap(d$bin); d$py <- ymap(d$change_pp)

CX <- 0.720                       # callout column left edge

frame <- function(t) {
  reveal <- clamp01(t)
  cloud <- subset(d, bin < 100 & bin <= reveal / 0.9 * 100)

  p <- ggplot() +
    scale_size_area(max_size = 13, limits = c(0, max(d$population))) +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Change in Democratic vote share, 2020 to 2024, percentage points")

  for (v in 0:-5) {
    is0 <- v == 0
    p <- p + annotate("segment", x = PX0, xend = PX1, y = ymap(v), yend = ymap(v),
                      colour = if (is0) RULE else GRID,
                      linewidth = if (is0) 0.6 else 0.35,
                      linetype = if (is0) "solid" else "22") +
      annotate("text", x = PX0 - 0.013, y = ymap(v), hjust = 1, vjust = 0.5,
               size = 3.4, colour = MUTED_SOFT, family = MONO,
               label = as.character(v))
  }
  p <- p + annotate("segment", x = PX0, xend = PX1, y = yt(PY1), yend = yt(PY1),
                    colour = RULE, linewidth = 0.6)
  for (v in c(1, 25, 50, 75, 100)) {
    p <- p + annotate("text", x = xmap(v), y = yt(PY1 + 0.030), hjust = 0.5,
                      vjust = 1, size = 3.4, colour = MUTED_SOFT, family = MONO,
                      label = as.character(v))
  }
  p <- p +
    annotate("text", x = PX0, y = yt(PY1 + 0.075), hjust = 0, vjust = 1,
             size = 3.5, colour = MUTED, family = SANS,
             label = "County price level (RPP percentile)") +
    annotate("text", x = PX1, y = yt(PY1 + 0.075), hjust = 1, vjust = 1,
             size = 3.5, colour = MUTED, family = SANS, fontface = "bold",
             label = "pricier →")

  # trend line, swept with the cloud
  tx2 <- min(100, max(1, reveal / 0.9 * 100))
  p <- p + annotate("segment", x = xmap(1), xend = xmap(tx2),
                    y = ymap(slope * 1 + intercept),
                    yend = ymap(slope * tx2 + intercept),
                    colour = TEAL, linewidth = 1.3)

  if (nrow(cloud) > 0) {
    p <- p + geom_point(data = cloud, aes(px, py, size = population),
                        fill = MUTED_SOFT, colour = FIELD, shape = 21,
                        stroke = 0.45, alpha = 0.9)
  }

  ax <- xmap(100); ay <- ymap(top$change_pp); py_pred <- ymap(pred100)
  ent <- clamp01((reveal - 0.9) / 0.1)

  if (ent > 0) {
    cy <- py_pred + (ay - py_pred) * ease_in_out(ent)
    curr <- data.frame(px = ax, py = cy, population = top$population)
    p <- p +
      annotate("point", x = ax, y = py_pred, shape = 21, fill = FIELD,
               colour = TEAL, size = 3.4, stroke = 1.1) +
      annotate("segment", x = ax, xend = ax, y = py_pred, yend = cy,
               colour = MUTED_SOFT, linewidth = 0.9, linetype = "22") +
      geom_point(data = curr, aes(px, py, size = population),
                 fill = AMBER, colour = FIELD, shape = 21, stroke = 1.2)

    a <- ease_in_out(ent)
    ly <- 0.300
    p <- p +
      annotate("text", x = CX, y = yt(ly), hjust = 0, vjust = 1, size = 3.4,
               colour = fade_col(MUTED_SOFT, a), family = MONO,
               label = "TOP PRICE BIN") +
      annotate("text", x = CX, y = yt(ly + 0.052), hjust = 0, vjust = 1,
               size = 7.6, fontface = "bold",
               colour = fade_col(AMBER, a), family = SANS,
               label = "−4.35 pp") +
      annotate("text", x = CX, y = yt(ly + 0.135), hjust = 0, vjust = 1,
               size = 3.9, colour = fade_col(INK, a), family = SANS,
               label = "27 counties\n17.4M people", lineheight = 1.25) +
      annotate("text", x = CX, y = yt(ly + 0.245), hjust = 0, vjust = 1,
               size = 3.9, colour = fade_col(TEAL, a), family = SANS,
               label = "Trend predicted\n−1.14 pp", lineheight = 1.25) +
      annotate("segment", x = CX - 0.012, xend = ax + 0.020,
               y = yt(ly + 0.070), yend = cy,
               colour = fade_col(MUTED_SOFT, a * 0.8), linewidth = 0.6)
  }

  finish_frame(
    p + source_line(paste0("Source: EIG analysis of county returns and BEA ",
                           "Regional Price Parities. Dot area = population."),
                    a = appear(reveal, 0.90, 0.10))
  )
}

site_anim(frame, "rpp", build_secs = 3.2, hold_secs = 2.0)
