library(Lahman)
library(tidyverse)
HallOfFame %>% filter(yearID >= 2018, inducted=="Y") %>% head()

Master %>% filter(playerID == "jonesch06")
Master %>% filter(playerID == "guerrvl01")
Master %>% filter(playerID == "thomeji01")

# hof <- HallOfFame %>% filter(is.na(deathYear))
hofplus <- HallOfFame %>% left_join(Master, by="playerID")
hofplus <- left_join(HallOfFame, Master, by="playerID")

hoffull <- HallOfFame %>% full_join(Master, by="playerID")


hofplus %>% filter(is.na(deathYear), inducted=="Y") %>% dim()

hofplus %>% filter(nameLast=="Sosa")

#######
library(classdata)
devtools::install_github("heike/classdata")
library(classdata)
summary(iowa$Date)
head(iowa$Date)

library(lubridate)
str(mdy("11/19/2019"))

summary(mdy(iowa$Date))
# accessor functions:

iowa$Date <- mdy(iowa$Date)
summary(iowa$Date)
summary(year(iowa$Date))

iowa %>% ggplot(aes(x = year(Date))) + geom_bar()
?wday

wday(dmy("01/05/2014"), label=TRUE, abb=FALSE)
wday(now(), label=TRUE)
now()

mday(now())

yday(now())

mdy("12/25/2019") - mdy("11/19/2019")

now <- now()

### Your Turn
iowa %>% ggplot(aes(x = year(Date))) + geom_bar()
iowa %>% ggplot(aes(x = year(Date),
                    weight=`Volume Sold (Gallons)`)) + geom_bar()

iowa %>% ggplot(aes(x = wday(Date, label=TRUE))) + geom_bar() +
  facet_wrap(~year(Date))
iowa %>% ggplot(aes(x = wday(Date, label=TRUE),
                    weight=`Volume Sold (Gallons)`/100000)) + geom_bar()



