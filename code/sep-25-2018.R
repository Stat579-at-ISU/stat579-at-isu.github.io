# A quick introduction to the pipe, %>%

a <- 1:10
a %>% mean()
mean(a)

# Pipes allow chaining of functions in a todo-style list
# data %>%
#   filter(...) %>%
#   arrange(variable) %>%
#   group_by(...) %>%
#   summarize()

# --- Your Turn ----------------------------------------------------------------

# Warm up: Your turn (04_logical.html, slide 8)
# Use the fbi data from the classdata package
library(classdata)
library(dplyr)
library(ggplot2)
# Get a subset of all crimes in Iowa, Plot incidences/rates for one type of crime over time.
data(fbi)
head(fbi)
tmp <- fbi %>%
  filter(State == "Iowa", Type == "Murder.and.nonnegligent.Manslaughter")
ggplot(data = tmp) +
  geom_line(aes(x = Year, y = Count))

# Get a subset of all crimes in 2009. Plot the number or rate for one type of crime by state.

fbi %>%
  filter(Year == 2009) %>%
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  ggplot() +
  geom_col(aes(x = State, y = Count/Population * 100000)) +
  ylab("Murder rate per 100,000 people") +
  coord_flip()

# Get a subset of the data that includes number of homicides for the last five years.
# Find the rate of homicides, extract all states that have a rate of greater
# than 90% of the rates across all states, and plot (Hint: ?quantile).
max(fbi$Year)
tmp <- fbi %>%
  filter(Year >= 2009) %>%
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  group_by(State) %>%
  summarize(Count = sum(Count, na.rm = T),
            Population = mean(Population)) %>%
  mutate(Rate = Count/Population * 100000)

threshold <- quantile(tmp$Rate, .9, na.rm = T)

filter(tmp, Rate >= threshold) %>%
  ggplot() +
  geom_col(aes(x = State, y = Rate)) +
  ylab("5-year Murder rate per 100,000 people") +
  coord_flip()

# ------------------------------------------------------------------------------

nrow(fbi)

dim(fbi)

quantile(rnorm(10000), .95)
quantile(rnorm(10000), c(.9, .95, .99))

which(fbi$Type == "Rape")
which.max(fbi$Count)
which.min(fbi$Count)

# --- Your Turn ----------------------------------------------------------------

# Use the fbi data object to answer the following questions:
# how many reports of Burglaries are there for California?

<<<<<<< HEAD
cali_burglary <- filter(fbi, State == "California") %>%
  filter(Type == "Burglary")
sum(cali_burglary$Count)


# for any of the violent crimes, which state had the highest rate (and for which crime) in 2014? in 1961?

violent_2014 <- filter(fbi, Violent.crime == T) %>%
  filter(Year == 2014)

which.max(violent_2014$Count/violent_2014$Population)
violent_2014[217,]

violent_1961 <- filter(fbi, Violent.crime == T) %>%
  filter(Year == 1961)

which.max(violent_1961$Count/violent_1961$Population)
violent_1961[209,]

# Use the fbiwide data object to answer the following question:
# in how many states in 2011 were there more vehicle thefts than robberies? (which states are those?)

data(fbiwide)
head(fbiwide)

vehicle_theft_states <- filter(fbiwide, Year == 2011) %>%
  filter(Motor.vehicle.theft > Robbery)

nrow(vehicle_theft_states)
vehicle_theft_states$State

# ------------------------------------------------------------------------------

x1 <- x2 <- sample(1:10, 10, replace = F)
x1

x1[x1 >= 9] <- 0
x1

replace(x2, x2 >= 9, 0)
x2

library(classdata)
# introduces new variable in the data set fbiwide
fbiwide$murder.rate <- fbiwide$Murder/fbiwide$Population*100000
names(fbiwide)

# --- Your Turn ----------------------------------------------------------------
# The gapminder data from homework 2 is available here.
# https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/gapminder-5060.csv
# read.csv helps you read the gapminder data from the given link. Store the result in an object.
# What format does the object have?
# Replace the problematic value in life expectancy for Canada in 1957 by the value 69.96.

gapminder <- read.csv("https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/gapminder-5060.csv")
str(gapminder)
summary(gapminder$lifeExp)

gapminder$lifeExp[gapminder$lifeExp > 150] <- 69.96

gapminder$lifeExp[which.max(gapminder$lifeExp)] <- 69.96


################################################################################
# --- Factor Variables ---------------------------------------------------------

x <- sample(letters, 15)
x_fac <- factor(x, levels = letters)
x_fac
x_fac_numeric <- as.numeric(x_fac)
x_fac_numeric

levels(x_fac)


# --- Your Turn ----------------------------------------------------------------

# Inspect the fbi object. How many variables are there? Which type does each of the variables have?

str(fbi) # 7 variables
# State and Abb are characters
# Year, Population, and Count are integers
# Type is a factor
# Violent.crime is a logical vector

#   Make a summary of Year

summary(fbi$Year)

# Make Year a factor variable: fbi$Year <- factor(fbi$Year)

fbi_copy <- fbi
fbi$Year <- factor(fbi$Year)

# Compare summary of Year to the previous result

summary(fbi$Year)

# Are there other variables that should be factors (or vice versa)?

# State, Abb should probably be factors
fbi$State <- factor(fbi$State)
fbi$Abb <- factor(fbi$Abb)

# --- Factors in Boxplots ------------------------------------------------------
# Reload fbi data
data(fbi)

twoyear <- dplyr::filter(fbi, Year %in% c(1961, 2014))

ggplot(data = twoyear) + geom_boxplot(aes(x = Year, y = Count))

ggplot(data = twoyear) + geom_boxplot(aes(x = factor(Year), y = Count))

fbi_factor <- fbi
fbi_factor$Year <- factor(fbi_factor$Year)

str(fbi_factor)
str(fbi_factor$Year)
mode(fbi_factor$Year)

is.factor(fbi$Year)
is.factor(fbi_factor$Year)

is.integer(fbi$Year)
is.integer(fbi_factor$Year)

is.numeric(fbi$Year)
is.numeric(fbi_factor$Year)

is.character(fbi$Year)
is.character(fbi_factor$Year)
is.character(fbi$State)

is.logical(fbi$Violent.crime)
is.logical(fbi$Count)

as.character(fbi_factor$Year)
as.character(fbi$Year)
as.integer(fbi_factor$Year) # ???
as.numeric(fbi_factor$Year)
as.numeric(as.character(fbi_factor$Year)) # What we expected out of as.numeric(factor var)

fbi_factor$Year %>%
  as.character() %>%
  as.numeric() # Piped version is much easier to read - sequential instead of inside-out


levels(fbi$Type)
reordered_Type <- factor(
  fbi$Type,
  levels = c("Larceny.theft", "Burglary", "Motor.vehicle.theft", "Robbery",
             "Rape", "Legacy.rape",  "Aggravated.assault",
             "Murder.and.nonnegligent.Manslaughter"))
levels(reordered_Type)


reorder(fbi$Type, fbi$Count, na.rm = T) %>% levels()
reorder(fbi$Type, fbi$Count) %>% levels()


# --- Your Turn ----------------------------------------------------------------

# For this your turn use the fbi object from the classdata package.
data(fbi)
# Introduce a rate of the number of reported offenses by population into the
# fbi data. You could use the Ames standard to make values comparable to a city
# of the size of Ames (population ~70,000).

fbi$Rate_Ames <- fbi$Count/fbi$Population * 70000

# Plot boxplots of crime rates by different types of crime. How can you make axis text legible?

fbi %>%
  ggplot(aes(x = Type, y = Rate_Ames)) +
  geom_boxplot()

fbi %>%
  ggplot(aes(x = Type, y = Rate_Ames)) +
  geom_boxplot() +
  coord_flip()

fbi$Type <- factor(fbi$Type,
                   labels = c("Agg. Assault", "Burglary", "Larceny/Theft",
                              "Legacy Rape", "Vehicle Theft",
                              "Murder and\nnonnegligent\nmanslaughter",
                              "Rape", "Robbery"))
fbi %>%
  ggplot(aes(x = Type, y = Rate_Ames)) +
  geom_boxplot() +
  coord_flip()

#   Reorder the boxplots of crime rates, such that the boxplots are ordered by their medians.

fbi$Type <- reorder(fbi$Type, fbi$Rate_Ames, FUN = median)
fbi %>%
  ggplot(aes(x = Type, y = Rate_Ames)) +
  geom_boxplot() +
  coord_flip()

fbi$Type <- reorder(fbi$Type, fbi$Rate_Ames, FUN = median, na.rm = T)
fbi %>%
  ggplot(aes(x = Type, y = Rate_Ames)) +
  geom_boxplot() +
  coord_flip()

# For one type of crime (subset!) plot boxplots of rates by state, reorder boxplots by median crime rates

fbi$State <- factor(fbi$State)
burgled <- filter(fbi, Type == "Burglary")

burgled$State <- reorder(burgled$State, burgled$Rate_Ames, FUN = median, na.rm = T)
burgled %>%
  ggplot(aes(x = State, y = Rate_Ames)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("Burglary Rates") +
  ylab("Annual Burglary Rates per 70,000 people")

# ------------------------------------------------------------------------------

data(fbi)
levels(fbi$Type)
levels(fbi$Type)[6] <- "Murder"
levels(fbi$Type)
