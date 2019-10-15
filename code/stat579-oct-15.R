library(tidyverse)
library(classdata)
head(happy)
happiness <- happy
# no longer necessary - the data set in the github repo is fixed
# happiness$happy should be ordered from "not to happy" to "very happy"
#happiness$happy <- factor(happiness$happy,
#                          levels = rev(levels(happiness$happy)))
happiness <- happiness %>% mutate(
  nhappy = as.numeric(happy)
)
levels(happiness$happy)

happiness %>%
  group_by(age, sex) %>%
  summarize(
    ave_happy = mean(nhappy, na.rm=TRUE),
    notNA = sum(!is.na(nhappy)),
    nNA = sum(is.na(nhappy))
  ) %>%
  ggplot(aes(x = age, y = ave_happy, colour = sex)) +
  geom_point()

happiness %>%
#  filter(year %in% c(2018, 2008)) %>%
  group_by(year) %>%
  summarize(
    ave_happy = mean(nhappy, na.rm=TRUE),
    notNA = sum(!is.na(nhappy)),
    nNA = sum(is.na(nhappy))
  ) %>%
  ggplot(aes(x = factor(year), y = ave_happy)) +
  geom_point()

?count

##################
library(classdata)
data(fbi)
head(fbi)

fbi <- fbi %>% mutate(
  Rate = Count/Population*70000
)

fbi %>% ggplot(aes(x = Type, y = Rate)) + geom_boxplot()

fbi <-fbi %>% group_by(Type)

fbi <- fbi %>% ungroup(Type) %>%
  mutate(
  Type = reorder(Type, Rate, median, na.rm=TRUE)
)

fbi %>% ggplot(aes(x = Type, y = Rate)) + geom_boxplot()

fbi %>% group_by(Year, Type) %>%
  mutate(
  Rank = rank(Rate)
) %>% filter(Year == 2014, Rank >=  47) %>%
  ggplot(aes(x = Abb)) + geom_bar()

##############

data("ChickWeight")
ChickWeight %>% ggplot(aes(x = Chick)) + geom_bar()

complete <- ChickWeight %>%
  group_by(Chick) %>%
  mutate(
    count = n()
  ) %>% filter(count == 12)


complete <- complete %>%
  group_by(Chick) %>%
  mutate(
    weight0 = weight[Time==0]
  )

complete %>%
  ggplot(aes(x = Time, y = weight-weight0, group=Chick)) +
  geom_line() +
  facet_wrap(~Diet)
