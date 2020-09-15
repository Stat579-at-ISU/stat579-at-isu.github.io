library(classdata)
?fbi
str(fbi)
fbi$Population

head(fbi$Population)
head(fbi$State)
head(fbi$Year)

fbi$population # R is case-sensitive!

fbi[2, 5]
dim(fbi)

fbi[2, ]
fbi[, 4]

fbi[, "Population"]
fbi[, c("Population", "Abb")]

1:10
400:395
1.5:10

fbi[1:6,]

################
# Your Turn

fbi[1:10,]
head(fbi, 10)

names(fbi)
mean(fbi$Count)
sd(fbi$Count)

?mean

median(fbi$Count, na.rm=TRUE)
mean(fbi$Count, na.rm=TRUE)
sd(fbi$Count, na.rm=TRUE)

library(ggplot2)
library(tidyverse)
fbi %>% ggplot(aes(x = Count)) + geom_histogram()


ggplot(data = fbiwide, aes(x = Population, y = Burglary)) +
  geom_point()

ggplot(data = fbiwide, aes(x = Population, y = Burglary,
                           colour = Abb)) +
  geom_point()


ggplot(data = fbiwide, aes(x = Population, y = Motor.vehicle.theft,
                           colour = Abb)) +
  geom_point()


# install.packages("tidyverse")
library(tidyverse)

?`%>%`
fbiwide %>%
  ggplot(aes(x = Year, y = Burglary, colour = Abb)) +
  geom_point()


fbiwide %>%
  ggplot(aes(x = Year, y = Burglary/Population, colour = Abb)) +
  geom_point() +
  facet_wrap(~Abb)

fbiwide %>%
  mutate(Abb = reorder(Abb, Burglary/Population, mean, na.rm=TRUE)) %>%
  ggplot(aes(x = Year, y = Burglary/Population, colour = Abb)) +
  geom_point() +
  facet_wrap(~Abb)
