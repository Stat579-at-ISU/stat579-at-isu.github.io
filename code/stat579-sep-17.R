library(tidyverse)
library(classdata)

fbi %>%
  filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
  ggplot(aes(x = Year, y= Count)) +
  geom_point()

# without the pipe

ggplot(data = filter(fbi, Type=="Murder.and.nonnegligent.Manslaughter"),
       aes(x = Year, y = Count)) +
  geom_point()


data(banknote, package="alr3")
head(banknote)
banknote$Y <- factor(banknote$Y)

banknote %>% ggplot(aes(x = Left, y = Y, colour = Y)) +
  geom_point()

# Your Turn

fbiwide %>%
  ggplot(aes(x = Abb, y = Robbery)) +
  geom_boxplot()

fbiwide %>%
  ggplot(aes(x = Abb, y = Robbery/Population*70000)) +
  geom_boxplot()

##############

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram()

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=10000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=1000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=50000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=100000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft, fill = Abb)) +
  geom_histogram(binwidth=100000) +
  ggtitle("Rainbow plot, do not use at home")

#####

fbi %>%
  ggplot(aes(x = Type)) + geom_bar() +
  coord_flip()

fbi %>%
  ggplot(aes(x = Type, weight = Count)) + geom_bar() +
  coord_flip()

#############

a <- c(3,4,5,1,2,7,4,3,5)
a > 3
a <= 4

TRUE
T

FALSE
F

(a == 1) | (a == 7)
a %in% c(1,7, 5)

a[a %in% c(1,7, 5)]
a[a >= 4]

(a > 1) & (a < 7)
########
a <- c(1, 15, 3, 20, 5, 8, 9, 10, 1, 3)

a[a < 20]
(a^2 > 100) | (a^2 < 10)

a %in% c(1,3)
#a == c(1,3) # wrong!

(a %% 2) != 1

##############
#

fbi %>%
  filter(Abb=="IA", Type == "Burglary") %>%
  ggplot(aes(x = Year, y = Count/Population, colour = Type)) +
  geom_point()

