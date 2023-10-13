filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)
popSharksAustralia <- popSharks[sharks$Australia == 1]
N <- 28

## Calculating the attribute on the population.
avePop <- mean(sharks[popSharksAustralia, "Length"])
medianPop <- median(sharks[popSharksAustralia, "Length"])
trimmedMeanPop <- mean(sharks[popSharksAustralia, "Length"], 0.2)
rangePop <- diff(range(sharks[popSharksAustralia, "Length"]))
iqrPop <- IQR(sharks[popSharksAustralia, "Length"])
sdPop <- sqrt((N - 1) * var(sharks[popSharksAustralia, "Length"])/N)

## Generating all possible samples
samples <- combn(popSharksAustralia, 5)

## Calculating the attributes on each sample
avesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"])
})
mediansSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  median(sharks[s, "Length"])
})
trimmedMeansSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  mean(sharks[s, "Length"], 0.2)
})
rangesSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  diff(range(sharks[s, "Length"]))
})
iqrsSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  IQR(sharks[s, "Length"])
})
sdsSamp <- apply(samples, MARGIN = 2, FUN = function(s) {
  sqrt((N - 1) * var(sharks[s, "Length"])/N)
})

# Examine the effect of outliers by replacing one unit
sharksBigSubmarine <- sharks
set.seed(12345564)
replaceShark <- sample(length(popSharksAustralia), 1)
rownameReplaceShark <- popSharksAustralia[replaceShark]
sharksBigSubmarine[rownameReplaceShark, "Length"] <- 480

# Plot histograms with and without the outlier
par(mfrow = c(1, 2))
### Location estimates
hist(sharks[popSharksAustralia, "Length"], 
     col = adjustcolor("grey", alpha = 0.5), 
     main = "", xlab = "shark length (inches)", xlim = c(0, 500), 
     breaks = seq(0, 500, 40))

hist(sharksBigSubmarine[popSharksAustralia, "Length"], 
     col = adjustcolor("grey", alpha = 0.5), 
     main = "", xlab = "shark length (inches)", xlim = c(0, 500), 
     breaks = seq(0, 500, 40))