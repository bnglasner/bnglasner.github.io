# site_theme.R — shared harness for the bnglasner.github.io homepage headline
# wheel figures. Port of the Style Guide reel pipeline's motion system
# (ai/pipelines/scripts/reel_anim.R) re-tokened to the site's 2026 redesign
# palette (_sass/_themes.scss). Charts are CHART-ONLY: the homepage card's
# HTML carries the title and hook line, so no baked-in headers or footers —
# only axes, direct labels, key annotations, and a small source line.
#
# SITE_THEME=light|dark selects the token set. Frames are written to
# out/frames/<stem>_<theme>/ and stitched to MP4 with ffmpeg outside R.

suppressPackageStartupMessages({ library(ggplot2); library(ragg) })

THEME <- Sys.getenv("SITE_THEME", "light")

if (THEME == "dark") {
  FIELD      <- "#1a1f24"   # --paper-bg
  INK        <- "#fcfcfa"   # --paper-text
  MUTED      <- "#a6acb2"   # --paper-muted
  MUTED_SOFT <- "#899299"   # --paper-muted-soft
  GRID       <- "#fcfcfa1A" # hairline-soft (10% white)
  RULE       <- "#fcfcfa29" # hairline (16% white)
  TEAL       <- "#2ba694"   # --accent-teal
  AMBER      <- "#c97d1d"   # --accent-amber
} else {
  FIELD      <- "#fcfcfa"
  INK        <- "#1a1f24"
  MUTED      <- "#4a5158"
  MUTED_SOFT <- "#6b7178"
  GRID       <- "#d8d6ce"
  RULE       <- "#c9c6bc"
  TEAL       <- "#116a5f"
  AMBER      <- "#9c610d"
}

# ---- fonts: the site's own faces, instanced to static TTFs -------------------
# fonts/ is generated from assets/fonts/*.woff2 by render_all.sh (R's ragg
# cannot read woff2 directly); it is gitignored — run render_all.sh to build.
FONT_DIR <- file.path(dirname(sub("^--file=", "",
  grep("^--file=", commandArgs(FALSE), value = TRUE)[1])), "fonts")
FONT_DIR <- normalizePath(FONT_DIR, mustWork = TRUE)
systemfonts::register_font("Site Sans",
  plain = file.path(FONT_DIR, "public-sans-400.ttf"),
  bold  = file.path(FONT_DIR, "public-sans-600.ttf"))
systemfonts::register_font("Site Mono",
  plain = file.path(FONT_DIR, "ibm-plex-mono-400.ttf"),
  bold  = file.path(FONT_DIR, "ibm-plex-mono-500.ttf"))
SANS <- "Site Sans"; MONO <- "Site Mono"

# ---- canvas ------------------------------------------------------------------
W <- 1280; H <- 720; DPI <- 160

# top-origin y helper (matches the reel pipeline's layout convention)
yt <- function(y_top) 1 - y_top

# ---- easing (verbatim port from reel_anim.R) ---------------------------------
clamp01        <- function(x) pmin(1, pmax(0, x))
ease_out_cubic <- function(t) 1 - (1 - clamp01(t))^3
ease_in_out    <- function(t) { t <- clamp01(t)
  ifelse(t < 0.5, 4 * t^3, 1 - (-2 * t + 2)^3 / 2) }
stagger <- function(i, n, t, overlap = 0.55) {
  if (n <= 1) return(clamp01(t))
  span  <- 1 / (n - (n - 1) * overlap)
  start <- (i - 1) * span * (1 - overlap)
  clamp01((t - start) / span)
}
tick   <- function(target, t, ease = ease_out_cubic) target * ease(t)
appear <- function(t, at, fade = 0.12) clamp01((t - at) / fade)
fade_col <- function(col, a) {
  n <- max(length(col), length(a))
  col <- rep_len(col, n); a <- clamp01(rep_len(a, n))
  vapply(seq_len(n), function(i) {
    if (a[i] <= 0) NA_character_
    else grDevices::adjustcolor(col[i], alpha.f = a[i])
  }, character(1))
}

# ---- shared furniture ---------------------------------------------------------
finish_frame <- function(p) {
  p + coord_cartesian(xlim = c(0, 1), ylim = c(0, 1), expand = FALSE) +
    theme_void() +
    theme(plot.background = element_rect(fill = FIELD, colour = NA),
          plot.margin = margin(0, 0, 0, 0), legend.position = "none")
}

# small mono source line, bottom-left — the one piece of chart furniture every
# wheel figure carries, because attribution travels with the pixels.
source_line <- function(text, a = 1, x = 0.035, y_top = 0.955, size = 2.9) {
  annotate("text", x = x, y = yt(y_top), hjust = 0, vjust = 1,
           size = size, colour = fade_col(MUTED_SOFT, a), family = MONO,
           label = text)
}

# ---- renderer ------------------------------------------------------------------
# frame_fn(t) -> ggplot for t in [0,1]. Writes frames + final-frame poster PNG.
site_anim <- function(frame_fn, stem, build_secs = 2.4, hold_secs = 1.6,
                      fps = 30) {
  out_root <- file.path(dirname(FONT_DIR), "out")
  frame_dir <- file.path(out_root, "frames", paste0(stem, "_", THEME))
  unlink(frame_dir, recursive = TRUE)
  dir.create(frame_dir, recursive = TRUE, showWarnings = FALSE)

  n_build <- max(2L, round(build_secs * fps))
  n_hold  <- max(0L, round(hold_secs * fps))

  for (i in seq_len(n_build)) {
    t <- (i - 1) / (n_build - 1)
    f <- file.path(frame_dir, sprintf("f_%04d.png", i))
    ggsave(f, frame_fn(t), device = ragg::agg_png,
           width = W / DPI, height = H / DPI, dpi = DPI, bg = FIELD)
  }
  last <- file.path(frame_dir, sprintf("f_%04d.png", n_build))
  for (j in seq_len(n_hold)) {
    file.copy(last, file.path(frame_dir, sprintf("f_%04d.png", n_build + j)))
  }
  poster <- file.path(out_root, sprintf("%s_%s.png", stem, THEME))
  ggsave(poster, frame_fn(1), device = ragg::agg_png,
         width = W / DPI, height = H / DPI, dpi = DPI, bg = FIELD)
  cat(sprintf("[%s/%s] %d frames -> %s\n", stem, THEME, n_build + n_hold, frame_dir))
}
