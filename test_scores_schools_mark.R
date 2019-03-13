# By Mark Mirador
# Uses college_data.csv to collect data

# Question of Focus: Are highly selective schools also schools with high test scores?

library("tidyr")
library("dplyr")
library("ggplot2")
source("csv.R")

# This function returns a data table containing all the colleges with their scores (SAT/ACT) and admission rates
# given they are within the admission_rate_low and admission_rate_high boundaries. Chose 75th percentile, since
# it reveals the more competitive portion of students at a specific college
test_scores_of_schools <- function(admission_rate_low, admission_rate_high) {
  colleges_with_admission_rate <- college %>%
    # filters out colleges in admission rate range || == NA
    filter(Percent.admitted...total >= admission_rate_low & Percent.admitted...total < admission_rate_high ) %>%
    select(Name, Percent.admitted...total,
           SAT.Critical.Reading.75th.percentile.score, SAT.Math.75th.percentile.score,
           ACT.Composite.75th.percentile.score) %>%
    filter(!is.na(SAT.Critical.Reading.75th.percentile.score), !is.na(SAT.Math.75th.percentile.score),
           !is.na(ACT.Composite.75th.percentile.score))
}

# This function returns a data frame containing the average scores (SAT/ACT) of students within specific bins defined
# by a range of admission rates of colleges. The interval of the bins is defined by the number of divisions passed
# to the function. For example, if divisions == 2, then the interval is 50 with two bins [0, 50) and [50, 100) where
# low is inclusive and high is exclusive given [low, high)
avg_test_scores_by_interval <- function(divisions) {
  interval = 100 / divisions
  lo = 0
  hi = interval
  bins <- data.frame(stringsAsFactors = FALSE) # empty frame that we will build up
  while (hi <= 100) {
    bin <- test_scores_of_schools(lo, hi) %>%
      summarize(
        Percent.admitted...total = mean(Percent.admitted...total),
        SAT.Critical.Reading.75th.percentile.score = mean(SAT.Critical.Reading.75th.percentile.score),
        SAT.Math.75th.percentile.score = mean(SAT.Math.75th.percentile.score),
        ACT.Composite.75th.percentile.score = mean(ACT.Composite.75th.percentile.score)
      )
    if (length(bins) == 0) { # empty data frame case
      bins <- bin
    } else {
      bins <- data.frame(
        Percent.admitted...total <- c(bins$Percent.admitted...total, bin$Percent.admitted...total),
        SAT.Critical.Reading.75th.percentile.score <- c(bins$SAT.Critical.Reading.75th.percentile.score, bin$SAT.Critical.Reading.75th.percentile.score),
        SAT.Math.75th.percentile.score <- c(bins$SAT.Math.75th.percentile.score, bin$SAT.Math.75th.percentile.score),
        ACT.Composite.75th.percentile.score <- c(bins$ACT.Composite.75th.percentile.score, bin$ACT.Composite.75th.percentile.score),
        stringsAsFactors = FALSE
      )
    }
    lo = lo + interval
    hi = hi + interval
  }
  bins <- filter(bins,
                 !is.na(bins$Percent.admitted...total),
                 !is.na(SAT.Critical.Reading.75th.percentile.score),
                 !is.na(SAT.Math.75th.percentile.score),
                 !is.na(ACT.Composite.75th.percentile.score))
  colnames(bins) = c(
    "Percent.admitted...total",
    "SAT.Critical.Reading.75th.percentile.score",
    "SAT.Math.75th.percentile.score",
    "ACT.Composite.75th.percentile.score"
  )
  bins
}

# Basically the line graph version of avg_test_scores_by_interval; takes in tests as well,
# which is expected to be a vector of strings of test types
avg_test_scores_by_interval_graph <- function(divisions, tests) {
  data <- avg_test_scores_by_interval(divisions)
  # gather data so we can group the lines
  data <- data %>%
    gather(
      key = test_type,
      value = score,
      -Percent.admitted...total
    ) %>%
    filter(test_type == tests)
  plot <- ggplot(data = data, aes(
      x = Percent.admitted...total,
      y = score,
      group = test_type
    )) +
    geom_line(mapping = aes(
      color = test_type
    )) +
    geom_point(mapping = aes(
      color = test_type
    )) +
    labs(
      title = "Admission Rate (%) vs. Test Scores",
      x = "Admission Rate (%)",
      y = "Test Score"
    )
  plot
}

View(avg_test_scores_by_interval(100))
