library("ggplot2")
library("scales")
getPieChart <- function(cutoff, groups) {
  selective_cutoff <- cutoff
  selective_set <-nrow(filter(astro_college_data, Percent.admitted...total <= selective_cutoff))
  selective_ratio <- round(100 * selective_set / nrow(astro))
  
  unselective_set <-nrow(filter(astro_college_data, Percent.admitted...total > selective_cutoff))
  unselective_ratio <- round(100 * unselective_set / nrow(astro))
  group <- c("Selective Schools", "Non-Selective Schools", "Military Academies")
  data <- c(selective_ratio, 72 - selective_ratio, 28)
  pie_frame <- data.frame(group, data, stringsAsFactors = FALSE)
  
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
                  label = percent(data/100)), size=5)
    pie
}