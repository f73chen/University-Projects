filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)

# Plot the mean length of all samples of size 5
popSharks <- rownames(sharks)
popSharksAustralia <- popSharks[sharks$Australia == 1]
samples <- combn(popSharksAustralia, 5)
N_s <- ncol(samples)

avePop <- mean(sharks[popSharksAustralia, "Length"])
avesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"])
})

hist(avesSamp, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, main = "Sampling Distribution (n=5)", 
     xlab = "Average Shark Length (inches)", ylim = c(0, 0.022), breaks = 25)
abline(v = avePop, col = "red", lty = 3, lwd = 2)


# Approximate the sampling distribution with a Gaussian
# Same mean and stdev as the sampling dist.
par(mfrow = c(1, 2))
hist(avesSamp, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, main = "Sampling Distribution (n=5)", 
     xlab = "Average Shark Length (inches)", ylim = c(0, 0.022), breaks = 25)
abline(v = avePop, col = "red", lty = 3, lwd = 2)

sdN = function(x) {
  sqrt(var(x) * (length(x) - 1)/length(x))
}

# Add the Gaussian density
tmpAve <- mean(avesSamp)
tmpSD <- sdN(avesSamp)
tmpX <- extendrange(avesSamp)
tmpX <- seq(tmpX[1], tmpX[2], length.out = 200)
lines(tmpX, dnorm(tmpX, mean = tmpAve, sd = tmpSD), lwd = 2, col = "blue")
legend("topleft", legend = c("Normal Approx"), lwd = 2, col = "blue", lty = 1, 
       bty = "n")

# Draw the QQ plot (Quantile-Quantile)
qqnorm(avesSamp, main = "Normal QQ plot for Sample Averages", 
       col = adjustcolor("Grey", 0.4), pch = 19)
qqline(avesSamp, lwd = 2, col = "blue", xlab = "Normal Quantiles")