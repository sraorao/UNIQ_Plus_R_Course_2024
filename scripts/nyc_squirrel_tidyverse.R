# installing packages
# install.packages("tidyverse")
library(tidyverse)
# library(dplyr)

squirrel <- read.csv(file = "../datasets/nyc_squirrel_uniq_plus.csv", 
                     header = TRUE)

# filtering dataset for squirrels making Quaas
View(squirrel[squirrel$Quaas == TRUE, ])
squirrel_quaas <- squirrel[squirrel$Quaas, ] # same as above, shorter

squirrel_quaas_dplyr <- filter(squirrel, Quaas)

# filter the squirrel dataset for Adult age using dplyr
filter(squirrel, Age == "Adult")

squirrel %>% filter(Age == "Adult") # smae as line 16

squirrel %>% 
  filter(Age == "Adult") %>%
  select(Unique.Squirrel.ID)

squirrel[squirrel$Age == "Adult", "Unique.Squirrel.ID"]

squirrel %>% 
  select(-Weight, -Age) %>%
  colnames()

squirrel %>%
  arrange(Weight) %>%
  View()

squirrel %>%
  group_by(Shift) %>%
  summarise(mean(Weight))

squirrel %>%
  group_by(Shift) %>%
  View()
