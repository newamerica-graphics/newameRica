# example, toy datasets for testing newameRica gallery
# run from the project root

# single category + value (bar charts)
ga_cat <- data.frame(
  category = c("Category A", "Category B", "Category C", "Category D", "Category E"),
  value    = c(42, 67, 31, 55, 78)
)

# category + group + value (stacked/grouped bar charts)
ga_cat_grouped <- data.frame(
  category = rep(c("A", "B", "C", "D"), each = 3),
  group    = rep(c("Group 1", "Group 2", "Group 3"), times = 4),
  value    = c(20, 15, 10, 30, 25, 12, 18, 22, 8, 25, 30, 20)
)

# time + value (single line chart)
ga_time <- data.frame(
  year  = 2015:2024,
  value = c(12, 15, 14, 18, 22, 20, 25, 27, 24, 30)
)

# time + group + value (multi-line chart)
ga_time_multi <- data.frame(
  year  = rep(2015:2024, times = 3),
  group = rep(c("Group A", "Group B", "Group C"), each = 10),
  value = c(
    12, 15, 14, 18, 22, 20, 25, 27, 24, 30,
     8, 10, 12, 11, 15, 17, 16, 20, 22, 19,
     5,  7,  9,  8, 10, 12, 14, 13, 16, 18
  )
)

# ordered groups (sequential palette demo)
ga_ordered <- data.frame(
  level = factor(c("Low", "Medium-Low", "Medium-High", "High"),
                 levels = c("Low", "Medium-Low", "Medium-High", "High")),
  value = c(22, 41, 58, 74)
)

# Likert-style responses (diverging palette demo)
ga_likert <- data.frame(
  response = factor(
    c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"),
    levels = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")
  ),
  count = c(12, 18, 25, 30, 15)
)

# U.S. political groups (political palette demo)
ga_political <- data.frame(
  party = factor(c("Democrat", "Republican", "Independent", "Swing"),
                 levels = c("Democrat", "Republican", "Independent", "Swing")),
  value = c(45, 38, 10, 7)
)

# paired political: Democrat + Republican before/after comparison
# fill_group levels match na_pol_pal_paired names for direct scale_fill_manual use
ga_pol_paired <- data.frame(
  party      = rep(c("Democrat", "Republican"), each = 2),
  period     = rep(c("2020", "2024"), 2),
  fill_group = factor(
    c("Democrat Light", "Democrat", "Republican Light", "Republican"),
    levels = c("Democrat", "Democrat Light", "Republican", "Republican Light")
  ),
  value = c(46, 51, 52, 45)
)

# single-series vertical bar with year labels
ga_annual <- data.frame(
  year  = factor(2019:2024),
  value = c(42, 38, 51, 58, 63, 70)
)

# extended stacked: 4 regions × 7 program areas
ga_programs <- data.frame(
  region  = rep(c("East", "South", "Midwest", "West"), each = 7),
  program = rep(c("Program 1", "Program 2", "Program 3", "Program 4",
                  "Program 5", "Program 6", "Program 7"), times = 4),
  value   = c(
    18, 22, 15, 25, 12,  8, 10,
    20, 19, 17, 23, 14,  9, 11,
    16, 20, 19, 21, 16, 11, 12,
    22, 25, 16, 24, 18, 10, 13
  )
)
ga_programs$region  <- factor(ga_programs$region,  levels = c("East", "South", "Midwest", "West"))
ga_programs$program <- factor(ga_programs$program, levels = c(
  "Program 1", "Program 2", "Program 3", "Program 4", "Program 5", "Program 6", "Program 7"
))

# 5 groups over time — stress-testing multi-line and the categorical palette
set.seed(7)
ga_five_lines <- data.frame(
  year  = rep(2010:2024, times = 5),
  group = rep(c("Group A", "Group B", "Group C", "Group D", "Group E"), each = 15),
  value = c(
    cumsum(c(10, rnorm(14, 0.8, 1.2))),
    cumsum(c(8,  rnorm(14, 0.5, 1.0))),
    cumsum(c(6,  rnorm(14, 0.4, 1.4))),
    cumsum(c(4,  rnorm(14, 0.6, 0.9))),
    cumsum(c(2,  rnorm(14, 0.3, 1.1)))
  )
)

# 4-cluster scatter
set.seed(42)
ga_four_clusters <- data.frame(
  x = c(rnorm(25, 1.5, 0.35), rnorm(25, 4.0, 0.4),
        rnorm(25, 2.5, 0.4),  rnorm(25, 5.5, 0.35)),
  y = c(rnorm(25, 15,  2.5),  rnorm(25, 50,  3.5),
        rnorm(25, 35,  3),     rnorm(25, 25,  2.5)),
  group = rep(c("Group A", "Group B", "Group C", "Group D"), each = 25)
)

# two numeric variables + group (scatter) — three clusters
set.seed(42)
ga_scatter <- data.frame(
  x = c(rnorm(18, mean = 2.5, sd = 0.4),
        rnorm(18, mean = 5.5, sd = 0.5),
        rnorm(18, mean = 4.0, sd = 0.4)),
  y = c(rnorm(18, mean = 20,  sd = 3),
        rnorm(18, mean = 55,  sd = 4),
        rnorm(18, mean = 38,  sd = 3)),
  group = rep(c("Group A", "Group B", "Group C"), each = 18)
)
