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

testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}




rho <- function(theta) {  # Original function
  theta * cos(theta)
}
g <- function(theta) {    # Derivative/gradient function
  cos(theta) - theta*sin(theta)
}
for (x in c(0, 4, -6)){
  print(gradientDescent(theta=x, rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                  testConvergenceFn = testConvergence)$theta)
}

# The 3 runs produce different results because there are multiple local optima 
plot(rho, xlim=c(-7, 7))

# With different step sizes, the function converges to different values
gradientDescent(theta=-3, lambdaStepsize = 0.001, lambdaMax = 5, rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                testConvergenceFn = testConvergence)$theta
gradientDescent(theta=-3, lambdaStepsize = 0.5, lambdaMax = 5, rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                testConvergenceFn = testConvergence)$theta
gradientDescent(theta=-3, lambdaStepsize = 0.7, lambdaMax = 5, rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                testConvergenceFn = testConvergence)$theta