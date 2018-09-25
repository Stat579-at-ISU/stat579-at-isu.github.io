# Homework 4, Q3

library(classdata)
data(mojo);head(mojo)

library(ggplot2)
ggplot(data = mojo, aes(x = WeekNo, y = `Total Gross`, group = Title)) + 
  geom_line() + 
  facet_wrap(~Year)

# A quick introduction to the pipe, %>%
library(dplyr)
a <- 1:10
a %>% mean()
mean(a)

# Pipes allow chaining of functions in a todo-style list
# data %>%
#   filter(...) %>%
#   arrange(variable) %>%
#   group_by(...) %>%
#   summarize()

head(mojo)
mojo %>% head()

mojo$Average %>% mean(x = ., na.rm = T)

square <- function(x) x^2

square(mean(a))
a %>% mean() %>% square()


# --- Your Turn ----------------------------------------------------------------
# Warm up: Your turn (04_logical.html, slide 10)
# Use the fbi data from the classdata package
library(classdata)
library(dplyr)
library(ggplot2)
# how many reports of Burglaries are there for California?
data(fbi)

tmp <- filter(fbi, State == "California", Type == "Burglary")
sum(tmp$Count)

# for any of the violent crimes, which state had the highest rate (and for which crime) in 2014? in 1961?

violent_2014 <- filter(fbi, Year == 2014, Violent.crime == TRUE)
which.max(violent_2014$Count/violent_2014$Population)
violent_2014[217,]

violent_1961 <- filter(fbi, Year == 1961, Violent.crime == TRUE)
which.max(violent_1961$Count/violent_1961$Population)
violent_1961[209,]

# in how many states in 2011 were there more vehicle thefts than 
# robberies? (which states are those?)
data(fbiwide)

tmp <- fbiwide %>%
  dplyr::filter(Year == 2011) %>%
  dplyr::filter(Motor.vehicle.theft > Robbery)

# ------------------------------------------------------------------------------

a <- 1:4
a[2:3] <- NA
a
a[2:3] <- "NA"
a


fbiwide$murder.rate <- fbiwide$Murder/fbiwide$Population*100000
fbiwide[which.max(fbiwide$murder.rate),]

# --- Your Turn - Slide 13 ----------------------------------------------------
gapminder <- read.csv("https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/gapminder-5060.csv")

# What format does the object have?
str(gapminder)

# Replace the problematic value in life expectancy for Canada in 1957 
# by the value 69.96.
summary(gapminder$lifeExp)
which.max(gapminder$lifeExp)
gapminder[82,]
which(gapminder$country == "Canada" & gapminder$year == 1957)

gapminder$lifeExp <- replace(gapminder$lifeExp, 
                             gapminder$country == "Canada" & 
                               gapminder$year == 1957,
                             69.96)

gapminder$lifeExp <- replace(gapminder$lifeExp, 
                             gapminder$lifeExp == 999999, 
                             69.96)
gapminder$lifeExp[82] <- 69.96

summary(gapminder$lifeExp)


#####################################
# --- Factors -----------------------

# Inspect the fbi object. How many variables are there? 
# Which type does each of the variables have?
str(fbi)
# Make a summary of Year
summary(fbi$Year)

# Make Year a factor variable: fbi$Year <- factor(fbi$Year)
fbi$Year <- factor(fbi$Year)

# Compare summary of Year to the previous result
summary(fbi$Year)

# Are there other variables that should be factors (or vice versa)?
data(fbi)
summary(fbi$State)
fbi$State <- factor(fbi$State)
summary(fbi$State)

# ------------------
twoyear <- dplyr::filter(fbi, Year %in% c(1961, 2014))


ggplot(data = fbi, 
       aes(x = Year, 
           y = Count)) + 
  geom_boxplot()

ggplot(data = fbi, 
       aes(x = factor(Year), 
           y = Count)) + 
  geom_boxplot()


head(fbi)

is.character(fbi$State)
str(fbi)
is.factor(fbi$State)
is.numeric(fbi$State)

is.numeric(fbi$Year)
is.integer(fbi$Count)
is.logical(fbi$Violent.crime)

as.integer(fbi$Violent.crime)

fbi$Year_fac <- factor(fbi$Year)
as.numeric(fbi$Year_fac)
as.character(fbi$Year_fac)
fbi$Year_fac %>% as.character() %>% as.numeric()
as.numeric(as.character(fbi$Year_fac))

ggplot(data = fbi, 
       aes(x = Year, 
           y = Count)) + 
  geom_col()

levels(fbi$State)

levels(fbi$Type)
fbi$myType <- factor(fbi$Type, labels = c("Assault", "Burglary", 
                                          "Theft", "Rape1", 
                                          "Car Theft", "Murder", 
                                          "Rape2", "Robbery"))
fbi$myType2 <- factor(fbi$Type, 
                      levels = c("Aggravated.assault",
                                 "Burglary",
                                 "Larceny.theft", 
                                 "Legacy.rape", 
                                 "Motor.vehicle.theft", 
                                 "Murder.and.nonnegligent.Manslaughter",
                                 "Rape", "Robbery"),
                      labels = c("Assault", "Burglary", 
                                 "Theft", "Rape1", 
                                 "Car Theft", "Murder", 
                                 "Rape2", "Robbery"))

levels(reorder(fbi$Type, fbi$Count))
levels(reorder(fbi$Type, fbi$Count, na.rm=TRUE))
levels(reorder(fbi$Type, fbi$Count, na.rm=TRUE, FUN = min))


tmp <- fbi %>% filter(Type == "Murder.and.nonnegligent.Manslaughter")
min(tmp$Count, na.rm = T) # 1
tmp <- fbi %>% filter(Type == "Legacy.rape")
min(tmp$Count, na.rm = T) # 6
tmp <- fbi %>% filter(Type == "Robbery")
min(tmp$Count, na.rm = T) # 8
tmp <- fbi %>% filter(Type == "Aggravated.assault")
min(tmp$Count, na.rm = T) # 14
tmp <- fbi %>% filter(Type == "Rape")
min(tmp$Count, na.rm = T)# 34
tmp <- fbi %>% filter(Type == "Motor.vehicle.theft")
min(tmp$Count, na.rm = T) # 178
tmp <- fbi %>% filter(Type == "Burglary")
min(tmp$Count, na.rm = T) # 865
tmp <- fbi %>% filter(Type == "Larceny.theft")
min(tmp$Count, na.rm = T) # 1489


# --- Your Turn ------------------------------------
# Introduce a rate of the number of reported offenses by population 
# into the fbi data. You could use the Ames standard to make values 
# comparable to a city of the size of Ames (population ~70,000).
data(fbi)

fbi$rate_ames <- fbi$Count/fbi$Population * 70000

# Plot boxplots of crime rates by different types of crime. How can 
# you make axis text legible?

ggplot(data = fbi, aes(x = Type, y = rate_ames)) + 
  geom_boxplot() + 
  ylab("# Crimes/Year in a city of 70,000") + 
  coord_flip()

fbi$Type_simple <- factor(fbi$Type, 
                          levels = c("Aggravated.assault",
                                     "Burglary",
                                     "Larceny.theft", 
                                     "Legacy.rape", 
                                     "Motor.vehicle.theft", 
                                     "Murder.and.nonnegligent.Manslaughter",
                                     "Rape", "Robbery"),
                          labels = c("Assault", "Burglary", 
                                     "Theft", "Rape1", 
                                     "Car Theft", "Murder", 
                                     "Rape2", "Robbery"))
ggplot(data = fbi, aes(x = Type_simple, y = rate_ames)) + 
  geom_boxplot() + 
  ylab("# Crimes/Year in a city of 70,000") + 
  coord_flip()

# Reorder the boxplots of crime rates, such that the boxplots are 
# ordered by their medians.

fbi$Type_simple <- reorder(fbi$Type_simple, fbi$rate_ames, 
                           FUN = median, na.rm = T)
ggplot(data = fbi, aes(x = Type_simple, y = rate_ames)) + 
  geom_boxplot() + 
  ylab("# Crimes/Year in a city of 70,000")

# For one type of crime (subset!) plot boxplots of rates by state, 
# reorder boxplots by median crime rates

tmp <- filter(fbi, Type_simple == "Car Theft")
tmp$State <- reorder(tmp$State, tmp$rate_ames, fun = median, na.rm = T)
ggplot(data = tmp, aes(x = State, y = rate_ames)) + 
  geom_boxplot() + 
  ylab("# Crimes/Year in a city of 70,000") + 
  coord_flip()
