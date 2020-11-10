# install.packages("Lahman") # install once
library(Lahman)
View(LahmanData)

### Your turn

# Identify all players who were inducted in the Hall of Fame in 2018,
# by filtering the Master data for their player IDs.

HallOfFame %>% filter(yearID==2018, inducted=="Y")
inducted <- HallOfFame %>% filter(yearID==2018, inducted=="Y")

Master %>% filter(playerID == "jonesch06")
Master %>% filter(playerID == "guerrvl01")

Master %>% filter(playerID %in% inducted$playerID)


#### Your Turn

# Join (relevant pieces of) the Master data set and the HallOfFame data.

hofplus <- HallOfFame %>% left_join(Master, by = "playerID")

# introduces a lot missing values into the Master data set
masterplus <- Master %>% left_join(HallOfFame, by="playerID")

# Find all Hall of Famers who were alive in 2018
alive <- hofplus %>% filter(inducted=="Y", (is.na(deathYear) | deathYear > 2018))
nrow(alive)

# How many attempts at being inducted to the HoF does Sammy Sosa have already?
hofplus %>% filter(nameFirst=="Sammy", nameLast=="Sosa")

hofplus %>% filter(nameFirst=="Barry", nameLast=="Bonds")

#######
wallabies <- read.table("http://www.statsci.org/data/oz/wallaby.txt", sep="\t", header=TRUE)
wallabies <- wallabies %>% mutate(
  Anim = as.factor(Anim),
  Sex = as.factor(Sex)
)

wallabies %>%
  ggplot(aes(x = Age, y = Weight, colour = Sex)) +
  geom_point()

wallabies %>% filter(Age > 450, Weight < 30000)

wallabies %>%
  ggplot(aes(x = Age, y = Weight, colour = Sex)) +
  geom_point() +
  geom_text(aes(label=Anim),
            hjust = 0, nudge_x = 5,
            data = wallabies %>% filter(Age > 450, Weight < 30000))

wallabies %>%
  ggplot(aes(x = Age, y = Weight)) +
  geom_point(aes(colour = Sex)) +
  geom_text(aes(label=Anim),
            hjust = 0, nudge_x = 5,
            data = wallabies %>% filter(Age > 450, Weight < 30000)) +
  geom_point(data = wallabies %>% filter(Anim==75))


wallabies %>%
  ggplot(aes(x = Age, y = Head)) +
  geom_point(aes(colour = Sex)) +
  geom_text(aes(label=Anim),
            hjust = 0, nudge_x = 5,
            data = wallabies %>% filter(Age > 450, Weight < 30000)) +
  geom_point(data = wallabies %>% filter(Anim==75 | Anim==125)) +
  theme_bw() +
  xlab("Age (in days since birth)")

######

diff(wallabies$Age)
length(diff(wallabies$Age))
length(wallabies$Age)

wallabies <- wallabies %>%
  group_by(Anim) %>%
  arrange(Age) %>%
  mutate(
    Next = c(diff(Age), NA),
    Next2 = lead(Age) - Age
  )




