library(classdata)
library(tidyverse)
# popup help does not work ...
ggplot(data = fbi, aes(x = Y))

# with pipe, popup help works
fbi %>% ggplot(aes(x = Year, 
                   y = Count)) + geom_point()


##########
?happy
levels(happy$happy)
happy$nhappy <- as.numeric(happy$happy)
# same as above:

happy <- happy %>% mutate(
  nhappy = as.numeric(happy)
)
head(happy)

# same as above:
happy <- happy %>% mutate(
  nhappy = ifelse(happy=="not too happy", 1, 
                  ifelse(happy=="pretty happy", 2, 3))
)
mean(happy$nhappy, na.rm=TRUE)

happy %>% summarize(
  avghappy = mean(nhappy, na.rm=TRUE)
)

happy %>%
  group_by(age, sex) %>%
  summarize(
  avghappy = mean(nhappy, na.rm=TRUE)
) %>%
  ggplot(aes(x = age, y = avghappy)) +
  geom_point() +
  facet_wrap(~sex)

happy %>%
  group_by(age, sex) %>%
  summarize(
    avghappy = mean(nhappy, na.rm=TRUE)
  ) %>%
  ggplot(aes(x = age, y = avghappy, colour=sex)) +
  geom_point() 

big <- happy %>%
  group_by(year,age, sex) %>%
  summarize(
    avghappy = mean(nhappy, na.rm=TRUE),
    n = n()
  )

happy %>%
  group_by(year, sex) %>%
  summarize(
    avghappy = mean(nhappy, na.rm=TRUE),
    n = n()
  ) %>%
  ggplot(aes(x = year, y = avghappy, colour=sex)) +
  geom_point() 

# Are Republicans or Democrats happier? Compare average happiness levels over partyid.

happy %>%
  group_by(partyid, sex) %>%
  summarize(
    avghappy = mean(nhappy, na.rm=TRUE),
    n = n()
  ) %>%
  ggplot(aes(x = partyid, y = avghappy, colour=sex)) +
  geom_point() +coord_flip()

# How are financial relations associated with average happiness levels? Is this association different for men and women?

happy %>%
  group_by(finrela, sex) %>%
  summarize(
    avghappy = mean(nhappy, na.rm=TRUE),
    n = n()
  ) %>%
  ggplot(aes(x = finrela, y = avghappy, 
             colour=sex)) +
  geom_point() +coord_flip()

