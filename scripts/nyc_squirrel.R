getwd() # get working directory

# also can sssign using = (same as the arrow)
squirrel <- read.csv(file = "../datasets/nyc_squirrel_uniq_plus.csv", 
                    header = TRUE)

View(squirrel)
head(squirrel)
tail(squirrel, n = 10)

dim(squirrel)
dim(squirrel)
str(squirrel)
summary(squirrel)

ncol(squirrel)
nrow(squirrel)

colnames(squirrel)
rownames(squirrel)

# subsetting data.frames
squirrel[1, 1] # df[row, col]
squirrel[ , 1]
squirrel_first_row <- squirrel[1, ]

squirrel[2 , "Unique.Squirrel.ID"]
squirrel[ , 30]

squirrel$Date

head(squirrel, n = 10)
squirrel[1:10, ]
View(squirrel[ , 24:29])
View(squirrel[ , 24:ncol(squirrel)])
View(squirrel[ , (ncol(squirrel)-6):ncol(squirrel)])

?ncol

# filtering
3 < 7
3 > 7

3 < 7 & 3 < 8
3 < 7 & 3 > 8
TRUE & FALSE

# expression to test whether my_data is between 10 and 20
my_data > 10 & my_data < 20
my_data <- 33
my_data > 10 | my_data < 20

squirrel$Age == "Adult"
squirrel[squirrel$Age == "Adult", ]

# filter to get only the zero or negative weight squirrels data
dim(squirrel[squirrel$Weight <= 0, ])

# subset of the data where the squirrel was recorded to
# be doing 'other activity'
# empty text referred to using "" or ''
unique(squirrel[squirrel$Other.Activities != "", "Other.Activities"])
table(squirrel[squirrel$Other.Activities != "", "Other.Activities"])
