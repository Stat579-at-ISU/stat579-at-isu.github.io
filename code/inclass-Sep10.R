library(tidyverse)
library(classdata) # remotes::install_github("heike/classdata")

fbiwide %>%
  ggplot(aes(x = Year, y = Murder)) +
  geom_point() +
  facet_wrap(~State)

# Your Turn
fbiwide %>%
  ggplot(aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State)

fbiwide %>%
  ggplot(aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State) +
  scale_y_log10()

fbiwide %>%
  ggplot(aes(x = Year, y = Motor.vehicle.theft)) +
  geom_point() +
  facet_wrap(~State, scales = "free_y")

fbi %>%
  ggplot(aes(x = Type, y = Count)) +
  geom_boxplot() +
  coord_flip()

fbi %>%
  ggplot(aes(x = Count, y = Type, fill = Type)) +
  geom_boxplot() +
  scale_x_log10()

# Histogram

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=50000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft)) +
  geom_histogram(binwidth=5000)

fbiwide %>%
  ggplot(aes(x = Motor.vehicle.theft, fill=factor(Year))) +
  geom_histogram(binwidth=5000)

fbiwide %>%
  ggplot(aes(y = Motor.vehicle.theft, fill=factor(Year))) +
  geom_histogram(binwidth=5000)


###

fbi %>%
  ggplot(aes(x = Type)) +
  geom_bar()

fbi %>%
  ggplot(aes(x = Type, weight = Count)) +
  geom_bar()

### Your Turn

fbi %>%
  ggplot(aes(x = Violent.crime, weight=Count, fill=Type)) +
  geom_bar()

fbi %>%
  ggplot(aes(x = Count)) + facet_wrap(~Type, scales="free") +
  geom_histogram()

