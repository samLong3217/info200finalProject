library("shiny")
library("ggplot2")
source("test_scores_schools_mark.R")

my_server <- function(input, output) {
  output$line_graph <- renderPlot({
    print("accessed")
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
    print(tests)
    # selected at least one of the tests
    if (input$act | input$sat_math | input$sat_read) {
      plot <- avg_test_scores_by_interval_graph(100, tests)
    # none of the tests are selected, so this is default
    } else {
      plot <- avg_test_scores_by_interval_graph(100, c(
        "ACT.Composite.75th.percentile.score",
        "SAT.Math.75th.percentile.score",
        "SAT.Critical.Reading.75th.percentile.score"
      ))
    }
    plot
  })
}