library(classdata)
?fbi

library(tidyverse)
# library(dplyr)
?filter

y16 <- filter(fbi, Year==2016)
filter(y16, Abb=="IA", Violent.crime != TRUE)
filter(y16, Abb=="IA" & Violent.crime != TRUE)

filter(y16, Abb=="IA" | Abb=="MN", Violent.crime != TRUE)

# Your turn
# Get a subset of all crimes in Iowa, 
# Plot incidences/rates for one type of crime over time.

ia <- filter(fbi, Abb=="IA")

ia %>% 
  filter(Type=="Burglary") %>%
  ggplot(aes(x = Year, y = Count)) + geom_point()


ggplot(data = filter(ia, Type=="Burglary"), 
       aes(x = Year, y = Count)) + geom_point()

ia %>% 
  filter(Type=="Burglary") %>%
  ggplot(aes(x = Year, y = Count/Population)) + 
  geom_point()



# Get a subset of all crimes in 2009. 
#Plot the number or rate for one type of crime by state.
y09 <- filter(fbi, Year==2009)

y09 %>% filter(Type=="Burglary") %>%
  ggplot(aes(y=Abb, x = Count/Population)) +
  geom_point()

# Get a subset of the data that includes number of homicides 
# for the last five years. 
# Find the rate of homicides, 
# extract all states that have a rate of greater than 90%
# of the rates across all states, and plot (Hint: ?quantile).

last5 <- filter(fbi, Year >= 2012, 
                Type=="Murder.and.nonnegligent.Manslaughter")

last5$rate <- last5$Count/last5$Population
summary(last5$rate)

q90 <- quantile(last5$rate, probs=0.9)
top10 <- filter(last5, rate>= q90)

top10 %>% ggplot(aes(x = Abb)) + geom_bar()

nrow(top10)
nrow(last5)

ncol(top10)
ncol(last5)

which(last5$rate > q90)
last5[c(9,19,60), ]

which.max(last5$rate)
last5$rate[91]
max(last5$rate)

## Your turn

# how many reports of Burglaries are there for California?
  fbi %>% 
    filter(Type=="Burglary", State=="California") %>% 
    nrow()

ca <-   fbi %>% 
    filter(Type=="Burglary", State=="California") 
sum(is.na(ca$Count))
  
NA == NA
sum(is.na(NA))
is.na(1)


# for any of the violent crimes, which state had the highest rate 
# (and for which crime) in 2014? in 1961? 
vc <- filter(fbi, Violent.crime == TRUE)
vc$rate <- vc$Count/vc$Population

vc14 <- filter(vc, Year==2014)
which.max(vc14$rate)
vc[217,] # not correct!!!
filter(vc, Year==2014)[217,]
vc14[217,]

vc61 <- filter(vc, Year==1961)
which.max(vc61$rate)
vc61[209,]
  
# Use the fbiwide data object to answer the following question: 
#  in how many states in 2011 were there at most as many vehicle
# thefts 
# as robberies? 
# (which states are those?)

head(fbiwide)
fbiwide$more_carthefts_than_robberies <- 
  fbiwide$Motor.vehicle.theft > fbiwide$Robbery

fbiwide %>% filter(Year == 2011, 
                   more_carthefts_than_robberies == FALSE)

fbiwide$State[which(fbiwide$Year==2011 & !fbiwide$more_carthefts_than_robberies)]

str(fbi)

is.factor(fbi$Type)
is.factor(fbi$State)
is.numeric(fbi$Type)
is.character(fbi$Type)

levels(fbi$Type)
summary(fbi$Type)

fbi$Type <- as.factor(fbi$Type)
fbi$State <- as.factor(fbi$State)
summary(fbi$Year) # mean of year doesn't mean much - Year might be better being treated as a factor

fbi$Year <- as.factor(fbi$Year)
summary(fbi$Year)
