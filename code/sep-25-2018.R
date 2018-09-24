# A quick introduction to the pipe, %>%

a <- 1:10
a %>% mean()
mean(a)

# Pipes allow chaining of functions in a todo-style list
# data %>%
#   filter(...) %>%
#   arrange(variable) %>%
#   group_by(...) %>%
#   summarize()


# ------------------------------------------------------------------------------

# Warm up: Your turn (04_logical.html, slide 8)
# Use the fbi data from the classdata package
library(classdata)
library(dplyr)
library(ggplot2)
# Get a subset of all crimes in Iowa, Plot incidences/rates for one type of crime over time.
data(fbi)
head(fbi)
tmp <- fbi %>%
  filter(State == "Iowa", Type == "Murder.and.nonnegligent.Manslaughter") 
ggplot(data = tmp) + 
  geom_line(aes(x = Year, y = Count))

# Get a subset of all crimes in 2009. Plot the number or rate for one type of crime by state.

fbi %>%
  filter(Year == 2009) %>%
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  ggplot() + 
  geom_col(aes(x = State, y = Count/Population * 100000)) + 
  ylab("Murder rate per 100,000 people") + 
  coord_flip()

# Get a subset of the data that includes number of homicides for the last five years. 
# Find the rate of homicides, extract all states that have a rate of greater 
# than 90% of the rates across all states, and plot (Hint: ?quantile).
max(fbi$Year)
tmp <- fbi %>%
  filter(Year >= 2009) %>%
  filter(Type == "Murder.and.nonnegligent.Manslaughter") %>%
  group_by(State) %>%
  summarize(Count = sum(Count, na.rm = T), 
            Population = mean(Population)) %>%
  mutate(Rate = Count/Population * 100000)

threshold <- quantile(tmp$Rate, .9, na.rm = T)

filter(tmp, Rate >= threshold) %>%
  ggplot() + 
  geom_col(aes(x = State, y = Rate)) + 
  ylab("5-year Murder rate per 100,000 people") + 
  coord_flip()

# ------------------------------------------------------------------------------

nrow(fbi)

dim(fbi)

quantile(rnorm(10000), .95)
quantile(rnorm(10000), c(.9, .95, .99))

which(fbi$Type == "Rape")
which.max(fbi$Count)
which.min(fbi$Count)

# ------------------------------------------------------------------------------

# Use the fbi data object to answer the following questions:
# how many reports of Burglaries are there for California?

# for any of the violent crimes, which state had the highest rate (and for which crime) in 2014? in 1961?

# Use the fbiwide data object to answer the following question:
# in how many states in 2011 were there more vehicle thefts than robberies? (which states are those?)


# ------------------------------------------------------------------------------

x1 <- x2 <- sample(1:10, 10, replace = F)
x1

x1[x1 >= 9] <- 0
x1

replace(x2, x2 >= 9, 0)
x2

library(classdata)
# introduces new variable in the data set fbiwide
fbiwide$murder.rate <- fbiwide$Murder/fbiwide$Population*100000
names(fbiwide)