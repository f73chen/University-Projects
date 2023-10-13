set.seed(341)
pop5 = round(rnorm(5), 2)
pop5 = sort(pop5)
pop5

# Suppose take sample of n=2 from population N=5
sam2 = combn(5, 2)
colnames(sam2) = paste("S", 1:10, sep="")
sam2

# Sample averages for all possible samples:
sam.avg <- apply(sam2, MARGIN=2, FUN=function(s) {
  mean(pop5[s])
})
round(sam.avg, 3)

# Sampling design d1 --> each sample selected with equal probability (1/10)
# Sampling design d2 --> different samples have random different probabilities
d1 = rep(1/10, 10)
d2 = 2 * (abs(apply(sam2, 2, diff)) - 1)
d2 = d2 / sum(d2)
designs = rbind(d1, d2)
colnames(designs) = paste("S", 1:10, sep="")
round(designs, 2)

# Sampling bias, variance, and MSE associated with both designs:
exp1 = sum(sam.avg * d1)
exp2 = sum(sam.avg * d2)

sam.bias = c(exp1, exp2) - mean(pop5)

sam.var = c(sum((sam.avg - exp1)^2 * d1), sum((sam.avg - exp2)^2 * d2))

designs.MSE = rbind(sam.bias, sam.var, MSE=sam.var+sam.bias^2)
colnames(designs.MSE) = c("d1", "d2")
round(designs.MSE, 3)

# Get the marginal inclusion probabilities for each unit
# and the joint inclusion probabilities for each possible pair
inSample <- function(sam, N) {
  inSam = numeric(N)  # inSam is a vector of size N
  inSam[sam] = 1
  inSam
}

pop5sam2.units = combn(5, 2, inSample, N=5)
rownames(pop5sam2.units) = paste("unit", 1:5, sep="")
colnames(pop5sam2.units) = paste("S", 1:10, sep="")
pop5sam2.units

# For each unit, add p(S) for each sample it appears in to get pu -->
# the inclusion probabilities for the d2 design
weighted.sum <- function(x, w) {
  sum(x * w)
}
pi2 = apply(pop5sam2.units, 1, weighted.sum, w=d2)
pi2

# To get the joint inclusion probabilities for d2, sum p(S) over all samples
# that contain the pair of interest
# For every sample, determine pairs of units in the sample
# Returns square matrix NxN where values at ii, ij, ji, jj = 1
inSample2 <- function(sam, N) {
  inSam = numeric(N)
  inSam[sam] = 1
  inSam = outer(inSam, inSam)
  inSam
}

# Generate a 5x5x10 tensor
jsample.incl = combn(5, 2, FUN=inSample2, N=5)
dimnames(jsample.incl) = list(paste("unit", 1:5, sep=""), 
                              paste("unit", 1:5, sep=""),
                              paste("S", 1:10, sep=""))
jsample.incl[, , 1:3]

# For each pair, add up p(S) for each sample they appear together to get puv
pij2 = apply(jsample.incl, c(1, 2), weighted.sum, w=d2)
pij2

# Use inclusion probabilities to make the estimator unbiased
# Where sam2 is all 10 possible combinations of 5 choose 2
# aHT(S) = SUM[u E S] ((1/piu)*(yu/5)) = 1/5 SUM[u E S] (yu/piu)
sam.HT = apply(sam2, 2, function(s, x, wt) {
  sum(x[s] / wt[s])
}, x=pop5, wt=pi2) / 5
sam.HT

# The sampling bias is SUM[S E Ps] ((aHT(s) - a(P)) * p(S))
sum((sam.HT - mean(pop5)) * d2)

# The sampling variance is SUM[S E Ps] ((aHT(s) - E[aHT(s)]) ^ 2) * p(S)
sum((sam.HT - sum(sam.HT * d2))^2 * d2)

##                  bias samp.var    MSE
## Design 1, Averge 0.00   0.2669 0.2669
## Design 2, Averge 0.02   0.0489 0.0493
## Design 2, HT     0.00   0.0643 0.0643