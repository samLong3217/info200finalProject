library("shiny")
library("ggplot2")
source("astro_schools_sam.R")
my_server <- function(input,output) {
  output$piePlot <- renderPlot({getPieChart(input$percent_selective, input$school_type)})
  
}