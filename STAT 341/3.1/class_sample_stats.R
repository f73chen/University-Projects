filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)

set.seed(341)
s = sample(length(agpop$farms87), 1000)

# Calculate differences in stats between sample and population
c(mean(agpop$farms87[s]) - mean(agpop$farms87),
  median(agpop$farms87[s]) - median(agpop$farms87),
  sd(agpop$farms87[s]) - sd(agpop$farms87),
  IQR(agpop$farms87[s]) - IQR(agpop$farms87))

# Compare differences between histograms
# COPIED
par(mfrow = c(1, 2))
hist(agpop$farms87[s], breaks = "FD", col = adjustcolor("grey", alpha = 0.5), 
     main = "Number of farms per county \n in 1987 - Sample", xlab = "number of farms", 
     prob = TRUE, xlim = c(0, 6000))
hist(agpop$farms87, breaks = "FD", col = adjustcolor("grey", alpha = 0.5), main = "Number of farms per county \n in 1987 - Population", 
     xlab = "number of farms", prob = TRUE, xlim = c(0, 6000))

