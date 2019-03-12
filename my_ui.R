library("shiny")

source("csv.R")

source("sam_data.R")
source("cam_data.R")


page_one <- tabPanel(
  "Introduction",
  titlePanel("Income Inequality"),
  p("bla")
  )



page_three <- tabPanel( #Marks's Question goes here
  "3",
  titlePanel("Income Inequality"),
  p("bla")
)

page_four <- tabPanel( #Rory's Question goes here
  "Is expensive to be an astronaut?",
  titlePanel("Do you need to be wealthy to become an astronaut"),
  sidebarPanel(
    p("Every child might have an astronaut dream for their future. However, becoming an astronaut is not an easy
      thing. There are so many contraints in front of you. One thing that we are curious about is whether your family
      background will affect your dream of becoming an astronaut. Therefore, we put a slider here. You can choose the
      living expense that you are able to afford for your college. The table on the right side will show how many 
      astronaut had the living expense in their college under the price you choose"),
    sliderInput(inputId = "expense", label = "Living expense you can afford for one year in college",
                           min = 0, max = 70000,value = 30000)),
 mainPanel(  textOutput(outputId = "nor_info"),
             p("In order to make reader can understand the difference easily, we also make a bar graph to provide reader
              a better visualization of the difference."),
             plotOutput(outputId = "graph"),
             tableOutput(outputId = "result"),
             textOutput(outputId = "info")
             
             )

)



my_ui <- navbarPage(
  "Astro Data",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)