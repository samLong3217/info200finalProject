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

get_sex_number_between <- function(start, end) {
  relevant <- filter(astro_college_data, !is.na(Year)) %>% 
    filter(Year >= start) %>% 
    filter(Year <= end)
  males <- filter(relevant, Gender == "Male")
  females <- filter(relevant, Gender == "Female")
  
  output <- list(length(males$Year), length(females$Year))
  names(output) <- c("num_males_recruited", "num_females_recruited")
  output
}

print(get_sex_number_between(1959, 2000))
