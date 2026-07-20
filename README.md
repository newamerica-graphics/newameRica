# newameRica

A ggplot2 theme and color palette system implementing New America's data visualization brand guidelines.

## Prerequisites

- R ≥ 4.1
- ggplot2 ≥ 3.5.0
- Packages: `ggplot2`, `ragg`, `systemfonts` (installed automatically as dependencies)

No font installation required — **Chivo** (New America's fallback Google Font) is bundled with the package and registered automatically on load.

## Installation

```r
# Install from GitHub
devtools::install_github("newamerica-graphics/newameRica")
```

## Quick start

```r
library(newameRica)
library(ggplot2)

# Once per session: set ggplot2 defaults (Chivo is registered automatically on load)
na_set_defaults()

# Single-series bar chart — teal fill and zero baseline applied automatically
ggplot(df, aes(x = category, y = value)) +
  geom_col() +
  na_theme_bar() +
  labs(title = "Chart Title", caption = "Source: ...")

na_save("output/chart.png")
```

## Session setup

Call this once at the top of every script or in your `.Rprofile`:

```r
na_set_defaults()  # sets global theme and teal defaults for all geoms
```

Chivo is registered automatically when the package loads, so no additional font setup is required. 

However, to use our custom, licensed font, Whyte, you will need to register it directly. Please use Whyte if you are preparing charts for publications. Here's how to register:

```r
na_register_fonts("whyte")  # registers Whyte + Whyte Book and activates them
```

To restore ggplot2's default theme and geom colors (e.g., if switching between branded and unbranded chart outputs in the same session):

```r
na_reset_defaults()
```

## Themes

| Function | Use for |
|---|---|
| `na_base_theme()` | Base theme — applied automatically by `na_set_defaults()` |
| `na_theme_bar()` | Vertical and horizontal bar/column charts |
| `na_theme_scatter()` | Scatter plots |

### Vertical bar charts

```r
ggplot(df, aes(x = category, y = value)) +
  geom_col() +
  na_theme_bar()
```

### Horizontal bar charts

The preferred approach is to swap the `aes()` mapping so the category is on `y` and the value is on `x`. ggplot2 renders bars horizontally automatically:

```r
ggplot(df, aes(y = category, x = value)) +
  geom_col() +
  na_theme_bar(horizontal = TRUE)
```

Alternatively, `coord_flip()` also works. Add `na_baseline()` manually in this case.

```r
ggplot(df, aes(x = category, y = value)) +
  geom_col() +
  coord_flip() +
  na_theme_bar(horizontal = TRUE) +
  na_baseline()
```

### Faceted charts

Facet strip styling (bold left-aligned labels, panel spacing) is included in `na_base_theme()` and activates automatically when `facet_wrap()` or `facet_grid()` is used.

## Color scales

### Categorical

```r
# Up to 6 categories
na_scale_fill_categorical()
na_scale_color_categorical()

# 7–10 categories
na_scale_fill_categorical(extended = TRUE)
na_scale_color_categorical(extended = TRUE)
```

### Sequential

Three palettes (`"teal"`, `"purple"`, `"orange"`). Supply `n` for a discrete stepped scale; omit `n` for a continuous gradient:

```r
na_scale_fill_sequential("teal", n = 4)    # discrete: 4 ordered steps
na_scale_color_sequential("orange", n = 3) # discrete: 3 ordered steps
na_scale_fill_sequential("purple")         # continuous gradient
```

### Diverging

Three palettes (`"orange_teal"`, `"purple_orange"`, `"blue_red"`). Omit `n` for a continuous 15-color gradient; supply `n` = 3, 5, or 7 for ordinal/Likert subsets:

```r
na_scale_fill_diverging("orange_teal", n = 5)
```

### Political

Reserved for U.S. political data. `na_scale_fill_political()` handles four parties; factor levels must match `"Democrat"`, `"Republican"`, `"Independent"`, `"Swing"`:

```r
na_scale_fill_political()
```

For before/after or sub-group comparisons using Democrat and Republican pairs, use `na_pol_pal_paired` directly with `scale_fill_manual()`:

```r
scale_fill_manual(values = na_pol_pal_paired)
# Includes: Democrat, Democrat Light, Republican, Republican Light
```

Individual political color constants are exported for building more complex combinations. Please refer to the brand guide or reach out to Comms for guidance!

```r
na_pol_democrat          # #037de3 — Democrat primary
na_pol_democrat_light    # #9fccfe — Democrat light variant
na_pol_republican        # #d53b58 — Republican primary
na_pol_republican_light  # #fdb0b4 — Republican light variant
na_pol_independent       # #494b4b — Independent (dark grey)
na_pol_independent_light # #acb2b3 — Independent light
na_pol_independent_gold  # #bb8f09 — Independent gold accent
na_pol_independent_gold_light  # #fade62 — Independent gold light
na_pol_swing             # #be9df8 — Swing/toss-up primary
na_pol_swing_dark        # #5821a2 — Swing dark accent
na_pol_swing_grey        # #acb2b3 — Swing neutral (same as independent_light)
```

Use grey for only one political group at a time (Independent, or Swing).

## Saving charts

```r
na_save("output/chart.png", size = "medium")
```

`na_save()` uses the `ragg` device for correct font rendering. Always use it instead of `ggsave()` directly. All exports are 300 DPI by default. Use the `dpi` argument to override if needed.

### Size presets (300 DPI)

| `size` | Width | Height | Pixels |
|---|---|---|---|
| `"small"` | 3.25 in | 2.5 in | 975 × 750 px |
| `"medium"` | 6.5 in | 4.5 in | 1950 × 1350 px |
| `"large"` | 9 in | 6.5 in | 2700 × 1950 px |

Use the `height` argument to override the preset height while keeping the preset width.

## Helpers

```r
na_baseline()     # geom_hline at y = 0; bundled into na_theme_bar() automatically —
                  # use directly for line charts that cross zero, or with coord_flip()
na_check_fonts()  # report active font and whether Whyte is available on the system
```

## Palette reference

```r
na_cat_pal      # 6-color categorical palette (vector of hex values)
na_ext_cat_pal  # 10-color extended categorical palette

na_div_orange_teal    # 15-color diverging ramp
na_div_purple_orange
na_div_blue_red

na_pol_pal        # Named political palette (Democrat, Republican, Independent, Swing)
na_pol_pal_paired # Named paired palette (Democrat + light, Republican + light)
na_null_color     # Cool Grey/20 — default for missing or deemphasized data
```

## Font notes

**Chivo** (bundled, default) is registered automatically when the package loads, without any explicit setup needed.

**Whyte** (New America's primary brand font, by ABC Dinamo) can be used instead by users who have it installed. Install the `.otf` files (named `ABCWhyte-*.otf`) via Font Book on macOS, then call:

```r
na_register_fonts("whyte")
```

This registers `"Whyte"` (Regular) and `"Whyte Book"` (Book weight for captions) and switches all subsequent theme calls to use them. To switch back to Chivo in the same session:

```r
na_register_fonts()   # or na_register_fonts("chivo")
```

Run `na_check_fonts()` at any time to see which font is active and whether Whyte is available on your system.
