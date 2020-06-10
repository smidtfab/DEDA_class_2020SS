
##Canonical GA

popSize<-10
nBits<-8
maxiter<-30

# generate beginning population
population <- matrix(NA, nrow = popSize, ncol = nBits)
for(j in 1:8) 
  population[,j] <- round(runif(10))

bestEval <- rep(NA, maxiter)
meanEval <- rep(NA, maxiter)
Fitness <- rep(NA, popSize)

for(i in 1:maxiter)
{
  # evalute fitness function (if needed)
  for(i in 1:popSize) 
    if(is.na(Fitness[i]))
    { Fitness[i] <- fitness(Pop[i,], ...) } 
  bestEval[iter] <- max(Fitness, na.rm = TRUE)
  meanEval[iter] <- mean(Fitness, na.rm = TRUE)
  
  Selection
}

##fuctions
Selection <- function(object, ...)
{
  # Proportional (roulette wheel) selection
  prob <- abs(object@fitness)/sum(abs(object@fitness))
  sel <- sample(1:object@popSize, size = object@popSize, 
                prob = pmin(pmax(0, prob), 1, na.rm = TRUE),
                replace = TRUE)
  out <- list(population = object@population[sel,,drop=FALSE],
              fitness = object@fitness[sel])
  return(out)
}
