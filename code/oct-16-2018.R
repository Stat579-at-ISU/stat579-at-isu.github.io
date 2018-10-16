iowa <- read.csv("http://www.hofroe.net/data/iowa-brfss-2012.csv")
library(tidyverse)
iowa %>% group_by(POORHLTH) %>% summarize(n=n()) %>% data.frame()
iowa <- iowa %>%
  mutate(
    POORHLTH = ifelse(POORHLTH==88, 0, 
                      ifelse(POORHLTH %in% c(77,99), NA,
                             POORHLTH))
  )
iowa %>% count(POORHLTH) %>% data.frame()

iowa %>% 
  group_by(X_AGE_G) %>%
  summarize(
    avepoor = mean(POORHLTH, na.rm=T),
    n = n(),
    non_missing = sum(!is.na(POORHLTH))
  )

iowa %>% 
  group_by(X_AGE_G) %>%
  summarize(
    avepoor = mean(POORHLTH, na.rm=T),
    n = n(),
    non_missing = sum(!is.na(POORHLTH))
  ) %>% ggplot() + geom_bar(aes(x = factor(X_AGE_G), weight = avepoor))


#####################
# Your Turn

# Use mutate to introduce a variable Rate into the fbi data
# Use mutate to reorder types of crimes by (median) rate.

library(classdata)
head(fbi)

fbi <- fbi %>% mutate(
  Rate = Count/Population*100000,
  Type = reorder(Type, Rate, FUN= median, na.rm=TRUE)
)

fbi %>% 
  ggplot(aes(x = Type, y = Rate)) +
  geom_boxplot() + coord_flip()

# Your Turn

# Introduce a ranking by rate for states for each type of crime and year.

fbi <- fbi %>% group_by(Type, Year) %>%
  mutate(
    Rank = rank(Rate)
  )

filter(fbi, Rank ==1) %>% summary()
  ggplot(aes(x = Abb)) + geom_bar() +
  facet_wrap(~Type, scales="free")
