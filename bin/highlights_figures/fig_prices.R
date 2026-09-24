# fig_prices.R — homepage wheel figure: one inflation index, very different
# prices. 16:9 re-layout of r3_component_growth.R (2026-08-06-inflation-
# series-pt3-what-drives-inflation; the original is 9:16 portrait with the
# values typed in). Claim (verified, that reel's source notes Claim 1; series
# labels as corrected 2026-08-06 — SAE1 is Education, SAH1 is Shelter):
# cumulative CPI-U growth 2000-2024, annual averages — education +166.4,
# energy +124.4, medical care +116.2, shelter +107.1, all items +82.2,
# apparel +1.5 percent.
# Data: BLS-Job-Day output/tables/ce/cpi_component_growth_summary.csv
# (regenerated 2026-08-06 from the BLS public API).
#
# Motion carries the idea: bars grow in order and the all-items bar lands
# fifth, mid-pack; then a reference line at the headline rate drops through
# every row, so four categories sit above it and one far below.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

raw <- read.csv(file.path(SRC_DIR, "data", "cpi_component_growth_summary.csv"),
                stringsAsFactors = FALSE)
KEEP <- c(education = "Education", energy = "Energy", medical = "Medical care",
          shelter = "Shelter", all_items = "All items (headline)", apparel = "Apparel")
d <- raw[raw$cpi_category_chr %in% names(KEEP), ]
d$label <- KEEP[d$cpi_category_chr]
d$value <- round(d$growth_2000_2024_pct, 1)
d <- d[order(-d$value), ]
stopifnot(nrow(d) == 6,
          identical(d$value, c(166.4, 124.4, 116.2, 107.1, 82.2, 1.5)),
          identical(d$cpi_category_chr,
                    c("education", "energy", "medical", "shelter", "all_items", "apparel")))
n <- nrow(d)
all_v <- d$value[d$cpi_category_chr == "all_items"]

# teal = the claim pair (medical care vs apparel), amber = the headline
# benchmark, the rest recede
role <- ifelse(d$cpi_category_chr %in% c("medical", "apparel"), "claim",
               ifelse(d$cpi_category_chr == "all_items", "headline", "other"))
BAR_COL <- c(claim = TEAL, headline = AMBER, other = fade_col(MUTED_SOFT, 0.55))[role]
LAB_COL <- c(claim = TEAL, headline = AMBER, other = MUTED)[role]

LX <- 0.245; BX0 <- 0.265; BX_MAX <- 0.840; V_MAX <- 170
ROW0 <- 0.125; PITCH <- 0.118; BAR_H <- 0.064
bx <- function(v) BX0 + v / V_MAX * (BX_MAX - BX0)
row_top <- function(i) ROW0 + (i - 1) * PITCH

frame <- function(t) {
  tb <- clamp01(t / 0.72)
  p <- ggplot() +
    annotate("text", x = 0.105, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Cumulative price growth by category, consumer price index (CPI-U), 2000 to 2024") +
    annotate("segment", x = BX0, xend = BX0, y = yt(row_top(1) - 0.012),
             yend = yt(row_top(n) + BAR_H + 0.012), colour = RULE, linewidth = 0.6)

  for (i in seq_len(n)) {
    a <- ease_out_cubic(stagger(i, n, tb, overlap = 0.55))
    top <- row_top(i)
    bold <- role[i] != "other"
    p <- p + annotate("text", x = LX, y = yt(top + BAR_H / 2), hjust = 1, vjust = 0.5,
                      size = 4.2, fontface = if (bold) "bold" else "plain",
                      colour = LAB_COL[[i]], family = SANS, label = d$label[i])
    if (a <= 0) next
    p <- p + annotate("rect", xmin = BX0, xmax = bx(d$value[i] * a),
                      ymin = yt(top + BAR_H), ymax = yt(top), fill = BAR_COL[[i]])
    if (a >= 0.04) {
      p <- p + annotate("text", x = bx(d$value[i] * a) + 0.012, y = yt(top + BAR_H / 2),
                        hjust = 0, vjust = 0.5, size = if (bold) 4.8 else 4.2,
                        fontface = if (bold) "bold" else "plain",
                        colour = LAB_COL[[i]], family = SANS,
                        label = sprintf("+%.1f%%", d$value[i] * a))
    }
  }

  # headline reference line drops through every row once the bars land
  a_ref <- ease_out_cubic(clamp01((t - 0.76) / 0.12))
  if (a_ref > 0) {
    y_a <- yt(row_top(1) - 0.012)
    y_b <- yt(row_top(n) + BAR_H + 0.012)
    p <- p + annotate("segment", x = bx(all_v), xend = bx(all_v), y = y_a,
                      yend = y_a + (y_b - y_a) * a_ref, colour = AMBER,
                      linewidth = 0.6, linetype = "31")
  }

  finish_frame(
    p + source_line("Annual averages. Source: BLS, Consumer Price Index for All Urban Consumers.",
                    a = appear(t, 0.90, 0.08))
  )
}

site_anim(frame, "prices", build_secs = 3.2, hold_secs = 2.0)
