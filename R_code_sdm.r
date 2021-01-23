install.packages("sdm")
library(sdm)
library(raster)
library(rgdal)

#import species data
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file) #readOGR

plot(species)
plot(species, pch=17)

species$Occurrence
plot(species[species$Occurrence == 1,], col='blue', pch=17)
points(species[species$Occurrence == 0,], col='red', pch=17)

path <- system.file("external", package="sdm")
# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) 
lst
preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], col='blue', pch=17)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=17)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], col='blue', pch=17)

plot(preds$precipitation, col=cl, main='precipitation')
points(species[species$Occurrence == 1,], pch=17)

plot(preds$vegetation, col=cl, main='vegetation')
points(species[species$Occurrence == 1,], pch=17)

d <- sdmData(train=species, predictors=preds)
d

# make the raster output layer
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
datasdm
# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")


points(species[species$Occurrence == 1,], pch=17)

# make the raster output layer
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
library(sdm)
# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
datasdm
 
# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
 

# make the raster output layer
p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)




 
