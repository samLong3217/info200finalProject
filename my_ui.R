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
  h2("The question we will be looking at:"),
  tags$ul(
    tags$li("Did astronauts go to highly selective schools in the US, or not highly selective?"),
    tags$li("Are highly selective schools also schools with high test scores?"),
    tags$li("Do you need to be wealthy to become an astronaut?"),
    tags$li("What is the ratio of female astronauts to male? Is this trend changing over time?")
  ),
  h2("What is the data?"),
  p("Our data looks at United State's college information, such as admissions and admissions scores."),
  p("The astronauts data gives information on astronauts that have traveled into space under the United States."),
  h2("Where did we find the Data?"),
  p(a("Astronaut Data", href = 'https://www.kaggle.com/nasa/astronaut-yearbook')),
  p(a("College Data", href = 'https://www.kaggle.com/samsonqian/college-admissions')),
  br(),
  imageOutput("spicyImage")
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
  "Astronaut College Expenses",
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
page_six <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  p("Through these analyses, the role of college with relation to astronauts has become more clear.
    We've seen an upward trend in the hiring of female astronauts. While this trend increases, as
    we strive for more gender equality in the US, it is still not perfect. We have a ways to go."),
  p("Another Analysis we have shown is that as test scores decrease, admission rates increase. 
    This is understandable, as competitive schools would have to make more dificult decisions, choosing
    only the best of the best of students for their programs."),
  p("We also discovered the astonauts go to schools that, on average, are more expensive than other 
    schools. This could be for many factors. For one, these schools may have solid STEM programs,
    or NASA may hire directly from some of these more expensive schools."),
  p("The final concept we learned was the breakdown of schooling for astronauts. Around 42.6% of
    astonauts went to competitive schools, the most out of all categories. This result may be explained
    in much of the same way as the prior question, with these competitive schools having better
    (or considered) programs for the fields that astronauts would be interested in."),
  p("Overall, it is clear that there are multiple barriers to entry into the most desirable of
    careers. Astronauts typically go to competetive schools that, while being highly selective 
    grades-wise, may also tend to filter candidates for socioeconomic status. Our data shows that
    good schools with high-testing students, are selective schools, are expensive schools. Economic status
    presents a huge barrier in the equity of fulfilling our dreams.")
  
)


my_ui <- navbarPage(
  "Educational Opportunities And Achieving Your Dreams, by Cameron Baird, Mark Mirador, Sam Long, Ruiheng Zhang",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five,
  page_six
)