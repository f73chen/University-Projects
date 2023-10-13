irls <- function(y, x, theta, rhoPrimeFn, 
                 dim = 2, delta = 1E-10,
                 testConvergenceFn = testConvergence,
                 maxIterations = 100,   # maximum number of iterations 
                 tolerance = 1E-6,      # parameters for the test
                 relative = FALSE       # for convergence function
) {
  if (missing(theta)) {theta <- rep(0, dim)}
  ## Initialize
  converged <- FALSE
  i <- 0
  N <- length(y)
  wt <- rep(1,N)
  ## LOOP
  while (!converged & i <= maxIterations) {
    ## get residuals
    resids <- getResids(y, x, wt, theta)
    ## update weights  (should check for zero resids)
    wt <- getWeights(resids, rhoPrimeFn, delta)
    ## solve the least squares problem
    thetaNew <- getTheta(y, x, wt)
    ##
    ## Check convergence
    converged <- testConvergenceFn(thetaNew, theta,
                                   tolerance = tolerance,
                                   relative = relative)
    ## Update iteration
    theta <- thetaNew
    i <- i + 1
  }
  ## Return last value and whether converged or not
  list(theta = theta, converged = converged, iteration = i)
}

testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}


### @@@ Example 1 (Least Squares) @@@ ###
# Use least squares regression to fit yu=α+β(xu−x￣w)+ru but using IRLS as estimation

# General getWeights function
getWeights <- function(resids, rhoPrimeFn, delta = 1e-12) {
  ## for calculating weights, minimum |residual| will be delta
  smallResids <- abs(resids) <= delta
  ## take care to preserve sign (in case rhoPrime not symmetric)
  resids[smallResids] <- delta * sign(resids[smallResids])
  ## calculate and return weights
  rhoPrimeFn(resids)/resids
}

# General getTheta function
getTheta <- function(y, x, wt) {
  theta <- numeric(length = 2)
  ybarw <- sum(wt * y)/sum(wt)
  xbarw <- sum(wt * x)/sum(wt)
  theta[1] <- ybarw
  theta[2] <- sum(wt * (x - xbarw) * y)/sum(wt * (x - xbarw)^2)
  ## return theta
  theta
}

# In ordinary least squares, equations are:
# ru=yu−α−β(x−x￣w),          ρ(ru)=ru^2,          ρ′(ru)=2*ru
getResids <- function(y, x, wt, theta) {
  xbarw <- sum(wt * x)/sum(wt)
  alpha <- theta[1]
  beta <- theta[2]
  ## resids are
  y - alpha - beta * (x - xbarw)
}

LSrhoPrime <- function(resid) {
  2 * resid
}

# Test on Where's Waldo dataset
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "wheres-waldo-locations.csv", sep="/")
waldo <- read.csv(filename, header=TRUE)
IRLSresult <- irls(waldo$Y, waldo$X, theta=c(0,0), rhoPrimeFn = LSrhoPrime)
print(IRLSresult)

# Compare to result using lm:
lm(waldo$Y ~ I(waldo$X - mean(waldo$X)))$coef



### @@@ Example 2: Robust Regression @@@ ###

# Recall the Huber function
huber.fn.prime <- function(resid, k = 1.345) {
  val = resid
  subr = abs(resid) > k
  val[subr] = k * sign(resid[subr])
  return(val)
}

# Perform robust regression but using IRLS as method of estimation
data(Animals2, package = "robustbase")
result <- irls(log(Animals2$brain), log(Animals2$body), theta = c(1, 1), rhoPrimeFn = huber.fn.prime, 
               maxIterations = 100)
print(result)

# Compare results to rlm
library(MASS)
temp = rlm(log(Animals2$brain) ~ I(log(Animals2$body) - mean(log(Animals2$body))), psi = "psi.huber")
temp$coef