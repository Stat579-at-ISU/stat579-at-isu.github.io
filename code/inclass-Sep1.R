library(ggplot2)

ggplot(data = fbiwide, aes(x = Year, y = Burglary)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary, color = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Population, y = Burglary, color = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary/Population, color = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Murder/Population, color = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Murder/Population*100000,
           color = Abb)) +
  geom_point()

library(plotly)
ggplotly() # takes last ggplot2 plot and makes it interactive

# for the pipe operator %>%
library(magrittr) # or
library(dplyr)


fbiwide %>%
  ggplot(aes(x = Population, y=Larceny.theft)) +
  geom_point()

fbiwide %>%
  ggplot(aes(x = log10(Population), y=log10(Larceny.theft))) +
  geom_point()

ggplot(aes(x = log(Burglary), y = log(Motor.vehicle.theft),
           colour=Year), data=fbiwide) + geom_point()


ggplot(data = fbiwide,
       aes(x = Population, y = Burglary, color = Year)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Population, y = Burglary,
           color = Year, size = Population)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Population, y = Burglary,
           color = Year, shape = Abb)) +
  geom_point()


