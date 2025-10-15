### Reproducing Carlsen et al. 1992 ############################################

  ### Carlsen et al. 1992: https://doi.org/10.1136/bmj.305.6854.609 


### Packages ###################################################################

  library(tidyverse)


### Loading and editing data ###################################################

  # Importing data
  Carlsen1992 <- read.csv("Data/Carlsen et al. 1992_Data.csv")
  
  # Fertility indicator as factor
  Carlsen1992$Fertility <- factor(Carlsen1992$Fertility, 
                                  levels = c(1, 2), 
                                  labels = c("proven fertile", "unselected"))
  
  # Mean vs median as factor
  Carlsen1992$Measure <- factor(Carlsen1992$Measure     , 
                                levels = c(1, 2), 
                                labels = c("mean", "median"))


### Reproducing Figure 1 #######################################################

  # Figure 1
  Carlsen1992 |> 
  ggplot(aes(x = Year, y = SpermCount,weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 150) +
    xlim(1937,1990)+
    labs(title = "Trends in mean sperm count", 
         x = "Year", 
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  # The figure differs from Fig 1 in the paper. The latter
  # only shows 32 data points, instead of all 61. Possible explanation: 32 of 
  # the studies included in the meta analysis  had 3 day abstinence period 
  # prescribed and perhaps Fig 1 just shows these data points. 
  
  # Regression with and without weights and with all variables
  summary(lm(SpermCount ~ Year, data = Carlsen1992, weights = SampleSize))
  summary(lm(SpermCount ~ Year, data = Carlsen1992))
  summary(lm(SpermCount ~ Year + Fertility + Measure, data = Carlsen1992, weights = SampleSize))
  
  # Apart from the difference between Fig 1 and the figure with all data 
  # points, our results are largely consistent with Carlsen et al. 


### General robustness checks ##################################################
  
  # Only data after 1970
  Carlsen1992 |> 
  filter(Year>1970) |> 
  ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 150) +
    xlim(1937,1990)+
    labs(title = "Trends in mean sperm count (> 1970)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Year > 1970), weights = SampleSize))
  
  # Only data after 1980
  Carlsen1992 |> 
  filter(Year>1980) |> 
  ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 150) +
    xlim(1937,1990)+
    labs(title = "Trends in mean sperm count (> 1980)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()

  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Year > 1980), weights = SampleSize))
  
  # Quadratic model: Year + Year^2
  Carlsen1992 |> 
    ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm",formula = y ~ x + I(x^2), linetype = 5, se = FALSE) +
    scale_size_continuous(range = c(0.01, 6)) +
    xlim(1937,1990)+
    ylim(0, 150) +
    labs(title = "Trends in mean sperm count (quadratic fit)", 
         x = "Year", 
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year + I(Year^2), data = Carlsen1992, weights = SampleSize))

  # split by proven fertility 
  Carlsen1992 |> 
  ggplot(aes(x = Year, y = SpermCount, weight = SampleSize, color = Fertility)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", se = FALSE) +
    scale_size_continuous(range = c(1, 6)) +
    scale_color_manual(values = c("red", "blue"), 
                       labels = c("proven fertile", "unselected"), 
                       name = "Fertility Group") +
    labs(title = "Trends in mean sperm count by fertility", 
         x = "Year", 
         y = "Mean Sperm Count") +
    xlim(1937,1990)+
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Fertility == "proven fertile"), weights = SampleSize))
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Fertility == "unselected"), weights = SampleSize))

  
### Robustness checks: only US data ############################################  

  # Main model
  Carlsen1992 |> 
  filter(Country == "United States") |> 
  ggplot(aes(x = Year, y = SpermCount,weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    xlim(1937,1990)+
    ylim(0, 150) +
    labs(title = "Trends in mean sperm count (USA only)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Country == "United States"), weights = SampleSize))
  
  # Quadratic 
  Carlsen1992 |> 
  filter(Country == "United States") |> 
  ggplot(aes(x = Year, y = SpermCount,weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm",formula = y ~ x + I(x^2), linetype = 5, se = FALSE) +
    scale_size_continuous(range = c(0.01, 6)) +
    xlim(1937,1990)+
    ylim(0, 150) +
    labs(title = "Weighted Linear Regression of Mean Sperm Count over Year (USA)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year + I(Year^2), data = subset(Carlsen1992, Country == "United States"), weights = SampleSize))

  # Just data after 1970
  Carlsen1992 |> 
  filter(Country == "United States" & Year > 1970) |> 
  ggplot(aes(x = Year, y = SpermCount, weight = SampleSize)) +
    geom_point(aes(size = log(SampleSize)), shape = 21, stroke = 1) +
    geom_smooth(method = "lm", linetype = 5, se = FALSE ) +
    scale_size_continuous(range = c(0.01, 6)) +
    ylim(0, 150) +
    xlim(1937,1990)+
    labs(title = "Weighted Linear Regression of Mean Sperm Count over Year(> 1970, only US)",
         x = "Year",
         y = "Sperm Count (x10^6/ml)") +
    theme_minimal()
  
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Year > 1970 & Country == "United States"),weights = SampleSize ))
  summary(lm(SpermCount ~ Year, data = subset(Carlsen1992, Year > 1970 & Country == "United States") ))
