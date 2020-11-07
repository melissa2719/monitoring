# write whatever you want here

# this is an array so we have to put a c before. the arrow goes from the dataset to the name
primates <- c(3, 5, 9, 15, 40)
primates

#new set
crabs <- c(100, 70, 30, 10, 5)
crabs 

# first plot in R
plot(primates, crabs)
# col changes the color
plot(primates, crabs, col="red")
# pch changes the symbol
plot(primates, crabs, col="red", pch=19)
# cex changes the size of the dots
plot(primates, crabs, col="red", pch=19, cex=2)
plot(primates, crabs, col="red", pch=19, cex=3)
# main is the title
plot(primates, crabs, col="red", pch=19, cex=6, main="my first ecological graph in R")

#create a dataframe (tables in R)
ecoset <- data.frame(primates, crabs)
ecoset

# mean number of individuals per site
(3+5+9+15+40)/5

# summary of the dataframe
summary(ecoset) 
