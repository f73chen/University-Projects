# Copy basic functions for reference
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
  list(theta = theta, converged = converged, iteration = i, fnValue = rhoFn(theta))
}

gridLineSearch <- function(theta, rhoFn, g, lambdaStepsize = 0.01, lambdaMax = 1) {
  lambdas <- seq(from = 0, by = lambdaStepsize, to = lambdaMax)
  
  rhoVals <- sapply(lambdas, function(lambda) {
    rhoFn(theta - lambda * g)
  })
  lambdas[which.min(rhoVals)]
}

testConvergence <- function(thetaNew, thetaOld, tolerance = 1e-10, relative = FALSE) {
  sum(abs(thetaNew - thetaOld)) < if (relative) 
    tolerance * sum(abs(thetaOld)) else tolerance
}


# Change gradientDescent to batch-stochastic GD
# Huber with edited gradient function
createRobustHuberGradient.stochastic <- function(x, y, kval, M) {
  xbar <- mean(x)
  ybar <- mean(y)
  function(theta) {
    alpha <- theta[1]
    beta <- theta[2]
    ru = y - alpha - beta * (x - xbar)
    rhok = huber.fn.prime(ru, k = kval)
    
    subset = sample(x = length(rhok), size = M)
    
    -1 * c(sum(rhok[subset]), sum((rhok * (x - xbar))[subset]))
  }
}

# Line search with fixed lambda sizes
fixedLineSearch <- function(theta, rhoFn, g, lambdaStepsize = 0.01, lambdaMax = 1) {
  lambdaStepsize
}

# Huber function
huber.fn <- function(r, k) {
  val = r^2/2
  subr = abs(r) > k
  val[subr] = k * (abs(r[subr]) - k/2)
  return(val)
}

# Huber objective function creator
createRobustHuberRho <- function(x, y, kval) {
  xbar <- mean(x)
  function(theta) {
    alpha <- theta[1]
    beta <- theta[2]
    sum(huber.fn(y - alpha - beta * (x - xbar), k = kval))
  }
}

# Derivative of the Huber function
huber.fn.prime <- function(r, k) {
  val = r
  subr = abs(r) > k
  val[subr] = k * sign(r[subr])
  return(val)
}

# Function to create the gradient function
createRobustHuberGradient <- function(x, y, kval) {
  xbar <- mean(x)
  ybar <- mean(y)
  function(theta) {
    alpha <- theta[1]
    beta <- theta[2]
    ru = y - alpha - beta * (x - xbar)
    rhok = huber.fn.prime(ru, k = kval)
    -1 * c(sum(rhok * 1), sum(rhok * (x - xbar)))
  }
}


# Perform robust GD regression on Animals
data(Animals2, package = "robustbase")
rho <- createRobustHuberRho(x = log(Animals2$body), y = log(Animals2$brain), 
                            kval = 0.766 * 1.5)
gradient <- createRobustHuberGradient(x = log(Animals2$body), y = log(Animals2$brain), 
                                      kval = 0.766 * 1.5)
result <- gradientDescent(theta = c(0, 0), rhoFn = rho, gradientFn = gradient, 
                          lineSearchFn = gridLineSearch, testConvergenceFn = testConvergence)
print(result)

# Stochastic GD
rho <- createRobustHuberRho(x = log(Animals2$body), y = log(Animals2$brain), 
                            kval = 0.766 * 1.5)
gradient.stochastic <- createRobustHuberGradient.stochastic(x = log(Animals2$body), 
                                                            y = log(Animals2$brain), kval = 0.766 * 1.5, M = 10)
set.seed(341)
result2 <- gradientDescent(theta = c(1, 0), rhoFn = rho, gradientFn = gradient.stochastic, 
                           lineSearchFn = fixedLineSearch, testConvergenceFn = testConvergence, maxIterations = 10^5, 
                           tolerance = 0.001, lambdaStepsize = 0.01, relative = TRUE)
print(result2)