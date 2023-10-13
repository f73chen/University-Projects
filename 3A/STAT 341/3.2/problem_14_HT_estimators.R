library(knitr)
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
kable(head(sharks))

set.seed(341)
sharkSample = sample(65, 21)
sharkSample

### COPY FUNCTIONS FROM COURSE NOTES ###
popSize <- function(pop) {nrow(as.data.frame(pop))}
sampSize <- function(samp) {popSize(samp)}

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


# a. Calculate the HT estimate of the proportion of shark lengths:
# - at most 140 inches
# - in encounters outside USA waters
# And provide the standard error of the estimate

n = 21
N = nrow(sharks)
inclusionProb <- createInclusionProbFn(1:N, sampSize=n)
inclusionJointProb <- createJointInclusionProbFn(1:N, sampSize=n)

sharksHTestimator <- createHTestimator(inclusionProb)
HTVarianceEstimator <- createHTVarianceEstimator(1:N,
                                                 pi_u_fn=inclusionProb,
                                                 pi_uv_fn=inclusionJointProb)

createVariateFnNyNonUs <- function(popData, var1, var2, N=1, y=NULL) {
  function(u) {(popData[u, var1] <= y & popData[u, var2] == 0) / N}
}
sharkAvgLength <- createVariateFnNyNonUs(sharks, "Length", "USA", N=N, y=140)

# The HT estimate is:
sharksHTestimator(sharkSample, sharkAvgLength)

# The estimate of the variance (or standard error b/c sqrt) is:
sqrt(HTVarianceEstimator(sharkSample, sharkAvgLength))



# b. Construct and calculate an HT estimate of the cumulative distribution function of shark length
# Give the standard error of the estimate
# Similar to the cdf, stderr is also a function of length
# Plot the two functions

createVariateFnNy <- function(popData, var1, N=1, y=NULL) {
  function(u) {(popData[u, var1] <= y) / N}
}
yseq = c(0, sort(sharks$Length[sharkSample]), 300)

CDFEstimate = sapply(yseq, function(y) {
  pSharky <- createVariateFnNy(sharks, "Length", N=N, y=y)
  sharksHTestimator(sharkSample, pSharky)
})

varianceCDFEstimate = sapply(yseq, function(y) {
  pSharky <- createVariateFnNy(sharks, "Length", N=N, y=y)
  HTVarianceEstimator(sharkSample, pSharky)
})
stderr.cdf = sqrt(round(varianceCDFEstimate, 14))

par(mfrow=c(1, 2))
plot(yseq, CDFEstimate, type='s', ylab='Proportion',
     xlab='Shark Length', main='Estimate of the quantile or CDF')
plot(yseq, stderr.cdf, type='s', ylab='Standard Error',
     xlab='Shark Length', main='Estimate of the Variance of the CDF')



# c. Using a Gaussian approximation, plot the HT estimate of
# the CDF along with 95% confidence limits (+-2 standard deviations)

plot(yseq, CDFEstimate, type='s', ylim=c(0, 1),
     ylab='Proportion', xlab='Shark Length', 
     main='Estimate of the quantile or CDF')
lines(yseq, CDFEstimate - 2*stderr.cdf, type='s', col=2, lty=2)
lines(yseq, CDFEstimate + 2*stderr.cdf, type='s', col=2, lty=2)



# d. The median can be written as a function of the CDF
# Use the HT estimate of the CDF to estimate the median

plot(yseq, CDFEstimate, type='s', main='Estimate of the quantile or CDF',
     xlab='Shark Length', ylab='Proportion')
abline(h=1/2, lty=2)

# Since the infimum is the median, m^ = 144
# But anything in [144, 156) will work
pSharky144 <- createVariateFnNy(sharks, "Length", N=N, y=144)
sharksHTestimator(sharkSample, pSharky144)
pSharky156 <- createVariateFnNy(sharks, "Length", N=N, y=156)
sharksHTestimator(sharkSample, pSharky156)
