x <- c(4,1,3,9)
y <- c(1,2,3,5)

sqrt(sum((x-y)^2))

# wrong!!!!
sqrt(sum(x-y)^2)

?lm
help.search("logistic regression")

help.search("linear")

# the hash starts a comment
#install.packages("devtools")
library(devtools)

#install_github("heike/classdata")
library(classdata)
library(help = classdata)

head(fbi)
tail(fbi)

summary(fbi)
str(fbi)
dim(fbi)
