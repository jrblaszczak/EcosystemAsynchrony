# Do dynamic time warping

setwd("Users/kek25/Documents/GitRepos/EcosystemAsynchrony/Data/")

library(dtw)
library(tidyverse)

Q=read.csv("BRB_Q_wy2019_merged.csv")
Q=Q[6:4353, ]


alignment<-dtw(Q$TwinSprings.Q,Q$Glenwood.Q,keep=TRUE)

## Display the warping curve, i.e. the alignment curve
plot(alignment,type="threeway")

plot(
  dtw(Q$TwinSprings.Q, Q$Glenwood.Q, keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

## See the recursion relation, as formula and diagram
rabinerJuangStepPattern(6,"c")
plot(rabinerJuangStepPattern(6,"c"))

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


lcm <- alignment$localCostMatrix
image(x = 1:nrow(lcm), y = 1:ncol(lcm), lcm)
text(row(lcm), col(lcm), label = lcm)
lines(alignment$index1, alignment$index2)