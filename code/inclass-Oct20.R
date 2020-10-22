library(dplyr)
library(ggplot2)
library(classdata)

# For this your turn use the fbi data from the classdata package
# Introduce a ranking by rate for states for each type of crime and year.

fbi <- fbi %>%
  group_by(Type, Year) %>%
  mutate(
    Rate = Count/Population*100000,
    Rank = rank(-Rate)
  ) %>%
  arrange(Rank)


# Focus on the top states.
# Find a visual that shows how often each state managed to take the top spot since 1961.

top <- fbi %>% filter(Rank == 1)

top %>% ggplot(aes(x = Abb)) +
  facet_wrap(~Type, scales="free_x") +
  geom_bar()

####################
data(french_fries, package="reshape2")

?pivot_longer


ff_tidy <- french_fries %>%
  pivot_longer(names_to="scale", values_to="score", cols=potato:painty)

ff_tidy %>%
  ggplot(aes(x = score)) + geom_histogram() + facet_wrap(~scale)

ff_tidy %>%
  pivot_wider(names_from=rep, values_from=score) %>%
  ggplot(aes(x = `1`, y = `2`)) +
  geom_point() +
  facet_wrap(~scale)


