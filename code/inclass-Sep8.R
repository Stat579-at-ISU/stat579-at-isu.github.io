library(tidyverse)

# update classdata package heike/classdata
# remotes::install_github("heike/classdata")
library(classdata)

fbiwide %>%
  ggplot(aes(x=Year, y=Murder)) +
  geom_point() +
  facet_wrap(~State)
# help for facet_wrap

fbiwide %>%
  ggplot(aes(x=Year, y=Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State)

fbiwide %>%
  ggplot(aes(x=Year, y=log10(Motor.vehicle.theft))) +
  geom_point() +
  facet_wrap(~State)

fbiwide %>%
  ggplot(aes(x=Year, y=Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales="free_y")


ggplot(data = fbi, aes(x = Type, y = log10(Count),
                       fill = Type)) +
  geom_boxplot() +
  coord_flip() +
  theme_bw() +
  theme(legend.position="none")

#########
# Your Turn

fbiwide %>%
  ggplot(aes(x = Abb, y = Robbery)) +
  geom_boxplot()

# result is dubious
fbiwide %>%
  ggplot(aes(x = Abb, y = log10(Robbery))) +
  geom_boxplot()

fbiwide %>%
  ggplot(aes(x = Abb, y = Robbery/Population*100000)) +
  geom_boxplot()

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=50000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=10000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(bins=10)

fbi %>%
  ggplot(aes(x = Count/Population*100000, fill=Type)) +
  geom_histogram(bins=100) +
  facet_wrap(~Type)

fbi %>%
  ggplot(aes(x = Type)) + geom_bar()

fbi %>%
  ggplot(aes(x = Type, weight=Count)) + geom_bar()
