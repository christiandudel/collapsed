### Data from Swan et al. 2000 #################################################

  ### Swan et al 2000: https://doi.org/10.1289/ehp.00108961

  ### This is NOT a reproduction of Swan et al, only using the same data


### Packages ###################################################################

  library(tidyverse)


### Loading and editing data ###################################################

  # Loading
  Carlsen1992 <- read.csv("Data/Carlsen et al. 1992_Data.csv")
  Swan2000 <- read.csv("Data/Swan et al. 2000_Data.csv")

  # Combining Carlsen et al. 1992 with Swan et al. 2000
  Carlsen1992$MetaAnalysis <- "Carlsen1992"
  Swan2000$MetaAnalysis <- "Swan2000"
  DataCombined <- rbind(Carlsen1992, Swan2000)
  
  # Adding 12 to median/geometric mean 
  DataCombined <- DataCombined |> mutate(SpermCount=ifelse(Measure %in% 2:3,
                                                           SpermCount+12,
                                                           SpermCount))

  
### Plot & regression ##########################################################  
  
  DataCombined |> 
    ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), 
               shape = 21, 
               stroke = 1) +
    geom_smooth(method = "lm", 
                linetype = 5, 
                se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 160) +
    xlim(1930,2000)+
    labs(title = "Trends in mean sperm count", 
         x = "Year", 
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()  
  
  summary(lm(SpermCount ~ Year, data = DataCombined, weights = SampleSize))
  
  fit1 <- lm(SpermCount ~ Year, data = DataCombined, weights = SampleSize)
  diff(predict(fit1,data.frame(Year=c(1940,1990))))
  
  
### Robustness checks ##########################################################
  
  # Only data after 1970
  DataCombined |> 
    filter(Year>1970) |> 
    ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 160) +
    xlim(1930,2000)+
    labs(title = "Trends in mean sperm count (> 1970)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1970), weights = SampleSize))
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1970)))
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1970), weights = log(SampleSize)))
  
  fit2 <- DataCombined |> filter(Year>1970) |> lm(SpermCount ~ Year, data = _, weights = SampleSize)
  diff(predict(fit2,data.frame(Year=c(1940,1990))))
  
  # Only data after 1980
  DataCombined |> 
    filter(Year>1980) |> 
    ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 160) +
    xlim(1930,2000)+
    labs(title = "Trends in mean sperm count (> 1980)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1980), weights = SampleSize))
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1980)))
  summary(lm(SpermCount ~ Year, data = subset(DataCombined, Year > 1980), weights = log(SampleSize)))
  
  # Quadratic model: Year + Year^2
  DataCombined |> 
    ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm",formula = y ~ x + I(x^2), linetype = 5, se = FALSE) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 160) +
    xlim(1930,2000)+
    labs(title = "Trends in mean sperm count (quadratic fit)", 
         x = "Year", 
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year + I(Year^2), data = DataCombined, weights = SampleSize))
  