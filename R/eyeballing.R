# Norway at age 45, cohort 1935 vs 1973 
# eyeballed from Figure 1 in Kravdal https://doi.org/10.1007/s10680-021-09590-4

childless1 <- 0.15
childless2 <- 0.25
child1 <- 1-childless1
child2 <- 1-childless2

# https://doi.org/10.1093/humupd/dmac035, Table 1, Sperm concentration (upper part)
average1 <- 83.5 # 1973
average2 <- 57.1 # 2018

unselected1 <- 101.2 # 1973
unselected2 <- 49.0 # 2018

fertile1 <- 77.3 # 1977
fertile2 <- 72.8 # 2017

### Working with the overall average
opposite1a <- (average1-fertile1*child1)/childless1
opposite2a <- (average2-fertile2*child2)/childless2

1-opposite2a/opposite1a
1-average2/average1

### Working with unselected
opposite1u <- (unselected1-fertile1*child1)/childless1
opposite2u <- (unselected2-fertile2*child2)/childless2

1-opposite2u/opposite1u
1-unselected2/unselected1
