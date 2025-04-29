# Outcome measure by treatment group
treated <- 60
untreated <- 100

# Prevalence of treatment over time
p_treatment_1 <- 0.4
p_treatment_2 <- 0.1

# Prevalence of control
p_u_1 <- 1-p_treatment_1
p_u_2 <- 1-p_treatment_2

# Results
r1 <- treated*p_treatment_1+untreated*p_u_1
r2 <- treated*p_treatment_2+untreated*p_u_2

# Change
r2/r1
