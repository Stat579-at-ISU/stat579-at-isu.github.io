# --- Setup---------------------------------------------------------------------

# Reinstall classdata package to get updates
devtools::install_github("heike/classdata")

# Install ggmosaic
install.packages("ggmosaic")

library(classdata)
library(ggplot2)
library(dplyr)
# ------------------------------------------------------------------------------

# --- Factors in boxplots ------------------------------------------------------
data(fbi)
twoyear <- dplyr::filter(fbi, Year %in% c(1961, 2014))

# Year as a numeric variable
ggplot(data = twoyear,
       aes(x = Year,
           y = Count)) +
  geom_boxplot()

# Year as a factor
ggplot(data = twoyear,
       aes(x = factor(Year),
           y = Count)) +
  geom_boxplot()

# ------------------------------------------------------------------------------

# --- Data Types: Checking and Casting -----------------------------------------

str(fbi)

mode(fbi$Type) # Factors have mode numeric
mode(fbi$State)
mode(fbi$Year)

is.factor(fbi$Type)

is.character(fbi$State)

is.numeric(fbi$Year)
is.numeric(fbi$Count)
is.numeric(fbi$Violent.crime)

is.logical(fbi$Violent.crime)

as.factor(fbi$Year) # Creates factors
factor(fbi$Year) # same thing
all.equal(as.factor(fbi$Year), factor(fbi$Year))
# factor() lets you set levels, labels, 
# and order more easily

fbi$YearFac <- factor(fbi$Year)

### Casting between types

as.numeric(fbi$YearFac) # ???
# as.numeric gives the order of the labels, not the labels themselves

as.character(fbi$YearFac)
fbi$YearFac %>% as.character() %>% as.numeric()
all.equal(fbi$Year, 
          fbi$YearFac %>% as.character() %>% as.numeric())

# ------------------------------------------------------------------------------

# --- Levels of factor variables -----------------------------------------------
levels(fbi$YearFac)
levels(fbi$Type)

fbi$TypeSimple <- factor(
  fbi$Type,
  labels = c("Assault", "Burglary", "Larceny", "Rape (old)",
             "Car Theft", "Murder", "Rape", "Robbery")
) # Rename Type with short labels

levels(fbi$TypeSimple) # levels have now changed

# Manual reordering
levels(fbi$Type)
factor(fbi$Type,
       levels = c("Larceny.theft", "Burglary", "Motor.vehicle.theft",
                  "Aggravated.assault", "Robbery", "Legacy.rape",
                  "Murder.and.nonnegligent.Manslaughter", "Rape")) %>%
  levels(.)

# Reordering using another variable

reorder(fbi$Type, fbi$Count) %>% levels()
reorder(fbi$Type, fbi$Count, na.rm = T) %>% levels()

# ------------------------------------------------------------------------------

# --- Your Turn ----------------------------------------------------------------
# For this your turn use the fbi object from the classdata package.

# Introduce a rate of the number of reported offenses by population into the
# fbi data. You could use the Ames standard to make values comparable to a
# city of the size of Ames (population ~70,000).

fbi$rate <- fbi$Count/fbi$Population * 70000

# Plot boxplots of crime rates by different types of crime.
# How can you make axis text legible?

ggplot(data = fbi, aes(x = TypeSimple, y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# Reorder the boxplots of crime rates, such that the boxplots are ordered
# by their medians.
fbi$TypeSimple <- reorder(fbi$TypeSimple, fbi$rate, 
                          median, na.rm = T)
ggplot(data = fbi, aes(x = TypeSimple, y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# For one type of crime (subset!) plot boxplots of rates by state,
# reorder boxplots by median crime rates
filter(fbi, TypeSimple == "Car Theft") %>%
  mutate(State = reorder(State, rate, 
                              median, na.rm = T)) %>%
  ggplot(aes(x = State, y = rate)) + 
  geom_boxplot() + 
  coord_flip()

# ------------------------------------------------------------------------------

# --- Changing Levels' names ---------------------------------------------------
levels(fbi$Type)

levels(fbi$Type)[6] <- "Murder"

levels(fbi$Type)
# ------------------------------------------------------------------------------

################################################################################
# --- Visualizing Factor Variables ---------------------------------------------

library(classdata)
library(ggplot2)

data(fbi) # Reload - clean copy

ggplot(fbi, aes(x = Type, fill = Year)) + geom_bar() # no color

ggplot(fbi, aes(x = Type, weight = Count, fill = Year)) + geom_bar() # no color

ggplot(fbi, aes(x = Type, fill = factor(Year))) + geom_bar() # colors are fairly meaningless..

ggplot(fbi, aes(x = Type, weight = Count, fill = factor(Year))) +
  geom_bar() # Add in Count to get a sense of how common each crime is

# ------------------------------------------------------------------------------

# --- Example: Survival on the Titanic -----------------------------------------
head(titanic)
str(titanic)

# Barcharts of all variables
ggplot(titanic, aes(x = Survived)) + geom_bar()

ggplot(titanic, aes(x = Class)) + geom_bar()

ggplot(titanic, aes(x = Age)) + geom_bar()

ggplot(titanic, aes(x = Sex)) + geom_bar()

# position = 'fill'

ggplot(titanic, aes(x = Class, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Class, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Age, fill = Survived)) +
  geom_bar(position = "fill")

ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "fill")
ggplot(titanic) +
  geom_bar(aes(x = Sex, fill = Survived), 
           position = "fill")

# ------------------------------------------------------------------------------

# --- Two and more factor variables --------------------------------------------
library(ggmosaic)
ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex), 
                  fill = Survived, 
                  weight = 1)) +
  facet_grid(Age~Class)
# ------------------------------------------------------------------------------

# ---  Your turn ---------------------------------------------------------------
# For this your turn use the titanic object from the classdata package.
# You might have to update the package using the command:
#   devtools::github_install("heike/classdata")

# Draw a barchart of Gender. Interpret.

ggplot(titanic, aes(x = Sex)) + geom_bar()

# Map survival to fill color in the barchart of Gender. Interpret.

ggplot(titanic, aes(x = Sex, fill = Survived)) + geom_bar()

# In the previous barchart change the position parameter to "fill". Interpret.

ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "fill")

# Read up on the position parameter in ?geom_bar. Try out other options for position.
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "stack")
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "dodge")
ggplot(titanic, aes(x = Sex, fill = Survived)) + 
  geom_bar(position = "dodge2")
# ------------------------------------------------------------------------------
