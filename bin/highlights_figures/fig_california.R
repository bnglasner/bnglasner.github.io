# fig_california.R — homepage wheel figure 5: take out healthcare and
# California shrank. Ground-up 16:9 build (the 2026-05-28-california-
# healthcare-jobs reel shipped only static portrait charts, and the 8-state
# dumbbell's non-headline values are not in the source notes — so this uses
# ONLY the reel's High-confidence verified numbers, source-notes line 18:
# March 2022 - March 2026, BLS SAE: CA total +3.4, CA healthcare +25.3,
# CA non-health -0.3; U.S. total +4.7, healthcare +16.3, non-health +2.9).
#
# Motion carries the idea (the pipeline's rule): bars grow in speech order
# and the last one — California without healthcare — crosses zero.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

groups <- c("Healthcare &\nsocial assistance", "All jobs", "Excluding\nhealthcare")
ca <- c(25.3, 3.4, -0.3)
us <- c(16.3, 4.7, 2.9)

V_LO <- -3; V_HI <- 27
PX0 <- 0.075; PX1 <- 0.925
PY0 <- 0.140; PY1 <- 0.740
gx <- function(i) PX0 + (i - 0.5) * (PX1 - PX0) / 3     # group centres
BAR_W <- 0.085; GAPW <- 0.012
vy <- function(v) yt(PY1 - (v - V_LO) / (V_HI - V_LO) * (PY1 - PY0))

fmt <- function(v) sprintf("%+.1f%%", v)

frame <- function(t) {
  tb <- clamp01(t / 0.88)
  p <- ggplot() +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Employment growth, March 2022 to March 2026") +
    # colour key, direct-labelled once, top right
    annotate("text", x = PX1, y = yt(0.032), hjust = 1, vjust = 1, size = 3.9,
             fontface = "bold", colour = MUTED_SOFT, family = SANS,
             label = "United States") +
    annotate("text", x = PX1 - 0.135, y = yt(0.032), hjust = 1, vjust = 1,
             size = 3.9, fontface = "bold", colour = TEAL, family = SANS,
             label = "California")

  for (v in c(0, 10, 20)) {
    p <- p + annotate("segment", x = PX0, xend = PX1, y = vy(v), yend = vy(v),
                      colour = if (v == 0) RULE else GRID,
                      linewidth = if (v == 0) 0.6 else 0.35) +
      annotate("text", x = PX0 - 0.013, y = vy(v), hjust = 1, vjust = 0.5,
               size = 3.4, colour = MUTED_SOFT, family = MONO,
               label = paste0(v, "%"))
  }

  for (i in 1:3) {
    a <- ease_out_cubic(stagger(i, 3, tb, overlap = 0.35))
    cxc <- gx(i)
    xc1 <- cxc - GAPW / 2 - BAR_W; xc2 <- cxc - GAPW / 2       # CA bar
    xu1 <- cxc + GAPW / 2;         xu2 <- cxc + GAPW / 2 + BAR_W

    if (a > 0) {
      vca <- ca[i] * a; vus <- us[i] * a
      ca_col <- if (i == 3) AMBER else TEAL
      p <- p +
        annotate("rect", xmin = xc1, xmax = xc2,
                 ymin = pmin(vy(0), vy(vca)), ymax = pmax(vy(0), vy(vca)),
                 fill = ca_col) +
        annotate("rect", xmin = xu1, xmax = xu2,
                 ymin = pmin(vy(0), vy(vus)), ymax = pmax(vy(0), vy(vus)),
                 fill = MUTED_SOFT)
      la <- appear(a, 0.999, 0.001)
      if (la > 0) {
        p <- p +
          annotate("text", x = (xc1 + xc2) / 2,
                   y = vy(ca[i]) + if (ca[i] >= 0) 0.028 else -0.030,
                   hjust = 0.5, vjust = 0.5, size = 4.8, fontface = "bold",
                   colour = fade_col(ca_col, la), family = SANS,
                   label = fmt(ca[i])) +
          annotate("text", x = (xu1 + xu2) / 2,
                   y = vy(us[i]) + if (us[i] >= 0) 0.028 else -0.030,
                   hjust = 0.5, vjust = 0.5, size = 3.9,
                   colour = fade_col(MUTED, la), family = SANS,
                   label = fmt(us[i]))
      }
    }
    p <- p + annotate("text", x = cxc, y = yt(PY1 + 0.075), hjust = 0.5,
                      vjust = 1, size = 3.9, colour = INK, family = SANS,
                      lineheight = 1.15, label = groups[i])
  }

  finish_frame(
    p + source_line("Source: EIG analysis of BLS State and Area Employment (SAE).",
                    a = appear(t, 0.90, 0.10))
  )
}

site_anim(frame, "california", build_secs = 2.8, hold_secs = 1.8)
