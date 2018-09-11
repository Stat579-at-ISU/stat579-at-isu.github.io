library(classdata)
?fbi

head(fbi)
tail(fbi)
summary(fbi)
dim(fbi)
str(fbi)

str(fbi$Abb)
fbi[10000,]
fbi[c(10000,10001),]
10000:10003
fbi[1:10,]
1.5:5
fbi[1:5,"Abb"]
fbi[1:5,c("Abb", "Population", "Type")]

head(fbi$Population)
mean(fbi$Population)
sd(fbi$Population)
range(fbi$Population)
# cor, cov, ...

# Your turn

fbi[1:10,]
head(fbi, n=10)

mean(fbi$Population)
mean(fbi$Count)
mean(fbi$Count, na.rm=TRUE)
sd(fbi$Count, na.rm=TRUE)

?fbiwide
library(ggplot2)
ggplot(data=fbiwide, 
       aes(x = Population, y = Burglary)) +
  geom_point()

ggplot(data=fbiwide, 
       aes(x = log10(Population), 
           y = log10(Burglary))) +
  geom_point()

ggplot(data=fbiwide, 
       aes(x = log10(Population), 
           y = log10(Burglary),
           colour=Abb)) +
  geom_point()

ggplot(data=fbiwide, 
       aes(x = log10(Population), 
           y = log10(Murder),
           colour=Year)) +
  geom_point()

ggplot(data=fbiwide, 
       aes(x = log10(Population), 
           y = log10(Murder),
           colour=Year)) +
  geom_point() +
  facet_wrap(~State)

ggplot(data=fbiwide, 
       aes(x = Year, 
           y = Murder/Population*60000,
           colour=Year)) +
  geom_point() +
  facet_wrap(~State)
