gradientDescent <- function(theta = 0, rhoFn, gradientFn, lineSearchFn, testConvergenceFn, 
                            maxIterations = 100, tolerance = 1e-06, relative = FALSE, lambdaStepsize = 0.01, 
                            lambdaMax = 0.5) {
  converged <- FALSE
  i <- 0
  while (!converged & i <= maxIterations) {
    g <- gradientFn(theta)  ## gradient
    glength <- sqrt(sum(g^2))  ## gradient direction
    if (glength > 0) {g <- g/glength}
    lambda <- lineSearchFn(theta, rhoFn, g, lambdaStepsize = lambdaStepsize, lambdaMax = lambdaMax)
    thetaNew <- theta - lambda * g
    converged <- testConvergenceFn(thetaNew, theta, tolerance = tolerance, relative = relative)
    theta <- thetaNew
    i <- i + 1
  }
  ## Return last value and whether converged or not
  list(theta = theta, converged = converged, iteration = i, fnValue = rhoFn(theta))
}



### line searching could be done as a simple grid search
gridLineSearch <- function(theta, rhoFn, g, lambdaStepsize = 0.01, lambdaMax = 1) {
  ## grid of lambda values to search
  lambdas <- seq(from = 0, by = lambdaStepsize, to = lambdaMax)
  ## line search
  rhoVals <- sapply(lambdas, function(lambda) {
    rhoFn(theta - lambda * g)
  })
  ## Return the lambda that gave the minimum
  lambdas[which.min(rhoVals)]
}



### Where testCovergence might be (relative or absolute)
testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}



# Suppose optimizing for p(x) = 2x^2 - 5x + 3 with gradient g(x) = 4x - 5
rho <- function(theta) {  # Original function
  2 * theta^2 - 5 * theta + 3
}
g <- function(theta) {    # Derivative/gradient function
  4 * theta - 5
}
gradientDescent(rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                testConvergenceFn = testConvergence)



# Suppose optimizing for multivariate function
rho <- function(theta) {
  (1 - theta[1])^2 + 100 * (theta[2] - theta[1]^2)^2
}
g <- function(theta) {
  c(400 * theta[1]^3 - 400 * theta[1] * theta[2] + 2 * theta[1] - 2, 
    -200 *theta[1]^2 + 200 * theta[2])
}
gradientDescent(theta = c(0, 0), rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                testConvergenceFn = testConvergence, maxIterations = 1000)