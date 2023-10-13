filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# Returns a function that takes in sampleSize and generates a sample
createSamplingMechanism <- function(pop, method = c("withoutReplacement", "withReplacement", 
                                                    "withUnique")) {
  
  if (method == "withoutReplacement") {
    function(sampSize) {
      sample(pop, sampSize, replace = TRUE)
    }
  } else if (method == "withReplacement") {
    function(sampSize) {
      sample(pop, sampSize, replace = FALSE)
    }
  } else if (method == "withUnique") {
    function(sampSize) {
      unique(sample(pop, sampSize, replace = TRUE))
    }
  } else {
    stop(paste("No sampling mechanism:", method))
  }
}

# For example, for simple random sampling without replacement (default) on
# the population of all sharks, define:
srswor <- createSamplingMechanism(popSharks, method="withoutReplacement")
set.seed(341)
sample_indx <- as.numeric(srswor(10))
sharkS <- sharks[sample_indx,]

# The marginal inclusion probability pu when sampling without replacement
# is n/N for all u:
N <- nrow(sharks)
n <- 10
pi <- rep(n/N, N)

# The joint inclusion probability puv when sampling without replacement
# is n(n-1) / N(N-1) for any pair (u, v) where u != v
# Creates matrix where all values are equal except diagonals
pij <- matrix((n*(n-1)) / (N*(N-1)), nrow=N, ncol=N)
diag(pij) <- pi

# Left number is the HT estimate of the attribute
# Right number is the true population value of the attribute

# Total shark length
yu <- sharkS$Length
piu <- pi[sample_indx]
c(sum(yu/piu), sum(sharks$Length))

# Average shark length
yu <- sharkS$Length / N
piu <- pi[sample_indx]
c(sum(yu/piu), sum(sharks$Length/N))

# Average victim age
yu <- sharkS$Age / N
piu <- pi[sample_indx]
c(sum(yu/piu), sum(sharks$Age/N))

# Proportion of shark encounters from Australia
yu <- sharkS$Australia / N
piu <- pi[sample_indx]
c(sum(yu/piu), sum(sharks$Australia/N))

# Proportion of shark encounters ending in a fatality
yu <- sharkS$Fatality / N
piu <- pi[sample_indx]
c(sum(yu/piu), sum(sharks$Fatality/N))

# Proportion of sharks with length <= 180 inches
newVariate <- (sharks$Length <= 180) * 1
yu <- newVariate[sample_indx] / N
piu <- pi[sample_indx]
c(sum(yu/piu), sum(newVariate/N))

# To quantify the sampling variability of these estimators, 
# use the HT estimate of the variance
# Helper function to get the estimate of the variance
estVarHT <- function(sam, yu, pi, pij) {
  pi = pi[sam]
  pij = pij[sam, sam]
  delta = pij - outer(pi, pi)
  estimateVar = sum((delta/pij) * outer(yu/pi, yu/pi))
  return(estimateVar)
}

# Left number is the estimate of the variance of the HT estimator
# Right number is the estimate of the stdev of the HT estimator (stderr)

# Total shark length
yu <- sharkS$Length
v <- estVarHT(sam=sample_indx, yu, pi, pij)
c(v, sqrt(v))

# Average shark length
yu <- sharkS$Length / N
v <- estVarHT(sam=sample_indx, yu, pi, pij)
c(v, sqrt(v))

# Proportion of sharks with length <= 180 inches
yu <- newVariate[sample_indx] / N
v <- estVarHT(sam=sample_indx, yu, pi, pij)
c(v, sqrt(v))


# Such measures of variability often used in interval estimates
# Ex. confidence intervals

# Gain intuition in the context of the sampling distribution for average shark length
# Skip over these helper functions
popSize <- function(pop) {nrow(as.data.frame(pop))}
sampSize <- function(samp) {popSize(samp)}
createvariateFnN <- function(popData, variate, N = 1) {
  function(u) {
    popData[u, variate]/N
  }
}
createInclusionProbFn <- function(pop, sampSize) {
  N <- popSize(pop)
  n <- sampSize
  function(u) { n/N }
}
createJointInclusionProbFn <- function(pop, sampSize) {
  N <- popSize(pop)
  n <- sampSize
  function(u,v) { 
    ## Note that the answer depends on whether u and v
    ## are the same or different
    if (u == v) {n/N} else {(n * (n-1)) / (N * (N-1))}
  }
}
createHTestimator <- function(pi_u_fn) {
  function(samp, variateFn) {
    Reduce(`+`, 
           Map(function(u) {variateFn(u)/ pi_u_fn(u)}, samp),
           init = 0
    )
  }
}
createHTVarianceEstimator <- function(pop, pi_u_fn, pi_uv_fn) {
  function(samp, variateFn) {
    Reduce(`+`,
           Map(function(u) {
             pi_u <- pi_u_fn(u)
             y_u <- variateFn(u)
             Reduce(`+`, 
                    Map(function(v) {
                      pi_v <- pi_u_fn(v)
                      pi_uv <- pi_uv_fn(u, v)
                      y_v <- variateFn(v)
                      Delta_uv <- pi_uv - pi_u * pi_v
                      
                      result <- (Delta_uv  * y_u * y_v) 
                      result <- result/(pi_uv * pi_u * pi_v)
                      result
                    }, 
                    samp),
                    init = 0) 
           },
           samp
           ),
           init = 0)
  }
}

inclusionProb <- createInclusionProbFn(1:N, sampSize=n)
sharksHTestimator <- createHTestimator(inclusionProb)

N = nrow(sharks)
n = 10

sharkAvgLength <- createvariateFnN(sharks, "Length", N=N)
popAvg <- sum(sharks$Length)/N

set.seed(341)
avgs <- Map(function(rep) {
  sharksHTestimator(sample(N, n), sharkAvgLength)
}, 1:10000)
avgs <- as.numeric(avgs)

hist(as.numeric(avgs), col=adjustcolor("grey", alpha=0.5), breaks=25,
     main="HT Estimates (n=10)", xlab="Average Shark Length (inches)")
# Mark the population attribute in red
abline(v=popAvg, col="red", lty=3, lwd=2)



# Approximate the sampling distribution by a bell curve
# Let mu = average (151.7) and sigma = stdev (13.2)
par(mfrow = c(1, 2), oma = c(0, 0, 0, 0))
hist(avgs, col = adjustcolor("grey", alpha = 0.5), main = "HT estimates (n = 10)", 
     xlab = "Shark Lengths in Australian encounters  (inches)", breaks = 25, 
     prob = TRUE)
abline(v = popAvg, col = "red", lty = 3, lwd = 2)

# Add the approximating normal curve
xseq = seq(10, 250, 0.01)
lines(xseq, dnorm(xseq, mean(avgs), sd(avgs)), col = 4, lwd = 2)

# Compare the observed distribution to the approximating normal dist.
qqnorm(avgs, pch = 16, col = adjustcolor("black", alpha = 0.3))
qqline(avgs, col = "purple", lwd = 2)

# The 95% interval calculated for the average shark length based on SRSWOR of size n=10 is
yu <- sharkS$Length / N
piu <- pi[sample_indx]
estHT <- sum(yu/piu)
sterrorHT <- sqrt(estVarHT(sam=sample_indx, yu, pi, pij))
estHT + 2*c(-1, 1) * sterrorHT