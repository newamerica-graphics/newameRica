#' check font registration status
#'
#' reports the currently active font family and whether Whyte is available
#' on the system. run this if charts render in the wrong font after calling
#' [na_register_fonts()].
#'
#' @return invisibly returns the active font family name.
#' @export
na_check_fonts <- function() {
  active         <- getOption("newameRica.font_family",    "Chivo")
  active_caption <- getOption("newameRica.caption_family", "Chivo Light")
  message("Active font: '", active, "' ('", active_caption, "' for captions)")

  whyte <- .whyte_system_fonts()
  if (nrow(whyte) > 0) {
    message("Whyte found: ", nrow(whyte), " variant(s) in system font directories.")
    message("Call `na_register_fonts('whyte')` to switch to Whyte.")
  } else {
    message("Whyte not found in system font directories.")
    if (active == "Whyte") {
      message("Currently set to Whyte but fonts not found. Call `na_register_fonts()` to fall back to Chivo.")
    }
  }

  invisible(active)
}

#' register fonts for use with ggplot2
#'
#' registers the active New America font with systemfonts so it is available
#' in ggplot2 via ragg. call once per R session, or add to your `.Rprofile`.
#'
#' `"chivo"` (default) uses the Chivo font bundled with this package. no
#' installation is required. `"whyte"` uses Whyte (by ABC Dinamo), which must be
#' installed in a system font directory (`~/Library/Fonts/` or `/Library/Fonts/`
#' on macOS).
#'
#' Chivo is also registered automatically when the package loads, so for most
#' users an explicit call is optional. main reasons to call this function would 
#' be: to see a confirmation message, to switch to Whyte, or to
#' re-register after a session issue:
#'
#' @param font which font to register: `"chivo"` (default, bundled) or
#'   `"whyte"` (system-installed Whyte by ABC Dinamo).
#' @return invisible logical. `TRUE` if registration succeeded, `FALSE` otherwise.
#' @export
na_register_fonts <- function(font = c("chivo", "whyte")) {
  font <- match.arg(font)

  if (font == "chivo") {
    .register_chivo(silent = FALSE)
    options(
      newameRica.font_family    = "Chivo",
      newameRica.caption_family = "Chivo Light"
    )
    return(invisible(TRUE))
  }

  # whyte path -- requires system-installed fonts
  whyte <- .whyte_system_fonts()

  if (nrow(whyte) == 0) {
    message("Whyte not found in system font directories.")
    message("Install the .otf files (ABCWhyte-*.otf) to ~/Library/Fonts/ (macOS) and restart R.")
    message("Call `na_register_fonts()` (no argument) to use the bundled Chivo font instead.")
    return(invisible(FALSE))
  }

  font_path <- function(style) {
    row <- whyte[whyte$style == style, ]
    if (nrow(row) == 0) return(NULL)
    row$path[[1]]
  }

  systemfonts::register_font(
    name       = "Whyte",
    plain      = font_path("Regular"),
    bold       = font_path("Bold"),
    italic     = font_path("Regular Italic"),
    bolditalic = font_path("Bold Italic")
  )

  systemfonts::register_font(
    name       = "Whyte Book",
    plain      = font_path("Book"),
    bold       = font_path("Medium"),
    italic     = font_path("Book Italic"),
    bolditalic = font_path("Medium Italic")
  )

  options(
    newameRica.font_family    = "Whyte",
    newameRica.caption_family = "Whyte Book"
  )

  message("Registered: 'Whyte' and 'Whyte Book'. Ready to plot.")
  message("If charts still render in the wrong font, run `na_check_fonts()` to diagnose.")
  invisible(TRUE)
}

# Internal: register bundled Chivo from inst/fonts/
.register_chivo <- function(silent = FALSE) {
  font_dir <- system.file("fonts", package = "newameRica")
  path     <- function(file) file.path(font_dir, file)

  try(systemfonts::register_font(
    name       = "Chivo",
    plain      = path("Chivo-Regular.ttf"),
    bold       = path("Chivo-Bold.ttf"),
    italic     = path("Chivo-Italic.ttf"),
    bolditalic = path("Chivo-BoldItalic.ttf")
  ), silent = TRUE)

  try(systemfonts::register_font(
    name       = "Chivo Light",
    plain      = path("Chivo-Light.ttf"),
    bold       = path("Chivo-SemiBold.ttf"),
    italic     = path("Chivo-LightItalic.ttf"),
    bolditalic = path("Chivo-SemiBoldItalic.ttf")
  ), silent = TRUE)

  if (!silent) {
    message("Registered: 'Chivo' and 'Chivo Light'. Ready to plot.")
    message("If charts still render in the wrong font, run `na_check_fonts()` to diagnose.")
  }
}

# Internal: find Whyte (family "ABC Whyte" in font metadata) in standard system font directories only
.whyte_system_fonts <- function() {
  fonts    <- systemfonts::system_fonts()
  sys_dirs <- c(path.expand("~/Library/Fonts/"), "/Library/Fonts/")
  in_sys   <- Reduce(`|`, lapply(sys_dirs, function(d) startsWith(fonts$path, d)))
  fonts[fonts$family == "ABC Whyte" & in_sys, ]
}
