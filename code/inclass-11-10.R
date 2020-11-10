library(lubridate) # install.packages("lubridate")

now()
str(now()) # POSIXct format - date&time format

dmy("10.11.2020")
mdy("11/10/2020")

identical(dmy("10.11.2020"),
          mdy("11/10/2020")
)

##
url <- "https://raw.githubusercontent.com/Stat579-at-ISU/materials/master/04_charts/Crime-log-Nov05.csv"
isu <- read.csv(url, stringsAsFactors = FALSE)


str(isu)

isu <- isu %>% mutate(
  Date.Reported = mdy(Date.Reported)
)
summary(isu$Date.Reported)


isu %>%
  group_by(Date.Reported) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = Date.Reported, y = n)) + geom_point()

isu %>%
  filter(Date.Reported == ymd("2020-10-11"))

isu %>%
  filter(Date.Reported == ymd("2020-10-10"))
# ISU Cyclones won on Oct 10 against Texas Tech

wday(ymd("2020-10-10"), label=TRUE)

wday(ymd("2020-10-10"), label=FALSE)


## Your Turn

# How many incidences did ISU police report on Oct 10? Where did those occur?
isu %>%
  filter(Date.Reported == ymd("2020-10-10"))


#  Can you identify a pattern for the week? Draw a barchart.

isu %>%
  ggplot(aes(x = wday(Date.Reported, label=TRUE, week_start = 1))) + geom_bar()


# How many different Mondays, Tuesdays, Wednesdays ... are in the data?
60/7 # 8 or 9

isu <- isu %>% mutate(wday = wday(Date.Reported, label=TRUE))
isu %>% group_by(wday) %>%
  summarize(no_different = length(unique(Date.Reported)))


# On how many days were there no reports?
?complete
# create a full sequence of dates between minimum and maximum of Date.Reported range
isu %>% complete(Date.Reported = full_seq(Date.Reported, period=1)) %>%
  summary()


isu %>%
  group_by(Date.Reported) %>%
  summarize(n = n(), .groups="drop_last")

#################
isu %>% str()

isu <- isu %>% mutate(
  hour = Time.Reported %/% 100,
  minutes = Time.Reported %% 100
)

isu$DateTime.Reported <- isu$Date.Reported

hour(isu$DateTime.Reported) <- isu$hour
minute(isu$DateTime.Reported) <- isu$minutes

str(isu$DateTime.Reported)

isu %>%
  ggplot(aes(x = DateTime.Reported, y = wday)) + geom_point()

isu %>%
  ggplot(aes(x = hour)) + geom_histogram(binwidth=1)


######
# maps

states <- map_data("state")
states %>% ggplot(aes(x = long, y=lat)) + geom_point()

states %>% ggplot(aes(x = long, y=lat, group=group)) + geom_path()

states %>% ggplot(aes(x = long, y=lat, group=group)) + geom_polygon(fill="pink")

# Alaska and Hawaii ?
url <- "https://github.com/Stat579-at-ISU/materials/raw/master/data/states.rds"
download.file(url, destfile="states.rds", mode="wb")
statesplus <- readRDS("states.rds")
statesplus %>%
  ggplot(aes(x = long, y = lat, group=group)) +
  geom_path()


library(classdata)
fbi %>% head()
fbi$region <- tolower(fbi$State)
head(fbi)

mapcrime <- states %>% left_join(fbi, by="region")
mapcrime %>%
  filter(Year == 2016) %>%
  ggplot(aes(x = long, y=lat, fill= Count/Population*100000, group=group)) +
  geom_polygon() + facet_wrap(~Type) +
  scale_fill_gradient2(midpoint=2000)








