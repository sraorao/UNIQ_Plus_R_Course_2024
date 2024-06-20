
cor.test(heroes$Height, heroes$Weight)

cor.test(heroes$Height, heroes$Weight, method = "spearman")


# Student's t test
# is there a difference in heights of male and female superheroes
heroes_female <- filter(heroes, Gender == "Female")
dim(heroes_female)

heroes_male <- heroes[heroes$Gender == "Male", ]
dim(heroes_male)

t.test(heroes_female$Height, heroes_male$Height)
?t.test
t.test(heroes_female$Height, heroes_male$Height, var.equal = TRUE)
