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

# Now have a population of attributes (ex. a population of sample means)
# Can calculate attributes on this new population
# Ex. sample means resembles a bell curve centered on the population mean
hist(aveSamp[1:M])
avePop <- mean(sharks$Length)
abline(v=avePop, col='red')

# Or generate summary statistics on the population of sample attributes
# Ex. half of the sample means will be between 142.4 and 169.8
# Reassuring especially given the sample size (5/28)
summary(aveSamp)

# Calculate sample error for all possible samples
sampleErrors <- aveSamp - avePop
sampleErrors[c(1:5,M)]

# Numerical summary of sample errors:
summary(sampleErrors)
