library(tidyverse)
library(classdata)

# your turn
fbi %>%
  filter(State == "Iowa") %>%
  filter(Type == "Robbery") %>%
  ggplot(aes(x = Year, y = Count/Population*70000, colour=Type)) + geom_point()


fbi %>%
  filter(Year == 2009) %>%
  filter(Type == "Robbery") %>%
  ggplot(aes(x = Abb, weight = Count/Population*70000)) +
  geom_bar()

fbi %>%
  filter(Year == 2009) %>%
  filter(Type == "Robbery") %>%
  ggplot(aes(x = Abb, y = Count/Population*70000)) +
  geom_point()

# not very sensible
fbi %>%
  filter(Year == 2009) %>%
  filter(Type == "Robbery") %>%
  ggplot(aes(x = Abb, y = Count/Population*70000)) +
  geom_boxplot()

##
last5 <- fbi %>% filter(Year >= 2013, Type == "Murder.and.nonnegligent.Manslaughter")
?quantile
quantile(last5$Count/last5$Population, na.rm=TRUE)
summary(last5$Count/last5$Population)
q90 <- quantile(last5$Count/last5$Population, na.rm=TRUE,
                probs = .9)

last5 %>%
  filter(Count/Population > q90) %>%
  ggplot(aes(x = Abb)) + geom_bar(aes(fill=factor(Year)))

last5 %>%
  filter(Count/Population > q90) %>%
  ggplot(aes(x = Abb, y = Year)) + geom_point()

which(last5$Abb == "IA")
?which

which(last5$Population == max(last5$Population))
last5[213,]

which.max(last5$Population)

which.min(last5$Population)
last5[260,]


ca_burg <- fbi %>%
  filter(Abb=="CA", Type=="Burglary")
dim(ca_burg)

pr_burg <- fbi %>%
  filter(Abb=="PR", Type=="Burglary")
dim(pr_burg)

length(which(fbi$Abb=="CA" & fbi$Type=="Burglary"))

violent <- filter(fbi, Violent.crime == TRUE, Year == 1961)
violent <- filter(fbi, Violent.crime, Year == 1961)

which.max(violent$Count/violent$Population)
#violent[8378,]
violent[which.max(violent$Count/violent$Population), ]

# DC, Aggravated Assault in both 1961 and 2014

fbiwide %>%
  filter(Year == 2011, Motor.vehicle.theft < Robbery)

#
fbiwide$Murder.rate

fbiwide$Murder.rate <- fbiwide$Murder/fbiwide$Population*70000

head(fbiwide)


fbiwide <- fbiwide %>% mutate(
  Murder.rate = Murder/Population*70000
)
##
# Your Turn
gap <- read.csv("https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/gapminder-5060.csv")
str(gap)

filter(gap, country=="Canada", year==1957)

gap <- gap %>% mutate(
  lifeExp = replace(lifeExp, country=="Canada" & year==1957, 69.96)
)

gap %>%
  filter(country=="Canada") %>%
  ggplot(aes(x = year, y = lifeExp)) + geom_point()

?ifelse

iowa <- read.csv(url <- "https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv")

iowa <- iowa %>% mutate(
  WEIGHT2 = replace(WEIGHT2, WEIGHT2 %in% c(7777, 9999), NA)
)

iowa <- iowa %>% mutate(
  WEIGHT2 = ifelse(WEIGHT2>9000, (WEIGHT2-9000)*2.2, WEIGHT2)
)

