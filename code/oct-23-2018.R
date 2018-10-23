library(ggplot2)
library(tidyverse)
data("ChickWeight")

ChickWeight %>% 
  ggplot(aes(x = Time, y = weight, colour=Diet, 
             group=Chick)) +
  geom_point() +
  facet_grid(Diet~.) +
  geom_line()

maxies <- ChickWeight %>% group_by(Diet) %>% 
  filter(Time == 21, weight == max(weight))

ChickWeight %>% 
#  filter(Chick %in% c(7, 21, 35, 48)) %>% # same as below
  filter(Chick %in% maxies$Chick) %>%
  ggplot(aes(x = Time, y = weight, 
             group = Chick, colour = Diet)) +
  geom_line() 


ChickWeight %>% group_by(Diet, Time) %>%
  mutate(
    rank = rank(-weight)
  ) %>% filter(rank == 1, Time == 21)


ChickWeight %>% group_by(Time, Diet) %>%
  summarize(
    meanweight = mean(weight, na.rm=FALSE)
  ) %>%
  ggplot(aes(x = Time, y = meanweight, colour = Diet)) +
  geom_line()


ChickWeight %>% filter(Time==0) %>%
  ggplot(aes(x = Diet, fill=Diet, weight=weight)) + 
  geom_bar()

levels(ChickWeight$Diet)
ChickWeight <- ChickWeight %>% mutate(
  Diet = factor(Diet, levels=c("3", "4", "2", "1"))
)
levels(ChickWeight$Diet)

ChickWeight %>% filter(Time==0) %>%
  ggplot(aes(x = Diet, fill=Diet, weight=weight)) + 
  geom_bar()

###########################
data(french_fries, package="reshape2")

french_fries %>% 
  ggplot(aes(x = time, y = potato)) + 
  geom_point()

french_fries %>% 
  ggplot(aes(x = time, y = potato)) + 
  geom_boxplot()


french_fries %>% 
  ggplot(aes(x = time, y = rancid)) + 
  geom_boxplot()

head(french_fries)

library(tidyr)
ffl <- french_fries %>% gather(key=scale, value=score, 
                        potato, buttery, grassy, 
                        rancid, painty)

ffl <- french_fries %>% gather(key=scale, value=score,
                               potato:painty)
ffl %>% head()
