library(classdata)
library(dplyr)

fbiwide %>% select(starts_with("A"), starts_with("B"), last_col(offset=3))

# Your turn
# Use the fbiwide data set from the classdata package

# Write out at least three different ways of selecting all variables describing incidences of different types of crimes
head(fbiwide)

fbiwide %>% select(5:12)
fbiwide %>% select(-(1:4))
fbiwide %>% select(-Population, -Year, -State, -Abb)
fbiwide %>% select(Murder:Motor.vehicle.theft)
fbiwide %>% select(!c(Population, Year, State, Abb))
fbiwide %>% select(!c("Population", "Year", "State", "Abb"))

# select is like square brackets selection, where we select columns

fbi <- fbi %>%
  mutate(
    Rate = Count/Population*100000
  )

fbi %>%
  group_by(Abb, Type) %>%
  summarise(
    mean_rate = mean(Rate, na.rm=TRUE),
    sd_rate = sd(Rate, na.rm = TRUE)
    )


############
# your turn

# how many variables, how many observations does the data have? What do the variables mean?

dim(happy)

# Plot the variable happy.
happy %>%
  ggplot(aes(x = happy)) + geom_bar()
# Introduce a new variable nhappy that has values 1 for not too happy,
# 2 for pretty happy, 3 for very happy and NA for missing values.
# There are multiple ways to get to that. Avoid for loops.


happy <- happy %>% mutate(
  nhappy = ifelse(happy=="not too happy", 1,
                  ifelse(happy=="pretty happy", 2,
                         ifelse(happy == "very happy", 3, NA)))
)
summary(happy$nhappy)

levels(happy$happy)

happy <- happy %>% mutate(
  nhappy = as.numeric(happy)
)
summary(happy$nhappy)


# Based on the newly introduced numeric scores,
# what is the average happiness of respondents?

happy %>%
  summarise(
    avg_happy = mean(nhappy, na.rm=TRUE)
  )


happy_by_age <- happy %>%
  group_by(age) %>%
  summarise(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE)
  )

happy_by_age %>%
  ggplot(aes(x = age, y = avg_happy)) + geom_point()



happy %>%
  group_by(age, sex) %>%
  summarise(
    avg_happy = mean(nhappy, na.rm=TRUE),
    sd_happy = sd(nhappy, na.rm=TRUE)
  ) %>%
  ggplot(aes(x = age, y = avg_happy, colour = sex)) +
  geom_point()

