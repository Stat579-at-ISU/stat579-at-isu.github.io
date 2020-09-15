25 + 7 - 3
(1 + 3)^2
sqrt(25)

sin(pi/2)
exp(1)

a <- 1
a -> b

d = 2.5
e <- c(1,2,5,8,9)
d*e
e - 1

#############
# Your turn

x <- c(4,1,3,9)
y = c(1,2,3,5)

sqrt(sum((x-y)^2))

# be careful with parentheses!
sqrt((sum(x-y)^2))

######
# parts of vectors

x[1]
c(x[1], x[3])
x[c(1,3)]

x[c(1,3,1,3,1,3,1,3)]
1:5
1.5:10

#########

str(x)
str(a)

library(devtools)
library("devtools")
#install.packages("devtools") # uncomment this line in case of an error and run, then comment out again

install_github("heike/classdata") # if we get message, most likely the installation of the package is up-to-date
library(classdata)


#############
str(fbi)
View(fbi)
head(fbi)
tail(fbi)
dim(fbi) # dimension of the data
