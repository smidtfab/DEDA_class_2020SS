if(!require(GA))
  {install.packages("GA")
  require(GA)
  }

require(stats4)

setwd('D:/')

x<-cars$speed
y<-cars$dist
n<-length(x)

#L<-function(beta0,beta1,sigma2) -n*log(sigma2)-sum((beta0+beta1*x-y)^2)/sigma2
#this form Likelihood function can't prevent sigma2 from being negtive during optimization

L<-function(beta0,beta1,sigma) -sum(dnorm(y,beta0+beta1*x,sigma,log = TRUE))
k.mle<-coef(mle(L,start = list(beta0=1,beta1=0,sigma=1)))
k.mle<-c(k.mle[1],k.mle[2])

x.ols<-cbind(1,x)
k.ols<-solve(t(x.ols)%*%x.ols,t(x.ols))%*%y

f<-function(k) -sum((k[1]+k[2]*x-y)^2)
maxiter <- 100
k.ga<-matrix(NA,maxiter,2)
#coef gained by GA, iter num is 30
monitor <- function(obj) 
{ 
  obj@fitnessValue <- max(obj@fitness, na.rm = TRUE)
  valueAt <- which(obj@fitness == obj@fitnessValue)
  solution <- obj@population[valueAt,,drop=FALSE]
  if(nrow(solution) > 1)
  { # find unique solutions to precision given by default tolerance
    eps <- gaControl("eps")
    solution <- unique(round(solution/eps)*eps, margin = 1)
  }
  k.ga[obj@iter,]<<-solution
}
GA.result<-ga("real-valued",f,
          lower=c(-40,0),
          upper = c(40,100),
          maxiter = maxiter,
          monitor = monitor)

##plotting
png(paste("fig_LR",0,".png",sep=""))
plot(x,y)
curve(k.mle[1]+k.mle[2]*x,from = 0,to=30,col="black",add = TRUE)
dev.off()
plotcol<-rep(rainbow(5),maxiter/5)# integer division
for(i in 1:maxiter){ 
  png(paste("fig_LR",i,".png",sep=""))
  plot(x,y)
  curve(k.ols[1]+k.ols[2]*x,from = 0,to=30,col="black",add = TRUE)
  for(j in 1:i)
    curve(k.ga[j,1]+k.ga[j,2]*x,from = 0,to=30,col=plotcol[j],add = TRUE)
  dev.off()
  }
