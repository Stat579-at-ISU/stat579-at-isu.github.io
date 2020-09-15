#devtools::install_github("heike/classdata")
# email to hofmann@iastate.edu if you encounter an error

library(tidyverse)
library(classdata)

fbiwide %>%
  ggplot(aes(x = Year, y = Murder, colour=Abb)) +
  geom_point()

fbiwide %>%
  ggplot(aes(x = Year, y = Murder, colour=Abb)) +
  geom_point() +
  facet_wrap(~Abb)

names(fbiwide)

# no context help without the pipe operator %>%
# ggplot(data=fbiwide, aes(x=))
fbiwide %>%
  ggplot(aes(x=Year, y=Motor.vehicle.theft)) + geom_point() +
  facet_wrap(~Abb)

fbiwide %>%
  ggplot(aes(x=Year, y=log(Motor.vehicle.theft))) + geom_point() +
  facet_wrap(~Abb)

fbiwide %>%
  ggplot(aes(x=Year, y=Motor.vehicle.theft)) + geom_point() +
  facet_wrap(~Abb, scales = "free_y")


fbiwide %>%
  ggplot(aes(x=Year, y=Motor.vehicle.theft/Population*70000)) +
  geom_point() +
  facet_wrap(~Abb)

#### Your Turn
fbiwide %>%
  ggplot(aes(x = Abb, y=log10(Robbery))) +
  geom_boxplot()

fbiwide %>%
  ggplot(aes(x = Abb, y=Robbery/Population*70000)) +
  geom_boxplot()

fbiwide %>%
  mutate(
    Abb = reorder(Abb, Robbery/Population*70000, median, na.rm=TRUE)
  ) %>%
  ggplot(aes(x = Abb, y=Robbery/Population*70000)) +
  geom_boxplot()

####
# Your Turn

fbi %>%
  ggplot(aes(x=Violent.crime, weight=Count, fill=Type)) +
  geom_bar()


fbi %>%
  ggplot(aes(x = Count)) +
  geom_histogram() +
  facet_wrap(~Type, scales="free")

##############
TRUE
T
F
FALSE
NA

x <- c(TRUE, T, T, F,F,F)
str(x)
