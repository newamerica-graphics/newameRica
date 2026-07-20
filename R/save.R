#' save a plot with New America defaults!
#'
#' a [ggplot2::ggsave()] wrapper with New America-standard export settings:
#' the ragg PNG device for correct font rendering, a white background, and
#' named size presets at 300 DPI. use the `dpi` argument to override if needed.
#'
#' ## size presets (width × height in inches, 300 DPI)
#' | `size`    | Width | Height | Pixels          |
#' |-----------|-------|--------|-----------------|
#' | `"small"` | 3.25  | 2.5    | 975 × 750 px    |
#' | `"medium"`| 6.5   | 4.5    | 1950 × 1350 px  |
#' | `"large"` | 9     | 6.5    | 2700 × 1950 px  |
#'
#' @param filename output file path. extension should be `.png`.
#' @param size named size preset: `"small"`, `"medium"` (default), or `"large"`.
#' @param height optional height override in inches. overrides the preset height
#'   while keeping the preset width.
#' @param dpi resolution in dots per inch. default 300.
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

  if (!size %in% names(widths)) {
    stop("`size` must be one of: ", paste(names(widths), collapse = ", "))
  }

  w <- widths[[size]]
  h <- if (!is.null(height)) height else heights[[size]]

  dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)

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

  invisible(filename)
}
