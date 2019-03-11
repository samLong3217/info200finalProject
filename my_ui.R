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

page_three <- tabPanel( #Marks's Question goes here
  "3",
  titlePanel("Income Inequality"),
  p("bla")
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