library("shiny")

source("csv.R")

source("sam_data.R")
source("cam_data.R")


page_one <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  p("  They tell you when you're young that you can be anything you want when you grow up. 
       But is that really true?! Do things like your race, gender, economic status determine your ability
       to fulfill your youthful dreams? Are these trends changing? Our presentation seeks to examine the role 
       education plays in your ability to achieve even the most lofty of ambitions. 
       Specifically, we will be homing in on Astronauts to see what types of universities they attended. 
       This will allow us to target details such as whether the school is private or not, how much financial aid 
       is available, if many successful astronauts trend to come from particular schools, etc. In doing so, we 
       hope to expose certain biases that often go unnoticed in society, to help ensure a more equitable future 
       for us all."),
  p(strong("The question we will be looking at:")),
  p(em("• Did astronauts go to highly selective schools in the US, or not highly selective?")),
  p(em("• Are highly selective schools also schools with high test scores?")),
  p(em("• Do you need to be wealthy to become an astronaut?")),
  p(em("• What is the ratio of female astronauts to male? Is this trend changing over time?")),
  p(strong("What is the data?")),
  p(em("Our data looks at United State's college information, such as admissions and admissions scores.")),
  p(em("The astronauts data gives information on astronauts that have traveled into space under the United States.")),
  p(strong("Where did we find the Data?")),
  p(em(a("Astronaut Data", href = 'https://www.kaggle.com/nasa/astronaut-yearbook'))),
  p(em(a("College Data", href = 'https://www.kaggle.com/samsonqian/college-admissions')))
  
  )




page_three <- tabPanel( # Marks's Question goes here
  "Selective School Test Scores",
  titlePanel("Are highly selective schools also schools with high test scores?"),
  sidebarLayout(
    sidebarPanel(
      h5(a("Which Tests Do You Want To View?")),
      checkboxInput(inputId = "act", "ACT Composite", FALSE),
      checkboxInput(inputId = "sat_math", "SAT Math", FALSE),
      checkboxInput(inputId = "sat_read", "SAT Reading", FALSE),
      sliderInput(inputId = "divisions", "How Many Plots Per Test?", min = 6, max = 100, value = 10)
    ),
    mainPanel(
      plotOutput(outputId = "line_graph")
    )
  ),
  textOutput(outputId = "test_scores_text")
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