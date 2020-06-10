if(!require(GA))
{install.packages("GA")
  require(GA)
}

f <- function(x)  (x+1)*(x-7)*(x-30)*(x-57)*(x-64)*(x-90)*(x-122)*(x-130)*10^(-10)+400
curve(f, from = 0, to = 126, n = 1000)

pop1st<-matrix(NA,10,7)
popfinal<-pop1st
monitor <- function(obj) 
{ 
  if(obj@iter==1) pop1st<<-obj@population
  if(obj@iter==obj@maxiter) popfinal<<-obj@population
  #points(obj@population, pch = 20, col = 2)
}

result <- ga(type = "binary", 
             fitness = function(x){x<-binary2decimal(x);f(x)},
             nBits = 7,popSize = 10,maxiter = 60,
             selection = gabin_rwSelection,elitism = 0,
             crossover = gabin_spCrossover,
             monitor = monitor)
summary(result)
plot(result)

pop1st<-apply(pop1st,1,binary2decimal)
popfinal<-apply(popfinal,1,binary2decimal)

curve(f, 0, 126)
points(pop1st,f(pop1st))
sapply(pop1st,function(x)lines(c(x,x),c(0,f(x)),lty=3))

curve(f, 0, 126)
points(popfinal,f(popfinal))
sapply(popfinal,function(x)lines(c(x,x),c(0,f(x)),lty=3))

