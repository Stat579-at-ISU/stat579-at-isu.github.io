library(alr3) # install.packages("alr3")
?banknote
banknote$Y <- factor(banknote$Y)

#####################
# don't run every time, just once in a while
devtools::install_github("heike/classdata")

# run this every time
library(classdata)

?fbiwide
library(ggplot2)
ggplot(fbiwide, 
       aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point()

# Your turn

ggplot(fbiwide, 
       aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State)

ggplot(fbiwide, 
       aes(x = Year, 
           y = log10(Motor.vehicle.theft))) +
  geom_point() +
  facet_wrap(~State)

ggplot(fbiwide, 
       aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free")

ggplot(fbiwide, 
       aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free_y")

ggplot(fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft/Population*60000)) +
  geom_point() +
  facet_wrap(~State, scales="free_y")

ggplot(fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft/Population*60000)) +
  geom_point() +
  facet_wrap(~State)

ggplot(data = fbi, aes(x = Type, y = log10(Count))) + geom_point()
ggplot(data = fbi, aes(x = Type, y = log10(Count))) +
  geom_boxplot() + 
  coord_flip()

# funky!! x has to be discrete, y has to be numeric/continuous
ggplot(data = fbi, aes(y = Type, x = log10(Count))) +
  geom_boxplot() 

# Your Turn

# boxplots of Robberies by State:

ggplot(fbiwide, aes(x = Abb,
                    y = log10(Robbery))) +
  geom_boxplot()
ggplot(fbiwide, aes(x = Abb,
                    y = Robbery/Population*60000)) +
  geom_boxplot() #+ facet_wrap(~State, scales="free_x")

ggplot(aes(x = Motor.vehicle.theft), 
       data=fbiwide) + 
  geom_histogram()
ggplot(aes(x = Motor.vehicle.theft), 
       data=fbiwide) + 
  geom_histogram(binwidth=10000)
ggplot(aes(x = Motor.vehicle.theft), 
       data=fbiwide) + 
  geom_histogram(binwidth=1000)
ggplot(aes(x = Motor.vehicle.theft), 
       data=fbiwide) + 
  geom_histogram(binwidth=50000)


ggplot(aes(x = log(Count)), 
       data=fbi) + 
  geom_histogram() + 
  facet_wrap(~Type)

ggplot(aes(x = log(Count)), 
       data=fbi) + 
  geom_histogram() + 
  facet_grid(Type~.)


ggplot(aes(x = Type), 
       data=fbi) + 
  geom_bar()
######################

TRUE
FALSE
T
F

x <- c(F, T, T, F, F, F, T, F, F, T, T, T)
str(x)


a <- c(3,5,10,1,5, 3)
x <- a <= 3
x
a > 3
a == 3
a != 3

# greater than 5 or less than 3:
(a > 5) | (a < 3)
a[(a > 5) | (a < 3)]

## Your Turn

a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)

# a is ...
# less than 20

a < 20
a[a < 20]

# squared value is at least 100 or less than 10

(a^2 >= 100) | (a^2 < 10)
a[(a^2 >= 100) | (a^2 < 10)]

# equals 1 or 3

(a==1)|(a==3)
a %in% c(1,3)

# even

a %% 2
a %/% 2
a[a %% 2 == 0]


library(dplyr)
head(filter(fbi, Year==2014, State=="Iowa"))
filter(fbi, (Year==2014) & (State=="Iowa"))

filter(fbi, Abb %in% c("IA", "MN"), Type=="Larceny.theft")

?which

which(a < 3)
