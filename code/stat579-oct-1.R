library(tidyverse)
url <- "https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv"
iowa <- read.csv(url)

sample <- iowa[144:202,]
sample$HEIGHT3

(sample$HEIGHT3 %/% 100) * 30.48

(sample$HEIGHT3 %% 100) * 2.54

ifelse(sample$HEIGHT3 > 9000, sample$HEIGHT3 - 9000, sample$HEIGHT3)

# do no do this!!!! breaks the relationship between data and variable
height <- na.omit(sample$HEIGHT3)

# next command needs some modification before it runs
iowa <- iowa %>% mutate(
  height = HEIGHT3) %>%
  mutate(
  height = replace(height, height %in% c(7777, 9999), NA),
  height = ifelse(height > 9000, , )
)

###############
library(classdata)
summary(fbi$Year)

summary(iowa$SEX1)

fbi$Year <- factor(fbi$Year)
summary(fbi$Year)
summary(factor(iowa$SEX1))
levels(fbi$Year)

levels(fbi$Year)[1] <- "nineteensixtyone"
levels(fbi$Year)[1] <- "1961"
levels(fbi$Type)

levels(fbi$Type)[6] <- "Murder"

rm(fbi)
fbi %>% filter(Year %in% c(2014, 1961)) %>%
  mutate(
    Year = factor(Year)
  ) %>%
  ggplot(aes(x = Year, y = Population)) +
  geom_boxplot()

#
str(fbi)
as.factor()
as.numeric()
as.integer()
as.character()

fbi$Year <- as.factor(fbi$Year)
fbi$Year <- as.numeric(fbi$Year)
head(fbi$Year)
as.numeric(as.character(factor(fbi$Year)))

# change SEX1 to factor variable,
# change labels to sensible text

str(iowa$SEX1)
summary(iowa$SEX1)
iowa$sex <- factor(iowa$SEX1)
levels(iowa$sex) <- c("male", "female", "don't know", "refused")
iowa %>%
  ggplot(aes(x = sex)) + geom_bar()

##
# manually change order
# be careful about typos!!!!
iowa$sex <- factor(iowa$sex,
                   levels = c("don't know", "refused", "female", "male"))
levels(iowa$sex)
levels(iowa$sex) <- c("Don't know", "Refused", "Female typos", "Male")

iowa %>%
  ggplot(aes(x = sex)) + geom_bar()

####
fbi %>%
  mutate(
    Type = reorder(Type, Count, FUN = median, na.rm=TRUE)
  ) %>%
  filter(!is.na(Count)) %>%
  ggplot(aes(x = Type, y = Count)) + geom_boxplot() + coord_flip()

fbi %>%
  mutate(
    Rate = Count/Population*70000,
    Type = reorder(Type, Rate, median, na.rm=T)
  ) %>%
  filter(!is.na(Rate)) %>%
  ggplot(aes(x = Type, y = Rate)) + geom_boxplot() + coord_flip()


fbi %>%
  filter(Type == "Motor.vehicle.theft") %>%
  mutate(
    Rate = Count/Population*70000,
    Abb = reorder(Abb, Rate, median, na.rm=T)
  ) %>%
  filter(!is.na(Rate)) %>%
  ggplot(aes(x = Abb, y = Rate)) + geom_boxplot() + coord_flip()





