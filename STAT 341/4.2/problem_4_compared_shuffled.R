filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "feh.csv", sep="/")
head(feh)

# Compare sub-populations from Blue Lance and Red Sword
feh$protection = feh[,"RES"]  
pop <- list(pop1 = feh[feh[,"Type"] == "Blue Lance", ],
            pop2 = feh[feh[,"Type"] == "Red Sword", ])
Map( function(popi) { summary(popi$protection ) }, pop)


# a. Construct a quantile plot of RES from Blue Lance and Red Sword units
par(mfrow=c(1,3),oma=c(0,0,2,0))

qvals <- sort(pop[[1]]$protection)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("navyblue", alpha = 0.5), 
     xlim=c(0,1), ylim=extendrange(range(feh$protection)),
     xlab = "Proportion p", 
     ylab = "Quantiles Q_y(p)",  
     main = "Blue Lance")

qvals <- sort(pop[[2]]$protection)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("red", alpha = 0.5), 
     xlim=c(0,1), ylim=extendrange(range(feh$protection)),
     xlab = "Proportion p", 
     ylab = "Quantiles Q_y(p)",  
     main = "Red Sword ")

qvals <- sort(pop[[1]]$protection)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("navyblue", alpha = 0.5), 
     xlim=c(0,1), ylim=extendrange(range(feh$protection)),
     xlab = "Proportion p", 
     ylab = "Quantiles Q_y(p)",  
     main = "Blue/Red Units ")
qvals <- sort(pop[[2]]$protection)
pvals <- ppoints(length(qvals))
points(pvals, qvals, pch = 19, col=adjustcolor("red", alpha = 0.5) )


# b. Using the difference in averages as a discrepancy measure, construct a histogram 
# of the discrepancy calculated on m=1000 randomly shuffled populations and
# indicate the discrepancy calculated on the observed populations
mixRandomly <- function(pop) {
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  
  mix <- rbind(pop1,pop2)
  select4pop1 <- sample(1:(n_pop1 + n_pop2),
                        n_pop1,
                        replace = FALSE)
  
  new_pop1 <- mix[select4pop1,]  
  new_pop2 <- mix[-select4pop1,]
  list(pop1=new_pop1, pop2=new_pop2)
}

# The original discrepancy measure
getAveDiffsFn <- function(variate) {
  function(pop) {mean(pop$pop1[, variate]) - mean(pop$pop2[,variate])}
}
diffAveRES <- getAveDiffsFn("RES")

# The discrepancy on shuffled populations
set.seed(341)
diffRate <- sapply(1:1000, FUN = function(...){ 
  diffAveRES(mixRandomly(pop)) 
})

# Plot the results
hist(diffRate, breaks="FD", prob=TRUE,
     main = "Randomly Mixed Populations", xlab="difference in averages",
     col="lightgrey", xlim=c(-8,10))
abline(v=diffAveRES(pop), col = "red", lwd=2)

legend(5, 0.2, legend=("Resistance \nBlue - Red\nUnits"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

# Estimate the significance level
# Low significance means high discrepancy
diff.avgSL = mean( abs(diffRate) >= diffAveRES(pop) )
diff.avgSL



# c. Using the t-like discrepancy measure, construct a histogram of the measure
# calculated on m=1000 shuffled populations and indicate the original measure
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

# Construct the discrepancy measure and compute them
tStatRES <- getDiscrepancyFn("RES")
set.seed(341)
tStatRandomRES <- sapply(1:1000, FUN = function(...) { 
  tStatRES(mixRandomly(pop))
})

# Plot
hist( tStatRandomRES, breaks="FD", prob=TRUE,
      main = "Randomly Mixed Population", xlab="t-like statistic",
      col="lightgrey")
abline(v=tStatRES(pop), col = "red", lwd=2)

x=seq(-4,4,length.out=100)
lines(x, dnorm(x, sd=sd(tStatRandomRES)), 
      col=adjustcolor("navyblue", 0.8), lwd=2)

par(xpd=TRUE)
legend(2, 0.3, legend=("Resistance \nBlue - Red\nUnits"), 
       lwd = c(2), col = c("red"), cex=0.9, bty = 'n')

# Estimate the significance level
diff.avgSLt = mean( abs(tStatRandomRES) >= tStatRES(pop) )
diff.avgSLt



# d. Want evidence for whether Blue Lance and Red Sword have different average RES
  # i. Give an estimate of the significance level using:
# The t-like discrepancy measure and a t-distribution approximation
hist( tStatRandomRES, breaks="FD", prob=TRUE, col="lightgrey",
      main = "Randomly Mixed Population", xlab="t-like statistic")
abline(v=tStatRES(pop), col = "red", lwd=2)

x=seq(-4,4,length.out=100)
lines(x, dt(x, df=nrow(pop[[1]])+nrow(pop[[2]])-2), 
      col=adjustcolor("navyblue", 0.8), lwd=2)

2*pt(tStatRES(pop), df=nrow(pop[[1]])+nrow(pop[[2]])-2, lower.tail=F)

# The t-like discrepancy measure and a standard normal approximation
hist( tStatRandomRES, breaks="FD", prob=TRUE, col="lightgrey",
      main = "Randomly Mixed Population", xlab="t-like statistic")
abline(v=tStatRES(pop), col = "red", lwd=2)

x=seq(-4,4,length.out=100)
lines(x, dnorm(x), col=adjustcolor("navyblue", 0.8), lwd=2)

2*pnorm(tStatRES(pop), lower.tail=F)

  # ii. What would we conclude based on the estimated significance level
  # and the t-like discrepancy measure?
diff.tSL = mean( abs(tStatRandomRES) >= tStatRES(pop))
diff.tSL

round( diff.tSL + c(-1,1)*2*sqrt(diff.tSL*(1-diff.tSL)/1000), 3 )

# Therefore, there is some evidence against the hypothesis that the Blue Lance
# and Red Sword units are different than randomly allocated populations

# However, can't really conclude that there is sufficient evidence to reject
# the hypothesis that Blue Lance and Red Sword are different
# because the confidence interval is 0.041, 0.071



# e. Generate 1000 estimates of the significance level using m=1000
set.seed(341)
SL.1000 <- sapply(1:1000, FUN = function(i){
  rand.tstat = sapply(1:1000, FUN = function(z){ 
    tStatRES(mixRandomly(pop)) 
  })
  mean( abs(rand.tstat) >= tStatRES(pop))
})
write.csv(SL.1000, "SL1000.csv")

SL.1000 = read.csv("SL1000.csv")
SL.1000 = as.numeric(SL.1000[,2])

# i. Construct a histogram of the significance level
# and approximate it by a normal distribution
hist(SL.1000, breaks="FD", prob=TRUE,
     main="Histogram of the significance level")

SLseq = seq(min(SL.1000), max(SL.1000), length.out=100)
lines(SLseq, dnorm(SLseq, mean(SL.1000), sd(SL.1000) ))

# The overall estimate of the significance level is:
overall.SL = mean(SL.1000)
overall.SL

# A confidence interval using the overall estimate is:
# Therefore, there is evidence for the hypothesis that Blue Lance and Red Sword
# have different RES averages at the 5% significance level
overall.CI = overall.SL + c(-1,1)*2*sqrt( overall.SL *(1-overall.SL )/10^6)
round(overall.CI,4)

# iii. Assuming the overall average is close enough to the observed significance
# level, estimate the coverage probability of the signficiance levels using 1000 estimators
# Provide a confidence interval for the coverage probability

# Estimate of the coverage probability from the 1000 estimates:
contain.p0= sapply(SL.1000, function(p, p0=NULL) {
  CI.p = p + c(-1,1)*2*sqrt( p*(1-p)/1000 ) 
  ( CI.p[1] <= p0 ) & (p0 <= CI.p[2])
}, p0= overall.SL )
coverage.est = mean(contain.p0)

# Approximate confidence interval for the coverage probability
round(coverage.est + c(-1,1)*2*sqrt( coverage.est *(1-coverage.est )/1000),3)



# f. If interested in evidence that Blue Lance have higher RES on average than Red Sword
# Using the t-like discrepancy measure:
SLtgreater.RES = mean( tStatRandomRES >= tStatRES(pop))
SLtgreater.RES
round(SLtgreater.RES + c(-1,1)*2*sqrt(SLtgreater.RES*(1-SLtgreater.RES)/5000),3)