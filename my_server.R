library("ggplot2")
source("cam-analysis.R")
source("astro_schools_sam.R")
source("test_scores_schools_mark.R")

my_server <- function(input,output) {
  # Function that used to create the table that includes the data of astronaut who spent their 
  # living expense under selected price in the college.
  output$result <- renderTable({
    schools <- filter(astro_college_data, !is.na(Total.price.for.out.of.state.students.living.on.campus.2013.14)) %>% 
      filter(Total.price.for.out.of.state.students.living.on.campus.2013.14 < input$expense) %>% 
      select(Name, Year, Status, Birth.Date, Gender, Alma.Mater,
             Total.price.for.out.of.state.students.living.on.campus.2013.14)
     colnames(schools)[7] <- "living_expense"
     schools
    
  })
  # Function that wrote the report for the table above.
  output$info <- renderText({
      schools <- filter(astro_college_data, !is.na(Total.price.for.out.of.state.students.living.on.campus.2013.14)) %>% 
        filter(Total.price.for.out.of.state.students.living.on.campus.2013.14 < input$expense) %>% 
        select(Name, Year, Status, Birth.Date, Gender, Alma.Mater,
               Total.price.for.out.of.state.students.living.on.campus.2013.14)
      colnames(schools)[7] <- "living_expense"
      mean_price <- mean(schools$living_expense) %>% round(digits = 2)
      max_price <- max(schools$living_expense)
      min_price <- min(schools$living_expense)
      med_price <- median(schools$living_expense)
      conclusion <- paste("As we can see, there are", nrow(schools), "astronauts has their living expense under",
                          input$expense, "dollars in one year. The mean of living expense is", mean_price, "dollars. The 
                          maximum living expense among these astronauts are", max_price, "dollars. The minimum 
                          living expense among these astronauts are", min_price, "dollars. The median of 
                          the expense is", med_price, "dollars.")
      conclusion
  })
  # Function that writes an introduction which introduce some basic statistic data about normal colleges and
  # colleges that astronauts goes. 
  output$nor_info <- renderText({
    mean_nor <- mean(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE) %>% round(digits = 2)
    max_nor <- max(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    min_nor <- min(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    med_nor <- median(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    mean_price <- mean(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE) %>% round(digits = 2)
    max_price <- max(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    min_price <- min(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    med_price <- median(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    
    conclu <- paste("In order to make comparsion, we get some basic static information about all universities in US",
                    "The mean of the living expense is", mean_nor, "dollars.",
                    "The maximum of the living expense is", max_nor, "dollars.",
                    "The minimum of the living expense is", min_nor, "dollars.",
                    "The median of the living expense is", med_nor, "dollars.",
                    "We also find out the data of the college that astronauts went. For these colleges,",
                    "The mean of the living expense is", mean_price, "dollars.",
                    "The maximum of the living expense is", max_price, "dollars.",
                    "The minimum of the living expense is", min_price, "dollars.",
                    "The median of the living expense is", med_price, "dollars."
                    )
    conclu
  })
  # Function that create the bar graph which shows the difference in some statistic data
  # between normal colleges and colleges that astronaut go.
  output$graph <- renderPlot({
    mean_price <- mean(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE) %>% round(digits = 2)
    max_price <- max(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    min_price <- min(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    med_price <- median(astro_college_data$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    mean_nor <- mean(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE) %>% round(digits = 2)
    max_nor <- max(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    min_nor <- min(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    med_nor <- median(college$Total.price.for.out.of.state.students.living.on.campus.2013.14, na.rm = TRUE)
    type <- c("astro", "normal")
    mean <- c(mean_price,mean_nor)
    max <- c(max_price,max_nor)
    min <- c(min_price,min_nor)
    median <-c(med_price,med_nor)
    table_in <-data.frame(type, mean, max, min, median)
    table_in <- melt(table_in, id=c("type"))
    histogram_data<-ggplot(table_in,aes(x = variable,y = value))+
      geom_bar(aes(fill = type),stat = "identity",position = "dodge") +
      scale_fill_manual("Type of College", values = c("lightgreen","lightblue"),labels = c(" Astro college", " Normal college")) +
      labs(x="Statistic data",y="Expense $")
      histogram_data
    
  })
  
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
  
  output$piePlot <- renderPlot({getPieChart(input$percent_selective, input$school_type)})
  

  # Question 2 Renders
  
  output$line_graph <- renderPlot({
    tests <- c()
    if (input$act) {
      tests <- c(tests, "ACT.Composite.75th.percentile.score")
    }
    if (input$sat_math) {
      tests <- c(tests, "SAT.Math.75th.percentile.score")
    }
    if (input$sat_read) {
      tests <- c(tests, "SAT.Critical.Reading.75th.percentile.score")
    }
    # selected at least one of the tests
    if (input$act | input$sat_math | input$sat_read) {
      plot <- avg_test_scores_by_interval_graph(input$divisions, tests)
      # none of the tests are selected, so this is default
    } else {
      plot <- avg_test_scores_by_interval_graph(input$divisions, c(
        "ACT.Composite.75th.percentile.score",
        "SAT.Math.75th.percentile.score",
        "SAT.Critical.Reading.75th.percentile.score"
      ))
    }
    plot
  })
  
  output$test_scores_text <- renderText({
    text <- ""
    scores_df <- avg_test_scores_by_interval(input$divisions)
    if (input$act) {
      avg <- round(mean(scores_df$ACT.Composite.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average ACT Composite: ", avg, ". ")
    }
    if (input$sat_math) {
      avg <- round(mean(scores_df$SAT.Math.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average SAT Math: ", avg, ". ")
    }
    if (input$sat_read) {
      avg <- round(mean(scores_df$SAT.Critical.Reading.75th.percentile.score, na.rm = TRUE), digits = 1)
      text <- paste0(text, "Average SAT Critical Reading: ", avg, ". ")
    }
    text <- paste0(text, "Across all three tests, the line graph consistently shows a downward trend where ")
    text <- paste0(text, "college admission rate (independent variable) has an inverse relationship with ")
    text <- paste0(text, "the corresponding test scores. Also, notice when the admission rate is lower (~ 0% - 50%), ")
    text <- paste0(text, "the scores fluctuate a lot more than when the admission rate is higher. However, if we took ")
    text <- paste0(text, "the average of the fluctuating slope of any of the test scores would be negative, meaning ")
    text <- paste0(text, "that the holistic progress of the graph is that test scores decrease as admission rates ")
    text <- paste0(text, "increase. In the reality of things, this basically means that the more competitive schools ")
    text <- paste0(text, "are (lower admissions rate), the higher the scores are, which answers our question.")
  })
  
}
