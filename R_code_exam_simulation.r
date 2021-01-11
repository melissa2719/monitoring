#R code for the exam
# nc data need library

install.packages("ncdf4")
library(ncdf4)

setwd("C:/lab/")

library(raster)
tjan <- raster("c_gls_LST10-DC_202101010000_GLOBE_GEO_V1.2.1.nc")
plot(tjan)

#color ramp palette
cltjan <- colorRampPalette(c('darkslategrey','darkslategray4','darkslategray1'))(100)
plot(tjan, col=cltjan)

cltjan <- colorRampPalette(c('blue','yellow','red'))(100) 
plot(tjan, col=cltjan)

#same for october data
toct <- raster("c_gls_LST10-DC_202010010000_GLOBE_GEO_V1.2.1.nc")
plot(toct, col=cltjan)

#compare them difference between Temperature
dift <- tjan - toct
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(dift, col=cldif)



