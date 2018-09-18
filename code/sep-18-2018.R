a <- c(3,5,10,1,5, 3)
a < 3

a[a < 3]
a[a <= 3]

# use for updating:
a[a <= 3] <- 0
a
a[a == 0] <- NA
a

replace(a, a == 10, 9)
a # is unchanged

# make change permanent
a <- replace(a, a >= 10, 9)
a


#############################
library(classdata)
?fbi
library(tidyverse)
# or:  library(dplyr)

head(dplyr::filter(.data=fbi, Year==2016))
head(dplyr::filter(.data=fbi, Year==2016, 
                   Abb=="IA", Violent.crime==FALSE))
head(dplyr::filter(.data=fbi, Year==2016 &
                   Abb=="IA" & Violent.crime==FALSE))
# logical or: 
head(dplyr::filter(.data=fbi, Year==2016 &
                     (Abb=="IA" | Abb == "MN" ) & Violent.crime==FALSE))


## Your Turn

ia <- filter(fbi, Abb=="IA")
library(ggplot2)
ggplot(data=filter(ia, Type=="Burglary"), 
       aes(x = Year, Count)) +
  geom_point()
ggplot(data=filter(ia, Type=="Burglary"), 
       aes(x = Year, Count/Population)) +
  geom_point()

y2009 <- filter(fbi, Year == 2009)

ggplot(data=filter(y2009, Type=="Burglary"),
       aes(y=Abb, x = Count/Population)) +
  geom_point()


hlast5 <- filter(fbi, Year >= 2012, 
                 Type=="Murder.and.nonnegligent.Manslaughter")
hlast5$mrate <- hlast5$Count/hlast5$Population
?quantile
quantile(hlast5$mrate)
quantile(hlast5$mrate, probs = 0.9)
top10 <- filter(hlast5, mrate >= 7.425674e-05)

# cleaner:
q90 <- quantile(hlast5$mrate, probs = 0.9)
top10 <- filter(hlast5, mrate >= q90)
top10

ggplot(top10, aes(x = Abb)) + geom_bar()
# D.C. and Louisiana show up every year


nrow(top10)
nrow(hlast5)
nrow(fbi)
ncol(top10)

?which
which(hlast5$mrate>= q90)
hlast5[which(hlast5$mrate>= q90)[1:3],]

max(hlast5$mrate)
which.max(hlast5$mrate)
hlast5[91,]
