library(tidyverse)
library(classdata)
head(titanic)
str(titanic)

titanic %>%
  ggplot(aes(x = Class)) + geom_bar()

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) + geom_bar()

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) + geom_bar(position="dodge")

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) + geom_bar(position="fill")

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) + geom_bar(position="stack")

titanic %>%
  ggplot(aes(x = Age, fill=Survived)) + geom_bar(position="fill")

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill")

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill") + facet_wrap(~Class)


titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill") + facet_grid(.~Class)

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill") + facet_grid(Class~.)

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill") + facet_grid(Class~Age)

# install.packages("ggmosaic")
library(ggmosaic)

titanic %>%
  ggplot() +
  geom_mosaic(aes(x = product(Sex), fill=Survived)) +
  facet_grid(~Class)

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) + geom_bar(position="fill") +
  facet_grid(~Class)

titanic %>%
  ggplot() +
  geom_mosaic(aes(x = product(Sex), fill=Survived)) +
  facet_grid(~Class)

###############
# Your Turn

library(classdata)
head(fbiwide)
names(fbiwide)

fbiwide %>% select(5:12) %>% head()
fbiwide %>% select(Aggravated.assault, Burglary:Robbery)
fbiwide %>% select(-1:-4)
#fbiwide %>% select(0)
fbiwide %>% select(-1, -2, -3, -4)
?starts_with

fbi %>%
  summarize(
    mean_count = mean(Count, na.rm=TRUE),
    sd_count = sd(Count, na.rm=TRUE),
    n_count = sum(!is.na(Count))
  )


fbi %>%
  group_by(Type, Year) %>%
  summarize(
    mean_count = mean(Count, na.rm=TRUE),
    sd_count = sd(Count, na.rm=TRUE),
    n_count = sum(!is.na(Count))
  )

################
dim(happy)
?happy

str(happy)

happiness <- happy
happiness %>%
  ggplot(aes(x = happy)) + geom_bar()

levels(happiness$happy)
happiness$nhappy <- as.numeric(happiness$happy)

happiness %>%
  ggplot(aes(x = nhappy)) + geom_bar()

happiness %>%
  summarise(
    mean_happy = mean(nhappy, na.rm=TRUE),
    n_happy = sum(!is.na(nhappy))
  )


happiness %>%
  group_by(age) %>%
  summarise(
    mean_happy = mean(nhappy, na.rm=TRUE),
    n_happy = sum(!is.na(nhappy))
  ) %>%
  ggplot(aes(x = age, y = mean_happy)) + geom_point()


happiness %>%
  group_by(age, sex) %>%
  summarise(
    mean_happy = mean(nhappy, na.rm=TRUE),
    n_happy = sum(!is.na(nhappy))
  ) %>%
  ggplot(aes(x = age, y = mean_happy, colour = sex)) + geom_point(size=4) + geom_line()

