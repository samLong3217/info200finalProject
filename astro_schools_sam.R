library("ggplot2")
library("scales")


source("csv.R")
# Takes in a cutoff for selective schools and schools types from the list of:
# Selective Schools, Un-Selective Schools, Military Schools, and No Schooling.
# Creates a pie chart dealing with these categories.
getPieChart <- function(cutoff, school_type) {
  selective_cutoff <- cutoff
  # Makes the selective and unselective school sets and gets how many entries are in each
  selective_set <-nrow(filter(astro_college_data, Percent.admitted...total <= selective_cutoff))
  unselective_set <-nrow(filter(astro_college_data, Percent.admitted...total > selective_cutoff))

  group <- c("Selective Schools", "Un-Selective Schools", "Military Schools", "No Schooling")

  data <- c(selective_set, unselective_set, length(military_astro$Name), length(errors$Name))
  # Creates the data frame with each piece of data
  pie_frame <- data.frame(group, data, stringsAsFactors = FALSE)
  
  # Filters groups of interest
  pie_frame <- filter(pie_frame, group %in% school_type)

  # Turns all values into percents
  total <- sum(pie_frame[, "data"])
  pie_frame[, "data"] <- pie_frame[, "data"] / total * 100
  
  pie_frame <- pie_frame %>% 
    arrange(-data) %>% 
    mutate(data_sum = cumsum(data) - 0.5 * data)
  
  pie_frame$group <- factor(pie_frame$group, levels = pie_frame$group[order(pie_frame$data)])
  print(pie_frame)
  #Creates the pie chart
  pie <- ggplot(data = pie_frame, aes(x = "", y = data, fill = group)) +
    
    geom_bar(mapping = aes(x = "", y = data, fill = group), stat = "identity", width = 1) +
    geom_text(aes(y = data_sum, label=percent(data/100))) +
    coord_polar("y", start = 0) +
    scale_fill_brewer(palette = "Pastel2") +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_blank(),
      plot.title=element_text(size=14, face="bold")
    ) +
    #geom_text(aes(x="",y = data / 3 + c(0, cumsum(data)[-length(data)]),
      #            label = percent(data/100)), size=5)  +
    
  
    labs(x = NULL, y = NULL, fill = NULL, title = "The Percentage of Astronauts and Where They Went
         to School")
  pie
}
getPieChart(60, c("Selective Schools", "Un-Selective Schools", "Military Schools", "No Schooling"))

