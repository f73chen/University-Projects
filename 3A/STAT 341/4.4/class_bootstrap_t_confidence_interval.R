filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# A function to put n or N in the denominator of SD
# rather than n-1 or N-1
sdn <- function( y.pop ) { 
  N = length(y.pop)
  sqrt( var(y.pop)*(N-1)/(N)  )    } 

se.avg <- function(y.sam) {
  sdn(y.sam)/sqrt(length(y.sam)) * sqrt((65-length(y.sam))/(65-1) )
}

popSize <- function(pop) {
  if (is.vector(pop))
  {if (is.logical(pop)) 
    ## then assume TRUE values identify units
    sum(pop) else length(pop)}
  else nrow(pop)
}

getSample <- function(pop, size, replace=FALSE) {
  N <- popSize(pop)
  pop[sample(1:N, size, replace = replace)]
}

M <- 10^4
n = 6
set.seed(341)
samples <- sapply(1:M, FUN =function(m)  sample(popSharks, n, replace = FALSE) )

avePop <- mean(sharks[, "Length"])
avesSamp <- apply(samples, MARGIN = 2, 
                  FUN = function(s){mean(sharks[s,"Length"])})

SEaveSamp <- apply(samples, MARGIN = 2, 
                   FUN = function(s){se.avg(sharks[s,"Length"])})

ZPop <- (avesSamp - mean(sharks[,"Length"]))/SEaveSamp

brk = seq(-50,50, by=0.25)
hist(ZPop, freq = FALSE, breaks = brk, col = adjustcolor("grey", 0.5),
     main = paste("Sampling Distribution \n n=", n),
     xlab = "Z", xlim=c(-4,4), ylim=c(0, .4) )
lines(x = seq(-4,4,0.1), y = dt(x = seq(-4,4,0.1), df = n-1), col = "blue", lwd = 2)



# Compare the sampling distribution to the bootstrap estimate for the average
n = 6
M <- 10^4

samSharks <- sample(popSharks, n, replace = FALSE) 
samStar <- sapply(1:M, FUN =function(m)  sample(samSharks, n, replace = TRUE) )
aveSam <- mean(sharks[samSharks, "Length"])
avesBoot <- apply(samStar, MARGIN = 2, 
                  FUN = function(s){mean(sharks[s,"Length"])})
SEaveBoot <- apply(samStar, MARGIN = 2, 
                   FUN = function(s){se.avg(sharks[s,"Length"]) })
ZBoot <- (avesBoot - aveSam)/SEaveBoot

# Plot and compare the two approaches
savePar <- par(mfrow=c(1,3))

brk = seq(-60,60, by=0.25)
hist(ZPop, freq = FALSE, breaks = brk, col = adjustcolor("grey", 0.5),
     main = paste("Sampling Distribution \n n=", n),
     xlab = "Z", xlim=c(-4,4), ylim=c(0, .5) )
lines(x = seq(-4,4,0.1), y = dt(x = seq(-4,4,0.1), df = n-1), col = "blue", lwd = 2)

hist(ZBoot, freq = FALSE, breaks = brk, col = adjustcolor("grey", 0.5),
     main = paste("Sampling Distribution \n Bootstrap Estimate n=", n),
     xlab = "Z", xlim=c(-4,4), ylim=c(0, .5) )

plot( ecdf(ZBoot), xlim=c(-4,4), col = "red", 
      main ="Compare ECDF", xlab="Z", ylab = "F(z)" )
lines( ecdf(ZPop), col = "blue")



# A bootstrap-t CI using SD^[a~(S)] for the average shark length is:
samSharksLengths = sharks[samSharks, "Length"]
zStar.lower = quantile(ZBoot, 0.025 ) 
zStar.upper = quantile(ZBoot, 0.975 ) 
round(mean(samSharksLengths) - c(zStar.upper, zStar.lower)*se.avg(samSharksLengths),2)

# A bootstrap-t CI using SD^*[a~(S)] for the average shark length is:
round(mean(samSharksLengths) - quantile(ZBoot, c(0.975, 0.025) )*sd(avesBoot),2)
