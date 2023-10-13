filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
pop <- list(pop1 = subset(sharks, sharks$Australia == 1), 
            pop2 = subset(sharks, sharks$USA == 1))

summary(pop[[1]]$Length)
summary(pop[[2]]$Length)

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

# Define factory functions for finding difference of means and ratios of stdevs
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

# Randomly mix the two sub-populations and calculating the same summaries:
set.seed(341)
mixedPop <- mixRandomly(pop)

diffLengths <- sapply(1:5000, FUN = function(...) {
  diffAveLengths(mixRandomly(pop))
})
round(c(diffAveLengths(mixedPop), ratioSDLengths(mixedPop)), 3)

# The approximate p-value assuming the discrepancy measure is |y1_bar - y2_bar|
# Therefore, H0: P_Australia and P_USA are drawn from the same population has p=0.704
sum(abs(diffLengths) >= abs(diffAveLengths(pop))) / length(diffLengths)

# For H0: P_fatal and P_non-fatal are drawn from the same population has p=0.0002
# Quantify the difference in the average and stdev by randomly mixing sub-populations
Fatpop <- list(pop1 = sharks[sharks[, "Fatality"] == 1, ], 
               pop2 = sharks[sharks[, "Fatality"] == 0, ])

par(mfrow = c(1, 2), oma = c(0, 0, 2, 0))
set.seed(341)
fatpair <- sapply(1:5000, FUN = function(...) {
  tmixpop = mixRandomly(Fatpop)
  c(diffAveLengths(tmixpop), ratioSDLengths(tmixpop))
})

hist(fatpair[1, ], breaks = "FD", main = "Randomly Mixed Populations", 
     xlab = "difference in averages", col = "lightgrey")
abline(v = diffAveLengths(Fatpop), col = "red", lwd = 2)
hist(fatpair[2, ], breaks = "FD", main = "Randomly Mixed Populations", 
     xlab = "ratio of standard devations", col = "lightgrey")
abline(v = ratioSDLengths(Fatpop), col = "red", lwd = 2)

# Suppose that the pair (P_Australia, P_USA) is a random draw
  # The chance of seeing a difference at least as large as (P_Aus, P_USA) is 0.704
  # Therefore, no evidence against the null hypothesis that they were randomly drawn

# Suppose that the pair (P_fatal, P_non-fatal) is a random draw
  # Probability of seeing a difference at least as large is 0.0002
  # Therefore, strong evidence against the null hypothesis