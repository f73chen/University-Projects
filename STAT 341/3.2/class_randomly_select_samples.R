library(knitr)
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
kable(head(sharks))

# Instead of generating all possible samples of size n in N,
# Focus on a sub-population, like all in Australia
# For N=28, there are only 98,280 ways to choose n=5
popSharks <- rownames(sharks)
popSharks.Aus <- popSharks[sharks$Australia == 1]
popSharks.Aus

# Get all index combinations of N choose n
samples <- combn(popSharks.Aus, 5)
M <- ncol(samples)
kable(data.frame(first=samples[, 1], second=samples[, 2],
                 third=samples[, 3], fourth=samples[, 4],
                 fifth=samples[, 5], last=samples[, M]))
M

# For every sample, can calculate any attribute
# Find average in the first 5 and last samples
aveSamp <- apply(samples, MARGIN=2, FUN=function(s) {
  mean(sharks[s, 'Length'])
})
aveSamp[c(1:5,M)]
aveSampSel <- aveSamp[1:10000]

# Now have a population of attributes (ex. a population of sample means)
# Can calculate attributes on this new population
# Ex. sample means resembles a bell curve centered on the population mean
avePop <- mean(sharks$Length)
par(mfrow=c(1, 3))
hist(aveSamp, breaks=20, col=adjustcolor('grey', 0.3))
abline(v=avePop, col='red')
hist(aveSampSel, breaks=20, col=adjustcolor('blue', 0.3))
abline(v=avePop, col='red')

hist(aveSamp, breaks=20, col=adjustcolor('grey', 0.3))
hist(aveSampSel, breaks=20, col=adjustcolor('blue', 0.3), add=TRUE)

# Compare graphs numerically
temp = rbind(summary(aveSamp), summary(aveSampSel))
dimnames(temp)[[1]] = c("All Possible Samples", "10,000 Randomly Selected Samples")
temp