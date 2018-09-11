x <- 2/3
y = 2/3

2/3 -> z

sqrt(x^2)

y <- c(5,4,6,9)
y
y[1]
y[2]
y[-1]
y[-2]

1:3
1:10
3.5:8

y[1:2]
y[c(1,3)]
mean(y)
y
# doesn't work y[1,3]
2*y
y + c(1,-1) # shorter vector is re-used
y + c(1,-1,0)
sum(y)
sd(y)

x <- c(4,1,3,9)
y <- c(1,2,3,5)
sqrt(sum((x-y)^2))

# not correct sqrt(sum(x-y)^2)
?sqrt

#install.packages("devtools")
library(devtools)
install_github("heike/classdata")
library(classdata)
?fbi
