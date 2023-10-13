filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# 95% normal bootstrap confidence interval for average shark length:
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

sdn <- function( y.pop ) { 
  N = length(y.pop)
  sqrt( var(y.pop)*(N-1)/(N)  )    } 

# A function to put n or N in the denominator of SD rather than n-1 or N-1
sdn <- function(y.pop) {
  N = length(y.pop)
  sqrt(var(y.pop) * (N - 1)/(N))
}

M <- 10^4
n <- 6
set.seed(341)
samples <- sapply(1:M, FUN = function(m) sample(popSharks, n, replace = TRUE))

avePop <- mean(sharks[, "Length"])
avesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"])
})
sampleErrors <- avesSamp - avePop

tmpAve <- mean(avesSamp)
tmpSD <- sdn(avesSamp)

sdsSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  sdn(sharks[s, "Length"])
})

set.seed(341)
S <- getSample(1:65, n, replace = FALSE)
S

# CI from bootstrap
Pstar <- S
B <- 10^4
set.seed(341)
Sstar <- sapply(1:B, FUN = function(b) getSample(Pstar, n, replace = T))
avesBootSamp <- sapply(1:B, FUN = function(i) mean(sharks[Sstar[, i], "Length"]))

# Note: population average is 151.86
mean(sharks[S, "Length"]) + 1.96 * c(-1, 1) * sdn(avesBootSamp)