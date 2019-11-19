library(tidyverse)
library(GGally)
data(nasa)
nasa %>% filter(x ==1, y %in% c(1,10)) %>%
  ggplot(aes(x = time, y = temperature, group=id, colour=id)) + geom_line()

nasa %>% filter(x ==1, y %in% c(1,10)) %>%
  ggplot(aes(x = time, y = temperature)) + geom_point()

nasa %>% ggplot(aes(x = x, y=y)) + geom_point()

#nasa2 %>% ggplot(aes(x = Gridx, y=-Gridy, colour=log(elev))) +
#  geom_point(size=4)

nasa %>% ggplot(aes(x = time, y=ozone, group=id)) +
  geom_line(alpha=0.1)

nasa %>% ggplot(aes(x = time, y=surftemp, group=id)) +
  geom_line(alpha=0.1) + facet_wrap(~lat>0)


nasa %>% ggplot(aes(x = time, y=pressure, group=id)) +
  geom_line() + facet_wrap(~lat>0)

states <- map_data("state")
head(states)

states %>% ggplot(aes(x=long, y=lat)) + geom_point()

states %>% arrange(desc(lat)) %>%
  arrange(order) %>%
  ggplot(aes(x=long, y=lat, group=group)) + geom_path()

states %>% arrange(desc(lat)) %>%
  arrange(order) %>%
  ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon(colour="white")


states %>% arrange(desc(lat)) %>%
  arrange(order) %>%
  ggplot(aes(x=long, y=lat, group=group, fill=lat)) +
  geom_polygon(colour="white")

counties <- map_data("county")
counties %>% ggplot(aes(x = long, y=lat, group=group,
                        fill=subregion=="story")) +
  geom_polygon()

counties %>% select(region, subregion) %>% unique() %>%
  count(subregion) %>% arrange(desc(n))

library(classdata)
head(fbiwide)

fbi16 <- fbiwide %>% filter(Year==2016)

head(fbi16)
head(states)
fbi16$region <- tolower(fbi16$State)

fbi.map <- fbi16 %>% left_join(states, by="region")

head(fbi.map)
fbi.map %>% ggplot(aes(x= long, y=lat, fill=Motor.vehicle.theft/Population*70000, group=group)) +
  geom_polygon() +
  scale_fill_gradient2(midpoint=median(70000*fbi16$Motor.vehicle.theft/ fbi16$Population))

