#Exhibit 1.1 Time Series Plot of Los Angeles Annual Rainfall
library(TSA)
win.graph(width=4.875, height=2.5,pointsize=8)
data(larain)
plot(larain,ylab='Inches',xlab='Year',type='o')
#Exhibit 1.2 Scatterplot of LA Rainfall versus Last Year's LA Rainfall
win.graph(width=3,height=3,pointsize=8)
plot(y=larain,x=zlag(larain),ylab='Inches', 
     xlab='Previous Year Inches')
#Exhibit 1.3 Time Series Plot of Color Property from a Chemical Process
win.graph(width=4.875, height=2.5,pointsize=8)
data(color)
plot(color,ylab='Color Property',xlab='Batch',type='o')
#Exhibit 1.4 Scatterplot of Color Value versus Previous Color Value
win.graph(width=3,height=3,pointsize=8) 
plot(y=color,x=zlag(color),ylab='Color Property', 
     xlab='Previous Batch Color Property')
#Exhibit 1.5 & 1.6 Hare Abundance
data(hare); plot(hare,ylab='Abundance',xlab='Year',type='o')
plot(y=hare,x=zlag(hare),ylab='Abundance',
     xlab='Previous Year Abundance')
#Exhibit 1.7 Temperature seasonality example 
data(tempdub); plot(tempdub,ylab='Temperature',type='o')
#Exhibit 1.8
data(oilfilters); plot(oilfilters,type='o',ylab='Sales')
#Exhibit 1.9 
plot(oilfilters,type='l',ylab='Sales')
oilfilters
points(y=oilfilters,x=time(oilfilters),
       pch=as.vector(season(oilfilters)))
## Latihan
#1.
#2.
#3 plot time series normal
ts.plot(rnorm(48,mean=1,sd=1))
#4 plot time series chisquare
ts.plot(rchisq(48,df=9))
#5 plot time series tdistribution
ts.plot(rt(n=48,df=10))
#6 Construct a time series plot with monthly plotting symbols for the Dubuque temperature series as in Exhibit 1.9, on page 7. The data are in the file named tempdub.
plot(oilfilters,type='l',ylab='Sales')
points(y=oilfilters,x=time(oilfilters),
       pch=as.vector(season(oilfilters)))
        