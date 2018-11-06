data(french_fries, package="reshape2")

library(tidyverse)
ffg <- french_fries %>% 
  gather(scale, score, potato:painty)
head(ffg)
tail(ffg)


# Use spread from the tidyr package to get a format in 
# which you can directly compare values from week 1 to 
# week 10. Plot a scatterplot of values in week 1 against week 10. Facet by treatment and scale, color by individuals and use different shapes for the replicates. Is there a pattern visible?

ffg %>% spread(time, score) %>%
  ggplot(aes( x = `1`, y = `10`, colour=subject)) +
  geom_point() +
  facet_grid(treatment~scale) +
  geom_abline()

library(devtools)
#install_github("heike/classdata")
library(classdata)

head(fbiwide)
fbi <- fbiwide %>% gather(Type, Incidences, 
                          Aggravated.assault:Robbery)
fbi <- fbi %>% mutate(
  Rate = Incidences/Population*100000
)

# Iowa and Minnesota
iamn <- fbi %>% filter(Abb %in% c("IA", "MN"))
iamn %>% select(Year, Type, Abb, Rate) %>%  
  spread(Abb, Rate) %>%
  ggplot(aes(x = IA, y = MN)) +
  geom_point()


#################
url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)
campaign %>% separate(`City Coordinates`,
                      into=c("address", "coords"),
                      sep="\\(")
