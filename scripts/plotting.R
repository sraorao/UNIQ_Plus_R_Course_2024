## DAY 2 AFTERNOON SESSIONS: PLOTTING WITH BASE R AND GGPLOT2 ####

### Base R ####
#Let´s start by exploring basic R plotting. 
#It is important to understand there is no need to remember all the arguments and optional things we can do with graphs. The important is to understand how plotting works and know the sources to get the information to reach your desired plot.
#We will work in heroes dataset
heroes = read.csv("../datasets/heroes_information.csv")
View(heroes)
str(heroes)
heroes$Publisher = as.factor(heroes$Publisher) # change Publisher variable to factor
heroes$Gender = as.factor(heroes$Gender) # change Gender variable to factor
levels(heroes$Gender)= c("Not Specified", "Female", "Male")# Define a new level as "Not Specified"


#### Histograms ####
hist(heroes$Height) # Histogram to see distribution
hist(heroes$Height, breaks=50) # More detail
hist(heroes$Height, breaks=50, col="red") # Add colour
hist(heroes$Height, breaks=50, col="red", main = "Height distribution") # Add title

#### Barplots ####
plot(heroes$Publisher) # Barplot
plot(heroes$Publisher, las=2) # turn 90 degrees x labels
plot(heroes$Publisher, las=2, cex.names=0.6) # change size labels
plot(heroes$Publisher, las=2, cex.names=0.6, ylim= c(0,500)) # Increase y axis range
plot(heroes$Publisher, las=2, cex.names=0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") # add title


#### XY graphs / scatterplots / correlation ####
plot(heroes$Height, heroes$Weight) # Scatterplot of x and y values
plot(heroes$Height, heroes$Weight, col="blue") #colour for every gender
plot(heroes$Height, heroes$Weight, col=heroes$Gender) #colour for every gender
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24) #change symbol
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24, cex=2) #change size

plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24)
legend(x=700, y=700, legend = levels(heroes$Gender), col=c(1:3), pch= 24) #create legend

# Remember we can check the different symbols we can use  
ggpubr::show_point_shapes()

#### Boxplots ####
boxplot(heroes$Height) # We can see distribution of the variable Height
boxplot(heroes$Height,heroes$Weight) # We can plot multiple boxplots (multiple variables)
boxplot(heroes$Height,heroes$Weight, names=c("Height", "Weight")) # Add name of variables plotted

# If we want to plot data based on a categorical data we can use plot()
plot(heroes$Gender, heroes$Height) # plot height data splited by Gender
plot(heroes$Gender, heroes$Height, col=c("green","blue", "red")) #add colour
plot(heroes$Gender, heroes$Height, col=c("green","blue", "red"), xlab = "Gender" ) #change x axis title

#### Save graphs ####
pdf("Barplot_heroes.pdf")
plot(heroes$Publisher, las=2, cex.names = 0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") 
dev.off()


pdf("Barplot_heroes.pdf", width=15, height = 15)
plot(heroes$Publisher, las=2, cex.names = 0.6, ylim= c(0,500), main = "Barplot of heroes by publisher") 
dev.off()

png("Hero_scatterplot.png")
plot(heroes$Height, heroes$Weight, col=heroes$Gender, pch=24)
dev.off()

#### More advanced information####
# Colours can be defined in different ways

# specifing colour name (most common)
boxplot(heroes$Height, col="blue") 
# you can find all the names for colours that R offers using
colors()

# specifing hexadecimal color code 
boxplot(heroes$Height, col="#FF00CC") 
# https://htmlcolorcodes.com will allow you to pick a colour and get the code

# using number 
boxplot(heroes$Height, col=431) 

# using rgb() function to build a color (red, green, blue)
boxplot(heroes$Height, col=rgb(0.3, 0.7, 0.3))

#### Exercises ####


# Plot a boxplot of the Weight by Alignment.





# Plot the frequency of every alignment in the dataset




# Colour the previous plot



### ggplot2 ####
#Plotting package that is part of tidyverse.
#We will work mostly on scatterplot


# Install/load ggplot2
#install.packages("ggplot2")
library(ggplot2)


# Let´s get rid of the not specified group for the sake of better visualisation
heroes = heroes[heroes$Gender != "Not Specified",]


# Plot the canvas
ggplot() 

# Add the data and mapping information
ggplot(data = heroes, mapping = aes(Weight,Height))

# Add the geometry
ggplot(data = heroes, mapping = aes(Weight,Height))+
  geom_point()

# Data and mapping can be given as global or on the layer. Remember that will affect the inheritance and where things apply.
ggplot(data = heroes)+
  geom_point(mapping = aes(Weight,Height))

ggplot()+
  geom_point(mapping = aes(Weight,Height), data= heroes)


# Use different type of gemoetry
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_line() 

# We can add different geometries too
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point() +
  geom_line() 

# There is really no need to specify that the arguments are the data or mapping.
ggplot(heroes, aes(Weight,Height))+
  geom_point()

# We can control the style with themes that are defined already
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point(aes(colour = Gender)) +
  theme_classic() # classic style


ggplot(data = heroes, mapping = aes(Weight,Height))+
  geom_point(aes(colour = Gender))+
  theme_dark() # dark style

#### Facets ####

# Split data into different graphs using facets
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point(aes(colour = Gender)) +
  theme_dark() +
  facet_wrap(~Alignment)


ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point(aes(colour = Gender)) +
  theme_dark() + 
  facet_grid(~Alignment)

ggplot(data = heroes, mapping = aes(Weight,Height))+
  geom_point(aes(colour = Gender))+
  theme_dark()+
  facet_grid(Gender~Alignment) # it can be split in two variable


#### Boxplots ####
#Let´s work now a bit on a different type of graph: boxplot

# Boxplot for Gender and Weight
ggplot(data = heroes, mapping = aes(Gender,Weight)) +
  geom_boxplot(aes(colour=Gender)) +
  theme_classic()

ggplot(data = heroes, mapping = aes(Gender,Weight)) +
  geom_boxplot(aes(colour=Gender))+
  theme_classic()+
  facet_grid(~Alignment)



#### Save graphs ####
#Let´s learn how to save the plot as a variable and how to export it:

# Save as a an object that we can print
myplot = ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot(aes(colour=Gender)) +
  theme_classic() +
  facet_grid(~Alignment) +
  ggtitle ("myplot")

print(myplot)

# Export the plot
ggsave("myplot.pdf", 
       plot = myplot, width = 10, height = 5)

ggsave("myplot.png", 
       plot = myplot)


#### Some things to have in mind #### 

# Let´s take this one graph we have worked with before
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point()

# Let's add some colour
ggplot(data = heroes, mapping = aes(Weight,Height)) +
  geom_point(colour = "Blue") 

# Different way
ggplot(data = heroes) + 
  geom_point( mapping = aes(Weight,Height),colour = "Blue") 

# Be careful! Not the same as
ggplot(data = heroes)+
  geom_point( mapping = aes(Weight,Height,colour = "Blue")) #If we add the colour inside aesthetic then it is linked to data and it is not the same!

# Colour based on a variable
ggplot(data = heroes, mapping = aes(Weight,Height))+
  geom_point(aes(colour = Gender)) # Here it makes sense as colour is linked now to data

# Specifiy colours
ggplot(data = heroes, mapping = aes(Weight,Height))+
  geom_point(aes(colour = Weight > 100)) # we can even decide a condition to based our colour in (we will see conditions later in the course)


# Some geometries only need a single mapping

ggplot(heroes) + 
  geom_histogram(aes(x = Weight))


#### Exercises ####

# Modify the code below to make points as squares and more transparent.


ggplot(heroes) + 
  geom_point(aes(Weight,  Height))


# Symbols as squares


# Symbols transparent
# Hint 1: transparency is controlled with alpha, and shape with shape
# Hint 2: remember the difference between mapping and setting aesthetics





# Solution
ggplot(heroes) + 
  geom_point(aes(Weight,  Height), shape = "square", alpha=0.5)



# Colour the data on the graph depending on alignment









# Solution
ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5)


 # Now add a main title




# Solution
ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment")


# Now let´s work with categorical data and boxplot.
# First plot just the continuos data Weigth

ggplot(data = heroes, mapping = aes(Weight)) +
  geom_boxplot()


#We can see the boxplot representing the weights of the whole dataset. With a line there is the median represented.
#Let´s add now the categorical data we would like to plot too.


ggplot(data = heroes, mapping = aes(Weight,Gender)) +
  geom_boxplot()


# Let´s consider just Male and Female data

ggplot(data = heroes, mapping = aes(Weight,Gender)) +
  geom_boxplot()


# Try to change the axis orientation so that Gender shows in x axis

ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot() 


# Let´s add the classic theme

ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot() +
  theme_classic()

# Add some colour

ggplot(data = heroes, mapping = aes(Gender, Weight, colour= Gender)) +
  geom_boxplot()


# Choose your own colours

ggplot(data = heroes, mapping = aes(Gender, Weight, fill= Gender)) +
  geom_boxplot() +
  scale_fill_manual(values=c("red", "yellow"))


ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot(aes(fill= Gender)) +
  scale_fill_manual(values=c("green", "purple"))

# Let us have a look to the following histogram

ggplot(heroes, aes(Weight)) +
  geom_histogram()

# Colour bars in blue:

ggplot(heroes, aes(Weight)) +
  geom_histogram(colour="Blue")


# Try fill instead of colour to define the blue bars:
  
ggplot(heroes, aes(Weight)) +
  geom_histogram(fill="Blue")


# Going back to our x y plot:
  
ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment")


# Let´s add a theme:

ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment") +
  theme_minimal()

# Now we will split the data using facets.
# First let´s try facet_wrap and split the data by alignment.

ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment") +
  theme_minimal() +
  facet_wrap(~Alignment)

# Let´s try facet_grid using Gender and Alignment to split the data.

ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment") +
  theme_minimal() +
  facet_grid(Gender~Alignment)

# We would probably visualise the data better with a darker canvas
ggplot(heroes) + 
  geom_point(aes(Weight,  Height, colour= Alignment), shape = "square", alpha=0.5) +
  ggtitle ("Heroes: weight vs height by alignment") +
  facet_grid(Gender~Alignment)


# Now we try facets on the previous boxplot graph
ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot(aes(colour=Gender)) +
  theme_classic()


# Again let´s split data by alignment

ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot(aes(colour=Gender)) +
  theme_classic() +
  facet_grid(~Alignment)


# How to export graphs

# Store graph in a variable
myplot = ggplot(data = heroes, mapping = aes(Gender, Weight)) +
  geom_boxplot(aes(colour=Gender)) +
  theme_classic() +
  facet_grid(~Alignment) +
  ggtitle ("Weight by Gender&Alignment")

print(myplot) # This way we can print the variable

# Save graph to file (saves last file )
ggsave("myplot.pdf")
ggsave("myplot.png")

# If we want to specify width and height
ggsave("myplot.pdf", width = 10, height = 5)

# If we want to specify a different file name
ggsave("hero_plot.pdf", 
       plot = myplot, width = 10, height = 5)


# Saving graph without ggsave()
pdf("myplot.pdf")
print(myplot)
dev.off()

# From RScript file we can export directly from the outcome window (go to RScript)


