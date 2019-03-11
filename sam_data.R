source("csv.R")

page_five <- tabPanel(
  "Highly Selective Schools",
   sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "percent_selective", label = "Selective Schools Definition", 
                  min = 0, max = 100, value = 60),
      p("This slider determines what admission percent qualifies a school as competitive."),
      checkboxGroupInput(inputId = "school_type", label = "Types of Schools:", choices = 
                           c("Un-Selective Schools", "Selective Schools", "Military Schools",
                             "No Schooling"), selected = c("Un-Selective Schools", "Selective Schools",
                                                           "Military Schools",
                                                           "No Schooling")
      )
    ),
    mainPanel(
      plotOutput(outputId = "piePlot")

   )
   )
)