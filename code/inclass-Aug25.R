# devtools package installed?
library(devtools)

# fails?
# install.packages("devtools")

install_github("heike/classdata", force = TRUE)
library(classdata)
