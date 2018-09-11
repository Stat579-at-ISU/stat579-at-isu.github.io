library(classdata)
# devtools::install_github("heike/classdata")
?fbi


fbi
summary(fbi)
head(fbi)
tail(fbi)
dim(fbi)
str(fbi)

fbi$Abb
summary(fbi$Abb)
head(fbi$Population)

fbi[1,]
fbi[1:5,]
fbi[1:5,1:3]
fbi[, "Year"]
fbi[, c("Year", "State")]

#####
# Your Turn

fbi[1:10,]
head(fbi, n=10)

mean(fbi$Population)
mean(fbi$Count)
summary(fbi$Count)
?mean
mean(fbi$Count, na.rm=TRUE)
sd(fbi$Count, na.rm=TRUE)

library(ggplot2)

ggplot(data = fbiwide, 
       aes(x = Population, y = Aggravated.assault)) +
  geom_point()

ggplot(data = fbiwide, 
       aes(x = log10(Population), 
           y = log10(Aggravated.assault))) +
  geom_point()

ggplot(data = fbiwide, 
       aes(x = log10(Population), 
           y = log10(Aggravated.assault),
           colour = Abb)) +
  geom_point()

# plot assault rate over time

ggplot(data = fbiwide, 
       aes(x = Year, 
           y = Aggravated.assault/Population*60000,
           colour = Abb)) +
  geom_point()

ggplot(data = fbiwide, 
       aes(x = Year, 
           y = Aggravated.assault/Population*60000
           )) +
  geom_point() +
  facet_wrap(~State)

ggplot(data = fbiwide, 
       aes(x = Year, 
           y = log10(Motor.vehicle.theft)
       )) +
  geom_point() +
  facet_wrap(~State)


ggplot(data = fbiwide, 
       aes(x = Year, 
           y = Motor.vehicle.theft
       )) +
  geom_point() +
  facet_wrap(~State, scales="free")

ggplot(data = fbi, 
       aes(x = Type 
       )) +
  geom_bar()

ggplot(data = fbi, 
       aes(x = Population,
           fill= Type
       )) +
  geom_histogram()
