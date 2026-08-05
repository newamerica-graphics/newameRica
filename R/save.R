#' save a plot with New America defaults
#'
#' a [ggplot2::ggsave()] wrapper with New America-standard export settings:
#' named size presets, a white background, and the correct device for the
#' output format. PNG uses ragg for correct font rendering; SVG uses svglite.
#' format is detected automatically from the filename extension.
#'
#' ## size presets (width × height in inches)
#' | `size`    | Width | Height | PNG at 300 DPI  |
#' |-----------|-------|--------|-----------------|
#' | `"small"` | 3.25  | 2.5    | 975 × 750 px    |
#' | `"medium"`| 6.5   | 4.5    | 1950 × 1350 px  |
#' | `"large"` | 9     | 6.5    | 2700 × 1950 px  |
#'
#' @param filename output file path. use `.png` or `.svg` extension.
#' @param size named size preset: `"small"`, `"medium"` (default), or `"large"`.
#' @param height optional height override in inches. overrides the preset height
#'   while keeping the preset width.
#' @param dpi resolution in dots per inch. default 300. ignored for SVG.
#' @param plot the plot to save. defaults to the last plot displayed.
#' @return the `filename`, invisibly.
#' @export
na_save <- function(filename,
                    size   = "medium",
                    height = NULL,
                    dpi    = 300,
                    plot   = ggplot2::last_plot()) {
  widths  <- c(small = 3.25, medium = 6.5, large = 9)
  heights <- c(small = 2.5,  medium = 4.5, large = 6.5)
  scales  <- c(small = 0.45, medium = 0.75, large = 1.0)

  if (!size %in% names(widths)) {
    stop("`size` must be one of: ", paste(names(widths), collapse = ", "))
  }

  w   <- widths[[size]]
  h   <- if (!is.null(height)) height else heights[[size]]
  ext <- tolower(tools::file_ext(filename))

  plot <- plot + .na_size_theme(scales[[size]])

  dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)

  if (ext == "svg") {
    ggplot2::ggsave(
      filename = filename,
      plot     = plot,
      device   = svglite::svglite,
      width    = w,
      height   = h,
      units    = "in",
      bg       = "white"
    )
  } else {
    ggplot2::ggsave(
      filename = filename,
      plot     = plot,
      device   = ragg::agg_png,
      width    = w,
      height   = h,
      units    = "in",
      dpi      = dpi,
      bg       = "white"
    )
  }

  invisible(filename)
}
