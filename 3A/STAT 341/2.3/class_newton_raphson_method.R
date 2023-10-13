testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}



NewtonRaphson <- function(theta, psiFn, psiPrimeFn, dim, testConvergenceFn = testConvergence, 
                          maxIterations = 100, tolerance = 1e-06, relative = FALSE) {
  if (missing(theta)) {
    ## need to figure out the dimensionality
    if (missing(dim)) {
      dim <- length(psiFn())
    }
    theta <- rep(0, dim)
  }
  converged <- FALSE
  i <- 0
  while (!converged & i <= maxIterations) {
    thetaNew <- theta - solve(psiPrimeFn(theta), psiFn(theta))
    converged <- testConvergenceFn(thetaNew, theta, tolerance = tolerance, 
                                   relative = relative)
    
    theta <- thetaNew
    i <- i + 1
  }
  ## Return last value and whether converged or not
  list(theta = theta, converged = converged, iteration = i, fnValue = psiFn(theta))
}



### Example: The Jacobian of the Rosenbrock Function ###
# Jacobian --> derv. of both gradients in terms of both thetas (2x2)
psiPrime <- function(theta = c(0, 0)) {
  val = matrix(0, nrow = length(theta), ncol = length(theta))
  val[1, 1] = 1200 * theta[1]^2 - -400 * theta[2] + 2
  val[1, 2] = -400 * theta[1]
  val[2, 1] = -400 * theta[1]
  val[2, 2] = 200
  return(val)
}

# Objective (Rosenbrock) function
rho <- function(theta) {
  (1 - theta[1])^2 + 100 * (theta[2] - theta[1]^2)^2
}

# Gradient --> derv. of objective function in terms of theta1 and theta2
g <- function(theta = c(0, 0)) {
  c(400 * theta[1]^3 - 400 * theta[1] * theta[2] + 2 * theta[1] - 2, -200 * 
      theta[1]^2 + 200 * theta[2])
}

# Solve via the Newton-Raphson method
NRresult <- NewtonRaphson(theta = c(0, 0), psiFn = g, psiPrimeFn = psiPrime)
print(NRresult)

# Test starting value sensitivity by moving theta
NRresult <- NewtonRaphson(theta = c(-2, -1), psiFn = g, psiPrimeFn = psiPrime, maxIterations = 10^4)
print(NRresult)



### Compare results to gradient descent ###
gradientDescent <- function(theta = 0, rhoFn, gradientFn, lineSearchFn, testConvergenceFn, 
                            maxIterations = 100, tolerance = 1e-06, relative = FALSE, lambdaStepsize = 0.01, 
                            lambdaMax = 0.5) {
  
  converged <- FALSE
  i <- 0
  
  while (!converged & i <= maxIterations) {
    g <- gradientFn(theta)  ## gradient
    glength <- sqrt(sum(g^2))  ## gradient direction
    if (glength > 0) 
      g <- g/glength
    
    lambda <- lineSearchFn(theta, rhoFn, g, lambdaStepsize = lambdaStepsize, 
                           lambdaMax = lambdaMax)
    
    thetaNew <- theta - lambda * g
    converged <- testConvergenceFn(thetaNew, theta, tolerance = tolerance, 
                                   relative = relative)
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

GDresult = gradientDescent(theta = c(0, 0), rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                           testConvergenceFn = testConvergence, maxIterations = 1000)
print(GDresult)

# Test starting value sensitivity by moving theta
GDresult = gradientDescent(theta = c(-2, -1), rhoFn = rho, gradientFn = g, lineSearchFn = gridLineSearch, 
                           testConvergenceFn = testConvergence, maxIterations = 1000)
print(GDresult)