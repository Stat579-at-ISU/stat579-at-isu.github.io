library(tidyverse)
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

campaign %>% ggplot(aes(x = long, y = lat)) + 
  geom_point() +
  xlim(c(NA, -50))

############################

library(classdata)
head(box)

movies <- box %>% select(Movie, Distributor) %>% unique()
movies %>% group_by(Movie) %>% tally() %>% arrange(desc(n))

movies %>% filter(Movie=="Beauty and the Beast")

##############################

library(Lahman)
HallOfFame %>% filter(yearID == 2017) %>% head()
Master %>% filter(playerID %in% c("bagweje01", "raineti01", "rodriiv01"))

dim(Master)
dim(HallOfFame)
HallOfFame <- HallOfFame %>% 
  left_join(Master %>% select(playerID, nameFirst, nameLast, deathDate),
            by = "playerID")
HallOfFame %>% filter(inducted=="Y", is.na(deathDate)) %>% dim()

HallOfFame %>% filter(nameFirst == "Sammy")
