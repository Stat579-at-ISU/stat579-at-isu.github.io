library(dplyr)
library(ggplot2)
library(readr)
starwars <- read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/star-wars-survey/StarWars.csv")

# the following lines are necessary to fix the multibyte problem and make proper names
# part of the names:
line1 <- names(starwars)
line2 <- unlist(starwars[1,])
varnames <- paste(line1, line2)
# clean up some of the multibyte characters:
names(starwars) <- enc2native(stringi::stri_trans_general(varnames, "latin-ascii"))

starwars <- starwars[-1,]
head(starwars)


names(starwars)[4] <- "Star Wars: Episode I  The Phantom Menace"

library(tidyverse)
library(tidyr)
starlong <- starwars %>% gather(key=Episode, value = Score, 10:15)

starlong2 <- starwars %>% pivot_longer(names_to="Episode", values_to="Score", 10:15)

identical(starlong, starlong2)
# not identical, because observations are ordered differently

starlong %>% select(Score, Episode) %>% head(10)
starlong2 %>% select(Score, Episode) %>% head(10)

identical(starlong %>% arrange(Episode), starlong2 %>% arrange(Episode))
# now they are identical - only order of observations was different


#####

url <- "https://github.com/Stat579-at-ISU/materials/blob/master/03_tidyverse/data/Iowa_Liquor_Sales.csv.zip?raw=TRUE"
download.file(url, "iowa.zip", mode="wb")
iowa <- readr::read_csv("iowa.zip")

which.max(iowa$`Volume Sold (Liters)`)
iowa[273099,]$`Bottles Sold`

iowa %>% arrange(desc(`Volume Sold (Gallons)`)) %>%
  select(`Volume Sold (Liters)`, `Bottles Sold`)


iowa %>% select(`Store Name`, `Store Number`) %>% unique() %>%
  group_by(`Store Number`) %>% tally() %>% arrange(desc(n))


iowa %>% count(`Store Number`)

iowa %>% arrange(desc(`Volume Sold (Gallons)`)) %>%
  select(`Volume Sold (Liters)`, `Bottles Sold`, Date)

mean(iowa$`Sale (Dollars)`, na.rm=TRUE)

iowa %>% separate(`Store Location`, into = c("foo", "latitude", "longitude"), sep=" ",  remove=FALSE) %>%
  select(`Store Location`, foo, latitude, longitude)

?parse_number
parse_number(iowa$`Store Location`) %>% head()

iowa %>% separate(`Store Location`, into = c("foo", "latitude", "longitude"), sep=" ",  remove=FALSE) %>%
  mutate(
    latitude = parse_number(latitude),
    longitude = parse_number(longitude)
  ) %>%
  select(`Store Location`, foo, latitude, longitude)

iowa <- iowa %>% separate(`Store Location`, into = c("foo", "latitude", "longitude"), sep=" ",  remove=FALSE) %>%
  mutate(
    latitude = parse_number(latitude),
    longitude = parse_number(longitude)
  )

iowa %>% separate(Date, remove=FALSE,  into=c("Month", "Day", "Year")) %>%
  select(Date, Month, Day, Year)

#install.packages("Lahman")
library(Lahman)
LahmanData

tail(HallOfFame)
ind18 <- HallOfFame %>% filter(yearID==2018, inducted=="Y")

Master %>% filter(playerID=="jonesch06")
Master %>% filter(playerID=="guerrvl01")


