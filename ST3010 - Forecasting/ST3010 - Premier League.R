library(forecast)

# The first step required is to read the data from Excel into time-series object
# skip = 2 removes the first two rows of the datasheet which are not relevant to my analysis
# header must be set to TRUE as the next row contains suitable headers for my data 
filepath = "C:/Users/Ross/Documents/MSISS/Third Year/ST3010 - Forecasting/premleague.csv"
premleaguets = ts(read.csv(filepath, header = TRUE, skip = 0, sep = ",")[,2],
                  start = c(2004,01), end = c(2017,12), frequency = 12)


############## Part 1 - Visualisation Tools ########################################################

#Visualise time series using plot function
plot(premleaguets, xlab = "Time", ylab = "% of Peak Popularity", main = "Premier League")

#Decompose time series into trend,seasonal & noise components using decompose function
decomp = decompose(premleaguets)
plot(decomp)

#Generate the season plot of time series
seasonplot(premleaguets)
  
#Generate the ACF and the PACF 
Acf(premleaguets, main = "Premier League ACF")
Pacf(premleaguets, main = "Premier League PACF")

#Use tsdisplay to combine plot, Acf and Pacf
tsdisplay(premleaguets, main = "Premier League Time Series")



############# Part 2 - Holt Winters Algorithm ######################################################

#Only seasonal HW apply. Generate by additive and multiplicative and compare SSE#
#additive#
additive = HoltWinters(premleaguets)
additive$SSE

#multiplicative
mult = HoltWinters(premleaguets, seasonal = "multiplicative")
mult$SSE

#Now generate forecasts based on the multiplicative HW
plot(forecast(mult))



############# Part 3 - ARIMA Models ################################################################
#Visualise the residuals - ACF significant at all levels
tsdisplay(arima(premleaguets, order = c(0,0,0), seasonal = list(order= c(0,0,0), period = 12))$residuals)

#remove seasonality (0,0,0)(0,1,0)
tsdisplay(arima(premleaguets, order = c(0,0,0), seasonal = list(order= c(0,1,0), period = 12))$residuals)

#remove trend (0,1,0)(0,1,0)
tsdisplay(arima(premleaguets, order = c(0,1,0), seasonal = list(order= c(0,1,0), period = 12))$residuals)

#slight exponential decay in PACF removed (0,1,0)(0,1,1)
tsdisplay(arima(premleaguets, order = c(0,1,0), seasonal = list(order= c(0,1,1), period = 12))$residuals)

#slight exponential decay in ACF removed (0,1,0)(1,1,1)
tsdisplay(arima(premleaguets, order = c(0,1,0), seasonal = list(order= c(1,1,1), period = 12))$residuals)

arimafit = arima(premleaguets, order = c(0,1,0), seasonal = list(order= c(1,1,1), period = 12))
arimafit$aic

#Use built in auto arima R function
auto = auto.arima(premleaguets)
auto$aic
#Auto.arima marginally better however using BIC the two methods are equal

#Generate forecasts based on auto
forecast(auto)
plot(forecast(auto))
