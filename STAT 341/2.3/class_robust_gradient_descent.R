filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "wheres-waldo-locations.csv", sep="/")
waldo <- read.csv(filename, header=TRUE)
plot(waldo$X, waldo$Y, pch = 19, col = adjustcolor("firebrick", 0.5), main = "Waldo's Location", 
     xlab = "Horizontal Location on Page", ylab = "Vertical Location on Page")

# New rho and gradient functions rely on data in addition to theta
# Note: functions are accessing global variable waldo
rho <- function(theta) {
  alpha <- theta[1]
  beta <- theta[2]
  y <- waldo$Y
  x <- waldo$X
  xbar <- mean(x)
  sum((y - alpha - beta * (x - xbar))^2)
}

gradient <- function(theta) {
  alpha <- theta[1]
  beta <- theta[2]
  y <- waldo$Y
  x <- waldo$X
  xbar <- mean(x)
  N <- length(x)
  g <- -2 * c(sum(y - alpha - beta * (x - xbar)), 
              sum((y - alpha - beta * (x - xbar)) * (x - xbar)))
  g
}


# Functions that make functions
# Ex. returns a quadratic function
createQuadratic <- function(a, b, c) {
  ## Return this function
  function(x) {
    fx = a * x^2 + b * x + c
    return(fx)
  }
}

x = seq(-3, 3, length.out = 100)
f1 = createQuadratic(a = 1, b = 1, c = 1)
f2 = createQuadratic(a = -2, b = 1, c = 5)
f3 = createQuadratic(a = -2, b = -2, c = 10)
plot(x, f1(x), type = "l", ylab = "f(x)")
lines(x, f2(x), col = 2)
lines(x, f3(x), col = 3)
legend("topleft", lty = 1, col = 1:3, legend = c("f1", "f2", "f3"), bty = "n")


# Similarly, take in any (x, y) and return rho and gradient functions for MSE
createLeastSquaresRho <- function(x, y) {
  xbar <- mean(x)
  function(theta) {
    alpha <- theta[1]
    beta <- theta[2]
    sum((y - alpha - beta * (x - xbar))^2)
  }
}
rho <- createLeastSquaresRho(waldo$X, waldo$Y)

createLeastSquaresGradient <- function(x, y) {
  xbar <- mean(x)
  ybar <- mean(y)
  N <- length(x)
  function(theta) {
    alpha <- theta[1]
    beta <- theta[2]
    -2 * c(sum(y - alpha - beta * (x - xbar)), 
           sum((y - alpha - beta * (x - xbar)) * (x - xbar)))
  }
}
gradient <- createLeastSquaresGradient(waldo$X, waldo$Y)

# Pass in the generalized functions for waldo into gradient descent
result <- gradientDescent(theta = c(0, 0), rhoFn = rho, gradientFn = gradient, 
                          lineSearchFn = gridLineSearch, testConvergenceFn = testConvergence)
print(result)


# Plot least-squares fit line on location population
plot(waldo$X, waldo$Y, pch = 19, col = adjustcolor("firebrick", 0.5), main = "Waldo's Location", 
     xlab = "Horizontal Location on Page", ylab = "Vertical Location on Page")
abline(result$theta[1] - result$theta[2] * mean(waldo$X), result$theta[2], lwd = 2)
legend("topleft", lty = 1, col = 1, lwd = 2, legend = "Least-squares line fit \n by gradient descent", 
       bty = "n")


# Robust Huber function
huber.fn <- function(r, k) {
  val = r^2/2
  subr = abs(r) > k
  val[subr] = k * (abs(r[subr]) - k/2)
  return(val)
}

# A function to create the objective function:
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

# A function to create the gradient function
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


# Test the functions on the Animals2 dataset
data(Animals2, package = "robustbase")
rho <- createRobustHuberRho(x = log(Animals2$body), y = log(Animals2$brain), 
                            kval = 0.766 * 1.5)
gradient <- createRobustHuberGradient(x = log(Animals2$body), y = log(Animals2$brain), 
                                      kval = 0.766 * 1.5)
result <- gradientDescent(theta = c(0, 0), rhoFn = rho, gradientFn = gradient, 
                          lineSearchFn = gridLineSearch, testConvergenceFn = testConvergence)
print(result)

# Compare results to the rlm (built-in) function --> similar results
library(MASS)
temp = rlm(log(Animals2$brain) ~ I(log(Animals2$body) - mean(log(Animals2$body))), 
           psi = "psi.huber")
temp$coef