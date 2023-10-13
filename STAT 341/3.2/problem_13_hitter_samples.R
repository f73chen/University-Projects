library(ISLR)
data("Hitters")
C_Hitters <- na.omit(Hitters)

# Only select designated hitters with putouts
rownames(C_Hitters)[C_Hitters$PutOuts == 0]
R_Hitters = C_Hitters[C_Hitters$PutOuts > 0,]

# Save the ratio of PutOuts to Hits
# Find the value of alpha which makes skewness = 0
ratio.variable = R_Hitters$PutOuts / R_Hitters$Hits
ratioSkew = createSkewFunction(ratio.variable)
ratio.alpha = uniroot(ratioSkew, interval=c(-1, 1))$root;
ratio.alpha

# Using alpha, construct a transformed variable then standardize it
trans.ratio = powerfun(ratio.variable, ratio.alpha)
st.ratio = (trans.ratio - mean(trans.ratio)) / sdn(trans.ratio)

# Check that the new variable is standardized
c(mean(st.ratio), sdn(st.ratio), skew(st.ratio))

# Construct a historam of the transformed and standardized variable
# Note: the histogram has three modes
# Since the ratio represents defence/offence, peaks are defensive, balanced, and offensive players
hist(st.ratio, breaks=seq(-4, 5, 0.15), main="Transformed and Standardized Variable", xlab="")

# In the new variable, the average and median are equal
# For sample sizes n = 10, 20, 30, ..., 100, generate 10,000 samples and find mean & median
# Summarize the sampling properties of the mean and median using bias, stdev, and rmse
sim.avg.mean <- function(pop=NULL, n=NULL, m=10^4){
  N = length(pop);
  set.seed(341)
  temp = unlist(Map(function(rep) {
                      sam.values = pop[sample(N, n, replace=FALSE)]
                      c(mean(sam.values), median(sam.values))},
                    1:m))
  
  temp = matrix(temp, nrow=m, ncol=2, byrow=TRUE)
  temp = c(apply(temp, 2, mean) - c(mean(pop), median(pop)), apply(temp, 2, sd))
  result = c(temp, temp[1]^2 + temp[3]^2, temp[2]^2 + temp[4]^2)
  return(result)
}

# Where SB = sampling bias, SD = sampling stdev
n.set = seq(10, 100, by=10)
result = matrix(nrow = length(n.set), ncol=6,
                dimnames = list(n.set, c("Avg. SB", "Median SB", "Avg. SD",
                                         "Median SD", "Avg. MSE", "Median MSE")))
for (i in 1:length(n.set)){
  result[i,] = sim.avg.mean(st.ratio, n=n.set[i])
}
round(result, 4)

# Median performs better than mean because its MSE is consistently smaller
# Plot mean in black, median in blue
par(mfrow=c(1,3),oma=c(0,0,0,0))
plot( result[,1]~n.set, main="Sampling Bias", type='l', ylim=range(result[,1:2]),
      ylab="Sampling Bias", xlab="Sample Size" ,cex.lab=1.5 , cex.axis=1.5)
lines( result[,2]~n.set, col=4)
abline(h=0, lty=2, col="grey")

plot(result[,3]~n.set, main="Sampling Standard Deviation", type='l', ylim=c(0,max(result[,3:4]) ), xlab="Sample Size", 
     ylab="Sampling Standard Deviation",cex.lab=1.5 , cex.axis=1.5)
lines( result[,4]~n.set, col=4)

plot( result[,5]~n.set, main="Sampling MSE", type='l', 
      ylim=c(0,max(result[,5:6]) ), xlab="Sample Size", ylab="Sampling MSE",
      cex.lab=1.5 , cex.axis=1.5)
lines( result[,6]~n.set, col=4)