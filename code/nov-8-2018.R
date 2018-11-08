data(nasa, package="GGally")

library(tidyverse)
nasa %>% filter(x == 1, y == 1) %>%
  ggplot(aes( x= time, y = surftemp)) + 
  geom_point()

nasa %>% filter(x == 1, y == 1) %>%
  ggplot(aes( x= time, y = surftemp)) + 
  geom_line()


nasa %>% filter(x == 1, y %in% c(1, 10)) %>%
  ggplot(aes( x= time, y = surftemp,group=id,
              colour = id)) + 
  geom_line()

###################################
# for one location, draw a time line of Ozone over the time frame (time).

nasa %>% filter(x == 1, y %in% c(1, 10)) %>%
  ggplot(aes( x= time, y = ozone, group=id,
              colour = id)) + 
  geom_line()

#Plot separate lines for each of the years, 
# i.e. put month on the x-axis and ozone on the y-axis 
#for the same location. Is there a seasonal pattern apparent?

nasa %>% filter(x == 1, y == 10) %>%
  ggplot(aes( x= month, y = ozone, group=year,
              colour = factor(year))) + 
  geom_line()


#  Pick a location with x in 1:10 and y in 7:10. Plot temperature over time. Comment on the result.
nasa %>% filter(x %in% 1:10, y %in% 7:10) %>%
  ggplot(aes( x= time, y = temperature, group=id)) + 
  geom_line()


states <- map_data("state")
head(states)
states %>% ggplot(aes( x = long, y = lat)) + 
  geom_point()

states %>% ggplot(aes( x = long, y = lat, group= group)) + 
  geom_path()

states %>% ggplot(aes( x = long, y = lat, group= group)) + 
  geom_polygon(colour="grey30")

states %>% ggplot(aes( x = long, y = lat, 
                       group= group, fill=region)) + 
  geom_polygon(colour="grey30") +
  theme(legend.position="none")

states %>% ggplot(aes( x = long, y = lat, 
                       group= group, fill=lat)) + 
  geom_polygon(colour="grey30") 


counties <- map_data("county")
counties %>% 
  ggplot(aes( x = long, y = lat, group = group,
              fill = subregion=="story")) +
  geom_polygon()

states %>% ggplot(aes( x = long, y = lat, 
                       group= group, fill=region)) + 
  geom_polygon(colour="grey30") +
  theme(legend.position="none")

counties %>% group_by(region, subregion) %>% 
  summarize(numpoints = n()) %>%
  ungroup() %>%
  count(subregion) %>%
  arrange(desc(n))


# Draw a choropleth map of the rate of motor vehicle thefts in 2012 across the US.
library(classdata)
fbi17 <- filter(fbi, Year==2017) 
fbi17$region <- tolower(fbi17$State)

anti_join(fbi17, states, by="region")
# scale_fill_gradient2 allows you to set a color scheme with two main colors. Read up on it and change the scheme in the first choropleth map.
fbi.map <- fbi17 %>% left_join(states, by="region")

fbi$Rate <- fbi$Count/fbi$Population*100000
med <- median(filter(fbi, Type == "Motor.vehicle.theft", Year >= 2010)$Rate)
  
fbi %>% 
  mutate(
    region = tolower(State)
  ) %>%
  left_join(states, by="region") %>%
  mutate(
    Rate = Count/Population*100000
  ) %>%
  filter(Type == "Motor.vehicle.theft", Year >= 2010) %>%
  ggplot(aes(x = long, y=lat, group=group, fill = Rate)) +
  geom_polygon() +
  facet_wrap(~Year) +
  scale_fill_gradient2(midpoint=med, low="darkblue", high="darkred")

