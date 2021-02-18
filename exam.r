#Amazon Rainforest Fires: A comparison between 2015-2019
#I want to analyze NDVI, Temperature and Fire disturbance in Amazon rainforest during the peak burning activity in 2015 and 2019; morover I would like to compare the results to have a broader view of the impacts on vegetation and biomes
#Since 2019 have had the worst impact ever seen on Amazon Rainforest I expect to see in my results < NDVI; >T and >fire disturbance for 2019 rather then 2015

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

### NDVI ANALYSIS ###
# The Normalized Difference Vegetation Index (NDVI) is an indicator of the greenness of the biomes therefore it's useful to observe how much of the vegetation is alive.
# I am going to check NDVI for 2015; 2019; 2020. I choose the month August since it has been the month of the highest peak for fires.  
#I expect to see >NDVI for 2015 rather than 2019 and 2020 since the biomes have been threaten by fires and by deforestation too. These episodes are increasing so I expect to see less vegetation going on with years.

# First I am going to import the data saved into the lab folder; I am using "" because the data are external to R.
# ndvi data for 2015 (Aug 2015)
ndvi2015<-raster("c_gls_NDVI300_201508210000_GLOBE_PROBAV_V1.0.1.nc")
#ndvi data for 2019 (Aug 2019)
ndvi2019<-raster("c_gls_NDVI300_201908210000_GLOBE_PROBAV_V1.0.1.nc")
#ndvi data for 2020 (Aug 2020) #I'm also going to import the data for 2020, you'll see later why I omitted it in the title of my analysis
ndvi2020<-raster("c_gls_NDVI300_202008210000_GLOBE_PROBAV_V1.0.1.nc")

# To see all the data I'm going to plot global data in order to understand at which coordinates to do the crop later
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)
plot(ndvi2015, col=Ncl)
 
# Now that I have seen where to crop and since the data are heavy I'm going to plot just the cropped image on South America , In order to focus better on Brazil and Amazon forest.
#I choose to crop all the south American continent in order to have a broader view about the consequences.
#I'm using ext function to crop
ext<- c(-90,-25,-75,20) #xmin xmax, ymin, ymax
# let's crop the ndvi data for 2015,2019 and 2020
ndvi2015 <- crop(ndvi2015, ext)
ndvi2019 <- crop(ndvi2019, ext)
ndvi2020 <- crop(ndvi2020, ext)

# I'm going to plot them using a palette; I'm going to call it Ncl
#2015 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette #100 is referred to the number of colors that I'm using but it is possible to put any number
plot(ndvi2015, col=Ncl, main="NDVI 2015") #function main it's used to name the map

# Now I'm going to export the map obtained in png
png("NDVI 2015.png")
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100) # to define the color palette 
plot(ndvi2015, col=Ncl,main="NDVI2015") 

dev.off() #to close the R graphic window and see the next image/plot

#2019 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette  #100 is referred to the number of colors that I'm using, it is possible to put any number
plot(ndvi2019, col=Ncl, main="NDVI 2019") #function main it's used to name the map

# Now I'm going to export the map in png
png("NDVI 2019.png")
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100) # to define the color palette 
plot(ndvi2019, col=Ncl,main="NDVI2019") 

dev.off() #to close the R graphic window and see the next image/plot

#2020 situation
Ncl <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100)  # to define the color palette 
#100 is referred to the number of colors that I'm using, it is possible to put any number
plot(ndvi2020, col=Ncl, main="NDVI 2020") #function main it's used to name the map
#Since the data is probably distorted (maybe because the satellite had some problem and it didn't catch the images for 2020)--->I'm not going to use this year in any of the next analysis; this is the reason why I choose the title of my analysis including only 2015 and 2019.

#I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows; 1 is the number of the row; 2 is the number of columns I want in my plot) 
par(mfrow=c(1,2))
plot(ndvi2015, col=Ncl,main="NDVI2015") 
plot(ndvi2019, col=Ncl,main="NDVI2019") 

# Now I'm going to export the map in png
png("NDVI 2015 and 2019.png")
par(mfrow=c(1,2))
plot(ndvi2015, col=Ncl,main="NDVI2015") 
plot(ndvi2019, col=Ncl,main="NDVI2019")

dev.off()

#I want to see the difference in NDVI: since I see >ndvi in the 2019 rather than in 2015, I'm going to do ndvi2019-ndvi2015I even if I expected to do the reverse.
#I'm going to change the colorRampPalette
cln <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100) # to define the color palette 
difndvi_1915 <- ndvi2019 - ndvi2015
plot(difndvi_1915, col= cln, main = "Difference in NDVI between August 2019 and August 2015") #I've obtained the expected map with the wrong difference

# save the plot in png
png("Difference in NDVI 2019 and 2015.png")
cln <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100) # to define the color palette 
difndvi_1915 <- ndvi2019 - ndvi2015
plot(difndvi_1915, col= cln, main = "Difference in NDVI between August 2019 and August 2015")

dev.off()

#Since I've obtained the expected plot by the reverse difference of what I expected, so I've decided to do also the difference I expected: ndvi2015-ndvi2019
difndvi_1519 <- ndvi2015 - ndvi2019
plot(difndvi_1519, col= cln, main = "Difference in NDVI between August 2015 and August 2019") 

# save the plot in png
png("Difference in NDVI 2015 and 2019.png")
cln <- colorRampPalette(c('red','gold','darkgoldenrod3',"cyan","cyan4","chartreuse1","darkgreen"))(100) # to define the color palette 
difndvi_1519 <- ndvi2015 - ndvi2019
plot(difndvi_1519, col= cln, main = "Difference in NDVI between August 2015 and August 2019")

dev.off()

#To plot my results in a single graph
par(mfrow=c(2,2)) # 2 row, 2colums
plot(ndvi2015, col=Ncl,main="NDVI2015") 
plot(ndvi2019, col=Ncl,main="NDVI2019")
plot(difndvi_1519, col= cln, main = "Difference in NDVI between August 2015 and August 2019")

###############################################################

# Since the results of NDVI are not as expected I choose to proceed also with FCOVER that is going to show me the fraction of ground covered by green vegetation. 

### FCOVER ANALYSIS ###
# I expect to see >FCover for 2015 rather than 2019
#FCover quantify the spatial extent of the vegetation; it is independent from the illumination direction and it is sensitive to the vegetation amount therefore I hope to obtain better results and I expect <FCover for 2019.
# I'm going to import the Fcover data for 2015 and 2019: In this case I renamed the downloaded data to be quick
fcover2015 <- raster("fcover2015.nc")
fcover2019 <- raster("fcover2019.nc")

# I am cropping on South America to have a broader view about Brazil and Amazon Rainforest situations
ext<- c(-90,-25,-75,20)
fcover2015 <- crop(fcover2015, ext)
fcover2019 <- crop(fcover2019, ext)

# I am plotting the cropped maps and changing the palette to see better the difference
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100) # to define the color palette 
# I want to see the plot for 2015
# I'm using main = "" to put a title
plot(fcover2015, col=clf, main = "Fcover 2015")

# save the plot in png
png("Fcover 2015.png")
plot(fcover2015, col=clf, main = "Fcover 2015")
dev.off()

#same for 2019
plot(fcover2019, col=clf, main = "Fcover 2019")

#save the plot in png
png("Fcover 2019.png")
plot(fcover2019,col=clf, main = "Fcover 2019")
dev.off()

# I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows) 
par(mfrow=c(1,2))
# I am having 1 row and two columns. Let's see the plot
plot(fcover2015, col=clf,main="Fcover 2015")
plot(fcover2019, col=clf, main="Fcover  2019")

# save the plot in png
png("Fcover 2015 and 2019.png")
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100) # to define the color palette 
par(mfrow=c(1,2))
plot(fcover2015, col=clf,main="Fcover 2015")
plot(fcover2019, col=clf, main="Fcover 2019")
dev.off()

#####################
#Closer FCover results
#to see the FCover result better I've decided to crop the map another time by using ext function that I will name ext1 in order to not confuse the two crop
ext1<- c(-70,-40,-30,-15) #xmin,xmax,ymin,xmax
fcover2015 <- crop(fcover2015, ext1)
fcover2019 <- crop(fcover2019, ext1)
#I am plotting the two graphs together using par function; using the same palette and r
par(mfrow=c(1,2))
plot(fcover2015, col=clf, main = "closer Fcover 2015")
plot(fcover2019, col=clf, main = "closer Fcover 2019")

#and save it in png
png("closer Fcover 2015 and 2019.png")
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100) # to define the color palette 
par(mfrow=c(1,2))
plot(fcover2015, col=clf,main=" closer Fcover 2015")
plot(fcover2019, col=clf, main=" closer Fcover 2019")

##############################################################################
# I want to see the difference between the two periods too
diffcover_1519 <- fcover2015 - fcover2019
plot(diffcover_1519, col= clf, main = "Difference in FCover between 2015 and 2019")

# save the plot in png
png("Difference in FCover between 2015 and 2019.png")
clf <- colorRampPalette(c('cornsilk1','blanchedalmond','darkgoldenrod3','palegreen1','green3','darkgreen'))(100) # to define the color palette 
diffcover_1519 <- fcover2015 - fcover2019
plot(diffcover_1519, col= clf, main = "Difference in FCover between 2015 and 2019")

dev.off()
###############################################

### TEMPERATURE ANALYSIS ###
# let's do the same analysis but with land surface temperature between August 2015 and 2019
t2015 <- raster("temperature2015.nc")
t2019 <- raster("temperature2019.nc")

# I'm going to plot just the cropped image on South America since the data are heavy
ext<- c(-90,-25,-75,20)
t2015 <- crop(t2015, ext)
t2019 <- crop(t2019, ext)

# I'm going to set a new color Ramp Palette for the plot to see better the difference
clt <- colorRampPalette(c("yellow2","goldenrod","darkred"))(100) # to define the color palette 

# I want to see the plot (temperature in August 2015)
# I'm writing the title using main=""
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

# I want to see the difference in temperature between 2015 and 2019
# I am changing the color palette to better highlight the differences
tdiffcl <- colorRampPalette(c("mediumblue",'goldenrod','darkred'))(100)
dif_t <- t2019 - t2015
plot(dif_t, col= tdiffcl , main = "Difference in temperature between August 2019 and August 2015")

# save the plot in png
png("Tempertature 2015 and 2019.png")
tdiffcl <- colorRampPalette(c("mediumblue",'goldenrod','darkred'))(100) # to define the color palette 
plot(dif_t, col= tdiffcl , main = "Difference in temperature between August 2019 and August 2015")

#######################################################

#closer crop for difference in temperature #I'm keeping the closer crop used in the previous analysis, named ext1
ext1<- c(-70,-40,-30,-15) #xmin,xmax,ymin,xmax
cdif_t<-crop(dif_t, ext1)
plot(cdif_t, col=tdiffcl,main="cropped difference in T")

#save in png
png("cropped difference in T.png")
plot(cdif_t, col= tdiffcl , main = "cropped difference in T")

##############################################################
# I am using par function to have multiple graphs in a single plot (mfrow stays for multiframe rows; 2 rows and 2 column ) 
par(mfrow=c(2,2))
#and then plot
plot(t2015, col=clt, main="Temperature August 2015")
plot(t2019, col=clt, main="Temperature August 2019")
plot(dif_t, col= tdiffcl , main = "Difference in temperature between August 2019 and August 2015")
plot(cdif_t, col=tdiffcl,main="cropped difference in T")

# save the plot in png
png("plot temperature.png")
par(mfrow=c(2,2))
plot(t2015, col=clt, main="Temperature August 2015")
plot(t2019, col=clt, main="Temperature August 2019")
plot(dif_t, col= clt, main = "Difference in temperature between August 2019 and August 2015")
plot(cdif_t, col=tdiffcl,main="cropped difference in T")


dev.off()
###################################################

### BURNED AREAS ANALYSIS ###
#I've decided to change the colorRampPalette of the plot to highlight better the presence or absence of burned areas
fcl <- colorRampPalette (c("white", "darkred"))(2) # to define the color palette #in this case I used (2) since I've only two colors in the palette chosen
burnedareas2015<-raster("c_gls_BA300_201508310000_GLOBE_PROBAV_V1.0.1.nc")
burnedareas2019<-raster("c_gls_BA300_201908310000_GLOBE_PROBAV_V1.1.1.nc")

#Before plotting I'm going to crop the area of interest
ext<- c(-90,-25,-75,20)
burnedareas2015<- crop(burnedareas2015, ext)
burnedareas2019 <- crop(burnedareas2019, ext)

#to plot with the colorRampPalette just created (col=fcl) and to name my plot (main="burned areas 2015")
plot(burnedareas2015, col=fcl, main="burned areas 2015")
#save in png
png("burnedareas2015.png")
fcl <- colorRampPalette (c("white", "darkred"))(2)
plot(burnedareas2015, col=fcl, main="burned areas 2015")

#Since I've obtained a low resolution I'm going to replot with a closer crop 
ext1<- c(-70,-40,-30,-15)
cburnedareas2015<-crop(burnedareas2015, ext1) #I'm calling it cburnedareas2015 to distinguish it from the other one.
plot(cburnedareas2015, col=fcl, main="burned areas 2015") #It is strange that there aren't burned areas maybe the resolution it's low; I assume that the disturbance of the fire or the cloud cover has distorted the data. 
#save in png
png("burned areas 2015 crop.png")
fcl <- colorRampPalette (c("white", "darkred"))(2)
plot(cburnedareas2015, col=fcl, main="burned areas 2015")

#let's see the plot for 2019
plot(burnedareas2019, col=fcl, main="burned areas 2019")
#save in png
png("burnedareas2019.png")
fcl <- colorRampPalette (c("white", "darkred"))(2)
plot(burnedareas2019, col=fcl, main="burned areas 2019")

#last thing is to see the difference between burned areas; for 2015 I've not seen any burned data so even I will do 2019-2019 burned areas
difburnedareas<- burnedareas2019-burnedareas2015
plot(difburnedareas, col= fcl, main=" difference burned areas") 
#save the difference in png
png(" difburnedareas.png")
fcl <- colorRampPalette (c("white", "darkred"))(2) 
plot(difburnedareas, col=fcl,main="difburnedareas") 
dev.off()

#In conclusion I want to put the graphs of the burned area analysis in a single plot so I'm using par function
par(mfrow=c(2,2))
plot(burnedareas2015, col=fcl, main="burned areas 2015")
plot(burnedareas2019, col=fcl, main="burned areas 2019")
plot(difburnedareas, col=fcl,main="difburnedareas") 
####################################################################################################################################




