#' New America base ggplot2 theme
#'
#' a [ggplot2::theme_minimal()] extension implementing New America brand
#' typography and styling. Use as the foundation for all chart types; apply
#' chart-specific helpers (e.g., [na_theme_bar()]) on top.
#'
#' font sizes scale with the `scale` multiplier. the default (0.75) is
#' calibrated for medium-size 300 DPI PNG export via [na_save()], which
#' automatically adjusts the scale for small and large sizes.
#'
#' @param scale numeric font size multiplier. default 0.75, calibrated for
#'   medium 300 DPI export. [na_save()] overrides this automatically per size.
#' @return a ggplot2 theme object.
#' @export
na_base_theme <- function(scale = 0.75) {
  body_font    <- getOption("newameRica.font_family",    "Chivo")
  caption_font <- getOption("newameRica.caption_family", "Chivo")

  ggplot2::theme_minimal(base_family = body_font) +
    ggplot2::theme(
      text              = ggplot2::element_text(color = cool_grey_90),
      plot.title        = ggplot2::element_text(face = "bold", size = 19 * scale),
      plot.subtitle     = ggplot2::element_text(
        size = 15 * scale, color = cool_grey_90,
        margin = ggplot2::margin(t = 2, b = 18)
      ),
      plot.title.position  = "plot",
      plot.caption         = ggplot2::element_text(
        family = caption_font,
        size = 12 * scale, color = cool_grey_90, hjust = 0,
        margin = ggplot2::margin(t = 20)
      ),
      plot.caption.position = "plot",
      axis.text   = ggplot2::element_text(size = 14 * scale),
      axis.text.x = ggplot2::element_text(color = cool_grey_70, margin = ggplot2::margin(t = 1)),
      axis.text.y = ggplot2::element_text(color = cool_grey_50, margin = ggplot2::margin(r = 1)),
      axis.title.x = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      legend.position            = "top",
      legend.direction           = "horizontal",
      legend.title               = ggplot2::element_blank(),
      legend.location            = "plot",
      legend.justification.top   = "left",
      legend.text                = ggplot2::element_text(size = 14 * scale),
      legend.key.width           = ggplot2::unit(14, "pt"),
      legend.key.height          = ggplot2::unit(8, "pt"),
      legend.key.spacing.x       = ggplot2::unit(4, "pt"),
      legend.key.spacing.y       = ggplot2::unit(0, "pt"),
      legend.margin              = ggplot2::margin(0, 0, 4, 0),
      panel.grid.minor.x = ggplot2::element_blank(),
      panel.grid.minor.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(color = cool_grey_20, linewidth = 0.4),
      strip.text         = ggplot2::element_text(
        face = "bold", size = 14 * scale, hjust = 0, color = cool_grey_90
      ),
      strip.background   = ggplot2::element_blank(),
      panel.spacing      = ggplot2::unit(16, "pt")
    )
}

# internal: re-applies only font size elements at a given scale.
# used by na_save() to adjust sizes per chart size without clobbering
# chart-type-specific theme overrides from na_theme_bar() etc.
.na_size_theme <- function(scale) {
  ggplot2::theme(
    plot.title    = ggplot2::element_text(
      size   = 19 * scale,
      margin = ggplot2::margin(b = 5.5 * scale)
    ),
    plot.subtitle = ggplot2::element_text(
      size   = 15 * scale,
      margin = ggplot2::margin(t = 2 * scale, b = 18 * scale)
    ),
    plot.caption  = ggplot2::element_text(
      size   = 12 * scale,
      margin = ggplot2::margin(t = 20 * scale)
    ),
    axis.text     = ggplot2::element_text(size = 14 * scale),
    axis.text.x   = ggplot2::element_text(margin = ggplot2::margin(t = 1 * scale)),
    axis.text.y   = ggplot2::element_text(margin = ggplot2::margin(r = 1 * scale)),
    legend.text   = ggplot2::element_text(size = 14 * scale),
    strip.text    = ggplot2::element_text(size = 14 * scale),
    legend.margin = ggplot2::margin(0, 0, 4 * scale, 0)
  )
}

#' New America zero baseline
#'
#' a [ggplot2::geom_hline()] at y = 0 styled to the brand spec (Cool Grey/50,
#' 0.4px). [na_theme_bar()] includes a baseline automatically — use this
#' directly in two cases:
#' - a non-bar chart that crosses zero (e.g., a line chart)
#' - a horizontal bar chart built with `coord_flip()` (use with
#'   `na_theme_bar(horizontal = TRUE, baseline = FALSE)`; `geom_hline` flips
#'   correctly with `coord_flip()`, whereas the bundled `geom_vline` would not)
#'
#' @return a ggplot2 layer
#' @export
na_baseline <- function() {
  ggplot2::geom_hline(yintercept = 0, color = cool_grey_50, linewidth = 0.4)
}

#' New America scatter plot theme
#'
#' extends [na_base_theme()] with x and y axis lines and no gridlines.
#' the axis frame anchors the data space without the visual noise of a grid.
#'
#' @return a ggplot2 theme object.
#' @export
na_theme_scatter <- function() {
  na_base_theme() +
    ggplot2::theme(
      axis.line.x        = ggplot2::element_line(color = cool_grey_50, linewidth = 0.4),
      axis.line.y        = ggplot2::element_line(color = cool_grey_50, linewidth = 0.4),
      panel.grid.major.y = ggplot2::element_blank()
    )
}

#' New America bar chart theme
#'
#' extends [na_base_theme()] with bar chart-specific settings. supports both
#' vertical (column) and horizontal orientations.
#'
#' **preferred approach for horizontal bars:** swap `aes()` so category is on
#' `y` and value is on `x`. ggplot2 renders bars horizontally automatically:
#' ```r
#' ggplot(df, aes(y = category, x = value)) +
#'   geom_col() +
#'   na_theme_bar(horizontal = TRUE)
#' ```
#'
#' **alternative (`coord_flip()`):** keep the default `aes()` mapping and add
#' `coord_flip()`. add [na_baseline()] manually; it uses `geom_hline()`,
#' which flips correctly with `coord_flip()`:
#' ```r
#' ggplot(df, aes(x = category, y = value)) +
#'   geom_col() +
#'   coord_flip() +
#'   na_theme_bar(horizontal = TRUE) +
#'   na_baseline()
#' ```
#'
#' @param horizontal logical. set to `TRUE` for horizontal bar charts. default `FALSE`.
#' @return a list of ggplot2 objects (theme + baseline layer)
#' @export
na_theme_bar <- function(horizontal = FALSE) {
  base <- na_base_theme()

  if (horizontal) {
    # with horizontal orientation (category on y, value on x), gridline
    # directions and axis label color assignments are inverted vs. vertical
    base <- base +
      ggplot2::theme(
        panel.grid.major.y = ggplot2::element_blank(),
        panel.grid.major.x = ggplot2::element_line(color = cool_grey_20, linewidth = 0.4),
        axis.text.x = ggplot2::element_text(color = cool_grey_50),
        axis.text.y = ggplot2::element_text(color = cool_grey_70, hjust = 0)
      )
  }

  bl <- if (horizontal) {
    ggplot2::geom_vline(xintercept = 0, color = cool_grey_50, linewidth = 0.4)
  } else {
    na_baseline()
  }
  list(base, bl)
}
