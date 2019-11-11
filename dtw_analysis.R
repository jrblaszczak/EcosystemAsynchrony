# Do dynamic time warping on discharge data in the Boise River Basin

#change this path to your local path name - there is a better way than switching everytime but that will take me some time to figure out
setwd("Users/kek25/Documents/GitRepos/EcosystemAsynchrony/Data/")

library(dtw)
library(tidyverse)

Q=read.csv("BRB_Q_wy2019_merged.csv")
Q=Q[6:4353, ]

# need this for plotting
alignment<-dtw(Q$TwinSprings.Q,Q$Glenwood.Q,keep=TRUE)

## Display the warping curve, i.e. the alignment curve
plot(alignment,type="threeway")

plot(
  dtw(Q$TwinSprings.Q, Q$Glenwood.Q, keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

## See the recursion relation, as formula and diagram - I dont understand these, but they mean something
rabinerJuangStepPattern(6,"c")
plot(rabinerJuangStepPattern(6,"c"))


#now do the same thing for other pairs of gages

#TwnSprings - Glenwood
plot(
  dtw(Q$TwnSprings.Q, Q$Parma.Q,keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

#Glenwood - Caldwell
plot(
  dtw(Q$Glenwood.Q[1700:4656],Q$Caldwell.Q[1700:4656], keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway")
#Caldwell - Parma
plot(
  dtw(Q$Caldwell.Q, Q$Parma.Q,keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

#I dont remember what all this does, but it ran really slow on my comp ...
lcm <- alignment$localCostMatrix
image(x = 1:nrow(lcm), y = 1:ncol(lcm), lcm)
text(row(lcm), col(lcm), label = lcm)
lines(alignment$index1, alignment$index2)