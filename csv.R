# This file should be source'd by all analysis files so we are working on one big, standard, csv file
library("dplyr")
library("tidyr")

astro <- read.csv("./astronauts.csv", stringsAsFactors = FALSE)
astro_trim <- select(astro, Name, Gender, Year, Alma.Mater) %>% 
  head(10L)
college <- read.csv("./college_data.csv", stringsAsFactors = FALSE)
college_trim <- select(college, Name, Percent.admitted...total, SAT.Math.75th.percentile.score,
                       SAT.Math.75th.percentile.score,
                       SAT.Writing.75th.percentile.score,
                       ACT.Composite.75th.percentile.score,
                       Total.price.for.out.of.state.students.living.on.campus.2013.14) %>%
  head(10L)

# creates new row that is a copy of the original row, with the new ; delimited college changed
astro <- separate_rows(astro, Alma.Mater, sep = "; ") 
#Add new changes to universities as needed
astro$Alma.Mater <- gsub("MIT", "Massachusetts Institute of Technology", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Illinois-Urbana", "University of Illinois at Urbana-Champaign", astro$Alma.Mater)

# appends information about alma mater of astronaut to astronauts' entries
# also serves purpose of filtering out colleges that no recorded astronaut went to

# if you want to correlate information about the astronaut (age, gender, etc) to the
# type of school he/she attended, you use this:
astro_college_data <- left_join(astro, college, by = c("Alma.Mater" = "Name"))
# if you want to take the average of colleges attended by astronauts, you don't want
# to count duplicates, so use this:
unique_attended_colleges <- filter(college, Name %in% astro_college_data$Alma.Mater)
# if you want to take the average of colleges NOT attended by astronauts (to compare to above, perhaps)
# you use this:
no_astronaut_colleges <- filter(college, !(Name %in% astro_college_data$Alma.Mater))

