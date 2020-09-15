library(tidyverse)
states <- map_data("state")
head(states)
states %>%
ggplot(aes( x = long, y = lat)) + geom_point()
states %>%
ggplot(aes( x = long, y = lat)) + geom_path()
states %>%
ggplot(aes( x = long, y = lat, group=group)) + geom_path()
states %>%
ggplot(aes( x = long, y = lat, group=region)) + geom_path()
states %>%
ggplot(aes( x = long, y = lat, group=group)) + geom_path()
states %>%
ggplot(aes( x = long, y = lat, group=group)) + geom_polygon()
states %>%
ggplot(aes( x = long, y = lat, group=group)) + geom_polygon(size=1)
states %>%
ggplot(aes( x = long, y = lat, group=group)) + geom_polygon(colour="white")
head(states)
states %>%
ggplot(aes( x = long, y = lat, group=group, fill=long)) +
geom_polygon(colour="white")
counties <- map_data("county")
counties %>%
ggplot(aes( x = long, y = lat, group=group, fill=long)) +
geom_polygon(colour="white")
counties %>%
ggplot(aes( x = long, y = lat, group=group, fill=subregion=="story")) +
geom_polygon(colour="white")
us_counties <- counties %>%
group_by(region, subregion) %>% summarize(n=n())
head(us_counties)
us_counties %>% count(subregion, sort=TRUE)
us_counties %>% ungroup(region) %>% count(subregion, sort=TRUE)
#####
library(classdata)
head(fbi)
fbi <- fbi %>% mutate(
region = tolower(State)
)
head(fbi)
tail(fbi)
fbi17 <- fbi %>% filter(Year == 2017)
fbi_map <- fbi17 %>% left_join(states, by="region")
fbi17 %>% count(Type)
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Motor.vehicle.theft") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter ") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter ") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon() +
scale_fill_gradient()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon() +
scale_fill_gradient2(midpoint = 8)
fbi17 %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
summary()
fbi17 %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
summary()
fbi_map %>%
mutate(
Rate = Count/Population*60000
) %>%
filter(Type=="Murder.and.nonnegligent.Manslaughter") %>%
ggplot(aes(x = long, y = lat, group=group, fill=Rate)) +
geom_polygon() +
scale_fill_gradient2(midpoint = 3.11)
