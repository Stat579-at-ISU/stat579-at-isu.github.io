install.packages("swirl")

library(swirl)
swirl()
install_course("Getting_and_Cleaning_Data")
swirl()
###############
library(tidyverse)
data(french_fries, package="reshape2")



ffm <- french_fries %>% gather(key=scale, value=score, potato:painty)
head(ffm)

french_fries %>% pivot_longer(cols = potato:painty, names_to="scale", values_to="score")

head(ffm)
ffw <- ffm %>% spread(key=rep, value=score)
cor(ffw$`1`, ffw$`2`, use = "pairwise")

ffw %>% ggplot(aes(x = `1`, y=`2`)) + geom_point()

ffw %>% ggplot(aes(x = `1`, y=`2`)) + geom_point() + facet_wrap(~scale)

ffm %>% filter(subject==3, treatment==1, scale=="potato", rep ==1)
ffm %>% filter(subject==3, treatment==1, scale=="potato", rep ==1) %>%
  spread(key=time, value=score)

ffw2 <- ffm %>%
  spread(key=time, value=score)
ffw2 %>% ggplot(aes(x = `1`, y = `10`, colour=factor(treatment))) + geom_point() + facet_wrap(~scale)

library(classdata)

fbil <- fbiwide %>% gather(key=Type, value=Incidences, Aggravated.assault:Robbery)
fbil <- fbil %>% mutate(
  Rate = Incidences/Population*70000
)

fbil %>% filter(Abb %in% c("IA", "MN"), Year==2016) %>%
  spread(key=State, value = Rate)

twostates <- fbil %>% filter(Abb %in% c("IA", "MN")) %>% select(-Incidences, -Abb, -Population) %>%
  spread(key=State, value = Rate)
twostates %>% ggplot(aes(x = Iowa, y = Minnesota)) + geom_point() + geom_abline()
