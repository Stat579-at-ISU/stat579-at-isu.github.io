library(dplyr)
library(ggplot2)

library(classdata)

head(happy)
happiness <- happy
str(happiness$happy)
levels(happiness$happy)

happiness <- happiness %>% mutate(
  nhappy = as.numeric(happy)
)
#####

summary(happiness$happy)
summary(happiness$nhappy)

happiness %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  )

##############

happy_by_age_sex <- happiness %>%
  group_by(sex, age) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  )

happy_by_age_sex %>%
  ggplot(aes(x = age, y = avg_happy, colour=sex)) + geom_point()

#### Your turn:
# are people now happier than ten years ago? How is happiness related to time?

happiness %>%
  group_by(year) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  filter(year %in% c("2016", "2006", "1996", "1986", "1976")) %>%
  ggplot(aes(x = year, y = avg_happy)) + geom_point()

###################
# Your Turn

# Are Republicans or Democrats happier? Compare average happiness levels over partyid.

happiness %>%
  group_by(partyid) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  ggplot(aes(y = partyid, x = avg_happy)) + geom_point()

happiness %>%
  group_by(partyid, sex) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  ggplot(aes(y = partyid, x = avg_happy, shape=sex)) + geom_point()

happiness %>%
  group_by(partyid, year) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  filter(non_missing >= 50) %>%
  ggplot(aes(x = year, y = avg_happy, color=partyid)) + geom_point()


# How are financial relations associated with average happiness levels?
# Is this association different for men and women?

happiness %>%
  group_by(finrela) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  ggplot(aes(x = finrela, y = avg_happy)) + geom_point()

happiness %>%
  group_by(finrela, sex) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(is.na(nhappy)==FALSE)
  ) %>%
  ggplot(aes(x = finrela, y = avg_happy, colour=sex)) + geom_point()

#  Find a plot that shows the differences for each one of the summaries.

#################
library(classdata)

fbi <- fbi %>% mutate(
  Rate = Count/Population*100000
)

fbi %>% ggplot(aes(x = Year, y = Rate)) + geom_point()

fbi %>% arrange(desc(Rate))


fbi <- fbi %>%
  mutate(
  Rate = Count/Population*100000,
  Rank = rank(-Rate)
)

fbi <- fbi %>%
  group_by(Type) %>%
  mutate(
    Rate = Count/Population*100000,
    Rank = rank(-Rate)
  )
fbi %>% filter(Rank <= 3)
