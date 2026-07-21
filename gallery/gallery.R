# newameRica gallery
# renders all chart type examples to gallery/output/

# run from proj root: source("gallery/gallery.R")

devtools::load_all()
library(ggplot2)
source("gallery/data.R")

na_register_fonts()
na_set_defaults()

dir.create("gallery/output", showWarnings = FALSE)

# ---------------------------------------------------------------------------
# vertical bar — standard
# ---------------------------------------------------------------------------

p_bar_v <- ggplot(ga_cat, aes(x = category, y = value)) +
  geom_col() +
  na_theme_bar() +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-vertical.png", size = "medium")

# ---------------------------------------------------------------------------
# horizontal bar
# ---------------------------------------------------------------------------

p_bar_h <- ggplot(ga_cat, aes(y = category, x = value)) +
  geom_col() +
  na_theme_bar(horizontal = TRUE) +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-horizontal.png", size = "medium")

# ---------------------------------------------------------------------------
# vertical stacked bar
# ---------------------------------------------------------------------------

p_bar_stacked_v <- ggplot(ga_cat_grouped,
                           aes(x = category, y = value, fill = group)) +
  geom_col(position = position_stack(reverse = TRUE), color = "white", linewidth = 0.3) +
  na_scale_fill_categorical() +
  na_theme_bar() +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-stacked-vertical.png", size = "medium")

# ---------------------------------------------------------------------------
# horizontal stacked bar
# ---------------------------------------------------------------------------

p_bar_stacked_h <- ggplot(ga_cat_grouped,
                           aes(y = category, x = value, fill = group)) +
  geom_col(position = position_stack(reverse = TRUE), color = "white", linewidth = 0.3) +
  na_scale_fill_categorical() +
  na_theme_bar(horizontal = TRUE) +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-stacked-horizontal.png", size = "medium")

# ---------------------------------------------------------------------------
# vertical bar — extended labels (year-based)
# ---------------------------------------------------------------------------

p_bar_annual <- ggplot(ga_annual, aes(x = year, y = value)) +
  geom_col() +
  na_theme_bar() +
  labs(
    title    = "Annual Program Enrollment",
    subtitle = "Total participants (thousands), 2019–2024",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-vertical-annual.png", size = "medium")

# ---------------------------------------------------------------------------
# vertical stacked bar — extended categorical palette (7 series)
# ---------------------------------------------------------------------------

p_stacked_ext_v <- ggplot(ga_programs, aes(x = region, y = value, fill = program)) +
  geom_col(position = position_stack(reverse = TRUE), color = "white", linewidth = 0.3) +
  na_scale_fill_categorical(extended = TRUE) +
  na_theme_bar() +
  labs(
    title    = "Program Spending by Region",
    subtitle = "Allocation across seven program areas ($M)",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-stacked-ext-vertical.png", size = "medium")

# ---------------------------------------------------------------------------
# horizontal stacked bar — extended categorical palette (7 series)
# ---------------------------------------------------------------------------

p_stacked_ext_h <- ggplot(ga_programs, aes(y = region, x = value, fill = program)) +
  geom_col(position = position_stack(reverse = TRUE), color = "white", linewidth = 0.3) +
  na_scale_fill_categorical(extended = TRUE) +
  na_theme_bar(horizontal = TRUE) +
  labs(
    title    = "Program Spending by Region",
    subtitle = "Allocation across seven program areas ($M)",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-stacked-ext-horizontal.png", size = "medium")

# ---------------------------------------------------------------------------
# single line chart
# ---------------------------------------------------------------------------

p_line <- ggplot(ga_time, aes(x = year, y = value)) +
  geom_line(linewidth = 0.8, color = na_cat_pal[1]) +
  scale_x_continuous(breaks = seq(2015, 2024, 2)) +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/line-single.png", size = "medium")

# ---------------------------------------------------------------------------
# multi-line chart
# ---------------------------------------------------------------------------

p_line_multi <- ggplot(ga_time_multi, aes(x = year, y = value, color = group)) +
  geom_line(linewidth = 0.8) +
  scale_x_continuous(breaks = seq(2015, 2024, 2)) +
  na_scale_color_categorical() +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/line-multi.png", size = "medium")

# ---------------------------------------------------------------------------
# multi-line chart — 5 series
# ---------------------------------------------------------------------------

p_five_lines <- ggplot(ga_five_lines, aes(x = year, y = value, color = group)) +
  geom_line(linewidth = 0.8) +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  na_scale_color_categorical() +
  na_baseline() +
  labs(
    title    = "Trends Across Five Groups",
    subtitle = "Cumulative index values, 2010–2024",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/line-five-series.png", size = "medium")

# ---------------------------------------------------------------------------
# scatter plot — 4 clusters
# ---------------------------------------------------------------------------

p_four_clusters <- ggplot(ga_four_clusters, aes(x = x, y = y, color = group)) +
  geom_point(size = 2.5, alpha = 0.75) +
  na_scale_color_categorical() +
  na_theme_scatter() +
  labs(
    title    = "Four-Cluster Scatter",
    subtitle = "Simulated observations across four groups",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/scatter-four-clusters.png", size = "medium")

# ---------------------------------------------------------------------------
# faceted line chart
# ---------------------------------------------------------------------------

p_facet <- ggplot(ga_time_multi, aes(x = year, y = value)) +
  geom_line(linewidth = 0.8, color = na_cat_pal[1]) +
  scale_x_continuous(breaks = seq(2015, 2024, 4)) +
  facet_wrap(~ group) +
  labs(
    title    = "Chart Title",
    subtitle = "Subtitle or supporting description goes here",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/facet-line.png", size = "large")

# ---------------------------------------------------------------------------
# sequential palette demo
# ---------------------------------------------------------------------------

p_seq <- ggplot(ga_ordered, aes(x = level, y = value, fill = level)) +
  geom_col() +
  na_scale_fill_sequential("teal", n = 4) +
  na_theme_bar() +
  labs(
    title    = "Sequential Palette — Teal (n=4)",
    subtitle = "Ordered groups, light to dark",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-sequential.png", size = "medium")

# ---------------------------------------------------------------------------
# diverging palette demo
# ---------------------------------------------------------------------------

p_div <- ggplot(ga_likert, aes(x = response, y = count, fill = response)) +
  geom_col() +
  na_scale_fill_diverging("orange_teal", n = 5) +
  na_theme_bar() +
  labs(
    title    = "Diverging Palette — Orange-Teal",
    subtitle = "Ordinal n=5 subset: flanking /80+/60, midpoint cool_grey_40",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-diverging.png", size = "medium")

# ---------------------------------------------------------------------------
# political palette demo
# ---------------------------------------------------------------------------

p_pol <- ggplot(ga_political, aes(x = party, y = value, fill = party)) +
  geom_col() +
  na_scale_fill_political() +
  na_theme_bar() +
  labs(
    title    = "Political Palette",
    subtitle = "Democrat, Republican, Independent, Swing",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-political.png", size = "medium")

# ---------------------------------------------------------------------------
# political palette — paired (before/after comparison)
# ---------------------------------------------------------------------------

p_pol_paired <- ggplot(ga_pol_paired,
                        aes(x = party, y = value, fill = fill_group)) +
  geom_col(position = position_dodge(0.7), width = 0.6) +
  scale_fill_manual(
    values = na_pol_pal_paired,
    labels = c(
      "Democrat"          = "Democrat (2024)",
      "Democrat Light"    = "Democrat (2020)",
      "Republican"        = "Republican (2024)",
      "Republican Light"  = "Republican (2020)"
    )
  ) +
  na_theme_bar() +
  labs(
    title    = "Political Palette (Paired)",
    subtitle = "Light variants for before/after or sub-group comparisons",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/bar-political-paired.png", size = "medium")

# ---------------------------------------------------------------------------
# font scale comparison — same chart at all three sizes
# used to visually tune scale values in na_save()
# ---------------------------------------------------------------------------

p_scale_test <- ggplot(ga_cat, aes(x = category, y = value)) +
  geom_col() +
  na_theme_bar() +
  labs(
    title    = "Font Scale Test",
    subtitle = "Check that text feels proportional at each size",
    caption  = "Source: Example data, newameRica gallery"
  )

na_save("gallery/output/scale-test-small.png",  size = "small",  plot = p_scale_test)
na_save("gallery/output/scale-test-medium.png", size = "medium", plot = p_scale_test)
na_save("gallery/output/scale-test-large.png",  size = "large",  plot = p_scale_test)

na_save("gallery/output/scale-test-facet-medium.png", size = "medium", plot = p_facet)
na_save("gallery/output/scale-test-facet-large.png",  size = "large",  plot = p_facet)
