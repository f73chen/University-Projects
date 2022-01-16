filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# A function to put n or N in the denominator of SD
# rather than n-1 or N-1
sdn <- function( y.pop ) { 
  N = length(y.pop)
  sqrt( var(y.pop)*(N-1)/(N)  )    } 

M <- 10^4
n = 6
set.seed(341)
samples <- sapply(1:M, FUN=function(m)  sample(popSharks, n, replace = TRUE) )

avePop <- mean(sharks[, "Length"])
avesSamp <- apply(samples, MARGIN = 2, 
                  FUN = function(s){mean(sharks[s,"Length"])})
sampleErrors <- avesSamp - avePop

# Baselines
tmpAve <- mean(avesSamp)
tmpSD <- sdn(avesSamp)

sdsSamp <- apply(samples, MARGIN = 2, 
                 FUN = function(s){sdn(sharks[s,"Length"])})

popSize <- function(pop) {
  if (is.vector(pop))
  {if (is.logical(pop)) 
    ## then assume TRUE values identify units
    sum(pop) else length(pop)}
  else nrow(pop)
}

getSample <- function(pop, size, replace=FALSE) {
  N <- popSize(pop)
  pop[sample(1:N, size, replace = replace)]
}

set.seed(341)
n <- 6
S <- getSample(1:65, n, replace = FALSE)
S

# Get the bootstrap samples
Pstar <- S
B <- 10^4
set.seed(341)
Sstar <- sapply(1:B, FUN=function(b) getSample(Pstar, n, replace = T))
dim(Sstar) 
Sstar[,1:10]

# Apply the attribute on each bootstrap sample
avesBootSamp <- sapply(1:B, FUN = function(i) mean(sharks[Sstar[,i], "Length"]))

# Using the bootstrap quantiles, obtain the interval [94.83, 151.83]
# Note: population average is 151.86

