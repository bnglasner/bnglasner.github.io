# fig_socsec.R — homepage wheel figure 4: Social Security's anti-poverty reach.
# Animated rebuild of r1_antipoverty_breakdown (2026-06-23-social-security-
# payroll-cap; the original is a static portrait stat card). Horizontal
# stacked bar builds segment by segment while the headline count ticks up.
# Data: that reel's antipoverty_ss_by_age_2024.csv (Census P60-287 Table B-7).
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

d <- read.csv(file.path(SRC_DIR, "data", "antipoverty_ss_by_age_2024.csv"),
              stringsAsFactors = FALSE)
d <- d[order(d$order), ]
stopifnot(sum(d$count_thousands) > 28600, sum(d$count_thousands) < 28800)
total_m <- sum(d$count_thousands) / 1000          # 28.699 -> "28.7M"

SEG_COL <- c(seniors = TEAL, working_age = MUTED, children = AMBER)
SEG_LAB <- c(seniors = "older Americans (65+)",
             working_age = "working-age adults",
             children = "children")
seg_m <- d$count_thousands / 1000
names(seg_m) <- d$group

BX0 <- 0.075; BX1 <- 0.925
BAR_TOP <- 0.470; BAR_BOT <- 0.610
wfrac <- function(m) (BX1 - BX0) * m / total_m

frame <- function(t) {
  # headline counter rides the whole build
  count <- tick(total_m, clamp01(t / 0.85))
  p <- ggplot() +
    annotate("text", x = BX0, y = yt(0.085), hjust = 0, vjust = 1,
             size = 15.5, fontface = "bold", colour = INK, family = SANS,
             label = sprintf("%.1fM", count)) +
    annotate("text", x = BX0, y = yt(0.270), hjust = 0, vjust = 1,
             size = 4.4, colour = MUTED, family = SANS,
             label = "people lifted out of poverty by Social Security in 2024, by age group")

  x <- BX0
  for (i in seq_len(nrow(d))) {
    g <- d$group[i]
    a <- ease_out_cubic(stagger(i, nrow(d), clamp01(t / 0.85), overlap = 0.25))
    if (a <= 0) { x <- x + wfrac(seg_m[[g]]); next }
    w <- wfrac(seg_m[[g]]) * a
    p <- p + annotate("rect", xmin = x, xmax = x + w,
                      ymin = yt(BAR_BOT), ymax = yt(BAR_TOP),
                      fill = SEG_COL[[g]])
    # label lands once its segment is fully grown
    la <- appear(a, 0.999, 0.001)
    if (la > 0) {
      full_w <- wfrac(seg_m[[g]])
      cx <- x + full_w / 2
      val <- sprintf("%.1fM", seg_m[[g]])
      if (g == "children") {
        # 4.7% of the bar: label outside, to the right, with a leader
        p <- p +
          annotate("segment", x = cx, xend = cx,
                   y = yt(BAR_TOP), yend = yt(BAR_TOP - 0.045),
                   colour = fade_col(MUTED_SOFT, la), linewidth = 0.5) +
          annotate("text", x = cx + 0.010, y = yt(BAR_TOP - 0.060),
                   hjust = 1, vjust = 1, size = 4.6, fontface = "bold",
                   colour = fade_col(SEG_COL[[g]], la), family = SANS,
                   label = paste(val, SEG_LAB[[g]]))
      } else {
        p <- p +
          annotate("text", x = cx, y = yt(BAR_BOT + 0.055), hjust = 0.5,
                   vjust = 1, size = 4.6, fontface = "bold",
                   colour = fade_col(SEG_COL[[g]], la), family = SANS,
                   label = val) +
          annotate("text", x = cx, y = yt(BAR_BOT + 0.115), hjust = 0.5,
                   vjust = 1, size = 3.9,
                   colour = fade_col(MUTED, la), family = SANS,
                   label = SEG_LAB[[g]])
      }
    }
    x <- x + wfrac(seg_m[[g]])
  }

  finish_frame(
    p + source_line(paste0("Source: Census Bureau, P60-287, Table B-7 ",
                           "(Supplemental Poverty Measure)."),
                    a = appear(t, 0.88, 0.10))
  )
}

site_anim(frame, "socsec", build_secs = 2.6, hold_secs = 1.8)
