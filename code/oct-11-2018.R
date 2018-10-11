library(classdata)
library(tidyverse)
#Use mutate to introduce a variable Rate into the fbi data
fbi <- fbi %>% mutate(
  Rate = Count/Population*70000
)
#Use mutate to reorder types of crimes by (median) rate.
fbi <- fbi %>% mutate(
  Type = reorder(Type, Rate, FUN=median, na.rm=TRUE)
)

#Plot crime rates by type in side-by-side boxplots. Medians of the boxplots should be ordered.

fbi %>% 
  ggplot(aes(x = Type, y = Rate)) + geom_boxplot() + 
  coord_flip()

# Your turn
# Introduce a ranking by rate for states for each type of crime and year.

fbi2 <- fbi %>% 
  group_by(Type, Year) %>%
  filter(!is.na(Rate)) %>%
  mutate(
    Rank = rank(Rate)
  )

top <- fbi2 %>% filter(Rank<=5)
top %>% 
  ggplot(aes(x = Abb)) + geom_bar(aes(fill=factor(Rank))) +
  facet_grid(~Type, scale="free", space="free")
# result is not consistent with documentation bc of missing values
# rank(c(NA, NA, NA, NA), ties.method="average")

library(plotly)
ggplotly()

data("french_fries", package="reshape2")
french_fries %>% gather(key=scale, value=score, 6:9)
