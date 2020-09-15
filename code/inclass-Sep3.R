# download a new version of classdata"
# remotes::install_github("heike/classdata")
library(classdata)
library(ggplot2)

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary, colour = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Population, y = Burglary, colour = Abb)) +
  geom_point()


ggplot(data = fbiwide,
       aes(x = Year, y = Burglary/Population,
           colour = Abb)) +
  geom_point()

library(plotly)
ggplotly() # make the last ggplot2 chart interactive

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary/Population,
           colour = Abb)) +
  geom_point()

ggplot(data = fbiwide,
       aes(x = Year, y = Burglary/Population,
           colour = Abb)) +
  geom_point() +
  facet_wrap(~State)

ggplot(data = fbiwide,
       aes(x = Year, y = Murder/Population*100000,
           colour = Abb)) +
  geom_point() +
  facet_wrap(~State)


