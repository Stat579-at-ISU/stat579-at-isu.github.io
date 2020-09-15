library(lubridate)
library(help=lubridate)

str(now())
str("10/31/2019")

str(mdy("10/31/2019"))

date <- mdy("10/31/2019")
date+70

month(date)
month(date, label=TRUE, abbr=FALSE)
year(date)

day(date)
mday(date)
yday(date)
wday(date, label=TRUE)
wday(mdy("01-01-2019"), label=TRUE)

library(classdata)
head(iowa)
str(iowa)
summary(iowa$Date)
summary(mdy(iowa$Date))
iowa$Date <- mdy(iowa$Date)
mean(iowa$Date)
diff(range(iowa$Date))

?wday

iowa %>%
  ggplot(aes(x = year(Date))) + geom_bar()

iowa %>%
  ggplot(aes(x = year(Date), weight=`Volume Sold (Gallons)`)) + geom_bar()

iowa$weekday <- wday(iowa$Date, label=TRUE)
iowa %>% ggplot(aes(x = weekday)) + geom_bar()
iowa %>% ggplot(aes(x = weekday, weight = `Sale (Dollars)`)) + geom_bar() +
  facet_wrap(~year(Date))

iowa %>% ggplot(aes(x = month(Date), weight = `Sale (Dollars)`)) + geom_bar() +
  facet_wrap(~year(Date))

iowa %>%
  group_by(Date) %>%
  summarize(n = n(), gallons = sum(`Volume Sold (Gallons)`)) %>% head()

iowa %>%
  group_by(Date) %>%
  summarize(n = n(), gallons = sum(`Volume Sold (Gallons)`)) %>% dim()

iowa %>% mutate(
  transaction = TRUE
) %>%
  complete(Date = seq(from = ymd("2012-01-03"), to = ymd("2019-09-30"), by =1)) %>%
  group_by(Date) %>%
  summarize(n = sum(transaction, na.rm=TRUE), gallons = sum(`Volume Sold (Gallons)`)) %>% summary()
