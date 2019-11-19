install.packages("biwavelet")
library(biwavelet)
install.packages("janitor")
install.packages("tibble")

library(tibble)
library(janitor)


closeAllConnections()
rm(list=ls())


Data <- read.csv("Connecticut_cQ_update_fill_0.3.csv")
Data <- read.csv("Potomac_cQ_fill.csv")
Data$timestamp <- as.Date(Data$timestamp,origin = "1899-12-30")
Data$timestamp <- excel_numeric_to_date(as.numeric(as.character(Data$timestamp)), date_system = "modern")   

#Data[is.na(Data)] <- 0

attach(Data)

# Define two sets of variables with time stamps
t1 <- cbind.data.frame(Data$timestamp,Data$Discharge..cfs)
t2 <- cbind.data.frame(Data$timestamp,Data$Nitrate..mg.N.L)
t1 = cbind(Data$timestamp,Data$Discharge..cfs)
t2 = cbind(Data$timestamp,Data$Nitrate..mg.N.L)

#number of iterations. The more the better (>1000)
nrands = 10 

wtc.AB = wtc(t1,t2,nrands=nrands)

# Plotting a graph
par(oma = c(0, 0, 0, 1), mar = c(5, 4, 5, 5) + 0.1)
plot(wtc.AB, plot.phase = TRUE, lty.coi = 1, col.coi = "grey", lwd.coi = 2, 
     lwd.sig = 2, arrow.lwd = 0.03, arrow.len = 0.12, ylab = "Scale", xlab = "Period", 
     plot.cb = TRUE, main = "Wavelet Coherence: A vs B")

# Adding grid lines
#n = length(t1[, 1])
#abline(v = seq(260, n, 260), h = 1:16, col = "brown", lty = 1, lwd = 1)

# Defining x labels
axis(side = 3, at = c(seq(0, n, 260)), labels = c(seq(1999, 2015, 1)))
