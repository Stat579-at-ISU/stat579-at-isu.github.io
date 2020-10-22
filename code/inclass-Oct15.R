library(dplyr)
library(ggplot2)

library(classdata)
happiness <- happy

happiness <- happiness %>% mutate(
  nhappy = as.numeric(happy)
)

happiness %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(!is.na(nhappy))
  )

# Your Turn
# How are financial relations associated with average happiness levels?
# Is this association different for men and women?

happiness %>%
  group_by(finrela) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(!is.na(nhappy))
  ) %>%
  ggplot(aes(x = finrela, y = avg_happy)) + geom_point()

happiness %>%
  group_by(finrela, sex) %>%
  summarize(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE),
    n = n(),
    non_missing = sum(!is.na(nhappy))
  ) %>%
  ggplot(aes(x = finrela, y = avg_happy, colour=sex)) + geom_point()

################

fbi %>% head()

# highest incidence count for each state?

fbi %>% group_by(State) %>%
  summarise(
    top_count = max(Count, na.rm=TRUE)
  )

# highest incidence count for each state? which type of crime do these
# incidences report?
?which.max


fbi %>% group_by(State) %>%
  summarise(
    top_count = max(Count, na.rm=TRUE),
    type = Type[which.max(Count)]
  )

# highest three incidence counts for each state?
?sort
?rank

fbi %>%
  group_by(State, Type) %>%
  mutate(
  Rate = Count/Population*100000,
  Rank = rank((-1)*Rate)
) %>% filter(Rank <= 10)


