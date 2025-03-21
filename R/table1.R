### Values for childlessness 
# Norwegian men at age 45, cohort 1935 vs 1973 
# eyeballed from Figure 1 in Kravdal https://doi.org/10.1007/s10680-021-09590-4

childless1 <- 0.15 # Cohort 1935
childless2 <- 0.25 # Cohort 1973
child1 <- 1-childless1
child2 <- 1-childless2

### Sperm concentration
# https://doi.org/10.1093/humupd/dmac035
# Table 1, upper part, unselected/fertile from stratified model
total_sc_1 <- 83.5 # 1973
total_sc_2 <- 57.1 # 2018

unselected_sc_1 <- 101.2 # 1973; these are the numbers are also used in the graphical abstract
unselected_sc_2 <- 49.0 # 2018

fertile_sc_1 <- 77.3 # 1977
fertile_sc_2 <- 72.8 # 2017

# Reverse calculation with total
infertile_sc_t_1 <- (total_sc_1-fertile_sc_1*child1)/childless1
infertile_sc_t_2 <- (total_sc_2-fertile_sc_2*child2)/childless2

# Reverse calculation comes from
# total = fertile_sc * proportion_fertile + infertile_sc * proportion_infertile
# rearranging gives
# infertile_sc = (total - fertile_sc * proportion_fertile)/proportion_infertile

# Reverse calculation with unselected
infertile_sc_u_1 <- (unselected_sc_1-fertile_sc_1*child1)/childless1
infertile_sc_u_2 <- (unselected_sc_2-fertile_sc_2*child2)/childless2

### Total sperm count
# https://doi.org/10.1093/humupd/dmac035
# Table 1, lower part, unselected/fertile from stratified model
total_tsc_1 <- 297.4 # 1973
total_tsc_2 <- 205.6 # 2018

unselected_tsc_1 <- 335.7 # 1973
unselected_tsc_2 <- 126.6 # 2018

fertile_tsc_1 <- 305.8 # 1977
fertile_tsc_2 <- 296.1 # 2017

# Reverse calculation with total
infertile_tsc_t_1 <- (total_tsc_1-fertile_tsc_1*child1)/childless1
infertile_tsc_t_2 <- (total_tsc_2-fertile_tsc_2*child2)/childless2

# Reverse calculation with unselected
infertile_tsc_u_1 <- (unselected_tsc_1-fertile_tsc_1*child1)/childless1
infertile_tsc_u_2 <- (unselected_tsc_2-fertile_tsc_2*child2)/childless2

### Negative predicted values
infertile_sc_t_1
infertile_sc_t_2
infertile_sc_u_1
infertile_sc_u_2

infertile_tsc_t_1
infertile_tsc_t_2
infertile_tsc_u_1
infertile_tsc_u_2

### Results: Infertile men need to have a much steeper decline in quality
# This compares infertile men with the reference from the paper
1-infertile_sc_t_2/infertile_sc_t_1
1-total_sc_2/total_sc_1 

1-infertile_sc_u_2/infertile_sc_u_1
1-unselected_sc_2/unselected_sc_1

1-infertile_tsc_t_2/infertile_tsc_t_1
1-total_tsc_2/total_tsc_1

1-infertile_tsc_u_2/infertile_tsc_u_1
1-unselected_tsc_2/unselected_tsc_1
