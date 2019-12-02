library(tidyverse)
library(ggrepel)
data(nasa, package="GGally")

nasa %>%
  filter(id %in% c("1-1", "10-10")) %>%
  ggplot(aes(x = time, y = temperature, group=id, colour=id)) +
  geom_line(aes(linetype=id)) +
  geom_point(size=4) +
  geom_label_repel(aes(label=year),
            data = . %>% filter( month==1)) +
  theme_bw() +
  theme(legend.key.width = unit(1.5, "cm"))

mymean <- function(x) {
  # calculate the mean of the values in x
  result <- sum(x)/length(x)
  return(result)
}

mymean <- function(x, na.rm=FALSE) {
  # calculate the mean of the values in x
  if (na.rm==TRUE) x <- na.omit(x)

  result <- sum(x)/length(x)
  result
}

library(rvest)
url <- "https://www.the-numbers.com/weekend-box-office-chart"
url <- "https://projects.economist.com/democratic-primaries-2020/"

doc <- read_html(url)
tables <- doc %>% html_table(fill=TRUE)

result <- tables[[2]]
