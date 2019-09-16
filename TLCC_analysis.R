## Time lagged cross correlation for
## Contingent out of phase synchrony

## Load packages
lapply(c("plyr","dplyr","ggplot2","cowplot",
         "lubridate","tidyverse", "reshape2",
         "PerformanceAnalytics","jpeg","grid",
         "rstan","bayesplot","shinystan"), require, character.only=T)

##############################
## Data Import & Processing ##
##############################
setwd("~/GitHub/EcosystemAsynchrony/Data")
data <- read.csv("NWIS_2010_3SiteYears.csv", header=T)
data$date <- as.POSIXct(as.character(data$date), format="%Y-%m-%d")

## split list by ID
l <- split(data, data$ID)

rel_LQT <- function(x){
  x$light_rel <- x$light/max(x$light)
  x$temp_rel <- x$temp/max(x$temp)
  x$tQ <- (x$Q-mean(x$Q))/sd(x$Q)
  x<-x[order(x$date),]
  return(x)
}

dat <- lapply(l, function(x) rel_LQT(x))

##################################################################
## Visualize & Extract Example Recovery Trajectories Post-Storm ##
##################################################################

vis_ts <- function(x) { plot_grid(
  ggplot(x, aes(date, GPP))+geom_line(color="chartreuse4"),
  ggplot(x, aes(date, Q))+geom_line(color="darkblue")+ylab("Q (cms)"),
  ncol=1, align="hv")}

vis_ts(dat$Clackamas_OR)

## Example 1: Extract spring of 2010 from Clackamas, OR
ex1 <- subset(dat$Clackamas_OR, date > as.Date("2010-01-01") & date < as.Date("2010-08-01"))
vis_ts(ex1)

#####################
## Time-lagged ccf ##
#####################

ccf(ex1$GPP, ex1$Q)

## Interpretation TBD

## Links I need to read
## https://homepage.univie.ac.at/robert.kunst/prognos4.pdf
## https://onlinecourses.science.psu.edu/stat510/lesson/8/8.2











