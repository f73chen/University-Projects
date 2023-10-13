# Fit regression line with severe outliers
data(cars)
cars.outliers <- data.frame(speed=c(3, 4, 5, 5, 5, 6, 7), dist=c(150, 200, 140, 200, 180, 150, 150)+100)
mycars <- rbind(cars, cars.outliers)
plot(mycars, main="Cars data with outliers", pch=19, col=adjustcolor("black", 0.4))

# Take general functions from class
getResids <- function(y, x, wt, theta) {
  xbarw <- sum(wt*x)/sum(wt)
  alpha <- theta[1]
  beta <- theta[2]
  ## resids are
  y - alpha - beta * (x - xbarw)
}

getWeights <- function(resids, psiFn, delta = 1e-12) {
  ## for calculating weights, minimum |residual| will be delta
  smallResids <- abs(resids) <= delta
  ## take care to preserve sign (in case psi not symmetric)
  resids[smallResids] <- delta * sign(resids[smallResids])
  ## calculate and return weights
  psiFn(resids)/resids
}

getTheta <- function(y, x, wt) {
  theta <- numeric(length = 2)
  ybarw <- sum(wt * y)/sum(wt)
  xbarw <- sum(wt * x)/sum(wt)
  theta[1] <- ybarw
  theta[2] <- sum(wt * (x - xbarw) * y) / sum(wt * (x - xbarw)^2)
  ## return theta
  theta
}

testConvergence <- function(thetaNew, thetaOld, tolerance = 1E-10, relative=FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) tolerance * sum(abs(thetaOld)) else tolerance
}

irls <- function(y, x, theta, psiFn, 
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
    wt <- getWeights(resids, psiFn, delta)
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
  list(theta = theta, 
       converged = converged, 
       iteration = i,
       c0 = sum(wt*x)/sum(wt)
  )
}

# Huber function
huber.psi <- function(resid, k = 1.345) {
  val = resid
  subr = abs(resid) > k 
  val[ subr ] = k*sign(resid[subr]) 
  return(val)
}

# Tukey's biweight function
TukeyBiweightpsi <- function (r, c=70) {
  psivals <- rep(0, length(r))
  middlevals  <- {abs(r) <= c} 
  psivals[middlevals] <- r[middlevals] * (1 - (r[middlevals]/c)^2)^2
  psivals
}

# Convergence results
irls.huber <- irls(mycars$dist, mycars$speed, 
                   theta = c(1,1),
                   psiFn = huber.psi, 
                   maxIterations = 200,
                   tolerance = 1e-8)

kable(as.data.frame(irls.huber))

irls.tukey <- irls(mycars$dist, mycars$speed, 
                   theta = c(1,1),
                   psiFn = TukeyBiweightpsi, 
                   maxIterations = 100,
                   tolerance = 1e-8)

kable(as.data.frame(irls.tukey))

# Plot Huber regression line
plot(mycars, main="Mycars with Huber (k=1.345)", pch=19, col=adjustcolor("black", 0.4) )
abline(a=irls.huber$theta[1]-irls.huber$theta[2]*irls.huber$c0[1], b=irls.huber$theta[2], col='red')

# Plot Tukey regression line
plot(mycars, main="Mycars with Tukey (c=70)", pch=19, col=adjustcolor("black", 0.4) )
abline(a=irls.tukey$theta[1]-irls.huber$theta[2]*irls.tukey$c0[1], b=irls.tukey$theta[2], col='blue')

# In conclusion, Huber is influenced less by outliers than Tukey