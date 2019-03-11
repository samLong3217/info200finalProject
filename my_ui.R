library("shiny")
source("csv.R")

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

page_three <- tabPanel( #Marks's Question goes here
  "3",
  titlePanel("Income Inequality"),
  p("bla")
)

page_four <- tabPanel( #Rory's Question goes here
  "4",
  titlePanel("Do you need to be wealthy to become an astronaut"),
  
  textInput(inputId = "expense", label = "Living expense you can afford"),
  
  p("bla")
)

page_five <- tabPanel( #Sam's Question goes here
  "5",
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