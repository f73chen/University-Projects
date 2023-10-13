filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# A function to put n or N in the denominator of SD rather than n-1 or N-1
sdn <- function(y.pop) {
  N = length(y.pop)
  sqrt(var(y.pop) * (N - 1)/(N))
}

# Construct an approx. S.D. for average shark length based on samples of size 6
M <- 10^4
n = 6
set.seed(341)
samples <- sapply(1:M, FUN = function(m) sample(popSharks, n, replace = TRUE))

avePop <- mean(sharks[, "Length"])
avesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"])
})
sampleErrors <- avesSamp - avePop

tmpAve <- mean(avesSamp)
tmpSD <- sdn(avesSamp)

sdsSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  sdn(sharks[s, "Length"])
})

# Draw one sample S from P using SRSWOR:
popSize <- function(pop) {
  if (is.vector(pop))
  {if (is.logical(pop)) 
    ## then assume TRUE values identify units
    sum(pop) else length(pop)}
  else nrow(pop)
}

getSample <- function(pop, size, replace=FALSE) {
  N <- popSize(pop)
  pop[sample(1:N, size, replace = replace)]
}

set.seed(341)
n <- 6
S <- getSample(1:65, n, replace = FALSE)
S

# Draw B bootstrap samples from this single sample
# There are 6^6 = 46,656 possible bootstrap samples of size 6 to select
# Choose B = 10,000 bootstrap samples
# Get 6xB matrix of bootstrap sample indices, where each column is a sample
Pstar <- S
B <- 10^4
set.seed(341)
Sstar <- sapply(1:B, FUN = function(b) getSample(Pstar, n, replace = T))

dim(Sstar)
Sstar[, 1:10]

# Compute the attribute of interest on each bootstrap sample
# Ex. average shark length
avesBootSamp <- sapply(1:B, FUN = function(i) mean(sharks[Sstar[, i], "Length"]))
round(avesBootSamp[1:10], 1)

# The collection of bootstrap averages is an estimate of the S.D for the sample average
# Can be thought of and treated like any other population

# Compare the bootstrap estimate of the S.D. to repeatedly sampling the population
# Plot the histogram of both collections
round(avesSamp[1:10], 1)

savePar <- par(mfrow = c(1, 2))
hPopAve <- hist(extendrange(c(avesSamp, avesBootSamp)), breaks = 50, plot = FALSE)
hist(avesBootSamp, xlim = range(avesSamp), breaks = hPopAve$breaks, freq = FALSE, 
     col = "grey", main = "B=10,000 Bootstrap Averages \n(n=6)", xlab = "")
hist(avesSamp, xlim = range(avesSamp), breaks = hPopAve$breaks, freq = FALSE, 
     col = "grey", main = "M=10,000 Sample Averages \n(n=6)", xlab = "")

# Estimate sample variance with bootstrap variance
# Make histograms for errors:
  # sample error = a(S) - a(P)
  # bootstrap sample error = a(S*) - a(S)
aveSam <- mean(sharks[S, "Length"])
savePar <- par(mfrow = c(1, 2))
range.avediff <- extendrange(c(avesSamp - avePop, avesBootSamp - aveSam))
hPopAvediff <- hist(range.avediff, breaks = 50, plot = FALSE)

hist(avesBootSamp - aveSam, xlim = range.avediff, breaks = hPopAvediff$breaks, 
     freq = FALSE, col = "grey", main = "B=10,000 Bootstrap Sample Errors \n(n=6)", 
     xlab = "")
hist(avesSamp - avePop, xlim = range.avediff, breaks = hPopAvediff$breaks, freq = FALSE, 
     col = "grey", main = "M=10,000 Sample Errors \n(n=6)", xlab = "")

# The standard deviation in both distributions:
sdn(avesBootSamp)
sdn(avesSamp)

# Special case: inference for the population average
# Note: if the sample is a bad representation of the population, the numbers might be very different
n = 6
N = dim(sharks)[1]
c(sdn(avesBootSamp), sdn(sharks[S, "Length"])/sqrt(n) * sqrt((N - n)/(N - 1)))

# Randomly select M=2000 samples of size n=6 from each population
# For each sample:
  # Calculate 2000 re;eated-sample-based estimates of SD^[Ybar]
  # Generate B=200 bootstraps to get 2000 bootstrap estimates of SD^[Ybar]
set.seed(341)
numSamps <- 2000
n <- 6

sampSes <- sapply(1:numSamps, FUN = function(i) getSample(popSharks, n))
B <- 200

valsBoot = t(apply(sampSes, 2, function(sam = NULL, B = NULL) {
  avesTemp = unlist(Map(function(i) {
    mean(sharks[sample(sam, n, replace = TRUE), "Length"])
  }, 1:B))
  c(sdn(avesTemp), sdn(sharks[sam, "Length"])/sqrt(n) * sqrt((N - n)/(N - 1)))
}, B = B))

colnames(valsBoot) <- c("sdBoot", "sdStandard")

par(mfrow = c(1, 2))
hTmp <- hist(extendrange(valsBoot), breaks = 50, plot = FALSE)
hist(valsBoot[, "sdBoot"], xlim = extendrange(valsBoot), breaks = hTmp$breaks, 
     freq = FALSE, col = "grey", main = "Bootstrap estimates", xlab = "SD(Ybar)")
abline(v = sdn(avesSamp), col = "red", lty = 2, lwd = 2)

hist(valsBoot[, "sdStandard"], xlim = extendrange(valsBoot), breaks = hTmp$breaks, 
     freq = FALSE, col = "grey", main = "Standard sample estimates", xlab = "SD(Ybar)")
abline(v = sdn(avesSamp), col = "red", lty = 2, lwd = 2)

# Plot the pairs of 2000 stdev estimates
par(mfrow = c(1, 3))
hist(valsBoot[, "sdBoot"] - valsBoot[, "sdStandard"], main = "Paired Differences", 
     breaks = 50, col = "grey", freq = FALSE, xlab = "SD: Bootstrap - Standard")
hist(valsBoot[, "sdBoot"]/valsBoot[, "sdStandard"], main = "Paired Ratios", 
     breaks = 50, col = "grey", freq = FALSE, xlab = "SD: Bootstrap/Standard")
plot(valsBoot[, "sdBoot"], valsBoot[, "sdStandard"], main = "Paired Values ", 
     col = "grey", xlab = "SD: Bootstrap", ylab = "SD: Standard")
abline(a = 0, b = 1)

# Bootstrap doesn't only apply to the arithmetic average
# Using B=10,000 bootstrap samples, estimate median, stdev, and skewness
# Where Sstar S* are the bootstrap samples
skew <- function(z) {
  3 * (mean(z) - median(z))/sdn(z)
}
sam.len = sharks[S, "Length"]
sam.est = c(median(sam.len), sdn(sam.len), skew(sam.len))
round(sam.est, 2)

bootAttr <- apply(Sstar, 2, function(sam, len) {
  pop = len[sam]
  c(median(pop), sdn(pop), skew(pop))
}, len = sharks[, "Length"])
par(mfrow = c(1, 3))
namHist = c("median", "standard deviation", "skewness")

for (i in 1:3) hist(bootAttr[i, ], main = namHist[i], xlab = "Bootstrap Replicates", 
                    breaks = 50, col = "grey", freq = FALSE)

# The bootstrap estimate of the stdev for each sampling distribution is:
round(apply(bootAttr, 1, sd), 3)
