library(tidyverse)
library(classdata)
head(happy)

str(happy)

happy %>% ggplot(aes(x = happy)) + geom_bar()
levels(happy$happy)
happy <- happy %>% mutate(
  nhappy = as.numeric(happy)
)

happy %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T)
  )

happy %>%
  group_by(age, sex) %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T)
  ) %>%
  ggplot(aes(x = age, y = mean_happy, colour=sex)) +
  geom_point()
summary(happy$year)

# How many respondents were 80 years old or older?
# How many responses is each of the happiness
#   values based on?
total <- nrow(happy)
happy %>%
  filter(age >= 80) %>%
  group_by(sex) %>%
  mutate(total = n()) %>%
  group_by(age, sex) %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T),
    n = n(),
    total_perc = n/total[1]*100
  )




happy %>%
  group_by(year, sex) %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T)
  ) %>%
  ggplot(aes(x = year, y = mean_happy, colour=sex)) +
  geom_point() +
  geom_smooth(method="lm")

happy %>%
  filter(year %in% c(2006, 2016)) %>%
  group_by(year, sex) %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T)
  ) %>%
  ggplot(aes(x = factor(year), y = mean_happy, colour=sex)) +
  geom_point()

happy %>%
  filter(year %in% c(2006, 2016)) %>%
  group_by(year, sex) %>%
  summarize(
    mean_happy = mean(nhappy, na.rm=T)
  ) %>%
  ggplot(aes(x = factor(year), weight = mean_happy-1,
             fill=sex)) +
  geom_bar(position="dodge")


head(fbi)
fbi <- fbi %>% mutate(
  Rate = Count/Population*70000
)
head(fbi)

fbi %>%
  mutate(
    Type = reorder(Type,Rate , median, na.rm=T)
  ) %>%
  filter(!is.na(Rate)) %>%
  ggplot(aes(x = Type, y= Rate)) +
  geom_boxplot()

fbi %>% group_by(Year, Type) %>%
  mutate(rank = rank(-Rate)) %>%
  filter(rank <= 10) %>%
  ggplot(aes(x = Abb)) + facet_wrap(~Type) +
  geom_bar()


