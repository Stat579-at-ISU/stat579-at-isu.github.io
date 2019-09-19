library(classdata)
library(tidyverse)
data(fbi)

# Get a subset of all crimes in Iowa, 
# Plot incidences/rates for one type of crime over time.

filter(fbi, State == "Iowa", Type == "Robbery") %>%
  ggplot() + 
  geom_line(aes(x = Year, y = Count)) + 
  ggtitle("Robberies in Iowa")

# Get a subset of all crimes in 2009. 
# Plot the number or rate for one type of crime by state.

filter(fbi, Year == 2009, Type == "Robbery") %>%
  ggplot() + 
  geom_bar(aes(x = State, weight = Count)) + 
  coord_flip() + 
  ggtitle("Robberies in 2009, By State")

filter(fbi, Year == 2009, Type == "Robbery") %>%
  ggplot() + 
  geom_bar(aes(x = State, weight = Count/Population)) + 
  coord_flip() + 
  ggtitle("Robberies in 2009, By State")

# Get a subset of the data that includes number of 
# homicides for the last five years. Find the rate of 
# homicides, extract all states that have a rate of 
# greater than 90% of the rates across all states, 
# and plot (Hint: ?quantile).

fbi$Rate <- fbi$Count/fbi$Population

filter(fbi, Type == "Murder.and.nonnegligent.Manslaughter", 
       Year > max(Year) - 5) %>%
  filter(Rate >= quantile(Rate, .9)) %>%
  ggplot() + 
  geom_bar(aes(x = State)) + 
  ggtitle("Years Murder Rate > 90% quantile Nationally") + 
  coord_flip()

data(fbiwide)



# how many reports of Burglaries are there for California?
tmp <- fbi %>% filter(State == "California", 
                      Type == "Burglary")
sum(tmp$Count)

# for any of the violent crimes, which state had 
# the highest rate (and for which crime) in 2014? 
# in 1961?

filter(fbi, Year == 2014, Type == "Murder.and.nonnegligent.Manslaughter") %>%
  filter(Rate == max(Rate))

filter(fbi, Year == 1961, Type == "Murder.and.nonnegligent.Manslaughter") %>%
  filter(Rate == max(Rate))

# in how many states in 2011 were there more vehicle 
# thefts than robberies? (which states are those?)

filter(fbiwide, Year == 2011) %>%
  filter(Motor.vehicle.theft > Robbery) %>%
  select("Abb")

# Load the 2018 BRFSS data for Iowa from https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv

brfss <- read_csv("https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv")

# How many observations, how many variables does the 
# data set have?
dim(brfss)  
nrow(brfss)
ncol(brfss)

# Draw a barchart of the variable SLEPTIM1
ggplot(data = brfss) + 
  geom_bar(aes(x = SLEPTIM1))

# Read up on the variable coding in the codebook

# Some of the values should be encoded as NA. 
# Use mutate to fix those values. 
# Then re-draw the barchart. Include gender (SEX1) 
# into the chart.

brfss <- brfss %>%
  mutate(Sleep = ifelse(SLEPTIM1 %in% 1:24, SLEPTIM1, NA),
         Sex = ifelse(SEX1 %in% 1:2, SEX1, NA)) 
brfss %>%
  filter(!is.na(Sex)) %>%
  ggplot() + 
  geom_bar(aes(x = Sleep)) + 
  facet_grid(Sex~.)



# Inspect the fbi object. How many variables are there? 
# Which type does each of the variables have?

ncol(fbi)
summary(fbi)


# Make a summary of Year
summary(fbi$Year)

# Make Year a factor variable: 

fbi$Year_fac <- factor(fbi$Year)

# Compare summary of Year to the previous result

summary(fbi$Year_fac)

# Are there other variables that should be factors (or vice versa)?

fbi$State_fac <- factor(fbi$State)
fbi$Abb_fac <- factor(fbi$Abb)
fbi$Type_fac <- factor(fbi$Type)

str(fbi)
is.factor(fbi$State)
is.character(fbi$State)
is.numeric(fbi$State_fac)
is.integer(fbi$State_fac)
as.numeric(fbi$Year_fac)
fbi$year_unfactored <- as.character(fbi$Year_fac) %>% as.numeric()



# Introduce a rate of the number of reported offenses 
# by population into the fbi data. You could use the 
# Ames standard to make values comparable to a city of 
# the size of Ames (population ~70,000).

fbi <- fbi %>%
  mutate(ames_rate = Count/Population*70000)

# Plot boxplots of crime rates by different types of 
# crime. How can you make axis text legible?

ggplot(data = fbi) + 
  geom_boxplot(aes(x = Type, y = ames_rate)) + 
  coord_flip()

# Reorder the boxplots of crime rates, such that the 
# boxplots are ordered by their medians.

inv_median <- function(x, ...) -median(x, ...)

fbi <- fbi %>%
  mutate(Type_reord = reorder(Type, ames_rate, median, na.rm = T))


ggplot(data = fbi) + 
  geom_boxplot(aes(x = Type_reord, y = ames_rate)) + 
  coord_flip()

# For one type of crime (subset!) plot boxplots of rates 
# by state, reorder boxplots by median crime rates

robbery <- filter(fbi, Type == "Robbery")

robbery %>%
  mutate(State_ord = factor(State),
         State_ord = reorder(State_ord, ames_rate, median, na.rm = T)) %>%
  ggplot() + 
  geom_boxplot(aes(x = State_ord, y = ames_rate)) + 
  coord_flip()
