# Randomly swap variates of counties from 1982 with variates of the same county
# from 1992
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)

### Randomly swap units within two sub-populations where the two
### sub-populations are linked by the row number.
swapRandomly <- function(pop) {
  ## Pop is expected to be a list with a pop1 and a pop2 component (possibly of
  ## different numbers of rows) Extract the first sub-population and size
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  ## Same for the second sub-population
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  ## Now put these together into a single structure assumed to be matrix or
  ## data frame
  if (n_pop1 != n_pop2) 
    stop("the populations are not the same size")
  
  swap = sample(c("no", "yes"), n_pop1, replace = TRUE)
  
  mix <- rbind(pop1, pop2)
  ## Now sample without replacement to get the units to be in the first
  ## sub-population select4pop1 <- sample(1:(n_pop1 + n_pop2), n_pop1, replace
  ## = FALSE) Construct the first sub-population from the random selection
  new_pop1 <- pop1
  new_pop1[swap == "yes", ] <- pop2[swap == "yes", ]
  
  new_pop2 <- pop2
  new_pop2[swap == "yes", ] <- pop1[swap == "yes", ]
  
  ## Return the population with the sub-populations mixed
  list(pop1 = new_pop1, pop2 = new_pop2)
}


# Quantity of interest is the number of acres decoted to farmland
# Question: has the average number of acres changed over the years?
pop <- list(pop1 = agpop[agpop$region == "NC", c("county", "acres82")], 
            pop2 = agpop[agpop$region == "NC", c("county", "acres92")])

# Create a discrepancy measure for acres
getAveDiffsFn <- function(variate) {
  function(pop) {
    mean(pop$pop1[, variate]) - mean(pop$pop2[, variate])
  }
}

diffAveAcres <- getAveDiffsFn("acres")
rbind(names(pop$pop1), names(pop$pop2))

# Use the same name for both populations and change the scale
names(pop$pop1)[2] = "acres"
names(pop$pop2)[2] = "acres"
pop$pop1$acres = pop$pop1$acres/10^6
pop$pop2$acres = pop$pop2$acres/10^6

diffAveAcres(pop)

# Compare the sub-populations numerically
temp = rbind(summary(pop[[1]]$acres), summary(pop[[2]]$acres))
dimnames(temp)[[1]] = c("Number of Acres in 1982", "Number of Acres in 1992")
round(temp, 3)

# Since the same counties are in both sub-populations, look at the following plots:
# Notice that there's a slight difference between the years
par(mfrow = c(1, 3))
plot(pop[[1]]$acres, pop[[2]]$acres, col = adjustcolor("black", 0.3), xlab = "Acres in  1982", 
     ylab = "Acres in  1992", xlim = c(0, 0.5), ylim = c(0, 0.5))
abline(a = 0, b = 1, col = 4)

random.set = sample(1:length(pop[[1]]$acres))
plot((pop[[2]]$acres - pop[[1]]$acres)[random.set], xlab = "County", ylab = "Difference in Acres")
abline(h = 0, col = 4)

hist(pop[[2]]$acres - pop[[1]]$acres, breaks = "FD", main = "Difference in Acres", 
     xlab = "")
abline(v = 0, col = 4)


# To compare these sub-populations, randomly swap years within each county
# to maintain the structure of the population
# But compare via random shuffling as well
swappedDiffAcres <- sapply(1:5000, FUN = function(...) {
  diffAveAcres(swapRandomly(pop))
})

par(mfrow = c(1, 2))
hist(swappedDiffAcres, breaks = "FD", prob = TRUE, main = "Randomly Swapped populations", 
     xlab = "difference in averages", col = "lightgrey", xlim = c(-1, 1) * 0.01)
abline(v = diffAveAcres(pop), col = "red", lwd = 2)
par(xpd = TRUE)

legend(6, 0.12, legend = ("Property\nCrime Rate\n2011 - 2015"), lwd = c(2), 
       col = c("red"), cex = 0.9, bty = "n")

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

mixedDiffAcres <- sapply(1:5000, FUN = function(...) {
  diffAveAcres(mixRandomly(pop))
})

hist(mixedDiffAcres, breaks = "FD", main = "Randomly Mixed or Shuffled Populations", 
     xlab = "difference in averages", col = "lightgrey")
abline(v = diffAveAcres(pop), col = "red", lwd = 2)