library(tidyverse)
#################
url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)
campaign <- campaign %>% separate(`City Coordinates`,
                      into=c("address", "coords"),
                      sep="\\(")
campaign <- campaign %>% separate(coords,
                                  into=c("latitude", "longitude"),
                                  sep=",")
as.numeric(c(" -1", "4)"))
str(c(" -1", "4)", " 5 -- 7"))
parse_number(c(" -1", "4)", " 5 -- 7"))
campaign <- 
  campaign %>% mutate(
    latitude = parse_number(latitude),
    longitude = parse_number(longitude)
  )

campaign %>% 
  filter(longitude < 0) %>%
  ggplot(aes(x = longitude, y = latitude)) + 
  geom_point()


#####################
library(Lahman)
LahmanData
head(Master)
head(HallOfFame)
HallOfFame %>% filter(yearID==2017, inducted=="Y")
Master %>% filter(playerID == "bagweje01")
Master %>% filter(playerID == "raineti01")
Master %>% filter(playerID == "rodriiv01")


### Your Turn

# Join (relevant pieces of) the Master data set and the HallOfFame data.
hof <- HallOfFame %>% left_join(Master, by="playerID")

# Find all Hall of Famers who were alive as of 2017.
hof %>% filter(is.na(deathYear), inducted=="Y") %>% nrow()

# How many attempts at being inducted to the HoF does Sammy Sosa have already?
hof %>% filter(nameFirst=="Sammy")
