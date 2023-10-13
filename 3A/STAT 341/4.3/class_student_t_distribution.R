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

sdN = function(x) {
  sqrt(var(x) * (length(x) - 1)/length(x))
}

Z = (avesSamp - mean(avesSamp))/sdN(avesSamp)

sdsSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  sdN(sharks[s, "Length"])
})

n = 5
N = 28
se = sdsSamp/sqrt(n) * sqrt((N - n)/(N - 1))
t = (avesSamp - mean(avesSamp))/se

# Make the two histograms use the same bins
delta = 0.2
brk = seq(min(t) - delta, max(t) + delta, delta)

par(mfrow = c(1, 2))

hist(Z, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, 
     main = "Standardized averages \n with known standard deviation", 
     xlab = "Standardized Shark Length (inches)", breaks = brk, 
     xlim = c(-4, 4), ylim = c(0, 0.4))
abline(v = 0, col = "red", lty = 3, lwd = 2)

# Add a Gaussian density
x = seq(-4, 4, length.out = 1000)
lines(x, dnorm(x), lwd = 2, col = "blue")

hist(t, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, 
     main = "Standardized averages \n with estimated standard deviation", 
     xlab = "Standardized Shark Length (inches)", breaks = brk, 
     xlim = c(-4, 4), ylim = c(0, 0.4))
abline(v = 0, col = "red", lty = 3, lwd = 2)

# Add a Gaussian density
x = seq(-4, 4, length.out = 1000)
lines(x, dnorm(x), lwd = 2, col = "blue")




# Normal distribution doesn't fit when stdev has to be estimated
# Instead, use the t_n-1 distribution in place of N(0, 1)
hist(t, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, ylim = c(0, 0.4), 
     main = "Standardized averages with \n estimated standard deviation", 
     xlab = "Standardized Shark Length (inches)", 
     breaks = brk, xlim = c(-4, 4))
abline(v = 0, col = "red", lty = 3, lwd = 2)

# Add a Gaussian density and t distribution
x = seq(-4, 4, length.out = 1000)
lines(x, dnorm(x), col = "blue", lwd = 2)
lines(x, dt(x, n - 1), col = "green", lwd = 2)




# Ex. coverage calculation via simulation
# Randomly select 100 samples of size n=5
# For each sample, calculate the 95% confidence interval
  # Using c ~= 2.78 from the t_4 distribution
# Should find that ~95% of the intervals contain/cover mu = 155.89

ylim <- c(0, 0.022)
n <- 5
N <- 28

# Add a Gaussian density
tmpAve <- mean(avesSamp)
tmpSD <- sdN(avesSamp)
confidence <- 0.95
numIntervals <- 100
cValue <- qt((confidence + 1)/2, df = n - 1)

set.seed(341)
tmpSamp <- sample(1:length(avesSamp), numIntervals)
ybarSampled <- avesSamp[tmpSamp]
sdSampled <- sdsSamp[tmpSamp]
maxSD <- max(sdSampled)/sqrt(n)

heights <- seq(diff(ylim)/numIntervals, max(ylim), length.out = numIntervals)
xlim <- extendrange(c(ybarSampled - cValue * sqrt((N - n)/(N - 1)) * sdSampled/sqrt(n), 
                      ybarSampled + cValue * sqrt((N - n)/(N - 1)) * sdSampled/sqrt(n)))
hist(avesSamp, col = adjustcolor("grey", alpha = 0.5), freq = FALSE, 
     main = paste0(numIntervals, " Individual ", round(100 * confidence), "% Confidence Intervals"), 
     xlab = "Average shark length (inches)", 
     ylim = ylim, xlim = xlim, breaks = 25)
abline(v = avePop, col = "red", lty = 3, lwd = 2)

numIntervalsCovered <- 0
for (i in 1:numIntervals) {
  tmpSampSD <- sdSampled[i]/sqrt(n) * sqrt((N - n)/(N - 1))
  lines(ybarSampled[i] + cValue * c(-tmpSampSD, tmpSampSD), 
        rep(heights[i], 2), col = "steelblue")
  
  if (tmpAve > ybarSampled[i] + cValue * tmpSampSD) {
    points(ybarSampled[i] - cValue * tmpSampSD, heights[i], pch = 8, 
           cex = 1.2, col = "red")
    points(ybarSampled[i], heights[i], pch = 18, cex = 1.2, col = "red")
    lines(rep(ybarSampled[i], 2), c(0, heights[i]), col = "red")
  } 
  
  else if (tmpAve < ybarSampled[i] - cValue * tmpSampSD) {
    points(ybarSampled[i] + cValue * tmpSampSD, heights[i], pch = 8, 
           cex = 1.2, col = "red")
    points(ybarSampled[i], heights[i], pch = 18, cex = 1.2, col = "red")
    lines(rep(ybarSampled[i], 2), c(0, heights[i]), col = "red")
  } 
  
  else numIntervalsCovered <- numIntervalsCovered + 1
}

tmpX <- extendrange(avesSamp)
tmpX <- seq(tmpX[1], tmpX[2], length.out = 200)
lines(tmpX, dnorm(tmpX, mean = tmpAve, sd = tmpSD))

# 93 of the 100 intervals cover mu
# Note that most of the missed intervals are on the right side
# We can find the exact coverage probability by calculating all possible confidence intervals
numIntervalsCovered