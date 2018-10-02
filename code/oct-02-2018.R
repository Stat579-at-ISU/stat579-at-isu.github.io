# --- Setup---------------------------------------------------------------------


library(classdata)
library(ggplot2)
library(dplyr)
# ------------------------------------------------------------------------------

# --- Homework questions -------------------------------------------------------
fly <- read.csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/flying-etiquette-survey/flying-etiquette.csv")
fly$Age <- factor(fly$Age, levels=c("18-29", "30-44", "45-60", "> 60", ""))
fly$Household.Income <- factor(fly$Household.Income, levels = c("$0 - $24,999","$25,000 - $49,999", "$50,000 - $99,999", "$100,000 - $149,999", "150000", ""))
fly$Education <- factor(fly$Education, levels = c("Less than high school degree", "High school degree", "Some college or Associate degree", "Bachelor degree",  "Graduate degree", ""))

# Question 1
fly$travel_freq <- fly$How.often.do.you.travel.by.plane.
levels(fly$travel_freq)

freq_order <- c("Never", "Once a year or less", 
                "Once a month or less", 
                "A few times per month", 
                "A few times per week", "Every day") 
fly$travel_freq <- factor(fly$travel_freq, 
                          levels = freq_order)
levels(fly$travel_freq)

ggplot(data = fly, aes(x = travel_freq)) + 
  geom_bar() + coord_flip()

# Question 5
fly$baby.on.plane <- fly$In.general..is.itrude.to.bring.a.baby.on.a.plane.
levels(fly$baby.on.plane)[1] <- "Not answered"
levels(fly$baby.on.plane)
baby_rude_levels <- levels(fly$baby.on.plane)[c(2, 3, 4, 1)]
fly$baby.on.plane <- factor(fly$baby.on.plane, 
                            levels = baby_rude_levels)
# ------------------------------------------------------------------------------

# ggplot2 plot types: http://shinyapps.stat.ubc.ca/r-graph-catalog/

################################################################################
# --- Visualizing Factor Variables ---------------------------------------------

library(classdata)
library(ggplot2)

data(fbi) # Reload - clean copy

ggplot(fbi, aes(x = Type, fill = Year)) + geom_bar() # no color

ggplot(fbi, aes(x = Type, weight = Count, fill = Year)) + geom_bar() # no color

ggplot(fbi, aes(x = Type, fill = factor(Year))) + geom_bar() # colors are fairly meaningless..

ggplot(fbi, aes(x = Type, weight = Count, fill = factor(Year))) +
  geom_bar() # Add in Count to get a sense of how common each crime is

# ------------------------------------------------------------------------------

# --- Example: Survival on the Titanic -----------------------------------------
head(titanic)
str(titanic)

# Barcharts of all variables
ggplot(titanic, aes(x = Survived)) + geom_bar()

ggplot(titanic, aes(x = Class)) + geom_bar()

ggplot(titanic, aes(x = Age)) + geom_bar()

ggplot(titanic, aes(x = Sex)) + geom_bar()

# position = 'fill'

ggplot(titanic, aes(x = Class, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Class, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Age, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic) +
  geom_bar(aes(x = Sex, fill = Survived), 
           position = "fill")

# ------------------------------------------------------------------------------

# --- Two and more factor variables --------------------------------------------

# Install ggmosaic
install.packages("ggmosaic")

library(ggmosaic)
ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex), 
                  fill = Survived)) +
  facet_grid(Age~Class)
# ------------------------------------------------------------------------------

# ---  Your turn ---------------------------------------------------------------
# For this your turn use the titanic object from 
# the classdata package.
# You might have to update the package using the 
# command: devtools::install_github("heike/classdata")

# Draw a barchart of Gender. Interpret.

ggplot(titanic, aes(x = Sex)) + geom_bar()

# Map survival to fill color in the barchart of Gender. Interpret.

ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar()

# In the previous barchart change the position 
# parameter to "fill". Interpret.

ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "fill")

# Read up on the position parameter in ?geom_bar. 
# Try out other options for position.
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "stack")
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "dodge")
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "dodge2")
# ------------------------------------------------------------------------------


################################################################################
# --- The dplyr package --------------------------------------------------------
library(dplyr)


# --- Common Structure ---------------------------------------------------------
# data is the first argument to each function
ggplot(data = fbi, aes(x = Year, y = Count)) + 
  geom_point()
filter(fbi, Year >= 2017, State == "Iowa")

# dplyr verbs - short demo

titanic %>%
  group_by(Class) %>%
  summarize(survival_rate = mean(Survived == "Yes"))

# The long way
tmp <- filter(titanic, Class == "1st")
mean(tmp$Survived == "Yes")
tmp <- filter(titanic, Class == "2nd")
mean(tmp$Survived == "Yes")
tmp <- filter(titanic, Class == "3rd")
mean(tmp$Survived == "Yes")
tmp <- filter(titanic, Class == "Crew")
mean(tmp$Survived == "Yes")


# --- The pipe operator --------------------------------------------------------
# f(x) %>% g(y) is equivalent to g(f(x), y)
# x %>% f(a, .) = f(a, x) # use . as a placeholder if you want 
#                         # to use pipes with non-tidyverse functions

# pipe version
titanic %>%
  group_by(Class, Sex) %>%
  summarize(survival_rate = mean(Survived == "Yes"))
# pipe-less version
summarize(group_by(titanic, Class), 
          survival_rate = mean(Survived == "Yes"))

# pipe-less version
ggplot(data = filter(fbi, Type=="Murder.and.nonnegligent.Manslaughter"), 
                     aes(x = Year, y = Count)) + 
         geom_point()
# pipe version
fbi %>%
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  ggplot(data = ., 
         aes(x = Year, y = Count)) + 
  geom_point()

# --- Filter -------------------------------------------------------------------
library(dplyr)
fbi %>%
  dplyr::filter(
    Type == "Murder.and.nonnegligent.Manslaughter",
    State == "Iowa", 
    Year > 1990) %>%
  ggplot(data = ., 
         aes(x = Year, y = Count)) + 
  geom_point()



fbi %>% filter(Type=="Burglary", Year==2014) %>%
  as_data_frame() # Get a nice print out

# --- Arrange ------------------------------------------------------------------
fbi %>%
  dplyr::filter(
    Type == "Murder.and.nonnegligent.Manslaughter",
    State == "Iowa"
  ) %>% as_data_frame() %>%
  arrange(desc(Count))

fbi %>%
  dplyr::filter(
    Type == "Murder.and.nonnegligent.Manslaughter",
    State == "Iowa"
  ) %>% as_data_frame() %>%
  arrange(Count)

# --- Select -------------------------------------------------------------------
fbi %>%
  as_data_frame() %>%
  select(-7)

fbi %>%
  as_data_frame() %>%
  select(-Violent.crime)

fbi %>%
  as_data_frame() %>%
  select(-c(1:3))

fbi %>%
  as_data_frame() %>%
  select(-starts_with("S"))

fbi %>%
  as_data_frame() %>%
  select(matches("State|state"))

fbi %>% arrange(desc(Year), Type, desc(Count)) %>%
  select(Type, Count, State, Year) %>% head()

# Stopped at slide 13
