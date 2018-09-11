x <- 2/3 
y = 1/4

4/5 -> z

sqrt(x)
exp(x)
sin(y)

y <- c(4,1,3,6)
# doesn't work because the c is upper case: y <- C(4,1,3,6)

y
y[1]
y[4]
y[-1]
# get second and third value:
y[-1][-3]
y[c(2,3)]

##############################
# your turn

x <- c(4,1,3,9)
y <- c(1,2,3,5)

d <- sqrt(sum((x-y)^2))
d
# NOT CORRECT! sum(x-y)^2 

?lm
help("lm")  
help.search("linear model")  

###############################
library(devtools)
#install.packages("devtools")


