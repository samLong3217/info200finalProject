library("shiny")
source("sam_data.R")

page_one <- tabPanel(
  "Introduction",
  titlePanel("Income Inequality"),
  p("bla")
  )

page_two <- tabPanel( #Cameron's Question goes here
  "2",
  titlePanel("Income Inequality"),
  p("bla")
)

page_three <- tabPanel( # Marks's Question goes here
  "3",
  titlePanel("Are highly selective schools also schools with high test scores?"),
  sidebarLayout(
    sidebarPanel(
      h5(a("Which Tests Do You Want To View?")),
      checkboxInput(inputId = "act", "ACT Composite", FALSE),
      checkboxInput(inputId = "sat_math", "SAT Math", FALSE),
      checkboxInput(inputId = "sat_read", "SAT Reading", FALSE),
      sliderInput(inputId = "divisions", "How Many Plots Per Test?", min = 0, max = 100, value = 10)
    ),
    mainPanel(
      plotOutput(outputId = "line_graph")
    )
  ),
  textOutput(outputId = "test_scores_text")
)

page_four <- tabPanel( #Rory's Question goes here
  "4",
  titlePanel("Income Inequality"),
  p("bla")
)



my_ui <- navbarPage(
  "Astro Data",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)