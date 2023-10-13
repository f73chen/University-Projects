data(iris)
head(iris)

# Isolate Sepal.Length and Sepal.Width of setosas
iris.s = iris[iris[, 5] == "setosa", -c(3, 4, 5)]

# Length and width seem to be correlated
plot(iris.s, col = adjustcolor("firebrick", 0.5), pch = 19)

# Assume that Sepal.Length is the x-covariate and Sepal.Width is the response
x = iris.s$Sepal.Length
y = iris.s$Sepal.Width
n = length(y)

# Assume a regression model of Yi = a + b(xi - xbar) + Ri
# Where Ri ~ N(0, var)
# The least squares estimate of a and b are (-0.5694327, 0.7985283)
lm(y ~ x)$coef

# Plot regression results
plot(iris.s, col = adjustcolor("firebrick", 0.5), pch = 19)
beta.hat = lm(y ~ I(x - mean(x)))$coef
beta.hat
abline(beta.hat + c(-beta.hat[2] * mean(x), 0))



# Bootstrap regression coefficients
# Sample with replacement from the pairs of observations
B = 1000
beta.boot = t(sapply(1:B, FUN = function(b) lm(y ~ I(x - mean(x)), 
                                               subset = sample(n, n, replace = TRUE))$coef))


# Consider alternative parameterizations of the line
beta.boot2 = t(sapply(1:B, FUN = function(b) lm(y ~ x, subset = sample(n, n, 
                                                                       replace = TRUE))$coef))


# Use the percentile method to get 95% CIs
x0 = 4.5
mu0.hat = sum(beta.hat * c(1, x0 - mean(x)))
mu0.star.hat = apply(beta.boot, 1, function(z, a) {
  sum(z * a)
}, a = c(1, x0 - mean(x)))
boot.ci0 = quantile(mu0.star.hat, prob = c(0.025, 0.975))
boot.ci0

# Plot the location of the CI
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))

hist(mu0.star.hat, freq = FALSE, breaks = "FD", col = adjustcolor("grey", 0.5), 
     main = "Histogram of \n mu.star.hat(x0)")
abline(v = c(mu0.hat, boot.ci0), lty = c(1, 2, 2))

plot(iris.s, pch = 19, col = adjustcolor("firebrick", 0.5))
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0))
lines(c(x0, x0), boot.ci0, col = 4, lwd = 2)



# Get the regression for the whole line by taking multiple points
x.seq = c(4.5, 5, 5.6)
boot.ci = matrix(0, nrow = length(x.seq), 2)

for (i in 1:length(x.seq)) {
  y.hat = apply(beta.boot, 1, function(z, a) {
    sum(z * a)
  }, a = c(1, x.seq[i] - mean(x)))
  boot.ci[i, ] = quantile(y.hat, prob = c(0.025, 0.975))
}

round(boot.ci, 2)

# Connect the results
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))

plot(iris.s, pch = 19, col = adjustcolor("firebrick", 0.5))
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0))

for (i in 1:length(x.seq)) lines(rep(x.seq[i], 2), boot.ci[i, ], col = 4, lwd = 2)

plot(iris.s, pch = 19, col = adjustcolor("firebrick", 0.5))
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0))

lines(x.seq, boot.ci[, 1], col = 4, lwd = 2)
lines(x.seq, boot.ci[, 2], col = 4, lwd = 2)



# Add even more x0 values
# Compare the bootstrap percentile interval to one that uses Gaussian errors
x.seq = seq(min(x), max(x), length.out = 100)
boot.ci = matrix(0, nrow = length(x.seq), 2)

for (i in 1:length(x.seq)) {
  y.hat = apply(beta.boot, 1, function(z, a) {
    sum(z * a)
  }, a = c(1, x.seq[i] - mean(x)))
  boot.ci[i, ] = quantile(y.hat, prob = c(0.025, 0.975))
}

## A CI using the assumption of Gaussian Errors
ci = predict(lm(y ~ x), newdata = data.frame(x = x.seq), interval = "confidence")

# Plot the results
par(mfrow = c(1, 2))

plot(iris.s, pch = 19, col = adjustcolor("firebrick", 0.5), main = "Bootstrap Confidence Interval")
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0))
lines(x.seq, boot.ci[, 1], col = 4, lwd = 2)  # Bootstrap percentile
lines(x.seq, boot.ci[, 2], col = 4, lwd = 2)

plot(iris.s, pch = 19, col = adjustcolor("firebrick", 0.5), main = "Gaussian Confidence Interval")
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0))
lines(x.seq, ci[, 2], col = 3, lwd = 2) # Gaussian
lines(x.seq, ci[, 3], col = 3, lwd = 2)



# Bootstrap parameter estimation
# Obtain the bootstrap samples using aˆ=3.428, ßˆ=0.7985, and sˆ=0.2565
B = 1000
par.boot.sam = Map(function(b) {
  Rstar = rnorm(n, mean = 0, sd = 0.2565)
  y = 3.428 + 0.7985 * (x - mean(x)) + Rstar
  data.frame(x = x, y = y)
}, 1:B)

par.boot.coef = Map(function(sam) lm(y ~ I(x - mean(x)), data = sam)$coef, par.boot.sam)




# Bootstrap by fitting const. alpha, beta, and sigma then resampling errors
B = 1000
nonpar.boot.sam = Map(function(b) {
  Rstar = R[sample(n, n, replace = TRUE)]
  y = 3.428 + 0.7985 * (x - mean(x)) + Rstar
  data.frame(x = x, y = y)
}, 1:B)

nonpar.boot.coef = Map(function(sam) lm(y ~ I(x - mean(x)), data = sam)$coef, 
                       nonpar.boot.sam)



# Other Examples
# Animals data and LS
library(robustbase)
data(Animals2)
# Animals2 = Animals2[-c(63,64,65),]
x = log(Animals2$body)
y = log(Animals2$brain)
n = length(y)
plot(x, y, pch = 19, col = adjustcolor("grey", 0.5))
beta.hat = lm(y ~ I(x - mean(x)))$coef
sd.hat = sqrt(sum(lm(y ~ I(x - mean(x)))$residuals^2)/(n - 2))
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0), col = adjustcolor("firebrick", 
                                                                         1))


# Animals data and robust regression line
library(robustbase)
library(MASS)
data(Animals2)
x = log(Animals2$body)
y = log(Animals2$brain)
n = length(y)
plot(x, y, pch = 19, col = adjustcolor("grey", 0.5))
beta.hat = rlm(y ~ I(x - mean(x)), psi = "psi.huber")$coef

sd.hat = sqrt(sum(rlm(y ~ I(x - mean(x)), psi = "psi.huber")$residuals^2)/(n - 2))
abline(coef = beta.hat + c(-beta.hat[2] * mean(x), 0), col = adjustcolor("firebrick", 1))
