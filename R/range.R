### Numbers from Human reproduction
unselected_sc_1 <- 101.2 #
unselected_sc_2 <- 49.0 # 2018

fertile_sc_1 <- 77.3 # 1977
fertile_sc_2 <- 72.8 # 2017

### Range of proportions negatively selected
childless1 <- seq(0.01,0.99,by=0.01)
childless2 <- seq(0.01,0.99,by=0.01)
child1 <- 1-childless1
child2 <- 1-childless2
nc1 <- length(childless1)
nc2 <- length(childless2)

# Matrix for results
results <- matrix(data=NA,nrow=nc1,ncol=nc2)

# Values
start <- (unselected_sc_1-fertile_sc_1*child1)/childless1
last <- (unselected_sc_2-fertile_sc_2*child2)/childless2

# Loop 
for(i in 1:nc1) {
  for(j in 1:nc2) {
    if(start[i]<0 | last[j]<0) next
    results[i,j] <- (last[i]-start[j])/start[j]
  }
}

### Quick look at results
image(t(results))
# Negative selection has to be at least 30% for the second point in time
# otherwise we get negative values