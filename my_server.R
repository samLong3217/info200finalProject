

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

}
