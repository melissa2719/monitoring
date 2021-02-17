#Amazon Rainforest Fires: A comparison between 2015-2019
#I want to analyze NDVI, Temperature and Fire disturbance in Amazon rainforest during the peak burning activity in 2015 and 2019; morover I would like to compare the results to have a broader view of the impacts on vegetation and biomes
#Since 2019 have had the worst impact on Amazon Rainforest I expect to see in my results < NDVI; >T and >fire disturbance for 2019 rather then 2015

#In order to do that I need to install all the needed packages before starting my analysis

#needed packages
# to read the copernicus data I have to install a package and to use "" in order to let R know to import them since they are external.
install.packages("ncdf4") 
#to recall the package installed, I need to use the function library 
library(ncdf4)

#I'm going to install also ggplot2 in order to create graphics 
install.packages("ggplot2")
#and recall the package using the function library
library(ggplot2)

#Another package useful for this analysis is RStoolbox that is used for remote sensing image processing 
install.packages("RStoolbox")
library(RStoolbox)

# Since data are saved in pixels need to install raster package too. In the spatial world, each pixel represents an area on the Earth's surface.
install.packages("raster")
library(raster)

# Last step before start is setting the working directory; since I am a windows user I will use setwd("c:/name of the folder which contains the data downloaded from Copernicus/")
setwd("c:/lab/")

# As I said previously, for this project I want to study NDVI, land surface temperature and fire disturbance in 2015 and 2019. See if and how those variables have changed in these years in Amazonian Rainforest due to fires 

## NDVI ANALYSIS
# The Normalized Difference Vegetation Index (NDVI) is an indicator of the greenness of the biomes therefore it's useful to observe how much of the vegetation is alive.
# I am going to check NDVI for 2015; 2019; 2020. I choose the month August since it has been the month of the highest peak for fires.  
#I expect to see >NDVI for 2015 rather than 2019 and 2020 since the biomes have been threaten by fires and by deforestation too. These episode are increasing so I expect to see less vegetation going on with years.

# I am using "" because the data are external to R and I need to import them.
# ndvi for Amazon Rainforest in 2015 (Aug 2015)
ndvi2015<-raster("c_gls_NDVI300_201508210000_GLOBE_PROBAV_V1.0.1.nc")
#ndvi Amazon Rainforest in 2019 (Aug 2019)
ndvi2019<-raster("c_gls_NDVI300_201908210000_GLOBE_PROBAV_V1.0.1.nc")
#ndvi Amazon Rainforest in 2020 (Aug 2020)
ndvi2020<-raster("c_gls_NDVI300_202008210000_GLOBE_PROBAV_V1.0.1.nc")

# To see all the data I'm going to plot global data in order to understand at which coordinates to do the crop later
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
plot(ndvi2015, col=Ncl)
 
# Now that I have seen I'm going to plot just the cropped image on South America since the data are heavy, morover I want to focus on Amazonian forest.
#I choose to crop all the southern continent in order to see better the consequences.
ext<- c(-90,-25,-75,20) #xmin xmax, ymin e ymax
# let's crop the ndvi for 2015,2019 and 2020
ndvi2015 <- crop(ndvi2015, ext)
ndvi2019 <- crop(ndvi2019, ext)
ndvi2020 <- crop(ndvi2020, ext)

# I'm going to plot using a palette
#2015 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette #100 is referred to the number of colors that I'm using but it is possible to put any number
plot(ndvi2015, col=Ncl, main="NDVI 2015") #function main it's used to name the map

# Now I'm going to export the map obtained in png
png("NDVI 2015.png")
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
plot(ndvi2015, col=Ncl,main="NDVI2015") 

dev.off() #to close the R graphic window and see the next image/plot

#2019 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette 
#100 is referred to the number of colors that I'm using, it is possible to put any number
plot(ndvi2019, col=Ncl, main="NDVI 2019") #function main it's used to name the map

# Now I'm going to export the map in png
png("NDVI 2019.png")
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
plot(ndvi2019, col=Ncl,main="NDVI2019") 

dev.off()

#2020 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette 
#100 is referred to the number of colors that I'm using, it is possible to put any number
plot(ndvi2020, col=Ncl, main="NDVI 2020") #function main it's used to name the map
#Since the data is probably ruined I'm not going to use this year in the next analysis; for this reason I choose the title of analysis including only 2015-19.

#I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows; 1 is the number of the row; 2 since I need two columns in my plot) 
par(mfrow=c(1,2))
plot(ndvi2015, col=Ncl,main="NDVI2015") 
plot(ndvi2019, col=Ncl,main="NDVI2019") 

# Now I'm going to export the map in png
png("NDVI 2015 and 2019.png")
par(mfrow=c(1,2))
plot(ndvi2015, col=Ncl,main="NDVI2015") 
plot(ndvi2019, col=Ncl,main="NDVI2019")

dev.off()

# now I want to see the difference between the two periods
difndvi_1519 <- ndvi2015 - ndvi2019
plot(difndvi_1519, col= cln, main = "Difference in NDVI between August 2015 and August 2019")

# save the plot in png
png("Difference in NDVI 2015 and 2019.png")
cln <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
difndvi_1519 <- ndvi2015 - ndvi2019
plot(difndvi_1519, col= cln, main = "Difference in NDVI between August 2015 and August 2019")

dev.off()

###############################################################

# FCOVER ANALYSIS
# Since the results of NDVI are not as expected I choose to proceed also with FCOVER that is going to show me the fraction of ground covered by green vegetation. 
#FCover quantify the spatial extent of the vegetation; it is independent from the illumination direction and it is sensitive to the vegetation amount therefore I hope to obtain better results and I expect <FCover for 2019.
### Fcover for 2015 and 2019: I renamed the downloaded data to be 
fcover2015 <- raster("fcover2015.nc")
fcover2019 <- raster("fcover2019.nc")

# I am cropping on Northern Italy, but I want to focus on Trentino-Alto Adige
ext<- c(-90,-25,-75,20)
fcover2015 <- crop(fcover2015, ext)
fcover2019 <- crop(fcover2019, ext)

# I am plotting the cropped maps 
# I want to see the plot for 2015
# I'm using main = "" to put a title
plot(fcover2015, main = "Fcover 2015")

# save the plot in png
png("Fcover 2015.png")
plot(fcover2015, main = "Fcover 2015")
dev.off()

# I want to see the plot for 2019
plot(fcover2019, main = "Fcover 2019")

# save the plot in png
png("Fcover 2019.png")
plot(fcover2019, main = "Fcover 2019")
dev.off()

# I want to change the color of the plot to see better the difference
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100)
# I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows) 
par(mfrow=c(1,2))
# I am having 1 row and two columns. Let's see the plot
plot(fcover2015, col=clf,main="Fcover 2015")
plot(fcover2019, col=clf, main="Fcover  2019")

# save the plot in png
png("Fcover 2015 and 2019.png")
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100)
par(mfrow=c(1,2))
plot(fcover2015, col=clf,main="Fcover 2015")
plot(fcover2019, col=clf, main="Fcover 2019")
dev.off()

# now I want to see the difference between the two periods
diffcover_1519 <- fcover2015 - fcover2019
plot(diffcover_1519, col= clf, main = "Difference in FCover between 2015 and 2019")

# save the plot in png
png("Difference in FCover between 2015 and 2019.png")
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100)
diffcover_1519 <- fcover2015 - fcover2019
plot(diffcover_1519, col= clf, main = "Difference in FCover between 2015 and 2019")

dev.off()

###############################################

# TEMPERATURE ANALYSIS
# let's do the same analysis but with surface temperature between August 2015 and 2019
t2015 <- raster("temperature2015.nc")
t2019 <- raster("temperature2019.nc")

# I'm going to plot just the cropped image on South America since the data are heavy
ext<- c(-90,-25,-75,20)
t2015 <- crop(t2015, ext)
t2019 <- crop(t2019, ext)

# I'm going to set a new color Ramp Palette for the plot to see better the difference
clt <- colorRampPalette(c("yellow2","goldenrod","darkred"))(100)

# I am plotting the cropped maps one at a time
# I want to see the plot (temperature in August 2015)
# I'm writing the title using main=""
plot(t2015, col=clt, main = "Temperature in August 2015")

# save the plot in png
png("Temperature 2015.png")
plot(t2015, col=clt, main = "Temperature in August 2015")

# I want to see the plot (temperautre in August 2019)
plot(t2019,col=clt, main = "Temperature in August 2019")

# save the plot in png
png("Tempertature 2019.png")
plot(t2019,col=clt, main = "Temperature in August 2019")

# I want to see the difference in temperature
dif_t <- t2019 - t2015
plot(dif_t, col= clt, main = "Difference in temperature between August 2019 and August 2015")

# save the plot in png
png("Tempertature 2015 and 2019.png")
clt <- colorRampPalette(c("yellow2","goldenrod","darkred"))(100)
plot(dif_t, col= clt, main = "Difference in temperature between August 2019 and August 2015")


# I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows; 2 rows and 2 column ) 
par(mfrow=c(2,2))
#and then plot
plot(t2015, col=clt, main="Temperature August 2015")
plot(t2019, col=clt, main="Temperature August 2019")
plot(dif_t, col= clt, main = "Difference in temperature between August 2019 and August 2015")

# save the plot in png
png("Tempertature 2015 and 2019.png")
par(mfrow=c(2,2))
plot(t2015, col=clt, main="Temperature August 2015")
plot(t2019, col=clt, main="Temperature August 2019")
plot(dif_t, col= clt, main = "Difference in temperature between August 2019 and August 2015")

dev.off()

###################################################

# BURNED AREAS ANALYSIS
#I've decided to change the colorRampPalette of the plot to highlight better the presence or absence of burned areas
fcl <- colorRampPalette (c("white", "darkred"))(2)
burnedareas2015<-raster("c_gls_BA300_201508310000_GLOBE_PROBAV_V1.0.1.nc")
burnedareas2019<-raster("c_gls_BA300_201908310000_GLOBE_PROBAV_V1.1.1.nc")

#Before plotting I'm going to crop the area of interest
ext<- c(-90,-25,-75,20)
burnedareas2015<- crop(burnedareas2015, ext)
burnedareas2019 <- crop(burnedareas2019, ext)

#to plot and to name my plot
plot(burnedareas2015, col=fcl, main="burned areas 2015")


#Since I've obtain a low resolution I'm going to replot with another crop
ext1<-c(-60,-40,-20,0)
rburnedareas2015<-crop(rburnedareas2015, ext1)
plot(rburnedareas2015, col=fcl) #It is strange that there aren't burned areas maybe the resolution it's low; I assume that the disturbance of the fire or the cloud cover has distorted the data. 

#let's see the plot for 2019
plot(burnedareas2019, col=fcl, main="burned areas 2019")

#last thing is to see the difference between burned areas; for 2015 I've not seen any burned data so even I will do 2019-2019 burned areas
difburnedareas<- burnedareas2019-burnedareas2015
plot(difburnedareas, col= fcl, main=" difburned areas") 

#save the difference in png
png(" difburnedareas.png")
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
plot(difburnedareas, col=Ncl,main="difburnedareas") 

dev.off()
####################################################################################################################################



