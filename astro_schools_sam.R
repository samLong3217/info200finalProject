library("ggplot2")
library("scales")


source("csv.R")
getPieChart <- function(cutoff, school_type) {
  print(school_type)
  selective_cutoff <- cutoff
  #print(selective_cutoff)
  selective_set <-nrow(filter(astro_college_data, Percent.admitted...total <= selective_cutoff))
  unselective_set <-nrow(filter(astro_college_data, Percent.admitted...total > selective_cutoff))
  selective_ratio <- round(100 * selective_set / nrow(astro))
  #View(astro_college_data)
  #unselective_set <-nrow(filter(astro_college_data, Percent.admitted...total > selective_cutoff))
  #unselective_ratio <- round(100 * unselective_set / nrow(astro))
  group <- c("Selective Schools", "Un-Selective Schools", "Military Schools", "No Schooling")
  #c("Un-Selective Schools", "Selective Schools", "Military Schools", "No Schooling")
  #data <- c(selective_ratio, 72 - selective_ratio, 28)
  data <- c(selective_set, unselective_set, length(military_astro$Name), length(errors$Name))
  pie_frame <- data.frame(group, data, stringsAsFactors = FALSE)
  #View(pie_frame)
  pie_frame <- filter(pie_frame, group %in% school_type)
  #print(pie_frame)
  total <- sum(pie_frame[, "data"])
  pie_frame[, "data"] <- pie_frame[, "data"] / total * 100
  #View(pie_frame)
  pie <- ggplot(data = pie_frame) +
    geom_col(mapping = aes(x = "", y = data, fill = group), width = 1) +
    coord_polar("y", start = 0) +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_blank()
    ) +
    geom_text(aes(x="",y = data / 3 + c(0, cumsum(data)[-length(data)]),
                  label = percent(data/100)), size=5) +
    labs(
      title = "Percent of U.S. Astronauts and Their Respective Schooling" #WHY IS THIS NOT WORKING
    )
  pie
}


