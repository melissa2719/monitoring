library(raster)
library(RStoolbox)

#setwd
setwd("C:/lab")

p224r63_2011 <- brick("p224r63_2011_masked.grd")


plot(p224r63_2011)
cl <- colorRampPalette(c('black','grey','light grey'))(100) # 
plot(p224r63_2011, col=cl)

#grafici colori diversi B=band 
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clg <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clg)


clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

#in RGB colors
dev.off()
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#green is the woodland
#let's move the layers so we shift by one in the blue we put the green; in the green we put 
the red; in the red we put the yellow one)

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#all the vegetation become red and in the red we can see cuts that could be streets and so on

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#B4 in the green component urban area is becoming violet

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#4 plot in the same graph
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

