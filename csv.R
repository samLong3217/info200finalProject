# This file should be source'd by all analysis files so we are working on one big, standard, csv file
library("dplyr")
library("tidyr")

astro <- read.csv("./astronauts.csv", stringsAsFactors = FALSE)
astro_trim <- select(astro, Name, Gender, Year, Alma.Mater) %>% 
  head(10L)
college <- read.csv("./college_data.csv", stringsAsFactors = FALSE)
college <- filter(college, !is.na(Applicants.total), !is.na(Admissions.total))
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
astro$Alma.Mater <- gsub("University of Colorado", "University of Colorado Boulder", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Missouri-Rolla", "University of Missouri-Columbia", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Washington", "University of Washington-Seattle Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Purdue University", "Purdue University-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Washington University", "Washington State University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Maryland", "University of Maryland-College Park", astro$Alma.Mater)
astro$Alma.Mater <- gsub("George Washington State University", "Washington State University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Texas", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Thomas Jefferson University", "Philadelphia University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("State University of New York-Buffalo", "University at Buffalo", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Tennessee", "The University of Tennessee-Knoxville", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Bowie State College", "Bowie State University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California Polytechnic Institute", "California Polytechnic State University-San Luis Obispo", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California Polytechnic State University", "California Polytechnic State University-San Luis Obispo", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California State University", "California State University-Los Angeles", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California Polytechnic State University-San Luis Obispo-San Luis Obispo", "California Polytechnic State University-San Luis Obispo", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California State University-Los Angeles-Fresno", "California State University-Los Angeles", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California State University-Los Angeles-Fullerton", "California State University-Los Angeles", astro$Alma.Mater)
astro$Alma.Mater <- gsub("California State University-Los Angeles-Northridge", "California State University-Los Angeles", astro$Alma.Mater)

astro$Alma.Mater <- gsub("Youngstown State University", "Ohio State University-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Washington & Lee University", "Washington and Lee University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Virginia Polytechnic Institute", "Virginia Polytechnic Institute and State University", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Wisconsin", "University of Wisconsin-Milwaukee", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of West Florida", "The University of West Florida", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Virginia", "University of Virginia-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Wisconsin-Milwaukee-Madison", "University of Wisconsin-Milwaukee", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of North Carolina", "University of North Carolina at Charlotte", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of New Mexico", "University of New Mexico-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Oklahoma", "University of Oklahoma-Norman Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of New Hampshire", "University of New Hampshire-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Missouri", "University of Missouri-Columbia", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Georgia Institute of Technology", "Georgia Institute of Technology-Main Campus", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Colorado State University", "Colorado State University-Fort Collins", astro$Alma.Mater)
astro$Alma.Mater <- gsub("University of Illinois", "University of Illinois at Urbana-Champaign", astro$Alma.Mater)
astro$Alma.Mater <- gsub("The University of Texas at Austin-Arlington", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("The University of Texas at Austin-Austin", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("The University of Texas at Austin-Dallas", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("The University of Texas at Austin-El Paso", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("The University of Texas at Austin Medical Branch-Galveston", "The University of Texas at Austin", astro$Alma.Mater)
astro$Alma.Mater <- gsub("Youngstown State University", "Ohio State University-Main Campus", astro$Alma.Mater)

#A vector of all possible military academies in the astro data set
military_academies <- c("US Military Academy", "US Naval Postgraduate School", "US Naval Academy", "Air Force Institute of Technology", 
                        "US Air Force Academy", "The Citadel", "US Coast Guard Academy", "US Merchant Marine Academy", "US Air Force Institute of Technology")

# Creates a new data frame containing only military academie astronauts
military_astro <- filter(astro, Alma.Mater %in% military_academies)

astro <- filter(astro, !Name %in% military_astro$Name)

astro <- filter(astro, !Name %in% c("Wright State University", "University of Sydney"))
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

# Creates a data frame of all astronauts who did not go to a school
errors <- filter(astro_college_data, Alma.Mater == "")

#Filters the joined set for na values
astro_college_data <- filter(astro_college_data, !is.na(Applicants.total))

