# Do dynamic time warping

setwd("~/Documents/GitRepos/UrbanStreamflow")

library(dtw)
library(tidyverse)

Q=read.csv("BRB_Q_wy2019_merged.csv")

#TwnSprings.x ==  "13185000"
#Glenwood.y ==  "13206000"
#Caldwell.x.x ==  "13211205"
#Parma.y.y ==  "13213000"

Q=Q[6:4353, ]

alignment<-dtw(Q$Flow_Inst.y,Q$Flow_Inst.x.x,keep=TRUE)

## Display the warping curve, i.e. the alignment curve
plot(alignment,type="threeway")

plot(
  dtw(Q$Flow_Inst.y.y,Q$Flow_Inst.x.x,keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

## See the recursion relation, as formula and diagram
rabinerJuangStepPattern(6,"c")
plot(rabinerJuangStepPattern(6,"c"))

#TwnSprings - Glenwood

plot(
  dtw(TwnSprings$Flow_Inst,Parma$Flow_Inst,keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

#Glenwood - Caldwell
plot(
  dtw(Glenwood$Flow_Inst[1700:4656],Caldwell$Flow_Inst[1700:4656], keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway")
#Caldwell - Parma
plot(
  dtw(Caldwell$Flow_Inst,Parma$Flow_Inst,keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)


#Fethervill - twin sprin

plot(
  dtw(Featherville$Flow_Inst,TwnSprings$Flow_Inst, keep=TRUE,
      step=rabinerJuangStepPattern(6,"c")),
  type="twoway",offset=-2)

plot(TwnSprings$dateTime, TwnSprings$Flow_Inst, type = 'l')
lines(Parma$dateTime, Parma$Flow_Inst, type='l', col='blue')

lcm <- alignment$localCostMatrix
image(x = 1:nrow(lcm), y = 1:ncol(lcm), lcm)
text(row(lcm), col(lcm), label = lcm)
lines(alignment$index1, alignment$index2)