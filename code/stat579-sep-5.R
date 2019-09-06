# you should be able to install packages

# from CRAN with
install.packages("devtools")

# from github with
devtools::github_install("heike/classdata")


# What to do if package installation doesn't work out of the box?

# 1. download the github repository as a zip file
# 2. unzip it
# 3. (rename it to remove the extension -master) optional!!
# 4. check the path to the folder

# 5. install the package 'by hand':
devtools::install("path to folder/classdata")

# From here on I assume that you are able to load the classdata package:

library(classdata)

# object checking functions:
fbi
str(fbi)
summary(fbi)


data(fbiwide, package = "classdata")

# start plotting charts:
library(ggplot2)
ggplot(data = fbiwide, aes(x = Burglary, y = Murder)) +
  geom_point()

ggplot(data = fbiwide, aes(x = Population, y = Murder, colour=Abb)) +
  geom_point()

ggplot(data = fbiwide, aes(x = log(Burglary), y = log(Murder))) +
  geom_point()

ggplot(data = fbiwide, aes(x = Population)) + geom_histogram()
