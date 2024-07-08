# installing packages
# install.packages("tidyverse")
# install.packages("dplyr")
library(tidyverse)
# library(dplyr)

squirrel <- read.csv(file = "../datasets/nyc_squirrel_uniq_plus.csv", 
                     header = TRUE)

# filtering dataset for squirrels making Quaas
squirrel$Quaas == TRUE
squirrel[squirrel$Quaas == TRUE, ]
View(squirrel[squirrel$Quaas == TRUE, ])
squirrel_quaas <- squirrel[squirrel$Quaas, ] # same as above, shorter

squirrel_quaas_dplyr <- filter(squirrel, Quaas)

squirrel_quaas_dplyr <- filter(squirrel, Quaas == TRUE)

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
  View()

squirrel %>%
  group_by(Shift) %>%
  summarise(mean(Weight))

squirrel %>%
  group_by(Shift) %>%
  View()
