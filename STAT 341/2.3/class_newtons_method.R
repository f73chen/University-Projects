Newton <- function(theta = 0, 
                   psiFn, psiPrimeFn, 
                   testConvergenceFn = testConvergence,
                   maxIterations = 100,   # maximum number of iterations 
                   tolerance = 1E-6,      # parameters for the test
                   relative = FALSE       # for convergence function
) {
  ## Initialize
  converged <- FALSE
  i <- 0
  ## LOOP
  while (!converged & i <= maxIterations) {
    ## Update theta
    thetaNew <- theta - psiFn(theta)/psiPrimeFn(theta)

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
       fnValue = psiFn(theta)
  )
}

gridLineSearch <- function(theta, rhoFn, g,
                           lambdaStepsize = 0.01,
                           lambdaMax = 1) {
  ## grid of lambda values to search
  lambdas <- seq(from = 0, by = lambdaStepsize,  to = lambdaMax)
  
  ## line search
  rhoVals <- sapply(lambdas, function(lambda) {rhoFn(theta - lambda * g)})
  ## Return the lambda that gave the minimum
  lambdas[which.min(rhoVals)]
}

# testConvergence method from GD
testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}


# Test on the FaceBook dataset
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "facebook.csv", sep="/")
fb <- read.csv(filename, header=TRUE)
fb <- na.omit(fb)

# Goal to determine the typical (mean) number of likes per post
# Weigh by the inverse of $Impressions so popular posts are less influential
# psi = weighted sum (yu - theta)
# psi' = - sum (weights)

### Here we create both functions at once
createPsiFns <- function(y, wt) {
  psi      <- function(theta = 0) { sum(wt * (y - theta)) }
  psiPrime <- function(theta = 0) { -sum(wt) }
  list(psi = psi, psiPrime = psiPrime)
}

### Create them for the particular data
psiFns <- createPsiFns(y = fb$like, wt = 1/fb$Impressions)
psi <- psiFns$psi
psiPrime <- psiFns$psiPrime

# Pass psi and psi' into the Newton function
result <- Newton(theta = mean(fb$like), psiFn = psi, psiPrimeFn = psiPrime)
print(result)

# Compare optimized value to the closed-form formula
# Converged in only 2 iterations because the function is linear
y <- fb$like
wt <- 1/fb$Impressions
c(NewtonSol = result$theta, weightedAve = sum(wt * y)/sum(wt))