str(TRUE)
F
FALSE
F == FALSE

x <- c(3,5,9,1,7, 13)
x %in% c(1, 4, 3, 7)

x > 5
x > c(3,1)
x > c(3,1, 3,1, 3,1)
x > c(3,1, 4, 7)
# x > c(3,1, 4, 7, 3,1)

####
a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)

a < 20
(a^2 >= 100) | (a^2 < 10)
(a == 1) | (a == 3)
a %in% c(1,3)

# this is wrong
a == c(1,3)


(a %% 2) == 0 # even number

library(classdata)
library(dplyr)
filter(fbi, Type=="Robbery")


####################################
# Your Turn

# Get a subset of all crimes in Iowa,
# Plot incidences/rates for one type of crime over time.
library(ggplot2)
iowa <- fbi %>% filter(State == "Iowa")

iowa %>%
  filter(Type == "Robbery") %>%
  ggplot(aes(x = Year, y = Count/Population*100000)) +
  geom_point()

# Get a subset of all crimes in 2009.
# Plot the number or rate for one type of crime by state.

fbi %>%
  filter(Year == 2009, Type == "Robbery") %>%
  ggplot(aes(y = Abb, x = Count)) +
  geom_point()

# Get a subset of the data that includes number of homicides
# for the five most recent years.
# Find the rate of homicides,
# extract all states that have a rate of greater than 90% of
# the rates across all states, and plot (Hint: ?quantile).

summary(fbi$Year)
lastfive <- fbi %>% filter(Year >= 2014,
                           Type=="Murder.and.nonnegligent.Manslaughter")
lastfive$Rate <- lastfive$Count/lastfive$Population*100000
str(lastfive)

quantile(lastfive$Rate, probs=.9)
top10 <- lastfive %>% filter(Rate > quantile(lastfive$Rate, probs=.9))

top10 %>%
  ggplot(aes(x = Abb)) + geom_bar()

top10 %>%
  ggplot(aes(x = Year)) + geom_bar()

##############

a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)
which(a == 1)

which.max(a) # index of maximum in a
which(a == max(a)) # pretty much the same

which.min(a) # index of minimum in a
which(a == min(a)) # not all minima are returned by which.min

#################
# Your turn

# Use the fbi data object to answer the following questions:

#  how many reports of Burglary counts are there for California?

fbi %>% filter(Abb=="CA", Type == "Burglary") %>% nrow()

#  how many burglaries were reported in total from California?

burgCA <- fbi %>% filter(Abb=="CA", Type == "Burglary")
sum(burgCA$Count)

# for any of the violent crimes,
# which state had the highest rate (and for which crime)
# in 2014? in 1961?

# D.C. in both years for aggravated assault
rates14 <- fbi %>% mutate(
  Rate_per_100k = Count/Population*100000
) %>% filter(Year %in% c(2014), Violent.crime == TRUE)

which.max(rates14$Rate_per_100k)
rates14[217,]

#  Use the fbiwide data object to answer the following question:

#  in how many states in 2011 were there more vehicle thefts
# than robberies? (which states are those?)

fbiwide %>%
  filter(Year==2011) %>%
  filter(Motor.vehicle.theft <= Robbery) %>% View()



