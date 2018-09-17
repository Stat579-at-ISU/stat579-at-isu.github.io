# Plot the number of car thefts by year for each state (facet by state).

# The numbers are dominated by the number of thefts in California, New York, and Texas. Use a log-scale for the y-axis. Does that help?
  
#  Another approach to fix the domination by CA, TX and NY: Read up on the parameters in facet_wrap to find a way to give each panel its own scale. Comment on the difference in the results.

library(classdata)
library(ggplot2)

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State)


ggplot(data=fbiwide, 
       aes(x = Year, 
           y = log10(Motor.vehicle.theft))) +
  geom_point() +
  facet_wrap(~State)

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free")

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free_y")

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free_y", ncol=10)

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft/Population*60000)) +
  geom_point() +
  facet_wrap(~State)

ggplot(data = fbi,
       aes(x = Type, y = log10(Count))) +
  geom_boxplot() +
  coord_flip()

# not usefule - not sure what the boxplots mean
ggplot(data = fbi,
       aes(y = Type, x = log10(Count))) +
  geom_boxplot()


ggplot(data = fbiwide, 
       aes(x = Motor.vehicle.theft)) +
  geom_histogram()

ggplot(data = fbiwide, 
       aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=10000)
ggplot(data = fbiwide, 
       aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=50000)

ggplot(data = fbiwide, 
       aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=5000)

# barcharts

ggplot(data = fbi, aes(x = Type)) +
  geom_bar()

ggplot(data = fbi, aes(x = Type, weight=Count)) +
  geom_bar() + coord_flip()

# Your turn

library(tidyverse)
ggplot(data = fbi, aes(x=Violent.crime))
fbi %>% ggplot(aes(x=Violent.crime)) + geom_bar()
fbi %>% ggplot(aes(x=Violent.crime, weight=Count)) + geom_bar()
fbi %>% ggplot(aes(x=Violent.crime, weight=Count)) + 
  geom_bar() +
  facet_wrap(~Type)
fbi %>% ggplot(aes(x=Violent.crime, weight=Count, 
                   colour=Type)) + 
  geom_bar()
fbi %>% ggplot(aes(x=Violent.crime, weight=Count, 
                   fill=Type)) + 
  geom_bar()


fbi %>% ggplot(aes(x = log(Count)))+
  geom_histogram(binwidth=0.25) +
  facet_wrap(~Type, scales="free")

# Your turn:

a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)


# less than 20
a < 20

T
TRUE
F
FALSE

a[a < 20]

# squared value is at least 100 or less than 10
(a^2 >= 100) | (a^2 < 10)

# equals 1 or 3
(a == 1) | (a == 3)
a %in% c(1, 3)

# even 
a %/% 2
a[a %% 2 == 0]

504

feet <- 504 %/% 100
inch <- 504 %% 100

7777 %/% 100
9999 %/% 100


