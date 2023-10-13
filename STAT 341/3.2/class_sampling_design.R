# Show how sampling design can affect the precision of estimation
# How it affects the estimation of coefficients in simple linear regression

# The regression coefficients are (aˆ,ßˆ)= (2.13, 0.75) for the fitted line yi=aˆ+ßˆxi
library(MASS)
data(mammals)
plot(log(mammals$body), log(mammals$brain), xlab = "log(Body)", ylab = "log(Brain)", 
     pch = 19, col = 4)
abline(lm(log(brain) ~ log(body), mammals)$coef)

# All samples of size 3
# There are (62 choose 3) = 37820 possible samples
# Slow to calculate the regression coefficient on all possible samples
lmtest <- function(sam = NULL, data = NULL) {
  lm(log(brain) ~ log(body), data, subset = sam)$coef
}
reg.coef3 = combn(62, 3, FUN = lmtest, data = mammals)
row.names(reg.coef3) = c("alpha", "beta")

# Median describes location and IQR describes spread
round(apply(reg.coef3, 1, summary), 2)

# Quantiles
a = c(0.001, 0.01, 0.05)
round(apply(reg.coef3, 1, quantile, prob = c(a/2, rev(1 - a/2))), 2)

# Plot all possible regression lines from samples of size 3
# Add results from all sampling designs to the same plot
plotregCoef <- function(reg.coefX = NULL, tmain = "") {
  # tmain = title of the plot 
  # regcoef is a 2 x m matrix containing the regression coefficients.
  plot(log(mammals$body), log(mammals$brain), xlab = "log(Body)", ylab = "log(Brain)", 
       pch = 19, main = tmain, col = 0)
  
  apply(reg.coefX, 2, function(z) {
    abline(z, col = adjustcolor("black", alpha = 0.3))
  })
  
  points(log(mammals$body), log(mammals$brain), pch = 19, col = adjustcolor("grey", 0.6))
  abline(lm(log(brain) ~ log(body), mammals)$coef, col = 2)
}

plotregCoef(reg.coef3, tmain = "n=3")

# There are (62 choose 6) = 61474519 possible samples
# Too many to calculate, so use a random subset of 10,000 samples to quantify the sampling design
m = 10000
set.seed(341)
reg.coef6 <- sapply(1:m, function(rep) {
  lm(log(brain) ~ log(body), data = mammals, subset = sample(62, 6))$coef
})

plotregCoef(reg.coefX = reg.coef6, tmain = "n=6")

# Instead of only increasing the sample size, 
# Construct a sampling design to reduce variability

# Use stratified sampling, but assume that body weight is already known
par(mfrow = c(1, 2), oma = c(0, 0, 0, 0))
hist(log(mammals$body), breaks = 25, xlab = "log(body)", main = "Histogram of log(body)")
plot(sort(log(mammals$body)), ppoints(62), pch = 20, xlab = "log(body)", ylab = "empirical CDF")

# Median log(body) weight is 1.21
# Split into two groups below and above the median
grp = numeric(nrow(mammals))
grp[log(mammals$body) <= median(log(mammals$body))] = 1
grp[log(mammals$body) > median(log(mammals$body))] = 2
summary(as.factor(grp))

par(mfrow = c(1, 2), oma = c(0, 0, 0, 0))
plot(grp, log(mammals$body), ylab = "log(body)", xlab = "group", pch = 19, col = grp)
plot(sort(log(mammals$body)), ppoints(62), pch = 20, xlab = "log(body)", col = grp[order(log(mammals$body))])

# Stratified sampling mechanism from below/above median
# Note: sample indices, not response values
createStrataMechanism <- function(pop, grp) {
  method <- function(sampSize) {
    sam = list()
    for (h in 1:length(sampSize)) sam[[h]] = sample(pop[grp == h], sampSize[h])
    sam
  }
  return(method)
}
mammalStrata = createStrataMechanism(1:62, grp)
set.seed(341)
mammalStrata(c(2, 3))

# Apply unlist for compatibility (print results on one line)
unlist(mammalStrata(c(2, 3)))


# Too many possibilities for stratified sampling of size 6
choose(31, 3) * choose(31, 3)

# Instead, use a random subset of samples to quantify the sampling design
m = 10000
set.seed(341)
reg.coef33 <- sapply(1:m, function(rep) {
  lm(log(brain) ~ log(body), data = mammals, subset = unlist(mammalStrata(c(3, 3))))$coef
})
plotregCoef(reg.coefX = reg.coef33, tmain = "n=(3,3)")


# Regression with 3 strata --> limit the number in the middle
# Split into top 10%, middle 80%, and bottom 10%
quantile(log(mammals$body), c(0.1, 0.9))
grp = numeric(nrow(mammals))
grp[log(mammals$body) <= -2.56] = 1
grp[log(mammals$body) <= 5.32 & log(mammals$body) > -2.56] = 2
grp[log(mammals$body) > 5.32] = 3

# Construct the strate sampling mechanism
mammalStrata3 = createStrataMechanism(1:62, grp)
set.seed(341)
mammalStrata3(c(2, 3, 1))


# Sample size 6 with 3 strata
# Too many possibilities
choose(7, 2) * choose(48, 2) * choose(7, 2)

# Use a random subset of samples to quantify the sampling design
m = 10000
set.seed(341)
reg.coef222 <- sapply(1:m, function(rep) {
  lm(log(brain) ~ log(body), data = mammals, subset = unlist(mammalStrata3(c(2, 2, 2))))$coef
})
plotregCoef(reg.coefX = reg.coef222, tmain = "n=(2,2,2)")


# Compare the sampling designs
# Same number of samples, only sampling designs differ
# Using sample size 6
  # Random sampling without replacement (1 strata)
  # Two strate with even split
  # Three strate with varying split
par(mfrow = c(1, 3), oma = c(0, 0, 0, 0))
N = nrow(mammals)
plotregCoef(reg.coefX = reg.coef6, tmain = "n=6")
plotregCoef(reg.coefX = reg.coef33, tmain = "n=(3,3)")
plotregCoef(reg.coefX = reg.coef222, tmain = "n=(2,2,2)")

# Numerical comparison
# Recall that the regression coefficient from the population are 2.135, 0.752
avg.and.sd <- function(z) {
  c(mean(z), sd(z))
}

temp = matrix(0, nrow = 3, ncol = 4)
rownames(temp) = c("n=6", "n=(3,3)", "n=(2,2,2)")
colnames(temp) = rep(c("average", "stdev"), 2)

temp[1, ] = apply(reg.coef6, 1, avg.and.sd)
temp[2, ] = apply(reg.coef33, 1, avg.and.sd)
temp[3, ] = apply(reg.coef222, 1, avg.and.sd)
round(temp, 3)