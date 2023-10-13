filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "Marks.csv", sep="/")
Grades <- read.csv(filename, header=TRUE)

# a. Plot the empirical CDF of the grades for female students
# and impose on it the empirical CDF for male students
Final.Female = Grades$Final[Grades$Gender=="Female"]
Final.Male = Grades$Final[Grades$Gender=="Male"]

pop = list(pop1 = Final.Female , pop2 = Final.Male)
qvals <- sort(pop$pop1)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch = 19, col=adjustcolor("black", alpha = 0.5), 
     xlim=c(0,1), ylim=extendrange(range(Final.Female)),
     xlab = "Proportion p", 
     ylab = "Quantiles Q_y(p)",  
     main = "Final Exam Male/Female Students")

qvals <- sort(pop$pop2)
pvals <- ppoints(length(qvals))
points(pvals, qvals, pch = 19, col=adjustcolor("red", alpha = 0.5) )



# b. Generate the histograms of the four discrepancy measures based on 5000 shuffled sub-populations
# P1: female students, P2: male students
# Superimpose on the histograms the observed discrepancy measure and comment
mixRandomly <- function(pop) {
  pop1 <- pop$pop1
  n_pop1 <- length(pop1)
  
  pop2 <- pop$pop2
  n_pop2 <- length(pop2)
  
  mix <- c(pop1,pop2)
  select4pop1 <- sample(1:(n_pop1 + n_pop2),
                        n_pop1,
                        replace = FALSE)
  
  new_pop1 = mix[select4pop1]  
  new_pop2 = mix[-select4pop1]
  list(pop1=new_pop1, pop2=new_pop2)
}

# i. D = (y1_bar - y2_bar) / [pooled_stdev * sqrt(1/n1 + 1/n2)]
D1Fn <- function(pop) {
  ## First sub-population
  pop1 <- pop$pop1
  n1 <- length(pop1)
  m1 <- mean(pop1)
  v1 <- var(pop1)
  
  ## Second sub-population
  pop2 <- pop$pop2
  n2 <- length(pop2)
  m2 <- mean(pop2)
  v2 <- var(pop2)
  
  ## Pool the variances
  v <- ((n1 - 1) * v1 + (n2 - 1) * v2)/(n1 + n2 - 2)
  
  ## Determine the t-statistic
  temp <- (m1 - m2) / sqrt(v * ( (1/n1) + (1/n2) ) )
  
  ## Return the t-value
  temp
}

# ii. (median(P1) - median(P2)) / IQR(P)
# Where IQR(P) is of the super-population: the union of P1 and P2
D2Fn <- function(pop) {
  ## First sub-population
  pop1 <- pop$pop1
  m1 <- median(pop1)
  
  ## Second sub-population
  pop2 <- pop$pop2
  m2 <- median(pop2)
  
  ## pooles IQR based on the super-population
  IQR.P <- IQR(c(pop1,pop1))
  
  ## Determine the test statistic
  temp <- (m1 - m2) /  IQR.P
  
  ## Return the t-value
  temp
}

# iii. SD(P1) / SD(P2) - 1
D3Fn <- function(pop) {
  ## First sub-population
  pop1 <- pop$pop1
  n1 = length(pop1)
  SD1 <- sqrt(var(pop1)*(n1-1)/n1)
  
  ## Second sub-population
  pop2 <- pop$pop2
  n2 = length(pop2)
  SD2 <- sqrt(var(pop2)*(n2-1)/n2)
  
  ## Determine the test statistic
  temp <- SD1/SD2 - 1
  
  ## Return the t-value
  temp
}

# iv. IQR(P1) / IQR(P2) - 1
D4Fn <- function(pop) {
  ## First sub-population
  pop1 <- pop$pop1
  IQR1 <- IQR(pop1)
  
  ## Second sub-population
  pop2 <- pop$pop2
  IQR2 <- IQR(pop2)
  
  ## Determine the test statistic
  temp <- IQR1/IQR2 - 1
  
  ## Return the t-value
  temp
}


# Produce the histograms
par(mfrow = c(2,2))

# Plot for D1
D1Vals <- sapply(1:5000, FUN = function(...){D1Fn(mixRandomly(pop))})
hist(D1Vals, breaks=40, probability = TRUE, 
     main = "Permuted populations", xlab="D1 statistic",
     col="lightgrey")
abline(v=D1Fn(pop), col = "red", lwd=2)

#Plot for D2
D2Vals <- sapply(1:5000, FUN = function(...){D2Fn(mixRandomly(pop))})
hist(D2Vals, breaks=40, probability = TRUE, 
     main = "Permuted populations", xlab="D2 statistic",
     col="lightgrey")
abline(v=D2Fn(pop), col = "red", lwd=2)

#Plot for D3
D3Vals <- sapply(1:5000, FUN = function(...){D3Fn(mixRandomly(pop))})
hist(D3Vals, breaks=40, probability = TRUE, 
     main = "Permuted populations", xlab="D3 statistic",
     col="lightgrey")
abline(v=D3Fn(pop), col = "red", lwd=2)

#Plot for D4
D4Vals <- sapply(1:5000, FUN = function(...){D4Fn(mixRandomly(pop))})
hist(D4Vals, breaks=40, probability = TRUE, 
     main = "Permuted populations", xlab="D4 statistic",
     col="lightgrey")
abline(v=D4Fn(pop), col = "red", lwd=2)

# Therefore, the sub-populations might be a random mix when it comes to spread
# But are distinct populations when it comes to location



# c. Use D1 from b. to find the significance level
# Since small, there is strong evidence against H0
d1obs = D1Fn(pop) 
mean(abs(D1Vals) >= abs(d1obs) )



# d. Simultaneously, using all 4 measures, perform a multiple test to compare
# Report the significance level and interpret it

# pop is a list whose two members are two sub-populations
# discrepancies is a list whose K members are K discrepancy measures: D1,...,Dk
calculateSLmulti <- function(pop, discrepancies, B_outer = 1000, B_inner){
  if (missing(B_inner)) B_inner <- B_outer
  ## Local function to calculate the significance levels
  ## over the discrepancies and return their minimum
  
  getSLmin <- function(basePop, discrepanies, B) {
    observedVals <- sapply(discrepancies, 
                           FUN = function(discrepancy) {discrepancy(basePop)})
    
    K <- length(discrepancies)
    total <- Reduce(function(counts, i){
      #mixRandomly mixes the two populations randomly, 
      #so the new sub-populations are indistinguishable
      NewPop <- mixRandomly(basePop)
      
      ## calculate the discrepancy and counts
      Map(function(k) {
        Dk <- discrepancies[[k]](NewPop)
        if (Dk >= observedVals[k]) counts[k] <<- counts[k] +1 },
        1:K) 
      counts
    }, 
    1:B, init = numeric(length=K)) 
    SLs <- total/B
    min(SLs)
  }
  
  SLmin <- getSLmin(pop, discrepancies, B_inner)
  total <- Reduce(function(count, b){
    basePop <- mixRandomly(pop)
    if (getSLmin(basePop, discrepancies, B_inner) <= SLmin) count + 1 else count
  },   1:B_outer, init = 0)
  
  SLstar <- total/B_outer
  SLstar
}
discrepancies <- list(D1Fn , D2Fn , D3Fn , D4Fn)

### The following takes a long time (about 20 minutes)
### for B_outer = B_inner = 1,000 say
### So for illustration much smaller values than would be sensible are
### used here
set.seed(341)
SLstar=calculateSLmulti(pop, discrepancies, B_outer = 300, B_inner=300)
SLstar

# The significance level is small (0.02), so there is evidence against H0
# Conclude that the two sub-populations are indeed different