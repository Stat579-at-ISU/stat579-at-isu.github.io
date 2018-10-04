library(classdata)
head(happy)
str(happy$happy)
levels(happy$happy)

library(tidyverse)
happy %>% mutate(
  nhappy = as.numeric(happy)
) %>% select(happy, nhappy) %>% tail(10)

happy <- happy %>% mutate(
  nhappy = as.numeric(happy)
)

happy %>% 
  summarize(
    happiness = mean(nhappy, na.rm=TRUE)
  )

# how does average happiness change over the course of a life time? 

byage <- happy %>% 
  group_by(age) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE)
  )  
byage %>% ggplot(
  aes(x = age, y = happiness)
) + geom_point()


happy %>% 
  group_by(age, sex) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE),
    n = length(nhappy)
  )  %>% 
  ggplot(
  aes(x = age, y = happiness, colour=sex)
) + geom_point() +
  facet_grid(.~sex)

# How is happiness related to time?

happy %>% 
  group_by(year) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE),
    n = length(nhappy)
  )  %>% 
  ggplot(
    aes(x = year, y = happiness)
  ) + geom_point() 

# Compare average happiness levels over partyid.

happy %>% 
  group_by(partyid) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE),
    n = length(nhappy)
  ) %>%
  ggplot(aes(y = partyid, x = happiness)) +
  geom_point()

happy %>% 
  group_by(partyid, year) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE),
    n = length(nhappy)
  ) %>%
  ggplot(aes(x = year, y = happiness, colour=partyid)) +
  geom_point()

# How are financial relations associated with average happiness levels? Is this association different for men and women?

happy %>% 
  group_by(finrela, sex) %>%
  summarize(
    happiness = mean(nhappy, na.rm=TRUE),
    n = length(nhappy)
  ) %>%
  ggplot(aes(x = finrela, y = happiness, colour = sex)) +
  geom_point()

