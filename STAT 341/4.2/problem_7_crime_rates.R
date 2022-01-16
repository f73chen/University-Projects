filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "Crime_Safety_2010-2014.csv", sep="/")
crime <- read.csv(filename, header=TRUE)

# Focus on:
  # Neighbourhood
  # prop11 - property crime rate per 1000 residents in 2011
  # prop14 - property crime rate per 1000 residents in 2014
# Find evidence for whether the average crime rate from 2014 is smaller than the average from 2011
set.seed(341)
names(crime)[c(1,12,15)]


# a. Use the function swapRandomly: randomly decide whether or not to swap the
# ith entry of P1 and P2 for all i
### Randomly swap units within two sub-populations 
### where the two sub-populations are linked by 
### the row number. 
swapRandomly <- function(pop) {
  ## Pop is expected to be a list with a pop1 and a pop2 component
  ## (possibly of different numbers of rows)
  ## 
  ## Extract the first sub-population and size
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  ## Same for the second sub-population
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  ## Now put these together into a single structure
  ## assumed to be matrix or data frame
  if (n_pop1 != n_pop2) stop("the populations are not the same size")
  
  swap = sample(c("no", "yes"), n_pop1, replace=TRUE)
  
  mix <- rbind(pop1,pop2)
  ## Now sample without replacement to get
  ## the units to be in the first sub-population
  #select4pop1 <- sample(1:(n_pop1 + n_pop2),
  #                   n_pop1,
  #                   replace = FALSE)
  ## Construct the first sub-population from the random selection
  new_pop1 <- pop1
  new_pop1[swap == "yes", ] <- pop2[swap == "yes",]
  
  new_pop2 <- pop2
  new_pop2[swap == "yes", ] <- pop1[swap == "yes",]
  
  ## Return the population with the sub-populations mixed
  list(pop1=new_pop1, pop2=new_pop2)
}



# b. Using the functions swapRandomly and getAveDiffsFn, compare the average property
# crime rate per 1000 residents from 2011 and 2014 using randomly swapped pairs
# of sub-populations
  # Compare the rates for m=5000 shuffled pairs of sub-populations and hist
  # Comment on how a Gaussian distribution can approximate the histogram
  # Interpret the significance level obtained from the shuffled pairs of sub-populations
getAveDiffsFn <- function(variate) {
  function(pop) {mean(pop$pop1[, variate]) - mean(pop$pop2[,variate])}
}
diffAvePropCrimeRate <- getAveDiffsFn("prop")

pop <- list(pop1 = crime[, c(1,12)],
            pop2 = crime[, c(1,15)])

names(pop$pop1)[2] = "prop"
names(pop$pop2)[2] = "prop"
diffAvePropCrimeRate(pop)diffRate <- sapply(1:5000, FUN = function(...){ 
  diffAvePropCrimeRate(swapRandomly(pop)) 
})

hist(diffRate, breaks="FD", prob=TRUE,
     main = "Randomly Swapped populations", xlab="difference in averages",
     col="lightgrey", xlim=c(-8,10))
abline(v=diffAvePropCrimeRate(pop), col = "red", lwd=2)
par(xpd=TRUE)

legend(6, 0.12, legend=("Property\nCrime Rate\n2011 - 2015"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

# Significance level:
SL.avg = mean( diffRate >= diffAvePropCrimeRate(pop))
SL.avg

# Approximate confidence interval for the significance:
round(SL.avg + c(-1,1)*2*sqrt(SL.avg*(1-SL.avg)/5000),3)

# There is some evidence against the null hypothesis
# But not at the 5% level because the confidence interval goes above 0.05
# Bimodal distribution, so Gaussian would be a bad fit



# c. Plot the influence on the discrepancy measure by Neighbourhood
# Neighbourhood 14 has the largest influence (Downtown)
influence = sapply( 1:56, function(i) {
  tpop <- list(pop1 = pop$pop1[-i,],
               pop2 = pop$pop2[-i,])
  names(tpop$pop1)[2] = "prop"
  names(tpop$pop2)[2] = "prop"
  diffAvePropCrimeRate(pop) - diffAvePropCrimeRate(tpop) 
} )
plot(influence, pch=19, xlab="Neighborhood")



# d. Repeat part b), but with the most influential neighbourhood removed
pop14 <- list(pop1 = crime[-14, c(1,12)],
              pop2 = crime[-14, c(1,15)])

names(pop14$pop1)[2] = "prop"
names(pop14$pop2)[2] = "prop"
diffAvePropCrimeRate(pop14)

diffRate14 <- sapply(1:5000, FUN = function(...){ 
  diffAvePropCrimeRate(swapRandomly(pop14)) 
})

hist(diffRate14, breaks="FD", prob=TRUE,
     main = "Randomly Swapped populations", xlab="difference in averages",
     col="lightgrey", xlim=c(-8,10))
abline(v=diffAvePropCrimeRate(pop14), col = "red", lwd=2)
par(xpd=TRUE)

legend(6, 0.12, legend=("Property\nCrime Rate\n2011 - 2015"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

xseq = seq(-5,5, length.out=100)
lines(xseq, dnorm(xseq, sd=sd(diffRate14)))

# Significance level and confidence interval:
# Now there is only weak evidence against the two years having similar crime rates
SL14.avg = mean(diffRate14 >= diffAvePropCrimeRate(pop14))
round(SL14.avg + c(-1,1)*2*sqrt(SL14.avg*(1-SL14.avg)/5000),3)




# e. Use the t-like discrepancy measure for differences in averages
# Remove the most influential neighbourhood and use getDiscrepancyFn as the measure
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
    t <- (m1 - m2) / sqrt(v * ( (1/n1) + (1/n2) ) )
    ## Return the t-value
    t
  }
}

tStatCrime14 <- getDiscrepancyFn("prop")

tStatRate14 <- sapply(1:5000, FUN = function(...){ 
  tStatCrime14(swapRandomly(pop14)) 
})

hist( tStatRate14, breaks="FD", prob=TRUE,
      main = "Randomly Swapped populations", xlab="t-like statistic",
      col="lightgrey")
abline(v=tStatCrime14(pop14), col = "red", lwd=2)
par(xpd=TRUE)
legend(2, 0.3, legend=("Property\nCrime Rate\n2011 - 2015"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

x=seq(-4,4,length.out=100)
lines(x, dnorm(x, sd=sd(tStatRate14)), col=adjustcolor("navyblue", 0.8), lwd=2)

# Significance level and confidence interval:
SLt14.avg = mean(tStatRate14 >= tStatCrime14(pop14))
round(SLt14.avg + c(-1,1)*2*sqrt(SLt14.avg*(1-SLt14.avg)/5000),3)




# f. The t-like discrepancy measures for differences in averages assumes that
# the two populations are independent, which is not the case
# Instead, use a paired t-like discrepancy measure which uses
# y1_bar - y2_bar = d_bar
# D(P1, P2) = d_bar / SD(a(Pd)) = d_bar / (SD(Pd) / sqrt(n))

# i. Create the function getDiscrepancyFnDiff which returns a function that
# calculates the discrepancy measure for two sub-populations
getDiscrepancyFnDiff <- function(var) {
  function(pop) {
    ## First sub-population
    pop1 <- pop$pop1
    n1   <- nrow(pop1)
    y1   <- pop1[, var]
    
    ## Second sub-population
    pop2 <- pop$pop2
    n2   <- nrow(pop2)
    y2   <- pop2[, var]
    
    d = y1-y2
    
    ## Determine the t-statistic
    t <- mean(d) / sqrt( var(d)/n1  )
    ## Return the t-value
    t
  }
}


# ii. With the most influential neighbourhood removed, repeat part b) and use
# getDiscrepancyFnDiff as the discrepancy measure
tDiffCrime14 <- getDiscrepancyFnDiff("prop")

tdiffRate14 <- sapply(1:5000, FUN = function(...){ 
  tDiffCrime14(swapRandomly(pop14)) 
})

hist( tdiffRate14, breaks="FD", prob=TRUE,
      main = "Randomly Swapped populations", xlab="t-like statistic",
      col="lightgrey")
abline(v=tDiffCrime14(pop14), col = "red", lwd=2)
par(xpd=TRUE)
legend(2, 0.3, legend=("Property\nCrime Rate\n2011 - 2015"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

x=seq(-4,4,length.out=100)
lines(x, dnorm(x), col=adjustcolor("navyblue", 0.8), lwd=2)

# Significance level and confidence interval:
SLtd14.avg = mean( tdiffRate14 >= tDiffCrime14(pop14) )
SLtd14.avg
round(SLtd14.avg + c(-1,1)*2*sqrt(SLtd14.avg*(1-SLtd14.avg)/5000),3)



# g. Summary

# i. Comment on the Gaussian approximation from d), e), and f)
# All three can be approximated by Gaussian, but only f) can be approximated
# with a standard Gaussian distribution

# ii. Use the Gaussian approximation in f) to calculate the significance level
pnorm( tDiffCrime14(pop14), lower.tail = FALSE)

# iii. Comment on the significance level found in d), e), and f)
# They were all roughly the same

# iv. What would you conclude from comparing b) and d)
# There is a decrease in the crime rate in Neighbourhood 14
# There is no or weak evidence in a decrease in the average crime rate in all
# neighbourhoods except downtown