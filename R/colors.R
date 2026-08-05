# color token constants, by color family and level/shade (10–100)

# Orange
orange_10 <- "#feefe1"; orange_20 <- "#fbd6bc"; orange_30 <- "#fab787"
orange_40 <- "#fb934f"; orange_50 <- "#ef661f"; orange_60 <- "#d14a15"
orange_70 <- "#ad3308"; orange_80 <- "#862108"; orange_90 <- "#5d1607"
orange_100 <- "#330803"

# Teal
teal_10 <- "#e4f7f4"; teal_20 <- "#adede4"; teal_30 <- "#6dded1"
teal_40 <- "#29cac0"; teal_50 <- "#09aca6"; teal_60 <- "#088f8c"
teal_70 <- "#017272"; teal_80 <- "#035656"; teal_90 <- "#023a3e"
teal_100 <- "#011e20"

# Purple
purple_10 <- "#f4f0fa"; purple_20 <- "#e4d7fa"; purple_30 <- "#d2baf9"
purple_40 <- "#be9df8"; purple_50 <- "#a67aef"; purple_60 <- "#8e58e1"
purple_70 <- "#7536cb"; purple_80 <- "#5821a2"; purple_90 <- "#3d1177"
purple_100 <- "#1f0248"

# Red
red_10 <- "#ffeded"; red_20 <- "#fed2d3"; red_30 <- "#fdb0b4"
red_40 <- "#fa8b94"; red_50 <- "#eb6274"; red_60 <- "#d53b58"
red_70 <- "#b02445"; red_80 <- "#881332"; red_90 <- "#5e1023"
red_100 <- "#320710"

# Blue
blue_10 <- "#e9f3fd"; blue_20 <- "#c8e1fb"; blue_30 <- "#9fccfe"
blue_40 <- "#73b6fe"; blue_50 <- "#3d99f8"; blue_60 <- "#037de3"
blue_70 <- "#0c63b5"; blue_80 <- "#074a8b"; blue_90 <- "#063264"
blue_100 <- "#00183b"

# Gold
gold_10 <- "#fef4b2"; gold_20 <- "#fade62"; gold_30 <- "#edc401"
gold_40 <- "#d9aa01"; gold_50 <- "#bb8f09"; gold_60 <- "#a07505"
gold_70 <- "#825b0c"; gold_80 <- "#62440b"; gold_90 <- "#462d03"
gold_100 <- "#261500"

# Warm Grey
warm_grey_10 <- "#f3f2ee"; warm_grey_20 <- "#e0ded9"; warm_grey_30 <- "#c9c7c0"
warm_grey_40 <- "#b4b1a7"; warm_grey_50 <- "#99968b"; warm_grey_60 <- "#807d74"
warm_grey_70 <- "#666359"; warm_grey_80 <- "#4d4a41"; warm_grey_90 <- "#373327"
warm_grey_100 <- "#1c190f"

# Cool Grey
cool_grey_10 <- "#f2f2f2"; cool_grey_20 <- "#dadfe0"; cool_grey_30 <- "#c4c9ca"
cool_grey_40 <- "#acb2b3"; cool_grey_50 <- "#939798"; cool_grey_60 <- "#7a7e7e"
cool_grey_70 <- "#5f6464"; cool_grey_80 <- "#494b4b"; cool_grey_90 <- "#313333"
cool_grey_100 <- "#181a1a"

# ---------------------------------------------------------------------------
# categorical palettes
# ---------------------------------------------------------------------------

#' New America 6-color categorical palette
#'
#' Use for charts with up to 6 distinct categories. For more than 6 groups,
#' use [na_ext_cat_pal].
#'
#' @export
na_cat_pal <- c(teal_50, purple_60, orange_40, blue_80, red_60, blue_30)

#' New America 10-color extended categorical palette
#'
#' Use sparingly for charts with 7–10 distinct categories. Prefer [na_cat_pal] 
#' for 6 or fewer groups.
#'
#' @export
na_ext_cat_pal <- c(
  teal_50, teal_80, purple_40, purple_80,
  orange_40, orange_70, blue_30, blue_60,
  red_30, red_60
)

# ---------------------------------------------------------------------------
# scale functions
# ---------------------------------------------------------------------------

#' New America categorical fill scale
#'
#' a [ggplot2::scale_fill_manual()] wrapper defaulting to New America brand
#' colors. use `extended = TRUE` for charts w/ more than 6 categories.
#'
#' @param extended logical -- use 10-color extended palette. default `FALSE`.
#' @param ... addt'l arguments passed to [ggplot2::scale_fill_manual()].
#' @export
na_scale_fill_categorical <- function(extended = FALSE, ...) {
  palette <- if (extended) na_ext_cat_pal else na_cat_pal
  ggplot2::scale_fill_manual(values = palette, ...)
}

#' New America categorical color scale
#'
#' A [ggplot2::scale_color_manual()] wrapper defaulting to New America brand
#' colors. use `extended = TRUE` for charts with more than 6 categories.
#'
#' @param extended logical. use the 10-color extended palette. default `FALSE`.
#' @param ... addt'l arguments passed to [ggplot2::scale_color_manual()].
#' @export
na_scale_color_categorical <- function(extended = FALSE, ...) {
  palette <- if (extended) na_ext_cat_pal else na_cat_pal
  ggplot2::scale_color_manual(values = palette, ...)
}

# ---------------------------------------------------------------------------
# null / missing data color
# ---------------------------------------------------------------------------

#' color for null or missing data
#'
#' Cool Grey/20 (`#dadfe0`). use as default for representing missing, null, or 
#' de-emphasized data points. (YMMV, the right grey shade here is dependent on 
#' chart type and particularities of your data!)
#'
#' @export
na_null_color <- cool_grey_20

# ---------------------------------------------------------------------------
# sequential palette subsets
# ---------------------------------------------------------------------------

# internal lookup: (palette, n) >> color vector.
# following current brand guide specs for n = 2–5 across our main 
# three color families (Teal primary; Orange and Purple secondary)
.seq_palettes <- list(
  teal = list(
    "2" = c(teal_50, teal_70),
    "3" = c(teal_50, teal_70, teal_90),
    "4" = c(teal_30, teal_50, teal_70, teal_90),
    "5" = c(teal_20, teal_40, teal_60, teal_80, teal_100)
  ),
  purple = list(
    "2" = c(purple_50, purple_80),
    "3" = c(purple_50, purple_70, purple_90),
    "4" = c(purple_30, purple_50, purple_70, purple_90),
    "5" = c(purple_20, purple_40, purple_60, purple_80, purple_100)
  ),
  orange = list(
    "2" = c(orange_50, orange_70),
    "3" = c(orange_50, orange_70, orange_90),
    "4" = c(orange_30, orange_50, orange_70, orange_90),
    "5" = c(orange_20, orange_40, orange_60, orange_80, orange_100)
  ),
  cool_grey = list(
    "2" = c(cool_grey_40, cool_grey_70),
    "3" = c(cool_grey_40, cool_grey_60, cool_grey_80),
    "4" = c(cool_grey_30, cool_grey_50, cool_grey_70, cool_grey_90),
    "5" = c(cool_grey_20, cool_grey_40, cool_grey_60, cool_grey_80, cool_grey_100)
  )
)

#' New America sequential fill scale
#'
#' applies brand-specified sequential color ramp. lighter shades will map to
#' smaller/lower values.
#'
#' supply `n` for a discrete scale (2--5 ordered groups). omit `n` for a
#' continuous gradient (e.g. choropleths, heatmaps) -- the full light-to-dark
#' ramp is passed to [ggplot2::scale_fill_gradientn()].
#'
#' @param palette one of `"teal"` (primary), `"purple"`, `"orange"`, or `"cool_grey"`.
#' @param n number of ordered groups (2--5) for a discrete scale. omit for
#'   a continuous gradient.
#' @param ... addt'l arguments passed to [ggplot2::scale_fill_manual()] or
#'   [ggplot2::scale_fill_gradientn()].
#' @export
na_scale_fill_sequential <- function(palette = "teal", n, ...) {
  palette <- match.arg(palette, names(.seq_palettes))
  if (missing(n)) {
    return(ggplot2::scale_fill_gradientn(
      colors = .seq_palettes[[palette]][["5"]], ...
    ))
  }
  colors <- .seq_palettes[[palette]][[as.character(n)]]
  if (is.null(colors)) stop("`n` must be between 2 and 5 for sequential palettes.")
  ggplot2::scale_fill_manual(values = colors, ...)
}

#' New America sequential color scale
#'
#' applies brand-specified sequential color ramp for non-fill geoms (lines,
#' points).
#'
#' supply `n` for a discrete scale (2--5 ordered groups). omit `n` for a
#' continuous gradient --  full light-to-dark ramp is passed to
#' [ggplot2::scale_color_gradientn()].
#'
#' @param palette one of `"teal"` (primary), `"purple"`, `"orange"`, or `"cool_grey"`.
#' @param n number of ordered groups (2--5) for a discrete scale. omit for
#'   a continuous gradient.
#' @param ... addt'l arguments passed to [ggplot2::scale_color_manual()] or
#'   [ggplot2::scale_color_gradientn()].
#' @export
na_scale_color_sequential <- function(palette = "teal", n, ...) {
  palette <- match.arg(palette, names(.seq_palettes))
  if (missing(n)) {
    return(ggplot2::scale_color_gradientn(
      colors = .seq_palettes[[palette]][["5"]], ...
    ))
  }
  colors <- .seq_palettes[[palette]][[as.character(n)]]
  if (is.null(colors)) stop("`n` must be between 2 and 5 for sequential palettes.")
  ggplot2::scale_color_manual(values = colors, ...)
}

# ---------------------------------------------------------------------------
# diverging palettes
# ---------------------------------------------------------------------------

#' New America Orange-Teal diverging palette
#'
#' 15-color diverging scale from orange (e.g., disagreement/no) to teal 
#' (e.g., agreement/yes).
#' position 8 (Cool Grey/10, `#f2f2f2`) is the neutral midpoint.
#'
#' for a subset of colors, index directly:
#' `na_div_orange_teal[c(1, 4, 8, 12, 15)]` gives a 5-point Likert subset.
#'
#' @export
na_div_orange_teal <- c(
  orange_80, orange_70, orange_60, orange_50, orange_40, orange_30, orange_20,
  cool_grey_10,
  teal_20, teal_30, teal_40, teal_50, teal_60, teal_70, teal_80
)

#' New America Purple-Orange diverging palette
#'
#' 15-color diverging scale from purple (e.g., less/colder) to 
#' orange (e.g., more/warmer).
#' position 8 (Cool Grey/10, `#f2f2f2`) is the neutral midpoint.
#'
#' @export
na_div_purple_orange <- c(
  purple_80, purple_70, purple_60, purple_50, purple_40, purple_30, purple_20,
  cool_grey_10,
  orange_20, orange_30, orange_40, orange_50, orange_60, orange_70, orange_80
)

#' New America Blue-Red diverging palette
#'
#' 15-color diverging scale from blue (e.g., Democrat vote margin) to 
#' red (e.g., Republican vote margin).
#' position 8 (Cool Grey/10, `#f2f2f2`) is the neutral midpoint.
#' reserved for U.S. political data.
#'
#' @export
na_div_blue_red <- c(
  blue_80, blue_70, blue_60, blue_50, blue_40, blue_30, blue_20,
  cool_grey_10,
  red_20, red_30, red_40, red_50, red_60, red_70, red_80
)

.div_palettes <- list(
  orange_teal   = na_div_orange_teal,
  purple_orange = na_div_purple_orange,
  blue_red      = na_div_blue_red
)

# ordinal subsets for discrete/Likert use (v1, needs refinement)
# current logic: Cool Grey midpoint is always 2 shades lighter than lightest
# flanking color (e.g., lightest flanking = /60 >> midpoint = cool_grey_40).
# Flanking shades by n: 3 >> /70; 5 >> /80+/60; 7 >> /80+/60+/40.
# TODO(v2): validate subsets w/ more chart examples across all three
# palettes and refine shades + midpoint rule
.div_ordinal <- list(
  orange_teal = list(
    "3" = c(orange_70, cool_grey_50, teal_70),
    "5" = c(orange_80, orange_60, cool_grey_40, teal_60, teal_80),
    "7" = c(orange_80, orange_60, orange_40, cool_grey_20, teal_40, teal_60, teal_80)
  ),
  purple_orange = list(
    "3" = c(purple_70, cool_grey_50, orange_70),
    "5" = c(purple_80, purple_60, cool_grey_40, orange_60, orange_80),
    "7" = c(purple_80, purple_60, purple_40, cool_grey_20, orange_40, orange_60, orange_80)
  ),
  blue_red = list(
    "3" = c(blue_70, cool_grey_50, red_70),
    "5" = c(blue_80, blue_60, cool_grey_40, red_60, red_80),
    "7" = c(blue_80, blue_60, blue_40, cool_grey_20, red_40, red_60, red_80)
  )
)

#' New America diverging fill scale
#'
#' applies a brand-specified diverging palette, used for data with 
#' a meaningful midpoint
#'
#' available palettes:
#' - `"orange_teal"` — e.g., disagree–agree, no–yes
#' - `"purple_orange"` — e.g., less–more, colder–warmer
#' - `"blue_red"` — e.g., margin Democrat–margin Republican (political data)
#'
#' omit `n` for a continuous gradient (e.g. choropleths). supply `n` (3, 5,
#' or 7) for ordinal/Likert data to get a symmetric discrete subset with a
#' neutral midpoint. the midpoint grey is always 2 shades lighter than
#' the lightest flanking color.
#' **Note:** ordinal subsets are v1 and may be refined in the future.
#'
#' @param palette one of `"orange_teal"`, `"purple_orange"`, or `"blue_red"`.
#' @param n optional integer. for ordinal use: 3, 5, or 7.
#' @param ... addt'l arguments passed to [ggplot2::scale_fill_gradientn()]
#'   or [ggplot2::scale_fill_manual()].
#' @export
na_scale_fill_diverging <- function(palette = "orange_teal", n = NULL, ...) {
  palette <- match.arg(palette, names(.div_palettes))
  if (is.null(n)) {
    return(ggplot2::scale_fill_gradientn(colors = .div_palettes[[palette]], ...))
  }
  colors <- .div_ordinal[[palette]][[as.character(n)]]
  if (is.null(colors)) stop("`n` must be 3, 5, or 7 for ordinal diverging palettes.")
  ggplot2::scale_fill_manual(values = colors, ...)
}

#' New America diverging color scale
#'
#' applies a brand-specified diverging palette for line charts, points, or
#' other non-fill geoms. See [na_scale_fill_diverging()] for full details.
#'
#' @param palette one of `"orange_teal"`, `"purple_orange"`, or `"blue_red"`.
#' @param n optional integer. for ordinal use: 3, 5, or 7.
#' @param ... addt'l arguments passed to [ggplot2::scale_color_gradientn()]
#'   or [ggplot2::scale_color_manual()].
#' @export
na_scale_color_diverging <- function(palette = "orange_teal", n = NULL, ...) {
  palette <- match.arg(palette, names(.div_palettes))
  if (is.null(n)) {
    return(ggplot2::scale_color_gradientn(colors = .div_palettes[[palette]], ...))
  }
  colors <- .div_ordinal[[palette]][[as.character(n)]]
  if (is.null(colors)) stop("`n` must be 3, 5, or 7 for ordinal diverging palettes.")
  ggplot2::scale_color_manual(values = colors, ...)
}

# ---------------------------------------------------------------------------
# U.S. Political palette
# ---------------------------------------------------------------------------

#' Democrat color: Blue/60 (`#037de3`)
#' @export
na_pol_democrat <- blue_60

#' Democrat light variant: Blue/30 (`#9fccfe`). use with [na_pol_democrat]
#' for before/after or sub-group comparisons.
#' @export
na_pol_democrat_light <- blue_30

#' Republican color: Red/60 (`#d53b58`)
#' @export
na_pol_republican <- red_60

#' Republican light variant: Red/30 (`#fdb0b4`). use with [na_pol_republican]
#' for before/after or sub-group comparisons.
#' @export
na_pol_republican_light <- red_30

#' Independent color: Cool Grey/80 (`#494b4b`)
#' @export
na_pol_independent <- cool_grey_80

#' Independent light variant: Cool Grey/40 (`#acb2b3`). use with
#' [na_pol_independent] for sub-group comparisons. do not use in the same
#' chart as [na_pol_swing_grey] (same color family).
#' @export
na_pol_independent_light <- cool_grey_40

#' Independent alternate color: Gold/50 (`#bb8f09`). use instead of
#' [na_pol_independent] when preferred, or when Cool Grey
#' is already in use for another group in the same chart.
#' @export
na_pol_independent_gold <- gold_50

#' Independent alternate light variant: Gold/20 (`#fade62`). use with
#' [na_pol_independent_gold] for sub-group comparisons.
#' @export
na_pol_independent_gold_light <- gold_20

#' Swing/Undecided color: Purple/40 (`#be9df8`)
#' @export
na_pol_swing <- purple_40

#' Swing dark variant — Purple/80 (`#5821a2`). In a paired Swing comparison,
#' Purple/80 serves as the stronger shade and Purple/40 ([na_pol_swing]) as
#' the lighter.
#' @export
na_pol_swing_dark <- purple_80

#' Swing alternate color: Cool Grey/40 (`#acb2b3`). use instead of
#' [na_pol_swing] when [na_pol_independent_gold] is used for Independent
#' (freeing up the cool grey family for Swing). do not use in same chart as
#' [na_pol_independent] (same color family).
#' @export
na_pol_swing_grey <- cool_grey_40

#' New America U.S. political palette
#'
#' named vector of brand colors for U.S. political groups. reserved for U.S.
#' political data only. names match expected `fill` or `color` factor levels:
#' `"Democrat"`, `"Republican"`, `"Independent"`, `"Swing"`.
#'
#' for before/after or sub-group comparisons of Democrats and Republicans, see
#' [na_pol_pal_paired]. for Independent/Swing alternate color families, use the
#' individual constants (e.g., [na_pol_independent_gold], [na_pol_swing_grey]).
#'
#' **Note:** use grey for only one group per chart. if Independent uses
#' Cool Grey/80 (default), swing must use Purple, not [na_pol_swing_grey].
#'
#' @export
na_pol_pal <- c(
  Democrat    = na_pol_democrat,
  Republican  = na_pol_republican,
  Independent = na_pol_independent,
  Swing       = na_pol_swing
)

#' New America paired political palette
#'
#' named vector of Democrat and Republican colors with their light variants,
#' for before/after or sub-group comparisons. factor levels in your data should
#' match the names: `"Democrat"`, `"Democrat Light"`, `"Republican"`,
#' `"Republican Light"`.
#'
#' for Independent and Swing paired variants, compose from individual constants
#' ([na_pol_independent_light], [na_pol_swing_dark], etc.) since the correct
#' color family depends on what other groups appear in the chart.
#'
#' @export
na_pol_pal_paired <- c(
  Democrat           = na_pol_democrat,
  `Democrat Light`   = na_pol_democrat_light,
  Republican         = na_pol_republican,
  `Republican Light` = na_pol_republican_light
)

#' New America political fill scale
#'
#' applies U.S. political party colors. reserved for U.S. political data only.
#' factor levels in your data should match the names in [na_pol_pal]:
#' `"Democrat"`, `"Republican"`, `"Independent"`, `"Swing"`.
#'
#' @param ... addt'l arguments passed to [ggplot2::scale_fill_manual()].
#' @export
na_scale_fill_political <- function(...) {
  ggplot2::scale_fill_manual(values = na_pol_pal, ...)
}

#' New America political color scale
#'
#' applies U.S. political party colors. reserved for U.S. political data only.
#'
#' @param ... addt'l arguments passed to [ggplot2::scale_color_manual()].
#' @export
na_scale_color_political <- function(...) {
  ggplot2::scale_color_manual(values = na_pol_pal, ...)
}
