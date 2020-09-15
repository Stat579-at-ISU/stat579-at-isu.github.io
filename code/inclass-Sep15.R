a <- c(4,5,7,1,2,-1, 13, 1)
b <- 5

a < b
a <= b
a == b

d <- c(2,4)
a > d

d <- c(2,4, 2,4, 2,4, 2,4)
a > d
length(a)

library(tidyverse)
library(classdata)

head(fbiwide)

filter(fbiwide, Year == 1980)

fbiwide %>% filter(Year == 1980)

#####

a <- c(4,5,7,1,2,-1, 13, 1)
!(a > 4)

#####
# Your turn

a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)

a < 20

(a^2 >= 100) | (a^2 < 10)
(a >= sqrt(100)) | (a < sqrt(10))

a %in% c(1,3)
(a == 1) | (a == 3)

# careful, don't do this!
a == c(1,3)
a == c(1,3, 1,3, 1,3, 1,3, 1,3)

##################

?%% # doesn't work
?`%%`

a %% 2 == 0

###################
#
library(dplyr)
filter(fbiwide, Year == 1980)

################
# Your turn

library(ggplot2)
# Get a subset of all crimes in Iowa, Plot incidences/rates for one type of crime over time.
iowa <- filter(fbi, Abb=="IA")
iowa %>%
  filter(Type=="Robbery") %>%
  ggplot(aes(x = Year, y = Count/Population*100000, colour=Type)) +
  geom_point()

fbi %>%
  filter(Abb=="IA", Type=="Robbery") %>%
  ggplot(aes(x = Year, y = Count/Population*100000, colour=Type)) +
  geom_point()

# Get a subset of all crimes in 2009. Plot the number or rate for one type of crime by state.
fbi %>%
  filter(Year == '2009', Type=="Robbery") %>%
  ggplot(aes(x = Abb, y = Count)) +
  geom_point()

# Get a subset of the data that includes number of homicides for the most five years in the data.
# Find the rate of homicides, extract all states that have a rate of greater than 90% of the rates across all states, and plot (Hint: ?quantile).
lastyear <- max(fbi$Year)
last5years <- fbi %>% filter(Year > lastyear-5, Type == "Murder.and.nonnegligent.Manslaughter")

last5years$Rate <- last5years$Count/last5years$Population*100000
head(last5years)

quantile(last5years$Rate, probs = 0.9)

toptenperc <- last5years %>%
  filter(Rate > quantile(last5years$Rate, probs = 0.9))

toptenperc %>%
  ggplot(aes(x = Abb)) + geom_bar()

toptenperc %>%
  ggplot(aes(x = Year)) + geom_bar()

toptenperc %>%
  ggplot(aes(x = factor(Year), fill=Abb)) + geom_bar()

a
which(a == 1)

which.max(a) # index of the maximum in a
which.min(a) # index of the minimum in a

which(a == min(a))

############3
# Your turn


#  how many reports of Burglaries are there for California?

yourturn1 <- fbi %>% filter(Type=="Burglary", Abb=="CA")
nrow(yourturn1)

fbi %>% filter(Type=="Burglary", Abb=="CA") %>% nrow()


#  for any of the violent crimes, which state had the highest rate (and for which crime) in 2014? in 1961?

yt14 <- fbi %>% filter(Violent.crime==TRUE, Year==2014)
yt61 <- fbi %>% filter(Violent.crime==TRUE, Year==1961)

yt14$Rate <- yt14$Count/yt14$Population
which.max(yt14$Rate)
yt14[217,]


yt61$Rate <- yt61$Count/yt61$Population
which.max(yt61$Rate)
yt61[209,]

#  Use the fbiwide data object to answer the following question:

#  in how many states in 2011 were there more vehicle thefts than robberies? (which states are those?)



