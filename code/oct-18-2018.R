data("french_fries", package="reshape2")
library(tidyverse)

ffm <- french_fries %>% 
  gather(key=scale, value=score, -(1:4))

ffm %>% spread(key=time, value=score) %>% 
  ggplot(aes(x = `1`, y = `10`)) +
  geom_point() +
  facet_grid(treatment~scale) +
  geom_abline()

##########################
# Your turn

data("fbiwide", package="classdata") 

fbi <- fbiwide %>% 
  gather(key=Type,  value=Incidence, 
                          Aggravated.assault:Robbery)
fbi <- fbi %>% mutate(
  Rate = Incidence/Population
)

iamn <- fbi %>% filter(Abb %in% c("IA", "MN"))
iamn1 <- iamn %>% 
  select(-Abb, -Population,-Incidence) %>%
  spread(key=State, value=Rate) 

iamn1 %>%
  ggplot(aes(x = Iowa, y = Minnesota)) +
  geom_point() +
  geom_abline()

iamn2 <- iamn %>% 
#  select(-Abb, -Population,-Incidence) %>%
  spread(key=State, value=Rate) %>% 
  group_by(Year, Type) %>%
  summarize(
    n = n(),
    Iowa = mean(Iowa, na.rm=TRUE),
    Minnesota = mean(Minnesota, na.rm=TRUE)
  )
  
iamn2 <- iamn2 %>% select(-n)


######################
url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)

head(campaign$`City Coordinates`)

campaign <- campaign %>% separate(`City Coordinates`, 
                      into=c("address", "right"), sep="\\(")
# set remove to FALSE!!! 

head(campaign$right)
campaign %>% separate(right, into=c("lat", "long"), sep=", ") %>% 
  select(lat, long) %>% head()

campaign <- campaign %>% separate(right, into=c("lat", "long"), sep=", ")

campaign <- campaign %>% mutate(
  lat = as.numeric(lat),
  long = parse_number(long)
)

campaign %>% ggplot(aes(x = long, y = lat)) + geom_point()
campaign %>% ggplot(aes(x = long, y = lat)) + 
  geom_point() +
  xlim(c(NA, 180))
