## Wavelet Analysis

install.packages('wavelets', dependencies = T)
install.packages('wavethresh', dependencies = T)
install.packages('WaveletComp', dependencies = T)

library(wavelets)
library(wavethresh)
library(WaveletComp)
library(lubridate)
library(zoo)
library(xts)
library(dygraphs)
library(pracma)
library(dplyr)
library(reshape2)
library(Hmisc)
library(ggplot2)
library(grid)
library(gridExtra)



## Read in all data
mydata <- ldply(list.files(pattern = "csv"), function(filename) {
  dum = read.csv(filename)
  #If you want to add the filename as well on the column
  dum$filename = filename
  return(dum)
})

## Separate out by stream level
X <- split(mydata, mydata$Stream)
str(X)

## Find Daily Means of SpC
xts.daily <- function(x){
  xts.x <- as.xts(x,x$DateTime)
  y <- apply.daily(xts.x, mean)
  return(y)
}

X <- lapply(X, function(x) xts.daily(x))





random


## Example Data

x = periodic.series(start.period = 50, length = 1000)
x= x + 0.2*rnorm(500)

my.data = data.frame(x=x)
my.w = analyze.wavelet(my.data, "x", loess.span = 0, dt=1, dj=1/250, lowerPeriod= 16, upperPeriod = 128, make.pval = T, n.sim=10)
wt.image(my.w, color.key="quantile", n.levels = 250, legend.params = list(lab="wavelet power levels", mar=4.7))

reconstruct(my.w, plot.waves = F, lwd=c(1,2), legend.coords = "bottomleft")



## My Example Data
setwd("C:/Users/jrb78/Box Sync/Home Folder jrb78/Desktop Box Sync/Urban Streams/Chemical Flashiness Project/UrbanData Processed/SpecCond")

sc13 <- read.csv('W13_SpCond_Edited.csv', header=T)
names(sc13)

sapply(sc13, class)
sc13$DateTime <- as.POSIXct(as.character(sc13$DateTime), format="%m/%d/%Y %H:%M:%S")
sc13.s <- subset(sc13,DateTime >= as.POSIXct("2013-11-01 00:00:00") & DateTime <= as.POSIXct("2016-05-08 11:55:00"))
colnames(sc13.s)[4] <- "date"

#visualize
xts.sc13 <- xts(sc13.s$Interpolation, order.by=sc13.s$date)
dygraph(xts.sc13)



sc13.w <- analyze.wavelet(my.data=sc13.s, my.series = "Interpolation", loess.span = 0, dt=1, dj=1/250, lowerPeriod= 16, upperPeriod = 128, make.pval = T, n.sim=10)















