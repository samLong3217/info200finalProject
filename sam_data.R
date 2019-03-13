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
      ),
      p("These checkboxes determines which portions of the pie are displayed on the pie chart.")
    ),
    mainPanel(
      plotOutput(outputId = "piePlot"),
      p("Did astronauts go to highly selective schools in the US, or not highly selective?"),
      p("The above pie chart displays the percentage distributions of Astronauts and their respective schooling. The groups are selective colleges and universities, unselective colleges and universities, 
        military academies, and those that recieved no after high school schooling. This chart is restricted to only schools in the US and astronauts that flew for the U.S. "),
      p("For our initial analysis, we made the cutoff for selective schools to be those that only admitted 60% of students. With this analysis in mind, 48.9% of Astronauts went to competitive schools, and
        18.9% of astronauts went to not competitive schools")

   )
   )
)