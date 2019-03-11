# By Cameron Baird
# relies on csv.R being sourced by Rmd, as well as csv.R having sourced dplyr

#USED COLUMNS: Name, Year, Gender

# Returns the percent of astronauts that are female between
# the year _start_ and _end_ (inclusive)
get_pct_female_between <- function(start, end) {
  relevant <- filter(astro_college_data, !is.na(Year)) %>% 
    filter(Year >= start) %>% 
    filter(Year <= end)
  female <- filter(relevant, Gender == "Female")
  ratio <- round(length(female$Name) / length(relevant$Name) * 100, digits = 2)
}

# Returns, in a data table, the number of male astronauts 
# and the number of female astronauts recruited from start(yr) to end
get_sex_number_between <- function(start, end) {
  relevant <- filter(astro_college_data, !is.na(Year)) %>% 
    filter(Year >= start) %>% 
    filter(Year <= end)
  males <- filter(relevant, Gender == "Male")
  females <- filter(relevant, Gender == "Female")
  
  gender <- c("Males", "Females")
  num <- c(length(males$Year), length(females$Year))
  output <- data.frame(gender, num)
  output
}


get_pct_female_over_time <- function() {
  tab = data.frame(numeric(50), numeric(50), stringsAsFactors = FALSE)
  iter <- 1
  for (year in 1959:2009) {
    tab[iter, 1] <- year
    tab[iter, 2] <- get_pct_female_between(year, year + 1)
    iter <- iter + 1
  }
  tab %>% filter(!is.nan(numeric.50..1))
}
