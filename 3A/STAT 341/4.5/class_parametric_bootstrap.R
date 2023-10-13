set.seed(341)
x = rnorm(10, mean = 5)

# Show the difference between the 9 quantile methods
pseq = seq(0, 1, length.out = 1000)
par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in 1:9) {
  plot(quantile(x, probs = pseq, type = i), pseq, type = "l", xlim = extendrange(x), 
       ylim = c(0, 1), ylab = "proportion", xlab = "", main = paste("Type=", i))
  segments(x0 = c(-5, 10), y0 = c(0, 1), x1 = c(min(x), max(x)), y1 = c(0, 1))
}




# Estimate the distribution function F(x) using a parametric model F(x; theta)
# Generate 100 observations from G(mu=5, sigma=1)
set.seed(341)
x = rnorm(100, mean = 5)
c(mean(x), sd(x))

# Overlay the fitted Gaussian distribution on the empirical CDF
# 4.994535 1.070854
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))
xseq = seq(-10, 10, length.out = 1000)
hist(x, breaks = "FD", xlim = extendrange(x), ylab = "proportion", xlab = "", 
     main = "Empirical Distribution Function", prob = TRUE)
lines(xseq, dnorm(xseq, mean(x), sd = sd(x)), col = 2)

plot(ecdf(x), xlim = extendrange(x), ylim = c(0, 1), ylab = "proportion", xlab = "", 
     main = "Empirical Distribution Function")

lines(xseq, pnorm(xseq, mean(x), sd = sd(x)), col = 2)




# Ex. Fit a parametric model on agpop
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)
missing92 <- agpop[, "acres92"] == -99
rowNumsMissing <- which(agpop[, "acres92"] == -99)
agpop[missing92, "acres92"] <- NA
agpop[agpop[, "acres87"] == -99, "acres87"] <- NA
agpop[agpop[, "acres82"] == -99, "acres82"] <- NA

set.seed(341)
acres87 = agpop[agpop$region == "W", "acres87"]
N = length(acres87)
n = 50
acres87Sam = acres87[sample(1:N, n)]

# From the histogram and empirical distribution, a 1/x_bar function fits well
# Where 1/x_bar is the maximum likelihood estimate of the parameter of the exponential distribution
par(mfrow = c(1, 2))
hist(acres87Sam, breaks = seq(0, max(acres87Sam, na.rm = TRUE), length.out = 15), 
     prob = TRUE, xlab = "Acres from 1987", main = "Acres from W region in 1987")

zseq = seq(0, max(acres87Sam, na.rm = TRUE), length.out = 100)
lines(zseq, dexp(zseq, rate = 1/mean(acres87Sam)))

plot(ecdf(acres87Sam), main = "ECDF of Acres", xlab = "Acres")
lines(zseq, pexp(zseq, rate = 1/mean(acres87Sam)), col = 2, xlab = "Acres")

# The exponential model is a good fit
# To repeat the experience and get more samples of size n
  # Simply generate n random samples from EXP(theta=1/x_bar) distribution
theta = 1/mean(acres87Sam)
B = 10^4
Sstar <- sapply(1:B, FUN = function(b) rexp(n, rate = theta))
bootAvg = apply(Sstar, 2, mean)

# Summary statistics for sample averages of the parametric bootstrap sample
sd(bootAvg)
summary(bootAvg)




# Test non-parametric bootstrap on acres87
Sstar0 <- sapply(1:B, FUN = function(b) acres87Sam[sample(n, n, replace = TRUE)])
bootAvg0 = apply(Sstar0, 2, mean)
sd(bootAvg0)
summary(bootAvg0)



# Compare parametric and non-parametric results
pseq = seq(0, 1, length.out = 1000)
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))

hhPopAve <- hist(extendrange(c(bootAvg, bootAvg0)), breaks = 50, plot = FALSE)$breaks

hist(bootAvg, main = "Parametric Bootstrap", breaks = hhPopAve)
hist(bootAvg0, main = "Bootstrap Sampling with \n Replacement", breaks = hhPopAve)



# Instead of the mean, consider the median
bootMed = apply(Sstar, 2, median)
bootMed0 = apply(Sstar0, 2, median)

pseq = seq(0, 1, length.out = 1000)
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))

hhPopMed <- hist(extendrange(c(bootMed, bootMed0)), breaks = 50, plot = FALSE)$breaks

hist(bootMed, main = "Parametric Bootstrap", breaks = hhPopMed)
hist(bootMed0, main = "Bootstrap Sampling with \n Replacement", breaks = hhPopMed)