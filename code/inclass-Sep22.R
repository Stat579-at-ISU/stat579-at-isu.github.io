library(tidyverse)
library(classdata)

?mutate
fbi <- fbi %>% mutate(
  rate = Count/Population*100000
  )

# equivalent
fbi$rate <- fbi$Count/fbi$Population*100000

fbi <- fbi %>% mutate(
  rate = Count/Population*50000
)

## from homework:
url <- "https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv"
iowa <- read.csv(url)

summary(iowa$HEIGHT3)

# get from 9XXX to centimeters by subtracting 9000 (or
# integer modulo operation of %% 9000)
iowa <- iowa %>% mutate(
  height = ifelse(HEIGHT3==9999, NA, HEIGHT3),
  height = ifelse(HEIGHT3==7777, NA, height)
)

iowa <- iowa %>% mutate(
  first_digit = height %/% 100,
  last_two = height %% 100
)

iowa <- iowa %>% mutate(
  height = ifelse(height >= 9000,
                  height - 9000, # true: height is 9000 or more
                  first_digit*30.48 + last_two*2.54) # false: height is between 200 and 711
)


# Your Turn
#
# work with fbi
# introduce a variable personal into the dataset that is TRUE for personal crimes,
# and FALSE for property crimes. Do not use the variable Violent.crime.
# It turns out that Violent.crime is mis-specified
unique(fbi$Type)

fbi <-fbi %>% mutate(
  personal = ifelse(Type %in% c("Larceny.theft", "Robbery", "Burglary", "Motor.vehicle.theft"),
                    FALSE, TRUE)
)

# don't do the following !!!!
fbi <-fbi %>% mutate(
  personal = ifelse(Type == c("Larceny.theft", "Robbery", "Burglary", "Motor.vehicle.theft"),
                    FALSE, TRUE)
)



# now introduce a variable class into the dataset that has two levels: personal and property
# classifying the types of crimes reported. Think of ifelse or replace.

fbi <- fbi %>% mutate(
  class = ifelse(personal == TRUE, "personal", "property")
)


str(fbi)
summary(fbi$Type)

summary(fbi$Year)

summary(factor(fbi$Year))

is.numeric(fbi$Year)
fbi$Year <- factor(fbi$Year)
is.numeric(fbi$Year)

is.factor(fbi$Year)
summary(fbi$Year)
summary(as.numeric(fbi$Year)) # as.numeric takes the ORDER of the levels and returns those
summary(as.character(fbi$Year)) # as.character takes the LABELS of the levels and returns those

fbi$Year %>% as.character() %>% as.numeric()
levels(fbi$Year)

levels(fbi$Violent.crime) # doesn't have levels

levels(as.factor(fbi$Violent.crime))
####

fbi %>%
  ggplot(aes(x = Count/Population*100000, y = Type)) +
  geom_boxplot()

levels(fbi$Type)
fbi$Type <- factor(fbi$Type, levels=c("Larceny.theft", "Burglary", "Motor.vehicle.theft",
                                 "Aggravated.assault", "Robbery", "Legacy.rape",
                                 "Murder.and.nonnegligent.Manslaughter", "Rape"))

fbi %>%
  ggplot(aes(x = Count/Population*100000, y = Type)) +
  geom_boxplot()


levels(reorder(fbi$Type, fbi$Count))


fbi %>%
  ggplot(aes(x = Count/Population*100000, y = reorder(Type, Count, na.rm=TRUE))) +
  geom_boxplot()

