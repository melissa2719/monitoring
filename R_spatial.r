# R spatial

# I don't need to reinstall install.packages("sp") so i'll recall library
library(sp)

#data will load specifical asset 
data(meuse)
#head to view part of dataset, first 6 lines
head(meuse)

#I will state to R that I'll use coordinates
# ~ is used to group different things, now we need to group x and y 
# ~ alt+5 on mac on; windows alt+126
#related only to sp and this is going to allow us to see data in space
coordinates(meuse)= ~x+y

plot(meuse)

#How zinc is spread in space in our data set? using spplot to plot a raster(image) or other object
#We use plot function ant thanks to ~x+y we can see how are scattered in space now we use ssplot to see where zinc is higher for example (red) where is lower (in blue) etc..
#spplot used to plot elements like zinc, lead etc 
#spplot(state the dataset in this case meuse, "column")

spplot(meuse, "zinc")
#add title to the graph using main= "brackets because i will use a text outside r"
spplot(meuse, "zinc", main="Concentration of zinc")

#plot the concentration of copper
spplot(meuse, "copper", main="Concentration of copper")
#such as zinc; highest values on the left part and lower on the right part

#see copper and zinc in the same graph with two different patterns
#same as first solution primates<- c(1,5,10)
spplot(meuse, c("copper", "zinc"))
#zinc higher level on left part so west part of planet and this is due to the fact that in the west part there is a river which is polluted by industrial processes so copper and zinc are more present in there
#another function is bubble which create a bubble plot of spatial data
#rather than using colours, let's make use bubble so the sizes of different points
bubble(meuse, "zinc")

#let's do the same with lead
bubble(meuse, "lead")
#change color with col="" function
bubble(meuse, "lead", col="red")
#folder of computer called lab
#save covid data from virtuale in this new folder


############################16/11 lesson#############################
install.packages("ggplot2")
library(ggplot2)
#
biofuels <- c(120, 200, 350, 570, 750)
oxydative <- c(1200, 1300, 21000, 34000, 50000)
d <- data.frame(biofuels, oxydative)
d
#geom point function what kind of geometry we would like to use
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point()
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point()
d <- data.frame(biofuels, oxydative)

#geom point function and she will know data inside
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point()

#change size and color so stated that ggplot open a new plot and put it on the table
#we will enter inside () changing size and color: size =5, col="red"
# " " used for color text and packages external to r

ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size =5, col="red")

#lines in the plot instead of points---> geom_lines which shows the trend of the data
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_line()
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_line(size =5, col="red")

#points + lines
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_point(size =5, col="red") + geom_line()

#polygons
ggplot(d, aes(x = biofuels, y = oxydative)) + geom_polygon()

###################set working directory, importing data from an external file
#lab directory is outside r so we have to explain to it using brackets
setwd("path/lab")

#setwd windows
setwd("C:/lab/")


#set working directory Mac 
#setwd("/Users/melissa/desktop/lab/")

#covid data is outside so we're going to use brackets, header is to inform R that the first line of data is just the name of the variable and it should not be included

covid<-read.table("covid_agg.csv", header=TRUE)
covid
head(covid)
#summary
summary(covid)
#ggplot2 we have already installed this library, names to undestand the x and the y of oue graph; then name the library, then ggplot
names(covid)
library(ggplot2)
ggplot(covid, aes(x = lon, y = lat)) + geom_point()

#changing size of points according to number of cases in March
ggplot(covid, aes(x = lon, y = lat, size=cases)) + geom_point()
