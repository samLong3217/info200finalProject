library("shiny")
library("ggplot2")
source("test_scores_schools_mark.R")

my_server <- function(input, output) {
  
  output$line_graph <- renderPlot({
    tests <- c()
    if (input$act) {
      tests <- c(tests, "ACT.Composite.75th.percentile.score")
    }
    if (input$sat_math) {
      tests <- c(tests, "SAT.Math.75th.percentile.score")
    }
    if (input$sat_read) {
      tests <- c(tests, "SAT.Critical.Reading.75th.percentile.score")
    }
    # selected at least one of the tests
    if (input$act | input$sat_math | input$sat_read) {
      plot <- avg_test_scores_by_interval_graph(input$divisions, tests)
    # none of the tests are selected, so this is default
    } else {
      plot <- avg_test_scores_by_interval_graph(input$divisions, c(
        "ACT.Composite.75th.percentile.score",
        "SAT.Math.75th.percentile.score",
        "SAT.Critical.Reading.75th.percentile.score"
      ))
    }
    plot
  })
  
  output$test_scores_text <- renderText({
    text <- ""
    scores_df <- avg_test_scores_by_interval(input$divisions)
    if (input$act) {
      avg <- round(mean(scores_df$ACT.Composite.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average ACT Composite: ", avg, ". ")
    }
    if (input$sat_math) {
      avg <- round(mean(scores_df$SAT.Math.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average SAT Math: ", avg, ". ")
    }
    if (input$sat_read) {
      avg <- round(mean(scores_df$SAT.Critical.Reading.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average SAT Critical Reading: ", avg, ". ")
    }
    text <- paste0(text, "Across all three tests, the line graph consistently shows a downward trend where ")
    text <- paste0(text, "college admission rate (independent variable) has an inverse relationship with ")
    text <- paste0(text, "the corresponding test scores. Also, notice when the admission rate is lower (~ 0% - 50%), ")
    text <- paste0(text, "the scores fluctuate a lot more than when the admission rate is higher. However, if we took ")
    text <- paste0(text, "the average of the fluctuating slope of any of the test scores would be negative, meaning ")
    text <- paste0(text, "that the holistic progress of the graph is that test scores decrease as admission rates ")
    text <- paste0(text, "increase. In the reality of things, this basically means that the more competitive schools ")
    text <- paste0(text, "are (lower admissions rate), the higher the scores are, which answers our question.")
  })
}