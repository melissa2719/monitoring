#6 nov

# R code for plotting the relationship among ecological variables

install.packages("sp")


data(meuse)



View(meuse)
head(meuse)
summary(meuse)

#exercise: plot zinc(y) against cadmium(x)
#error
plot(cadmium,zinc)
#error in evaluating the argument 'x' 

# $
plot(meuse$cadmium, meuse$zinc)

#if i use attach i don't need to use $
attach(meuse)
plot(cadmium, zinc)

plot(cadmium, lead)

#scatterplot Matrices
pairs(meuse)

#pairing only elements part of dataset: how to do that?
#only with cadmium, copper, lead, zinc...
