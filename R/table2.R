### Values for childlessness 
# Norwegian men at age 45, cohort 1935 vs 1973 
# eyeballed from Figure 1 in Kravdal https://doi.org/10.1007/s10680-021-09590-4
# Seems to be a pretty strong increase for such a short period

childless1 <- 0.15 # Cohort 1935
childless2 <- 0.25 # Cohort 1973
child1 <- 1-childless1
child2 <- 1-childless2

### Sperm concentration
# https://doi.org/10.1093/humupd/dmac035
# Table 2, upper part, 2000 vs 2018, unselected men
unselected_sc_1 <- 65.6 # 2000
unselected_sc_2 <- 35.3 # 2018

fertile_sc_1 <- 77.3 # 1977 value; unrealistic, likely overestimates decline in fertile men!
fertile_sc_2 <- 72.8 # 2017

# Reverse calculation with unselected
infertile_sc_u_1 <- (unselected_sc_1-fertile_sc_1*child1)/childless1
infertile_sc_u_2 <- (unselected_sc_2-fertile_sc_2*child2)/childless2

### Negative predicted values
infertile_sc_u_1
infertile_sc_u_2

### Results: Infertile men need to have a much steeper decline in quality
1-infertile_sc_u_2/infertile_sc_u_1
1-unselected_sc_2/unselected_sc_1


### Proportions infertile for which SC of infertile men is not negative in 2018
childless2 <- seq(0.01,0.99,by=0.01)
child2 <- 1-childless2
infertile_sc_u_2 <- (unselected_sc_2-fertile_sc_2*child2)/childless2
plot(childless2,infertile_sc_u_2,type="l",panel.first=abline(h=0))
