data(french_fries, package="reshape2")
library(tidyr)
?gather
ff <-  french_fries %>% gather(scale, score, potato:painty)
?starts_with
french_fries %>% pivot_longer(names_to="scale", values_to = "score",
                               c(potato:painty)) %>% data.frame()

ff %>%
  ggplot(aes(x = time, y = score)) + geom_point() +
  facet_wrap(~scale) + geom_smooth()
str(ff)
levels(ff$time)

ff %>%
  ggplot(aes(x = as.numeric(time), y = score)) + geom_point() +
  facet_wrap(~scale) + geom_smooth()


ff %>% spread(key=time, value = score) %>%head()
?spread
ffw <- ff %>% pivot_wider(names_from=time, values_from = score)
ffw %>% ggplot(aes(x = `1`, y = `10`, colour=treatment)) + geom_point() +
  facet_wrap(~scale) + geom_abline()

#####
library(classdata)

fbi_long <- fbiwide %>% pivot_longer(names_to="Type", values_to = "Incidences",
                         Aggravated.assault:Robbery)
head(fbi_long)

fbi_long$Rate <- fbi_long$Incidences/fbi_long$Population*70000

fbi_long %>% filter(Abb %in% c("IA", "MN"), Year == 2014) %>%
  select(-State, -Population, -Incidences) %>%
  pivot_wider(names_from="Abb", values_from="Rate")


?separate

url <- "https://github.com/Stat579-at-ISU/materials/blob/master/03_tidyverse/data/Iowa_Liquor_Sales.csv.zip?raw=TRUE"
download.file(url, "iowa.zip")
iowa <- readr::read_csv("iowa.zip")

iowa %>% arrange(desc(`Volume Sold (Liters)`)) %>% select(`Bottles Sold`)
iowa %>% group_by(`Store Number`) %>%
  summarize(n = length(unique(`Store Name`))) %>%
  arrange(desc(n))

length(unique(iowa$`Store Number`))
length(unique(iowa$`Store Name`))

iowa %>% group_by(Date) %>%
  summarize(
    sold = sum(`Volume Sold (Gallons)`, na.rm = TRUE)
  ) %>% arrange(desc(sold))
