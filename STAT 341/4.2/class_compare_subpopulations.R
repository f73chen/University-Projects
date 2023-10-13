filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
pop <- list(pop1 = subset(sharks, sharks$Australia == 1), pop2 = subset(sharks, sharks$USA == 1))

# Numerically compare the sub-populations
summary(pop[[1]]$Length)
summary(pop[[2]]$Length)

# Graphically compare the sub-populations using a quantile plot
par(mfrow = c(1, 3), oma = c(0, 0, 2, 0))

qvals <- sort(pop[[1]]$Length)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col = adjustcolor("black", alpha = 0.5), 
     xlim = c(0, 1), ylim = extendrange(range(sharks$Length)), 
     xlab = "Proportion p", ylab = bquote("Quantiles Q"["y"] * "(p)"), main = "Australia Encounters")
qvals <- sort(pop[[2]]$Length)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col = adjustcolor("red", alpha = 0.5), 
     xlim = c(0,1), ylim = extendrange(range(sharks$Length)), 
     xlab = "Proportion p", ylab = bquote("Quantiles Q"["y"] * "(p)"), main = "US Encounters")

qvals <- sort(pop[[1]]$Length)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col = adjustcolor("black", alpha = 0.5), 
     xlim = c(0,1), ylim = extendrange(range(sharks$Length)), 
     xlab = "Proportion p", ylab = bquote("Quantiles Q"["y"] * "(p)"), main = "Australia/US Encounters")
qvals <- sort(pop[[2]]$Length)
pvals <- ppoints(length(qvals))
points(pvals, qvals, pch = 19, col = adjustcolor("red", alpha = 0.5))


# The difference between the means in the sub-populations:
# a(P1) - a(P2) = y1_bar - y2_bar
mean(pop$pop1[, "Length"]) - mean(pop$pop2[, "Length"])

# The ratop between standard deviations:
# a(P1) / a(P2) = SD(P1) / SD(P2)
sd(pop$pop1[, "Length"])/sd(pop$pop2[, "Length"])



# Combine two sub-populations together into P = {P1, P2}
  # Then randomly draw two new sub-populations P1* and P2*
  # Ensuring that sub-population sizes are kept the same
mixRandomly <- function(pop) {
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  
  mix <- rbind(pop1, pop2)
  select4pop1 <- sample(1:(n_pop1 + n_pop2), n_pop1, replace = FALSE)
  
  new_pop1 <- mix[select4pop1, ]
  new_pop2 <- mix[-select4pop1, ]
  list(pop1 = new_pop1, pop2 = new_pop2)
}


# Define a factory function for calculating differences of means and ratios of stdev
getAveDiffsFn <- function(variate) {
  function(pop) {
    mean(pop$pop1[, variate]) - mean(pop$pop2[, variate])
  }
}

getSDRatioFn <- function(variate) {
  function(pop) {
    sd(pop$pop1[, variate])/sd(pop$pop2[, variate])
  }
}

diffAveLengths <- getAveDiffsFn("Length")
ratioSDLengths <- getSDRatioFn("Length")
round(c(diffAveLengths(pop), ratioSDLengths(pop)), 3)

# Now randomly mix the two sub-populations (while maintaining population sizes)
# and re-calculate the same summaries:
# Notice that the standard deviation doesn't change much after shuffling, but mean can change a lot
set.seed(341)
mixedPop <- mixRandomly(pop)
round(c(diffAveLengths(mixedPop), ratioSDLengths(mixedPop)), 3)


# Make a histogram of all differences and ratios
# To graph the changes from all shufflings
# a(P_Australia) - a(P_USA) doesn't seem extreme compared to all shufflings
set.seed(341)
diffLengths <- sapply(1:5000, FUN = function(...) {
  diffAveLengths(mixRandomly(pop))
})
hist(diffLengths, breaks = 20, main = "Randomly Mixed Populations", 
     xlab = "difference in averages", col = "lightgrey")
abline(v = diffAveLengths(pop), col = "red", lwd = 2)

# Same for standard deviation
# SD(P_Australia)/SD(P_USA) doesn't seem extreme compared to all shufflings
set.seed(341)
ratioLengths <- sapply(1:5000, FUN = function(...) {
  ratioSDLengths(mixRandomly(pop))
})
hist(ratioLengths, breaks = 20, main = "Randomly Mixed Populations", xlab = "ratio of standard devations", 
     col = "lightgrey")
abline(v = ratioSDLengths(pop), col = "red", lwd = 2)


# Compare sub-populations on the basis of medians and IQR
# Define helper functions
getMedianDiffsFn <- function(variate) {
  function(pop) {
    median(pop$pop1[, variate]) - median(pop$pop2[, variate])
  }
}

getIQRRatioFn <- function(variate) {
  function(pop) {
    IQR(pop$pop1[, variate])/IQR(pop$pop2[, variate])
  }
}
diffMedianLengths <- getMedianDiffsFn("Length")
ratioIQRLengths <- getIQRRatioFn("Length")


# Repeat the above but for P1 = fatal encounters and P2 = non-fatal encounters
# Variate of interest is still shark length
Fatpop <- list(pop1 = sharks[sharks[, "Fatality"] == 1, ], 
               pop2 = sharks[sharks[, "Fatality"] == 0, ])

# Compare numerically
summary(Fatpop[[1]]$Length)
summary(Fatpop[[2]]$Length)

# When compared graphically, clear that fatal encounters involve bigger sharks
# Quantify the difference in mean and stdev by mixing sub-populations
Fatpop <- list(pop1 = sharks[sharks[, "Fatality"] == 1, ], 
               pop2 = sharks[sharks[, "Fatality"] == 0, ])
par(mfrow = c(1, 2), oma = c(0, 0, 2, 0))

set.seed(341)
fatpair <- sapply(1:5000, FUN = function(...) {
  tmixpop = mixRandomly(Fatpop)
  c(diffAveLengths(tmixpop), ratioSDLengths(tmixpop))
})

# There is a very extreme difference in mean lengths between original & mixed populations
hist(fatpair[1, ], breaks = "FD", main = "Randomly Mixed Populations", 
     xlab = "difference in averages", col = "lightgrey")
abline(v = diffAveLengths(Fatpop), col = "red", lwd = 2)

hist(fatpair[2, ], breaks = "FD", main = "Randomly Mixed Populations", 
     xlab = "ratio of standard devations", col = "lightgrey")
abline(v = ratioSDLengths(Fatpop), col = "red", lwd = 2)