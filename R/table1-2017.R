### Values for childlessness 
# Norwegian men at age 45, cohort 1935 vs 1973 
# eyeballed from Figure 1 in Kravdal https://doi.org/10.1007/s10680-021-09590-4

childless1 <- 0.15 # Cohort 1935
childless2 <- 0.25 # Cohort 1973
child1 <- 1-childless1
child2 <- 1-childless2

### Sperm concentration 2017
# 
# Table 1, upper part, unselected/fertile from stratified model
unselected_sc_1 <- 99.0 # 1973; these are the numbers are also used in the graphical abstract
unselected_sc_2 <- 47.1 # 2011

fertile_sc_1 <- 83.8 # 1977
fertile_sc_2 <- 62.0 # 2009

# Reverse calculation with unselected
infertile_sc_u_1 <- (unselected_sc_1-fertile_sc_1*child1)/childless1
infertile_sc_u_2 <- (unselected_sc_2-fertile_sc_2*child2)/childless2
