library(classdata)
library(tidyverse)

titanic %>%
  ggplot(aes(x = Class)) +
  geom_bar()

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) +
  geom_bar()

titanic %>%
  ggplot(aes(x = Class, fill=Survived)) +
  geom_bar(position="fill") +
#  scale_fill_manual(values=c("steelblue", "darkorange"))
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()
?RColorBrewer
library(RColorBrewer)
display.brewer.all()

titanic %>%
  ggplot(aes(x = Age, fill=Survived)) +
  geom_bar(position="fill") +
  #  scale_fill_manual(values=c("steelblue", "darkorange"))
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) +
  geom_bar(position="fill") +
  #  scale_fill_manual(values=c("steelblue", "darkorange"))
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()


titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) +
  geom_bar(position="fill") +
  #  scale_fill_manual(values=c("steelblue", "darkorange"))
  scale_fill_brewer(palette = "Dark2") +
  theme_bw() +
  facet_wrap(~Class)

titanic %>%
  ggplot(aes(x = Sex, fill=Survived)) +
  geom_bar(position="stack") +
  #  scale_fill_manual(values=c("steelblue", "darkorange"))
  scale_fill_brewer(palette = "Dark2") +
  theme_bw() +
  facet_wrap(~Class)

library(ggmosaic)
titanic %>%
  ggplot() +
  geom_mosaic(aes(x = product(Survived, Sex, Age), fill=Survived)) +
  facet_wrap(~Class) +
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()

titanic %>%
  ggplot() +
  geom_mosaic(aes(x = product(Sex), fill=Survived)) +
  facet_wrap(~Class) +
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()

titanic %>%
  ggplot() +
  geom_mosaic(aes(x = product(Sex, Class), fill=Survived),
              divider = c("vspine", "hspine", "hspine")) +
  scale_fill_brewer(palette = "Dark2") +
  theme_bw()

################

