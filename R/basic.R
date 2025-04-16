### Collapsing predictors, proof of concept

# Seed
set.seed(1932)

# Outcome model
constant <- 0
positive <- 2
negative <- -2
errorsd <- 0.5

# Probability of observing selected studies
startpositive <- 0.4 
endpositive <- 0.05

startnegative <- 0.1
endnegative <- 0.4

# Years
years <- 1970:2020
nyears <- length(years)

# Studies per year
n <- 10

# Interpolating probabilities
positiveprobs <- nyears
negativeprobs <- nyears
neutralprobs <- nyears

positiveprobs <- seq(startpositive,endpositive,length.out=nyears)
negativeprobs <- seq(startnegative,endnegative,length.out=nyears)
neutralprobs <- 1-(positiveprobs+negativeprobs)

# Generate data frame
simulateddata <- data.frame(year=numeric(),
                            positive=numeric(),
                            negative=numeric(),
                            neutral=numeric(),
                            outcome=numeric())
# Number of studies
nostudies <- n*nyears

# Loop over years
for(year in years) {
  whichyear <- which(years==year)
  yearvar <- rep(year,n)
  typevar <- sample(c(1,2,3),size=n,rep=TRUE,prob=c(positiveprobs[whichyear],
                                                    negativeprobs[whichyear],
                                                    neutralprobs[whichyear]))
  
  positivevar <- as.numeric(typevar==1)
  negativevar <- as.numeric(typevar==2)
  neutralvar <- as.numeric(typevar==3)
  
  outcomevar <- constant + positivevar*positive + negativevar*negative + rnorm(n=n,sd=errorsd)
  
  tmpdata <- data.frame(year=year,
                        positive=positivevar,
                        negative=negativevar,
                        neutral=neutralvar,
                        outcome=outcomevar)
  
  simulateddata <- rbind(simulateddata,tmpdata)
  
}

# Dummy for selection
simulateddata$selected <- as.numeric(simulateddata$positive==1|simulateddata$negative==1)

# Dummy for "unselected"
simulateddata$unselected <- as.numeric(simulateddata$positive!=1)

# Regressions
fit1 <- lm(outcome~year,data=simulateddata)
fit2 <- lm(outcome~year+selected,data=simulateddata)
fit3 <- lm(outcome~year+positive,data=simulateddata)
fit4 <- lm(outcome~year,data=simulateddata[simulateddata$positive!=1,])
fit5 <- lm(outcome~year+positive+negative,data=simulateddata)

# Results: overview
summary(fit1)
summary(fit2)
summary(fit3)
summary(fit4)
summary(fit5)

# Effect of going from first to last year, standardized
coef(fit1)["year"]*nyears/sd(simulateddata$outcome)
coef(fit2)["year"]*nyears/sd(simulateddata$outcome)
coef(fit3)["year"]*nyears/sd(simulateddata$outcome)
coef(fit4)["year"]*nyears/sd(simulateddata$outcome)
coef(fit5)["year"]*nyears/sd(simulateddata$outcome)
