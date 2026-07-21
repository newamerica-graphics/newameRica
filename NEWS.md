# newameRica 0.1.0

Initial release.

## Themes

* `na_base_theme()` — base ggplot2 theme implementing New America typography and spacing; includes facet strip styling (activates automatically with `facet_wrap()` / `facet_grid()`)
* `na_theme_bar()` — bar/column chart theme with horizontal support; horizontal bars use `aes(y = category, x = value)`
* `na_theme_scatter()` — scatter plot theme with axis frame and no gridlines

## Session setup

* `na_set_defaults()` — sets global ggplot2 theme and geom color defaults for the session
* `na_reset_defaults()` — reverses `na_set_defaults()`; restores `theme_gray()` and ggplot2 geom defaults
* `na_register_fonts()` — switches the active font for the session. Default (`"chivo"`) uses Chivo (install from Google Fonts). Pass `"whyte"` to use Whyte (our custom, licensed font by ABC Dinamo) from system font directories for users who have it installed.
* `na_check_fonts()` — reports which font is active and whether Whyte is available on the system

## Saving

* `na_save()` — ragg-backed PNG export at 300 DPI with named size presets: `"small"` (3.25 × 2.5 in), `"medium"` (6.5 × 4.5 in), `"large"` (9 × 6.5 in)

## Helpers

* `na_baseline()` — `geom_hline` at y = 0; bundled into `na_theme_bar()` automatically. Use directly for line charts that cross zero, or with `coord_flip()` horizontal bars

## Color system

* Categorical palettes: `na_cat_pal` (6-color), `na_ext_cat_pal` (10-color)
* Sequential palettes: teal, purple, orange — discrete (n = 2–5) or continuous gradient (omit `n`)
* Diverging palettes: orange-teal, purple-orange, blue-red — continuous or ordinal (n = 3/5/7)
* Political palette: `na_pol_pal` (Democrat, Republican, Independent, Swing); `na_pol_pal_paired` (Democrat + light variant, Republican + light variant, for before/after comparisons)
* Individual political constants: `na_pol_democrat`, `na_pol_democrat_light`, `na_pol_republican`, `na_pol_republican_light`, `na_pol_independent`, `na_pol_independent_light`, `na_pol_independent_gold`, `na_pol_independent_gold_light`, `na_pol_swing`, `na_pol_swing_dark`, `na_pol_swing_grey`
* Scale functions: `na_scale_fill_*` / `na_scale_color_*` for all palette types
* `na_null_color` — Cool Grey/20 default for missing or de-emphasized data
