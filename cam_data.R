source("csv.R")

page_two <- tabPanel( #Cameron's Question goes here
  "Women in Space",
  titlePanel("Women in Space"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "yearRange", label = "Concerning Astronauts Hired From...",
                  min = 1959, max = 2009, value = c(1959, 2009)),
      p("Select the year range you would like to look at.")
    ),
    mainPanel(
      plotOutput(outputId = "womenBar")
      
      
    )
  )
  
)