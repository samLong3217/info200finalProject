library("ggplot2")
source("cam-analysis.R")


my_server <- function(input,output) {
  output$womenBar <- renderPlot({
    members <- get_sex_number_between(input$yearRange[1], input$yearRange[2])
    out <- ggplot(data = members) +
      geom_col(mapping = aes(x = gender, y = num, fill = gender)) +
      labs(
        title = paste0("Ratio of Male to Female Astronaut Recruits for ", input$yearRange[1], "-", input$yearRange[2]),
        x = "Gender",
        y = "Recruit Number"
      )
      
    out
  })
  
  output$womenBlurb <- renderText({
    pct <- get_pct_female_between(input$yearRange[1], input$yearRange[2])
  })
  
}

