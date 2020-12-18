#Vegan community ecology package about multivariate analysis 

install.packages("vegan")
library(vegan)
#permute and lattice packages loaded

#setwd
setwd("C:/lab/")

#load data which is outside R so we use brackets
load("biomes_multivar.RData")
# to show the objects that are in the workspace
ls()

#plot per species matrix;head to see part of the table:It will show the first six plot
head(biomes)

#to see how the different species are related to each other; the higher the distance in the plot the lower we be the difference between the species
#detrendend correspondent analysis decorana with the name given to analysis 

multivar <- decorana(biomes)
multivar

#we can plot the multivar
plot(multivar)

#we can si that the red_colubus; giant orb; tree_fern; rafflesia; diponera are living together and so on 
#now we put names of the different biomes

head(biomes_types)

#put ellipse in the ordination
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)

#ordispider will make a web in the plot; label will take the type of biome
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)

#save the image
pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)
dev.off()

