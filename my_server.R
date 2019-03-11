library("ggplot2")
source("cam-analysis.R")


my_server <- function(input,output) {
  output$womenBar <- renderPlot({
    members <- get_sex_number_between(input$yearRange[1], input$yearRange[2])
    out <- ggplot(data = members) +
      geom_col(mapping = aes(x = gender, y = num, fill = gender)) +
      labs(
        title = paste0("Ratio of Male to Female Astronaut Recruits for ", input$yearRange[1], "-", input$yearRange[2]),
        x = "Gender",
        y = "Recruit Number"
      )
      
    out
  })
  
  output$womenDotPlot <- renderPlot({
    tab <- get_pct_female_over_time() %>% 
      filter(numeric.50. > input$yearRange[1] & numeric.50. < input$yearRange[2])
    out <- ggplot(data = tab, aes(x = numeric.50., y = numeric.50..1)) +
      geom_line() +
      labs(
        title = paste0("Ratio of Female to Male Astronaut Recruits Over Time Between ", input$yearRange[1], "-", input$yearRange[2]),
        x = "Hire Year",
        y = "Percent Astronauts Hired who were Female"
      )
    out
  })
  
  output$womenBlurb1 <- renderText({
    pct <- get_pct_female_between(2009, 2019)
    
    out <- paste0("Here, we sought to scratch the surface of the question: What role does gender play ",
                  "in your opportunities? Namely, we tried to attack this difficult and controversial ",
                  "topic by looking into the ratio of female astronauts to male, and how that ratio ",
                  "fluctuates over time. Blatant when looking at the whole data set is that the 60s were ",
                  "not a time for females to become astronauts. Something we tried to control for ",
                  "is issues of pipeline and demand for astronauts versus systemic bias. The above graphs ",
                  "control for astronaut demand by showing the ratio of male to female (some years saw",
                  " spikes in astronaut recruitment in general)")
  })
  
  output$womenBlurb2 <- renderText({
    pct <- get_pct_female_between(2009, 2019)
    
    out <- paste0("Trying to discern between systemic ",
                  "bias and 'pipeline' issues is a harder one to answer, however. We feel comfortable ",
                  "claiming that the ZERO female participation as astronauts in the 60s was due to ",
                  "bias in the system against women. However, as the ratio begins to even out at the ",
                  "turn of the 21st Century, residing at ", pct, ", other factors need to be considered ",
                  "such as access to higher education for women (independent of blatant sexism of recruiters). ",
                  "How much does college cost? Are women there enough women pursuing Aeronautics or other",
                  "majors related to the astronaut career path? Do women have access to military academies, ",
                  "and just how important is that? ",
                  "It is some of these questions that we seek to answer in other sections of the application.")
  })
  
}

