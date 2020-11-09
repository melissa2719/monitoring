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

# $ to attach
plot(meuse$cadmium, meuse$zinc)

#if i use attach i don't need to use $
attach(meuse)
plot(cadmium, zinc)

plot(cadmium, lead)

#scatterplot Matrices
pairs(meuse)

#pairing only elements part of dataset: how to do that?
#only with cadmium, copper, lead, zinc...

library(sp)
data(meuse)

#look the dataframe with the head function to look the first part of the table
head(meuse)

#cadmium, copper, lead and zinc pairs with soil variable; number of the column where the data are present
#from the third column to column n 6
#quadratic brackets and number of column; #altè+

pairs(meuse[,3:6])
#if i use dataframe and number i use by default rows
#before i had the pairs of all variables and now i have the pairs of variables from 3 to 6th row
#how to solve the ploblem of the counting of the column
#use the names of the column:
#we need to explain to the system that the columns are all together; tilde alt+5

pairs(~cadmium+copper+lead+zinc, data=meuse)
#no differences in the two graphs, they are two different codes which do the same thing
#tilde is group several object all together, data=meuse data is meuse
#exercise: just use cadmium and zinc
pairs(~cadmium+lead+zinc, data=meuse)

#let's prettify the graph
#change the color
pairs(~cadmium+copper+lead+zinc, data=meuse, col="green")

#change color of single panels by the par() function next lessons
#change symbol to filled triangles; write on google pch R and look for the number--->symbol pch=17
pairs(~cadmium+copper+lead+zinc, data=meuse, col="green", pch=17)
# page to understand how to change colors https://statisticsglobe.com/r-pairs-plot-example/
head(meuse)
#increase size of triangles cex=2
pairs(~cadmium+copper+lead+zinc, data=meuse, col="green", pch=17, cex=3)
