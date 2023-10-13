filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)
popSharksAustralia <- popSharks[sharks$Australia == 1]

samples <- combn(popSharksAustralia, 5)
N_s <- ncol(samples)

avePop <- mean(sharks[popSharksAustralia, "Length"])
avesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"])
})

# Some attributes are:
  # N = 28, n = 5
  # mu = a(P) = 155.89 --> population average
  # sigma = 49.74 --> population standard deviation
  # SD[Y_bar] = sigma/sqrt(n) = 19.8

# Standardize the random variable and use a N(0, 1) curve for approximation
sdN = function(x) {
  sqrt(var(x) * (length(x) - 1)/length(x))
}
Z = (avesSamp - mean(avesSamp))/sdN(avesSamp)

# Plot the sampled and population attributes
hist(Z, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, main = "Sampling Distribution (n = 5)", 
     xlab = "Standardized Shark Length (inches)", breaks = 25)
abline(v = 0, col = "red", lty = 3, lwd = 2)

# Add the Gaussian density
x = seq(-4, 4, length.out = 1000)
lines(x, dnorm(x), col = "blue", lwd = 2)

legend("topleft", legend = c("Normal Approx"), lwd = 2, col = "blue", lty = 1, 
       bty = "n")




# Given mu and sigma:
  # Randomly select 100 samples of size n
  # For each sample, calculate the 95% confidence interval
  # Should find that approximately 100(1-p)% = 95% of intervals contain mu
ylim <- c(0, 0.022)

### Add a Gaussian density
tmpAve <- mean(avesSamp)
tmpSD <- sdN(avesSamp)
confidence <- 0.95
p <- 1 - confidence
numIntervals <- 100
cValue <- qnorm(1 - p/2)  # or qnorm((confidence + 1)/2)
set.seed(341)  # comment out this line to get different samples every time you run the code.
ybarSampled <- sample(avesSamp, numIntervals)
heights <- seq(diff(ylim)/numIntervals, max(ylim), length.out = numIntervals)
xlim <- extendrange(avesSamp + cValue * c(-tmpSD, tmpSD))

hist(avesSamp, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, 
     main = paste0(numIntervals, " Individual ", round(100 * confidence), "% Confidence Intervals"), 
     xlab = "Average Shark Length (inches)", 
     ylim = ylim, xlim = xlim, breaks = 25)
abline(v = avePop, col = "red", lty = 3, lwd = 2)

numIntervalsCaptured <- 0
for (i in 1:numIntervals) {
  lines(ybarSampled[i] + cValue * c(-tmpSD, tmpSD), rep(heights[i], 2), 
        col = "steelblue")
  
  # If interval missed to the left
  if (tmpAve > ybarSampled[i] + cValue * tmpSD) {
    points(ybarSampled[i] - cValue * tmpSD, heights[i], pch = 8, cex = 1.2, 
           col = "red")
    points(ybarSampled[i], heights[i], pch = 18, cex = 1.2, col = "red")
    lines(rep(ybarSampled[i], 2), c(0, heights[i]), col = "red")
  } 
  
  # If interval missed to the right
  else if (tmpAve < ybarSampled[i] - cValue * tmpSD) {
    points(ybarSampled[i] + cValue * tmpSD, heights[i], pch = 8, cex = 1.2, 
           col = "red")
    points(ybarSampled[i], heights[i], pch = 18, cex = 1.2, col = "red")
    lines(rep(ybarSampled[i], 2), c(0, heights[i]), col = "red")
  } 
  
  else numIntervalsCaptured <- numIntervalsCaptured + 1
}

tmpX <- extendrange(avesSamp)
tmpX <- seq(tmpX[1], tmpX[2], length.out = 200)
lines(tmpX, dnorm(tmpX, mean = tmpAve, sd = tmpSD))

# 95 of the 100 intervals cover the value mu (as expected)
# The intervals that don't cover mu are marked with * and means indicated with diamonds
# Notice that the missed samples are on the tails of the bell curve
numIntervalsCaptured