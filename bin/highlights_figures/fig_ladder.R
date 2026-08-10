# fig_ladder.R — homepage wheel figure 1: the generation wage ladder.
# Port of gen_ladder_hero_x16x9.R (2026-08-03-intergenerational-wage-ladder),
# chart-only, site tokens. Boomer-forward (the social-cut decision: the
# Silent series' young-age cells are only partly observed, and
# Boomer -> Millennial is the harder, more relevant comparison).
#
# Colour grammar maps onto the site's two-accent system: the claim pair
# carries the accents (Boomer = amber comparison, Millennial = teal treated,
# exactly the hero-figure's grammar) and the fill generations recede into
# the site's neutral ramp, carried by position and direct label.
source(file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "site_theme.R"))

SRC_DIR <- dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))

raw <- read.csv(file.path(SRC_DIR, "data",
                          "incwage_median_by_generation_age.csv"),
                stringsAsFactors = FALSE)
GENS <- c("Boomer (1946-1964)", "Gen X (1965-1980)",
          "Millennial (1981-1996)", "Gen Z (1997-2012)")
GEN_SHORT <- c("Boomer", "Gen X", "Millennial", "Gen Z")
names(GEN_SHORT) <- GENS
GEN_COL <- c(AMBER, MUTED_SOFT, TEAL, MUTED)
names(GEN_COL) <- GENS

AGE_MIN <- 22; AGE_MAX <- 65; MED_MAX <- 80000

raw$age <- as.integer(raw$age_in_income_year)
raw$med <- as.numeric(raw$median_real)
raw$full <- raw$fully_covered == "TRUE"
raw <- raw[raw$generation %in% GENS &
             raw$age >= AGE_MIN & raw$age <= AGE_MAX, ]
raw <- raw[order(raw$generation, raw$age), ]

PX0 <- 0.115; PX1 <- 0.905
PY_TOP <- 0.115; PY_BOT <- 0.800
sx <- function(age) PX0 + (age - AGE_MIN) / (AGE_MAX - AGE_MIN) * (PX1 - PX0)
sy <- function(med) yt(PY_BOT - (med / MED_MAX) * (PY_BOT - PY_TOP))
raw$x <- sx(raw$age); raw$y <- sy(raw$med)

grid_meds <- seq(0, 80000, by = 20000)
age_ticks <- seq(25, 65, by = 10)

# Anchor ages and dollar offsets ported from the source's LABEL_SPEC — they
# encode which side of each line is empty, a property of the data.
dy_dollars <- function(d) d / MED_MAX * (PY_BOT - PY_TOP)
LABEL_SPEC <- list(
  "Boomer (1946-1964)"     = list(age = 63, dd =  9500),
  "Gen X (1965-1980)"      = list(age = 55, dd =  8000),
  "Millennial (1981-1996)" = list(age = 43, dd =  8000),
  "Gen Z (1997-2012)"      = list(age = 27, dd =  9500)
)

# Reveal schedule ported: claim pair sweeps from age 38, fills follow.
PAIR <- c("Boomer (1946-1964)", "Millennial (1981-1996)")
FILL <- c("Gen X (1965-1980)", "Gen Z (1997-2012)")
TOTAL_FRAMES <- 150                      # 5.0 s at 30 fps
EDGE_AGE_AT_F0 <- 38
PAIR_FRAMES <- 24
FILL_FRAMES <- 30
fill_start <- PAIR_FRAMES + (seq_along(FILL) - 1) * FILL_FRAMES
names(fill_start) <- FILL

reveal_frac <- function(g, f) {
  if (g %in% PAIR) {
    edge <- EDGE_AGE_AT_F0 +
      max(0, min(1, f / PAIR_FRAMES)) * (AGE_MAX - EDGE_AGE_AT_F0)
    d <- raw[raw$generation == g, ]
    span <- max(d$age) - min(d$age)
    if (span <= 0) return(1)
    return(max(0, min(1, (edge - min(d$age)) / span)))
  }
  s <- fill_start[[g]]
  max(0, min(1, (f - s) / FILL_FRAMES))
}

# Solid (fully covered) vs dashed (partly covered) runs, never joined across
# a gap — ported: the dashes are a data-integrity mark, not decoration.
runs_for <- function(d) {
  if (nrow(d) < 2) return(list())
  breaks <- which(d$full[-1] != d$full[-nrow(d)] | diff(d$age) != 1)
  starts <- c(1, breaks + 1); ends <- c(breaks, nrow(d))
  out <- list()
  for (i in seq_along(starts)) {
    seg <- d[starts[i]:ends[i], ]
    if (starts[i] > 1) seg <- rbind(d[starts[i] - 1, ], seg)
    if (nrow(seg) >= 2) out[[length(out) + 1]] <- seg
  }
  out
}

build_frame_n <- function(f) {
  p <- ggplot() +
    annotate("segment", x = PX0, xend = PX1,
             y = sy(grid_meds), yend = sy(grid_meds),
             colour = GRID, linewidth = 0.35) +
    annotate("text", x = PX0 - 0.012, y = sy(grid_meds), hjust = 1,
             vjust = 0.5, size = 3.4, colour = MUTED_SOFT, family = MONO,
             label = ifelse(grid_meds == 0, "$0",
                            paste0("$", grid_meds / 1000, "k"))) +
    annotate("text", x = sx(age_ticks), y = yt(PY_BOT + 0.038), hjust = 0.5,
             vjust = 1, size = 3.4, colour = MUTED_SOFT, family = MONO,
             label = as.character(age_ticks)) +
    annotate("text", x = PX0, y = yt(0.032), hjust = 0, vjust = 1, size = 3.8,
             colour = MUTED, family = SANS,
             label = "Median wage income at each age, by birth generation, in 2025 dollars") +
    annotate("text", x = (PX0 + PX1) / 2, y = yt(PY_BOT + 0.082),
             hjust = 0.5, vjust = 1, size = 3.5, colour = MUTED, family = SANS,
             label = "Age during the income year")

  for (g in c(FILL, PAIR)) {
    frac <- reveal_frac(g, f)
    if (frac <= 0) next
    d <- raw[raw$generation == g, ]
    edge_age <- min(d$age) + frac * (max(d$age) - min(d$age))
    keep <- d[d$age <= edge_age, ]
    if (nrow(keep) < 2) next
    if (frac < 1 && max(keep$age) < max(d$age)) {
      nxt <- d[d$age == max(keep$age) + 1, ]
      if (nrow(nxt) == 1) {
        tt <- edge_age - max(keep$age)
        last <- keep[nrow(keep), ]
        keep <- rbind(keep, transform(
          last, age = edge_age,
          x = last$x + tt * (nxt$x - last$x),
          y = last$y + tt * (nxt$y - last$y)))
      }
    }
    lw <- if (g %in% PAIR) 1.5 else 1.0
    for (seg in runs_for(keep)) {
      p <- p + annotate("path", x = seg$x, y = seg$y,
                        colour = GEN_COL[[g]], linewidth = lw,
                        linetype = if (all(seg$full)) "solid" else "22")
    }
    if (frac >= 1) {
      spec <- LABEL_SPEC[[g]]
      lab <- d[d$age == spec$age, ]
      p <- p + annotate("text", x = lab$x, y = lab$y + dy_dollars(spec$dd),
                        hjust = 0.5, vjust = 0.5, size = 4.4,
                        fontface = "bold", colour = GEN_COL[[g]],
                        family = SANS, label = GEN_SHORT[[g]])
    } else if (g %in% PAIR) {
      edge <- keep[nrow(keep), ]
      p <- p + annotate("text", x = edge$x + 0.012,
                        y = edge$y + dy_dollars(
                          if (g == "Millennial (1981-1996)") 4200 else -4200),
                        hjust = 0, vjust = 0.5, size = 4.4, fontface = "bold",
                        colour = GEN_COL[[g]], family = SANS,
                        label = GEN_SHORT[[g]])
    }
  }

  finish_frame(
    p + source_line(paste0("Dashed = partly observed. Source: IPUMS CPS ASEC ",
                           "1962-2025 (INCWAGE) and FRED PCEPI."),
                    a = appear(f / BUILD_FRAMES, 0.80, 0.10))
  )
}

# site_anim drives t in [0,1]; map back onto the ported frame schedule.
# (BUILD_FRAMES is referenced inside build_frame_n's source_line gate, so it
# is defined before any frame is drawn.)
BUILD_FRAMES <- 84                       # pair 24 + fills 60: motion ends here
frame <- function(t) build_frame_n(round(t * BUILD_FRAMES))
site_anim(frame, "ladder",
          build_secs = BUILD_FRAMES / 30, hold_secs = (TOTAL_FRAMES - BUILD_FRAMES) / 30)
