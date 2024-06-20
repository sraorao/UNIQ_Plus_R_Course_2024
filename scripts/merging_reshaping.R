library(tidyverse)

heroes <- read.csv("../datasets/heroes_information.csv")
powers <- read.csv("../datasets/super_hero_powers.csv")

View(heroes)
View(powers)

colnames(powers) <- sub("hero_names", "name", colnames(powers))

heroes_with_powers <- merge(heroes, powers, by = "name")
heroes_with_powers_all <- merge(heroes, powers, by = "name", all = TRUE)
heroes_with_powers_left <- merge(heroes, powers, by = "name", all.x = TRUE)
heroes_with_powers_right <- merge(heroes, powers, by = "name", all.y = TRUE)

## reshaping

colnames(powers)

powers_vision_long <- pivot_longer(powers, starts_with("Vision"), 
                                   names_to = "all_vision_powers", 
                                   values_to = "all_vision_values")
View(powers_vision_long)
colnames(powers_vision_long)

powers_vision_long %>%
  select(name, all_vision_powers, all_vision_values) %>%
  group_by(all_vision_powers) %>%
  summarise(sum(all_vision_values))

table(powers_vision_long$all_vision_values)

powers_vision_long$all_vision_values <- as.logical(powers_vision_long$all_vision_values)
table(powers_vision_long$all_vision_values)

powers_vision_long %>%
  select(name, all_vision_powers, all_vision_values) %>%
  group_by(all_vision_powers) %>%
  summarise(sum(all_vision_values))


heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
    geom_point()

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point() +
  facet_wrap(~Alignment)

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point(alpha = 0.24)

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_density2d()

heroes_with_powers %>%
  ggplot(aes(y = Weight, colour = Alignment)) +
  geom_density()

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point(alpha = 0.24) +
  geom_density2d()

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point(alpha = 0.24) +
  geom_label(aes(label = name))

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point(alpha = 0.24) +
  geom_label(aes(label = name), alpha = 0.2)

install.packages("ggrepel")
library(ggrepel)

heroes_with_powers %>%
  ggplot(aes(x = Height, y = Weight, colour = Alignment)) +
  geom_point(alpha = 0.24) +
  geom_label_repel(aes(label = name))


powers_vision_long %>%
  select(name, all_vision_powers, all_vision_values) %>%
  filter(all_vision_values=TRUE) %>%
  ggplot(aes(x=all_vision_powers, y=all_vision_values))+
  geom_col()
