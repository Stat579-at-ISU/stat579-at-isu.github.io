library(tidyverse)
library(GGally)
data(nasa, package="GGally")

nasa %>% filter(x ==1, y ==1) %>%
  ggplot(aes(x = time, y = temperature)) +
  geom_point()

nasa %>% filter(x ==1, y ==1) %>%
  ggplot(aes(x = time, y = temperature)) +
  geom_line()

nasa %>% filter(x ==c(1,10), y ==1) %>%
  ggplot(aes(x = time, y = temperature)) +
  geom_point()

nasa %>% ggplot(aes(x = long, y = lat, colour=y)) +
  geom_point()

nasa %>% filter(x ==c(1,10), y ==1) %>%
  ggplot(aes(x = time, y = temperature, 
             group=x)) +
  geom_line()

##########################
# Your Turn

nasa %>% filter(x ==1, y ==1) %>%
  ggplot(aes(x = time, y = ozone)) +
  geom_line()

nasa %>% filter(x ==1, y ==1) %>%
  ggplot(aes(x = month, y = ozone,
             group = year, colour=factor(year))) +
  geom_line() +
  geom_point()

nasa %>% filter(x ==1, y ==1) %>%
  ggplot(aes(x = month, y = ozone,
             group = year, colour=year)) +
  geom_line() +
  geom_point()

# Pick a location with x in 1:10 and y in 7:10. Plot temperature over time. Comment on the result.

nasa %>% filter(x %in% 1:10, y %in% 7:10) %>%
  ggplot(aes(x = time, y = temperature,
             group=interaction(x,y))) +
  geom_line() 

nasa %>% filter(x %in% 1:10, y %in% 7:10) %>%
  ggplot(aes(x = time, y = temperature,
             group=id)) +
  geom_line() 

##########################

states <- map_data("state")
states %>% ggplot(aes(x = long, y = lat)) +
  geom_point()

states %>% ggplot(aes(x = long, y = lat)) +
  geom_line()

states %>% arrange(lat) %>%
  arrange(order) %>%
  ggplot(aes(x = long, y = lat, group=group)) +
  geom_path()

states %>% arrange(lat) %>%
  arrange(order) %>%
  ggplot(aes(x = long, y = lat, group=group)) +
  geom_polygon(colour="white")

states %>% arrange(lat) %>%
  arrange(order) %>%
  ggplot(aes(x = long, y = lat, group=group, fill=region)) +
  geom_polygon(colour="white")

states %>% 
  ggplot(aes(x = long, y = lat, group=group, 
             fill=region=="iowa")) +
  geom_polygon()

#############
# 
counties <- map_data("county")
counties %>% 
  ggplot(aes(x = long, y = lat, group=group)) +
  geom_path()

counties %>% 
  ggplot(aes(x = long, y = lat, group=group, 
             fill=subregion=="story")) +
  geom_polygon()

counties %>% group_by(region, subregion) %>% 
  summarize(once = 1) %>% ungroup(region, subregion) %>% 
  count(subregion) %>% arrange(desc(n))

#################################
library(classdata)
data(fbi)

fbi$region <- tolower(fbi$State)

head(states)
fbi17 <- fbi %>% filter(Year==2017)

fbi.map <- fbi17 %>% left_join(states, by="region")
head(fbi.map)

fbi.map %>% filter(Type=="Motor.vehicle.theft") %>%
  mutate(Rate = Count/Population*100000) %>%
  ggplot(aes(x = long, y = lat, fill = Rate, group = group)) +
  geom_polygon()

fbi.map %>% filter(Type=="Larceny.theft") %>%
  mutate(Rate = Count/Population*100000) %>%
  ggplot(aes(x = long, y = lat, fill = Rate, group = group)) +
  geom_polygon()
