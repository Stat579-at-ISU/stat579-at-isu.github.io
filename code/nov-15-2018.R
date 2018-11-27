#devtools::install_github("heike/classdata")
library(tidyverse)
library(classdata)
head(mojo)

mojo %>% ggplot(aes(x = Week, y = `Total Gross`)) +
  geom_line(aes(group = Title)) +
  xlim(c(1,30)) +
  geom_text(aes(label=Title),
            mojo %>% filter(`Total Gross`> 5.5*10^8))

mojo %>% filter(`Total Gross`> 5.5*10^8) %>% nrow()

labels <- mojo %>% group_by(Title, Studio) %>%
  summarize(
    lastWeek = min(c(max(Week),30)),
    Total = `Total Gross`[Week == lastWeek][1]
  )
labels %>% arrange(desc(Total))

mojo %>% ggplot(aes(x = Week, y = `Total Gross`)) +
  geom_line(aes(group = Title)) +
  xlim(c(1,30)) +
  geom_text(aes(label=Title, x = lastWeek, y=Total),
            colour="grey50",
            data = labels %>% filter(Total > 5.5*10^8),
            hjust = 1.0, vjust=-0.5)

mojo %>% ggplot(aes(x = Week, y = `Total Gross`)) +
  geom_line(aes(group = Title)) +
  xlim(c(1,30)) +
  ggrepel::geom_text_repel(aes(label=Title, x = lastWeek, y=Total),
            colour="grey50",
            data = labels %>% filter(Total > 5.5*10^8))

#############
library(lubridate)

today <- "11-15-2018"
today <- "Nov 15 2018"
date <- mdy(today)
str(date)

year(date) <- 2014
month(date, label=TRUE)
yday(date)
wday(date, label=TRUE)
mdy("Nov 15 2018")
mdy("May 1 2018")
mdy("Jan 5 2018")
########################

box %>% mutate(
  wday = wday(Date)
) %>% count(wday)


summary(budget$`Release Date`)

budget %>% 
  mutate(year = year(`Release Date`),
         month = month(`Release Date`)) %>%
  filter(between(year, 2000, 2017)) %>%
  ggplot(aes(x = factor(month))) + geom_bar() +
  facet_wrap(~year)

budget %>% 
  mutate(year = year(`Release Date`),
         month = month(`Release Date`),
         wday = wday(`Release Date`, label=TRUE)) %>%
  filter(between(year, 2000, 2017)) %>%
  ggplot(aes(x = wday)) + geom_bar() +
  facet_wrap(~year)

#########################


mymean <- function(x, na.rm=FALSE) {
  if (na.rm==TRUE) {
    x <- na.omit(x)
  }
  
  return(sum(x)/length(x))
}

z <- 1:15
mymean(z)
mymean(c(4,8,10,-1))

mymean(c(4,8,10,-1, NA), na.rm=TRUE)
month
