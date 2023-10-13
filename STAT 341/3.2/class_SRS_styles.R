# Get the indices of a simple random sample without replace
set.seed(341)
pop15 = round(rnorm(15), 2)
pop15

set.seed(341)
sample5 = sample(15, 5)
sample5

# If instead of indices, units were identified by the unique contents of vector pop,
# Then sample(pop, n) returns the vector of units in the sample
pop15[sample5]
set.seed(341)
sample(pop15, 5)




# Generate simple random samples with replacement
# Same command but set sample(replace=TRUE)
set.seed(341)
pop15 = round(rnorm(15), 3)

set.seed(341)
sample5 = sample(15, 5, replace=TRUE)
sample5

pop15[sample5]
set.seed(341)
sample(pop15, 5, replace=TRUE)




# Weird hybrid of simple random sampling
set.seed(341)
pop10 = round(rnorm(10), 3)
set.seed(341)
sample5 = sample(10, 5, replace=TRUE)
sample5

pop10[sample5]
unique(pop10[sample5])






# For both SRSWOR and SRSWR, select 10,000 samples and calculate the average
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)

popSharks <- rownames(sharks)
popSharksAustralia <- popSharks[sharks$Australia == 1]
avePop <- mean(sharks[popSharksAustralia, "Length"])

# Sample size and number of samples
n <- 15
m <- 10000

# Samples without replacement
set.seed(123415)
sampsWithout <- Map(function(i) {
  sample(popSharksAustralia, size=n, replace=FALSE)
}, 1:m)
aveWithout <- Map(function(s) {
  mean(sharks[s, "Length"])
}, sampsWithout)

# Samples with replacement
sampsWith <- Map(function(i) {
  sample(popSharksAustralia, size=n, replace=TRUE)
}, 1:m)
aveWith <- Map(function(s) {
  mean(sharks[s, "Length"])
}, sampsWith)

# Samples with replacement but no duplicates
aveWithUnique <- Map(function(s) {
  mean(sharks[unique(s), "Length"])
}, sampsWith)



# Plot histograms and compare
# Use the same x-axis scale, bin counts, and heights in all plots
xlim <- extendrange(c(aveWith, aveWithout))
bins <- hist(c(as.numeric(aveWithout), as.numeric(aveWith)), breaks = 30, plot = FALSE)
ylim <- c(0, 2200)

# Plot without replacement
par(mfrow = c(1, 3))
hist(as.numeric(aveWithout), main = "Average without replacement", xlim = xlim, 
     xlab = "length (inches)", ylim = ylim, breaks = bins$breaks, col = adjustcolor("grey", 
                                                                                    0.75))
abline(v = avePop, col = "red", lty = 2)

# Plot with replacement
hist(as.numeric(aveWith), main = "Average with replacement", xlim = xlim, xlab = "length (inches)", 
     ylim = ylim, breaks = bins$breaks, col = adjustcolor("grey", 0.75))
abline(v = avePop, col = "red", lty = 2)

# With replacement but no duplicates
hist(as.numeric(aveWithUnique), main = "Average with replacement unique", xlim = xlim, 
     xlab = "length (inches)", ylim = ylim, breaks = bins$breaks, col = adjustcolor("grey", 
                                                                                    0.75))
abline(v = avePop, col = "red", lty = 2)



# Compare sampling mechanisms numerically using bias, variance, and MSE
# Therefore, SRSWOR is the best method
population = sharks[popSharksAustralia, ]$Length

# 10,000 averages based on different sampling designs
aveWithout = unlist(aveWithout)
aveWith = unlist(aveWith)
aveWithUnique = unlist(aveWithUnique)

average = matrix(0, nrow = length(aveWith), ncol = 3)
average[, 1] <- aveWithout
average[, 2] <- aveWith
average[, 3] <- aveWithUnique

temp = rbind(apply(average, 2, mean) - mean(population), apply(average, 2, var), 
             (apply(average, 2, mean) - mean(population))^2 + apply(average, 2, var))
dimnames(temp)[[1]] = c("Bias", "Var", "MSE")
dimnames(temp)[[2]] = c("Without Replacement", "With Replacement", "With Replacement but no duplicates")
round(t(temp), 4)