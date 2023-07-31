library(TSA)

#Exhibit 6.5 Sample Autocorrelation of an MA(1) Process with θ = 0.9
data(ma1.1.s)
acf(ma1.1.s,xaxp=c(0,20,10))
s<-"The dashed horizontal lines in Exhibit 6.5, plotted at = ±0.1826, are
    intended to give critical values for testing whether or not the autocorrelation coefficients
    are significantly different from zero. These limits are based on the approximate large
    sample standard error that applies to a white noise process, namely ."
#Exhibit 6.6 Alternative Bounds for the Sample ACF for the MA(1) Process
acf(ma1.1.s,ci.type='ma',xaxp=c(0,20,10))


# Exhibit 6.9 on page 120.
data("ma2.s")
acf(ma2.s,ci.type='ma',xaxp=c(0,20,10))
#The argument ci.type='ma' instructs R to plot the sample ACF with the confidence
#band for the kth lag ACF computed based on the assumption of an MA(k − 1) model.


# Exhibit 6.11 on page 121.
data("ar1.s")
pacf(ar1.s,xaxp=c(0,20,10))
#pacf(data,xaxp=c(awal,akhir,pembagi untuk jarak lag yang ditampilkan))

# Exhibit 6.17 on page 124.
data("arma11.s")
eacf(arma11.s)
s<-"This computes the sample EACF function (extended autocorrelation function) of the
    data arma11.s. The maximum AR and MA orders can be set via the ar.max and
    ma.max arguments. Their default values are seven and thirteen, respectively. 
    For example, eacf(arma11.s,ar.max=10,ma.max=10) 
    computes the EACF with maximum AR and MA orders of 10. 
    The EACF function prints a table of symbols with X
    standing for a significant value and O a nonsignificant value."
