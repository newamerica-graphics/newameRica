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
  active_caption <- getOption("newameRica.caption_family", "Chivo")
  message("Active font: '", active, "' ('", active_caption, "' for captions)")

  whyte <- .whyte_system_fonts()
  if (nrow(whyte) > 0) {
    message("Whyte found: ", nrow(whyte), " variant(s) in system font directories.")
    message("Call `na_register_fonts('whyte')` to switch to Whyte.")
  } else {
    message("Whyte not found in system font directories.")
    if (active == "Whyte") {
      message("Currently set to Whyte but fonts not found. Call `na_register_fonts('chivo')` to fall back to Chivo.")
    }
  }

  invisible(active)
}

#' register fonts for use with ggplot2
#'
#' switches the active New America font for the session. call once per session,
#' or add to your `.Rprofile`.
#'
#' `"whyte"` registers Whyte (by ABC Dinamo) from system font directories and
#' activates it. Whyte must be installed in `~/Library/Fonts/` or
#' `/Library/Fonts/` on macOS -- contact the design team for the font files.
#'
#' `"chivo"` (default) resets to Chivo, New America's Google Fonts fallback.
#' Chivo must be installed as a system font -- download the static files from
#' Google Fonts (fonts.google.com, search "Chivo") and install via Font Book
#' on macOS. install the static files, not the variable font.
#'
#' @param font which font to use: `"chivo"` (default) or `"whyte"`.
#' @return invisible logical. `TRUE` if successful, `FALSE` otherwise.
#' @export
na_register_fonts <- function(font = c("chivo", "whyte")) {
  font <- match.arg(font)

  if (font == "chivo") {
    options(
      newameRica.font_family    = "Chivo",
      newameRica.caption_family = "Chivo"
    )
    message("Active font set to 'Chivo'.")
    message("If charts render in the wrong font, confirm Chivo is installed and run `na_check_fonts()`.")
    return(invisible(TRUE))
  }

  # whyte path -- requires system-installed fonts
  whyte <- .whyte_system_fonts()

  if (nrow(whyte) == 0) {
    message("Whyte not found in system font directories.")
    message("Install the .otf files (ABCWhyte-*.otf) to ~/Library/Fonts/ (macOS) and restart R.")
    message("Call `na_register_fonts()` to use Chivo instead.")
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

# internal: find Whyte in standard system font directories only
.whyte_system_fonts <- function() {
  fonts    <- systemfonts::system_fonts()
  sys_dirs <- c(path.expand("~/Library/Fonts/"), "/Library/Fonts/")
  in_sys   <- Reduce(`|`, lapply(sys_dirs, function(d) startsWith(fonts$path, d)))
  fonts[fonts$family == "ABC Whyte" & in_sys, ]
}
