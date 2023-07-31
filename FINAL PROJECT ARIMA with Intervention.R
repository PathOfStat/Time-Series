getwd()
setwd("C:/Users/ASUS/OneDrive - Institut Teknologi Sepuluh Nopember/Dokumen/Semester 6/time series/final project")

library(TSA)
library(tsoutliers)
library(forecast)
library(tseries)
library(lmtest)
library(nortest)
library(xts)
library(CausalImpact)
library(MASS)

#set data
coeftest(m1)
df<-read.csv("011170.KSV2.csv")
Diagnostik = function(model){
  par(mfrow=c(2,2))
  
  # Plot sisaan terhadap order
  plot(residuals(model), ylab ='Residuals', type='o'); 
  abline(h=0)
  
  # QQ plot
  qqnorm(residuals(model))
  qqline(residuals(model))
  
  # Histogram sisaan
  hist(model$residuals)
  
  # Plot ACF sisaan
  acf(model$residuals)
  
  # Uji Ljung-Box
  print(Box.test(model$residuals, type = "Ljung-Box"))
  
  # Uji Kolmogorov-Smirnov
  print(ks.test(model$residuals, "pnorm", mean=mean(model$residuals), sd=sd(model$residuals)))
  
  # uji t-test
  print(t.test(model$residuals, mu = 0, alternative = "two.sided"))
}
full<-df[1:330,c("Date","Close")]
pre<-df[1:258,c("Date","Close")]
post<-df[259:330,c("Date","Close")]
full$Date<-as.Date(full$Date)
fullxts<-xts(full$Close,order.by=as.POSIXct(full$Date))
prexts<-xts(pre$Close,order.by=as.POSIXct(pre$Date))
postxts<-xts(post$Close,order.by=as.POSIXct(post$Date))

fullts<-ts(full$Close)
prets<-ts(pre$Close)
posts<-ts(post$Close)
# pengujian stationer plot acf dan pacf
par(mfrow=c(1,2))
acf(prets)
pacf(prets)
tsbc<-BoxCox(prets,-0.5)
tsbc
plot(tsbc,type="l")

adf.test(tsbc)
par(mfrow=c(1,1))
acf(tsbc,lag.max = 100)
pacf(tsbc)
acf(diff(tsbc,1))
pacf(diff(tsbc,1))

#membuat berbagai model sebelum intervensi
m1<-Arima(prets,order = c(1,0,0),lambda = -0.5) #lolos uji coef dan normalitas
m2<-Arima(prets,order = c(2,0,0),lambda = -0.5) 
m3<-Arima(prets,order = c(1,0,0),seasonal = list(order=c(1,0,0),period=20) ,lambda = -0.5)#lolos uji
m4<-Arima(prets,order = c(0,0,0),seasonal = list(order=c(1,0,0),period=20) ,lambda = -0.5)#lolos uji
m5<-Arima(prets,order = c(0,1,0),seasonal = list(order=c(1,0,0),period=20), lambda = -0.5)
m6<-Arima(prets,order = c(1,0,1),lambda = -0.5)
m7<-Arima(prets,order = c(2,1,0),lambda = -0.5)
m8<-Arima(prets,order = c(1,1,1),lambda = -0.5)
m9<-Arima(prets,order = c(1,1,2),lambda = -0.5)
m10<-Arima(prets,order = c(0,1,0),lambda = -0.5)

#pengujian asumsi model intervensi
coeftest(m1)
coeftest(m2)
coeftest(m3)
coeftest(m4)
coeftest(m5)
coeftest(m6)
coeftest(m7)
coeftest(m8)

coeftest(m9)
coeftest(m10)

Diagnostik(m1)
Diagnostik(m2)
Diagnostik(m3)
Diagnostik(m4)
Diagnostik(m5)
Diagnostik(m6)
Diagnostik(m7)
Diagnostik(m8)
Diagnostik(m10)

Diagnostik(fit)
accuracy(m1)
accuracy(m3)
AIC(m1)
AIC(m3)
plot(forecast(m1))
coeftest(m1)
accuracy(m1)
#plot model terbaik sebelum intervensi
par(mfrow=c(1,1))
plot(prets,lwd=2,col="blue",lty=2,main="plot fitted vs actual")
yhat<-m1$fitted
yhat2<-m3$fitted
lines(yhat,col="black",lty=2,lwd=2)
lines(yhat2,col="red",lty=2,lwd=2)
legend("topright",                           # Add legend to plot
       c("Actual", "Arima (1,0,0)","Arima (1,0,0)(1,0,0)20"),
       lwd=2,
       lty=2,
       col = c("blue","black","red"))

#MAPE model terbaik sebelum intervensi
mean((abs(prets-m1$fitted)/prets))*100
mean((abs(prets-m3$fitted)/prets))*100
#Bayesian Impact

preperiod<-c(1, 258)
postperiod<-c(259, 330)
impact<-CausalImpact(full$Close,pre.period = preperiod,post.period = postperiod)
impact
plot(impact)
summary(impact,"report")

#mencari intervensi
plot(tso(fullts))
tso(fullts)

#Model Intervensi
fit <- arimax(fullts, order = c(1, 0, 0), 
              xtransf = data.frame(pulse = 1 * (seq_along(fullts) == 300)),
              transfer = list(c(0, 0)))
fit
mean(abs(fit$residuals/fullts))*100
m1

par(mfrow=c(1,1))
plot(fullts,lwd=2,col="blue",lty=2,main="plot fitted vs actual")
yhat3<-fitted(fit)
lines(yhat3,col="black",lty=2,lwd=2)
legend("topright",                           # Add legend to plot
       c("Actual", "Model Intervensi"),
       lwd=2,
       lty=2,
       col = c("blue","black"))
coeftest(fit)
Diagnostik(fit)

s<-predict(fit,n.ahead = 10)
s$pred[,1]
a<-c(1:10)

plot(s$pred[,1],type='l')

