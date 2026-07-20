#' set New America ggplot2 defaults for the session
#'
#' call once per session to:
#' - set the global ggplot2 theme to [na_base_theme()]
#' - set default geom colors to New America Teal/50
#'
#' geom-specific scale functions (e.g., [na_scale_fill_categorical()]) override
#' these defaults when multiple colors are needed.
#'
#' @return invisibly returns `NULL`. called for side effects.
#' @export
na_set_defaults <- function() {
  ggplot2::theme_set(na_base_theme())

  ggplot2::update_geom_defaults("bar",     list(fill   = teal_50))
  ggplot2::update_geom_defaults("col",     list(fill   = teal_50))
  ggplot2::update_geom_defaults("point",   list(colour = teal_50))
  ggplot2::update_geom_defaults("line",    list(colour = teal_50))
  ggplot2::update_geom_defaults("step",    list(colour = teal_50))
  ggplot2::update_geom_defaults("path",    list(colour = teal_50))
  ggplot2::update_geom_defaults("boxplot", list(fill   = teal_50))
  ggplot2::update_geom_defaults("density", list(fill   = teal_50))

  invisible(NULL)
}

#' reset ggplot2 defaults to base ggplot2
#'
#' reverses [na_set_defaults()]: restores `theme_gray()` and resets geom
#' colors to ggplot2's built-in defaults. useful when switching between
#' New America branded and unbranded output in the same R session.
#'
#' @return invisibly returns `NULL`. called for side effects.
#' @export
na_reset_defaults <- function() {
  ggplot2::theme_set(ggplot2::theme_gray())

  ggplot2::update_geom_defaults("bar",     list(fill   = "grey35"))
  ggplot2::update_geom_defaults("col",     list(fill   = "grey35"))
  ggplot2::update_geom_defaults("point",   list(colour = "black"))
  ggplot2::update_geom_defaults("line",    list(colour = "black"))
  ggplot2::update_geom_defaults("step",    list(colour = "black"))
  ggplot2::update_geom_defaults("path",    list(colour = "black"))
  ggplot2::update_geom_defaults("boxplot", list(fill   = "white"))
  ggplot2::update_geom_defaults("density", list(fill   = NA))

  invisible(NULL)
}
