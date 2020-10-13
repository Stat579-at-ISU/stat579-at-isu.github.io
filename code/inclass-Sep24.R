a <- c(4:1,NA)
a[1]
a[c(3,1)]
a[c(1,3)]
a[c(1,1,1,1,1,1,1,1,4,4,4,4,4,4)]
a[10]
a[5]
a[-c(1,5)]

# bracket operator on the left hand, new value assigned to a[5]
a[5] <- -1


a <- replace(a, 5, 3)

replace(a, 5, NA)
a

replace(a, c(1,3,5), NA)
replace(a, c(1,3,5), c(4,6)) # works, but ....

##############
b <- ifelse(a == 3, NA, 2*a)
a

##############
url <- "https://raw.githubusercontent.com/Stat579-at-ISU/stat579-at-isu.github.io/master/homework/data/brfss-iowa-2018.csv"
iowa <- read.csv(url)

# 7777 and 9999 should be coded as missing values:
summary(iowa$HEIGHT3)
iowa <- iowa %>% mutate(
  height = HEIGHT3,
  height = ifelse(height %in% c(7777,9999), NA, height)
)

# fix all metric measurements
iowa <- iowa %>% mutate(
  metric = ifelse(height >= 9000, height - 9000, NA)
)

# standard height measurements have form fii
# feet in first digit, inch in last two
iowa <- iowa %>% mutate(
  feet = height %/% 100,
  inch = height %% 100
)

iowa <- iowa %>% mutate(
  height = ifelse(height >= 9000,
                  metric, # yes, height starts with 9000
                  feet*30.48 + inch*2.54) # no, height is in feet&inch
)
summary(iowa$height)
iowa %>% ggplot(aes(x = height)) + geom_histogram(binwidth=5)

##########
## Your turn

##

# Use the fbi data from the package classdata
# introduce a variable personal into the dataset that is TRUE
# for personal crimes, and FALSE for property crimes. Do not use the variable Violent.crime.

unique(fbi$Type)

fbi <- fbi %>% mutate(
  personal = Type %in% c("Murder.and.nonnegligent.Manslaughter",
                         "Legacy.rape", "Rape", "Aggravated.assault",
                         "Robbery")
)
summary(fbi$personal)
summary(fbi$Violent.crime)

# now introduce a variable class into the dataset that has two levels:
# personal and property classifying the types of crimes reported.
# Think of ifelse or replace.
fbi <- fbi %>% mutate(
  class = ifelse(personal == TRUE, "personal", "property")
)
summary(fbi$class)

#######

str(fbi)
summary(fbi$Year)
summary(factor(fbi$Year))

class(fbi)
is.data.frame(fbi)

is.factor(fbi$Year)
is.factor(factor(fbi$Year))

x <- c(1, 4, "3.5", pi, "seven", "1,024")
class(x)
is.character(x)

as.numeric(x)

fY <- factor(fbi$Year)
is.factor(fY)
as.character(fY)
summary(as.numeric(fY))
as.numeric(as.character(fY))

###
levels(fbi$Type)
levels(fbi$personal)
levels(factor(fbi$personal))


levels(fbi$Type)[3] <- "Theft"


fbi %>%
  ggplot(aes(x = Type, y = log(Count))) +
  geom_boxplot() + coord_flip()

fbi$Type <- factor(fbi$Type, levels = c("Theft", "Burglary", "Motor.vehicle.theft",
                            "Rape", "Legacy.rape", "Murder.and.nonnegligent.Manslaughter",
                            "Aggravated.assault", "Robbery"))

fbi %>%
  ggplot(aes(x = Type, y = log(Count))) +
  geom_boxplot() + coord_flip()

?reorder

reorder(fbi$Type, fbi$Count, FUN = median, na.rm=TRUE)

fbi %>%
  mutate(
    Type = reorder(Type, Count, median, na.rm=TRUE)
  ) %>%
  ggplot(aes(x = Type, y = log(Count))) +
  geom_boxplot() + coord_flip()


