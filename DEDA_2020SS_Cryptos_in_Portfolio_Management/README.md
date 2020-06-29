[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **DEDA_2020SS_Cryptos_in_Portfolio_Management** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of Quantlet: 'DEDA_2020SS_Cryptos_in_Portfolio_Management'

Published in: 'DEDA class 2020SS'

Description: 'Investigation of benefits of introducing crytocurrencies in a traditial portfolio allocation'

Keywords: 'returns, CRIX, cryptocurrency, portfolio-management'

Author: 'Yuliya Gustap, Arash Moussavi'

Submitted: '29. June 2020, Yuliya Gustap'

```

### R Code
```r

BCOM = read.csv("Bloomberg Commodity Historical Data.csv")
CADUSD = read.csv("CADUSD_max.csv")            
CHFUSD = read.csv("CHFUSD_max.csv")                
CRIX = read.csv("crix.csv")
EEM = read.csv("EEM_max.csv")
EURUSD = read.csv("EURUSD_max.csv")
GBPUSD = read.csv("GBPUSD_max.csv")
JPYUSD = read.csv("JPYUSD_max.csv")
S_P500 = read.csv("S_P_500_Max.csv")
SEKUSD = read.csv("SEKUSD_max.csv")
REALSTATE = read.csv("TLT_max.csv")
DM = read.csv("VEA_max.csv")
returns = read.csv("merged.csv")
BCOM = BCOM[,1:7]

CADUSD = CADUSD[3033:4358,]
CHFUSD = CHFUSD[3033:4358,]
CRIX = CRIX[275:2129,]
EEM = EEM[3034:4312,]
EURUSD = EURUSD[2980:4305,]
GBPUSD = GBPUSD[2980:4305,]
#JPYUSD = 
S_P500 = S_P500[21934:23212,]
SEKUSD = SEKUSD[3600:4925,]
REALSTATE = REALSTATE[3212:4490,]
DM = DM[1956:3234,]


par(bg="transparent")
x <- returns$S.p
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="S&P 500")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$TLT
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="Debt")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$VEA
  h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="Developed Markets ETF")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)


x <- returns$EEM
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="Emerging Market Index")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$CADUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="CADUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$CHFUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="CHFUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$EURUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="EURUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$GBPUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="GBPUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$JPYUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="JPYUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$SEKUSD
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="SEKUSD")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$CRIX
h<-hist(x, breaks=70, col="green", bg= "gray", xlab="Return",main="CRIX Index")
xfit<-seq(min(x),max(x),length=100)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)

x <- returns$BCOM
h<-hist(x, breaks=30, col="green", bg= "gray", xlab="Return",main="Bloomberg Commodity Index")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=3)


Data = returns
Data

TLTmean <- mean(Data$TLT)
S_pmean <- mean(Data$S.p)
VEAmean <- mean(Data$VEA)
EEMmean <- mean(Data$EEM)
CADUSDmean <- mean(Data$CADUSD)
CHFUSDmean <- mean(Data$CHFUSD)
EURUSDmean <- mean(Data$EURUSD)
GBPUSDmean <- mean(Data$GBPUSD)
JPYUSDmean <- mean(Data$JPYUSD) 
SEKUSDmean <- mean(Data$SEKUSD)
CRIXmean <- mean(Data$CRIX)
BCOMmean <- mean(Data$BCOM)

mean.v = c(TLTmean,S_pmean,VEAmean,EEMmean,CADUSDmean,CHFUSDmean,EURUSDmean,GBPUSDmean,JPYUSDmean, SEKUSDmean,CRIXmean,BCOMmean)
mean.v

### Standard Deviations
TLTstd <- sd(Data$TLT)
S_pstd <- sd(Data$S.p)
VEAstd <- sd(Data$VEA)
EEMstd <- sd(Data$EEM)
CADUSDstd <- sd(Data$CADUSD)
CHFUSDstd <- sd(Data$CHFUSD)
EURUSDstd <- sd(Data$EURUSD)
GBPUSDstd <- sd(Data$GBPUSD)
JPYUSDstd <- sd(Data$JPYUSD) 
SEKUSDstd <- sd(Data$SEKUSD)
CRIXstd <- sd(Data$CRIX)
BCOMstd <- sd(Data$BCOM)

std.v = c(TLTstd,S_pstd,VEAstd,EEMstd,CADUSDstd,CHFUSDstd,EURUSDstd,GBPUSDstd,JPYUSDstd, SEKUSDstd,CRIXstd,BCOMstd)
std.v

### Skewnes
library(e1071)
TLTskew <- skewness(Data$TLT, na.rm = TRUE, type = 3)
S_pskew <- skewness(Data$S.p, na.rm = TRUE, type = 3)
VEAskew <- skewness(Data$VEA, na.rm = TRUE, type = 3)
EEMskew <- skewness(Data$EEM, na.rm = TRUE, type = 3)
CADUSDskew <- skewness(Data$CADUSD, na.rm = TRUE, type = 3)
CHFUSDskew <- skewness(Data$CHFUSD, na.rm = TRUE, type = 3)
EURUSDskew <- skewness(Data$EURUSD, na.rm = TRUE, type = 3)
GBPUSDskew <- skewness(Data$GBPUSD, na.rm = TRUE, type = 3)
JPYUSDskew <- skewness(Data$JPYUSD, na.rm = TRUE, type = 3) 
SEKUSDskew <- skewness(Data$SEKUSD, na.rm = TRUE, type = 3)
CRIXskew <- skewness(Data$CRIX, na.rm = TRUE, type = 3)
BCOMskew <- skewness(Data$BCOM, na.rm = TRUE, type = 3)


skew.v = c(TLTskew,S_pskew,VEAskew,EEMskew,CADUSDskew,CHFUSDskew,EURUSDskew,GBPUSDskew,JPYUSDskew, SEKUSDskew,CRIXskew,BCOMskew)
skew.v


### Kurtosis
TLTkur <- kurtosis(Data$TLT, na.rm = TRUE, type = 3)
S_pkur <- kurtosis(Data$S.p, na.rm = TRUE, type = 3)
VEAkur <- kurtosis(Data$VEA, na.rm = TRUE, type = 3)
EEMkur <- kurtosis(Data$EEM, na.rm = TRUE, type = 3)
CADUSDkur <- kurtosis(Data$CADUSD, na.rm = TRUE, type = 3)
CHFUSDkur <- kurtosis(Data$CHFUSD, na.rm = TRUE, type = 3)
EURUSDkur <- kurtosis(Data$EURUSD, na.rm = TRUE, type = 3)
GBPUSDkur <- kurtosis(Data$GBPUSD, na.rm = TRUE, type = 3)
JPYUSDkur <- kurtosis(Data$JPYUSD, na.rm = TRUE, type = 3) 
SEKUSDkur <- kurtosis(Data$SEKUSD, na.rm = TRUE, type = 3)
CRIXkur <- kurtosis(Data$CRIX, na.rm = TRUE, type = 3)
BCOMkur <- kurtosis(Data$BCOM, na.rm = TRUE, type = 3)

kur.v = c(TLTkur,S_pkur,VEAkur,EEMkur,CADUSDkur,CHFUSDkur,EURUSDkur,GBPUSDkur,JPYUSDkur, SEKUSDkur,CRIXkur,BCOMkur)
kur.v

### Coefficient of Variation

TLT_CV <- TLTstd/TLTmean
S_p_CV <- S_pstd/S_pmean
VEA_CV <- VEAstd/VEAmean
EEM_CV <- EEMstd/EEMmean
CADUSD_CV <- CADUSDstd/CADUSDmean
CHFUSD_CV <- CHFUSDstd/CHFUSDmean
EURUSD_CV <- EURUSDstd/EURUSDmean
GBPUSD_CV <- GBPUSDstd/GBPUSDmean
JPYUSD_CV <- JPYUSDstd/JPYUSDmean 
SEKUSD_CV <- SEKUSDstd/SEKUSDmean
CRIX_CV <- CRIXstd/CRIXmean
BCOM_CV <- BCOMstd/BCOMmean

coe.v = c(TLT_CV,S_p_CV,VEA_CV,EEM_CV,CADUSD_CV,CHFUSD_CV,EURUSD_CV,GBPUSD_CV,JPYUSD_CV, SEKUSD_CV,CRIX_CV,BCOM_CV)
coe.v

titles = c("TLT","S&P500","VEA","EEM","CADUSD","CHFUSD","EURUSD","GBPUSD","JPYUSD","SEKUSD","CRIX","BCOM")

table = cbind(titles,mean.v,std.v,skew.v,kur.v,coe.v)
table
write.csv(table,"table.csv")
table = read.csv("table.csv")

ztable(head(table))
ztable = makeHeatmap(ztable(table, digits = 5), palette = "RdBu",  margin = 2, reverse = TRUE, par(bg))
print(ztable,caption="Table 1.Moments of Distribution and further Coefficients")

library(corrplot) 
library(gplots) 


#### Correlation

cor(Data[,2:13])

corrplot.mixed(corr=cor(Data[,2:13]), upper="circle", tl.pos="lt", lower.col = "Black", addgrid.col = "black")

#### QQ plots

library(carData)
library(car)
par(bg="transparent")
qqPlot(returns$S.p)
qqPlot(returns$TLT)
qqPlot(returns$VEA)
qqPlot(returns$EEM)
qqPlot(returns$CADUSD)
qqPlot(returns$CHFUSD)
qqPlot(returns$EURUSD)
qqPlot(returns$GBPUSD)
qqPlot(returns$JPYUSD)
qqPlot(returns$SEKUSD)
qqPlot(returns$CRIX)
qqPlot(returns$BCOM)

```

automatically created on 2020-06-29