# install.packages("Lahman") # install once, update it on a yearly basis
library(Lahman)
LahmanData

head(HallOfFame)
tail(HallOfFame)

head(Master)

# Identify all players who were inducted in the Hall of Fame in 2018,
# by filtering the Master data for their player IDs.

inducted <- HallOfFame %>% filter(yearID==2018, inducted=="Y")

Master %>% filter(playerID=="jonesch06")
Master %>% filter(playerID=="guerrvl01")

Master %>% filter(playerID %in% inducted$playerID)


# Your Turn

# Join (relevant pieces of) the Master data set and the HallOfFame data.

hofplus <- HallOfFame %>% left_join(Master, by = "playerID")
# previous question
# hofplus %>% filter(yearID==2018, inducted=="Y") %>% select(nameFirst, nameLast)

masterplus <- Master %>% left_join(HallOfFame, by = "playerID")
# a lot more observations
masterplus %>% count(inducted)
# most rows are for people who were never considered on a ballot
rm(masterplus)

# Find all Hall of Famers who were alive as of 2018.
hofplus %>% filter(deathYear > 2018 | is.na(deathYear), inducted=="Y")

# How many attempts at being inducted to the HoF does Sammy Sosa have already?

hofplus %>% filter(nameFirst=="Sammy", nameLast=="Sosa")

hofplus <- hofplus %>% group_by(playerID) %>% mutate(attempt = n())
hofplus %>% filter(inducted=="Y") %>% arrange(desc(attempt)) %>% View()

####
library(lubridate)

str(now())

str(ymd("2020/12/25"))

# "2020-11-05 19:56:23 GMT"

str(mdy("11/5/2020"))
str(dmy("5.11.2020"))




