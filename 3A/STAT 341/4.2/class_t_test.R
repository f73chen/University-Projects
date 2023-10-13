# Factory function that returns a function to calculate the t discrepancy measure
# for any two sub-populations for a given variate
# Assuming the variance of the sub-populations are equal

### The t statistic
getDiscrepancyFn <- function(var) {
  function(pop) {
    ## First sub-population
    pop1 <- pop$pop1
    n1 <- nrow(pop1)
    m1 <- mean(pop1[, var])
    v1 <- var(pop1[, var])
    ## Second sub-population
    pop2 <- pop$pop2
    n2 <- nrow(pop2)
    m2 <- mean(pop2[, var])
    v2 <- var(pop2[, var])
    ## Pool the variances
    v <- ((n1 - 1) * v1 + (n2 - 1) * v2)/(n1 + n2 - 2)
    ## Determine the t-statistic
    t <- (m1 - m2)/sqrt(v * ((1/n1) + (1/n2)))
    ## Return the t-value
    t
  }
}


filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
pop <- list(pop1 = subset(sharks, sharks$Australia == 1), 
            pop2 = subset(sharks, sharks$USA == 1))
summary(pop[[1]]$Length)
summary(pop[[2]]$Length)

# Get the t-like discrepancy for shark length
tStatLengths <- getDiscrepancyFn("Length")
tStatLengths(pop)


# To gauge the size of the discrepancy measures:
  # Shuffle the sub-populations M=5000 times and plot the histogram
  # Overlay the Student t density (with N1 + N2 - 2 dof) which calculates the p-value assuming normality
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

set.seed(341)
tVals <- sapply(1:5000, FUN = function(...) {
  tStatLengths(mixRandomly(pop))
})
xvals <- extendrange(tVals)
xvals <- seq(from = min(xvals), to = max(xvals), length.out = 200)

# Overlay the histogram with the theoretical t-density
n1 <- nrow(pop$pop1)
n2 <- nrow(pop$pop2)
densityVals <- dt(xvals, df = (n1 + n2 - 2))
histHeights <- hist(tVals, breaks = 20, plot = FALSE)$density
heightRange <- c(0, max(densityVals, histHeights))

# Plot the histogram
hist(tVals, breaks = 50, probability = TRUE, ylim = heightRange, main = "Permuted populations", 
     xlab = "t-statistic", col = "lightgrey")
abline(v = tStatLengths(pop), col = "red", lwd = 2)
# Add the density to the plot
lines(xvals, densityVals, col = "black")
legend("topright", legend = c("Observed t value", "t density"), lwd = c(2, 2), 
       col = c("red", "black"))



# The p-value can be estimated in two ways:
  # 1. Using the sub-populations generated via random mixing
tobs = tStatLengths(list(pop1 = sharks[sharks[, "Australia"] == 1, ], 
                         pop2 = sharks[sharks[, "USA"] == 1, ]))
mean(abs(tVals) >= abs(tobs))

  # 2. Using the t-distribution with N1 + N2 - 2 degrees of freedom
2 * pt(abs(tobs), df = (n1 + n2 - 2), lower.tail = FALSE)

# The similarity of the numbers shows that, in this example, the t-distribution
# could be a good approximation
# The p-value is so large that the observed discrepancy measure is not unusual
# if the null hypothesis is true
  # The test provides no evidence against the null hypothesis
  # P_Aus and P_USA likely don't have different average shark lengths

# Compare shark lengths in fatal vs. non-fatal encounters
Fatpop <- list(pop1 = sharks[sharks[, "Fatality"] == 1, ], 
               pop2 = sharks[sharks[, "Fatality"] == 0, ])
tStatLengths(Fatpop)


# To gauge the size of the discrepancy measures:
  # Shuffle the sub-populations M=5000 times and plot the histogram
  # Overlay the Student t density which assumes normality
set.seed(341)
tVals <- sapply(1:5000, FUN = function(...) {
  tStatLengths(mixRandomly(Fatpop))
})
xvals <- extendrange(tVals)
xvals <- seq(from = min(xvals), to = max(xvals), length.out = 200)

# Overlay the histogram with the theoretical t-density
n1 <- nrow(pop$pop1)
n2 <- nrow(pop$pop2)
densityVals <- dt(xvals, df = (n1 + n2 - 2))
histHeights <- hist(tVals, breaks = 20, plot = FALSE)$density
heightRange <- c(0, max(densityVals, histHeights))

# Plot the histogram
hist(tVals, breaks = 50, probability = TRUE, ylim = heightRange, main = "Permuted populations", 
     xlab = "t-statistic", col = "lightgrey")
abline(v = tStatLengths(Fatpop), col = "red", lwd = 2)
# Add the density to the plot
lines(xvals, densityVals, col = "black")
legend("topright", legend = c("Observed t value", "t density"), lwd = c(2, 2), 
       col = c("red", "black"))

# 1. Estimate the p-value via random mixing
tobs = tStatLengths(list(pop1 = sharks[sharks[, "Fatality"] == 1, ], 
                         pop2 = sharks[sharks[, "Fatality"] == 0, ]))
SL.hat = mean(abs(tVals) >= abs(tobs))
sprintf("%.4f", SL.hat)

# 2. Estimate the p-value using the t-distribution with N1 + N2 - 2 dof
SL.that = 2 * pt(abs(tobs), df = (n1 + n2 - 2), lower.tail = FALSE)
sprintf("%.5f", SL.that)

# The observed significance level is so small that the observed discrepancy would
# be unusual if the hypothesis is true
  # Therefore, there is evidence against the null hypothesis
  # And the lengths of the two sub-populations are different