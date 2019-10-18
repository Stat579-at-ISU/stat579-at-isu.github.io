library(tidyverse)

url <- "https://github.com/Stat579-at-ISU/materials/blob/master/03_tidyverse/data/Iowa_Liquor_Sales.csv.zip?raw=TRUE"
download.file(url, "iowa.zip", mode="wb")
iowa <- readr::read_csv("iowa.zip")

?parse_number
parse_number(head(iowa$`Store Location`))
head(iowa$`Store Location`)

iowa <- iowa %>% separate(`Store Location`,
                        sep=" ", remove=FALSE,
                        into=c("foo1", "foo2", "foo3")) %>%
  mutate(
    longitude = parse_number(foo2),
    latitude=parse_number(foo3)
  ) %>%
  select(-starts_with("foo"))
iowa %>%
  ggplot(aes(x = longitude, y = latitude)) + geom_point()

# date:
str(iowa$Date)
library(lubridate)
str(mdy(iowa$Date))
summary(mdy(iowa$Date))

iowa <- iowa %>% separate(Date, sep="/",
                  into=c("Month", "Day", "Year"),
                  remove = FALSE) %>%
  mutate(
    Month = parse_number(Month),
    Day = parse_number(Day),
    Year = parse_number(Year)
  )

iowa %>% ggplot(aes(x = Year)) + geom_bar()

iowa %>% ggplot(aes(x = Year, weight=`Volume Sold (Gallons)`)) + geom_bar()

iowa %>% ggplot(aes(x = Year, weight=`Sale (Dollars)`)) + geom_bar()

iowa %>% group_by(`Store Number`) %>%
  summarize(n = length(unique(`Store Name`))) %>%
  arrange(desc(n))
iowa %>% filter(`Store Number`==4251) %>% count(`Store Name`)

#devtools::install_github("heike/classdata")

library(classdata)
head(box)



box %>% count(Movie, Date, sort=TRUE)
box %>% filter(Movie =="Mama Africa")


library(Lahman)
HallOfFame %>% filter(yearID >= 2017, inducted=="Y")

Master %>% filter(playerID == "raineti01")
