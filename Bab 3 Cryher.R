#Exhibit 3.1 Random Walk
library(TSA)
data(rwalk)
model1=lm(rwalk~time(rwalk))
summary(model1)

#Exhibit 3.1 Random Walk linear trend
win.graph(width=4.875, height=2.5,pointsize=8)
data(rwalk) # rwalk contains a simulated random walk
plot(rwalk,type='o',ylab='Random Walk')
abline(model1) 

#exhibit 3.3
data(tempdub)
(tempdub)
month.=season(tempdub)# period added to improve table display
month.
model2=lm(tempdub~month.-1) # -1 removes the intercept term 
summary(model2)
model3=lm(tempdub~month.) # January is dropped automatically
summary(model3)

#Exhibit 3.5 Cosine Trend Model for Temperature Series
har.=harmonic(tempdub,1)
model4=lm(tempdub~har.)
summary(model4)

#Exhibit 3.6 Cosine Trend for the Temperature Series
win.graph(width=4.875, height=2.5,pointsize=8)
plot(ts(fitted(model4),freq=12,start=c(1964,1)), 
ylab='Temperature',type='l',
ylim=range(c(fitted(model4),tempdub))); points(tempdub) # ylim ensures that the y axis range fits the raw data and the fitted values

#Exhibit 3.7 Regression Output for Linear Trend Fit of Random Walk
model1=lm(rwalk~time(rwalk))
summary(model1)

#Exhibit 3.8 Residuals versus Time for Temperature Seasonal Means 
plot(y=rstudent(model3),x=as.vector(time(tempdub)),
     xlab='Time',ylab='Standardized Residuals',type='o')
#Exhibit 3.9 Residuals versus Time with Seasonal Plotting Symbols
plot(y=rstudent(model3),x=as.vector(time(tempdub)),xlab='Time',
ylab='Standardized Residuals',type='l')
points(y=rstudent(model3),x=as.vector(time(tempdub)), 
         pch=as.vector(season(tempdub)))

#Exhibit 3.11 Histogram of Standardized Residuals from Seasonal Means Model
hist(rstudent(model3),xlab='Standardized Residuals')

#Exhibit 3.12 Q-Q Plot: Standardized Residuals of Seasonal Means Mode
qqnorm(rstudent(model3))

#Exhibit 3.13 Sample Autocorrelation of Residuals of Seasonal Means Mode
acf(rstudent(model3))

#Exhibit 3.14 Residuals from Straight Line Fit of the Random Walk
plot(y=rstudent(model1),x=as.vector(time(rwalk)), 
    ylab='Standardized Residuals',xlab='Time',type='o')

#Exhibit 3.15 Residuals versus Fitted Values from Straight Line Fit
plot(y=rstudent(model1),x=fitted(model1), 
     ylab='Standardized Residuals',xlab='Fitted Trend Line Values', 
     type='p')

#Exhibit 3.16 Sample Autocorrelation of Residuals from Straight Line Model
acf(rstudent(model1))

#Exhibit 3.17 Quantile-Quantile Plot of Los Angeles Annual Rainfall Series
data("larain")
qqnorm(larain); 
qqline(larain)
