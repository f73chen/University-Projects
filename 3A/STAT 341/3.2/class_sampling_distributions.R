# Compare two different ways of defining p(S) for S E Ps
# Select S on the basis of bias, variance, and MSE

# Suppose that population P consists of 5 units
set.seed(341)
pop5 = round(rnorm(5), 2)
pop5 = sort(pop5)
pop5

# All possible samples of size two
sam2 = combn(5, 2)
colnames(sam2) = paste("S", 1:10, sep="")
sam2

# Find mean of all (N choose n) samples
sam.avg <- apply(sam2, MARGIN=2, FUN=function(s) {
  mean(pop5[s])
})
round(sam.avg, 3)

# Consider two sampling designs:
# d1. each sample is selected from the 10 possible samples with equal probability
# d2. different samples have different probabilities of being selected
d1 = rep(1/10, 10)
d2 = 2 * (abs(apply(sam2, 2, diff)) - 1)
d2 = d2 / sum(d2)
designs = rbind(d1, d2)
colnames(designs) = paste("S", 1:10, sep="")
round(designs, 2)

# The distribution of the attribute (ex. mean) induced by the sampling design is:
# Pr(A=ai)
# Note that the distribution of the attribute with respect to design d2 is more concentrated
avg.ord = order(sam.avg)

par(mfrow=c(2, 2), oma=c(0, 0, 0, 0))
plot(sam.avg[avg.ord], d1[avg.ord], xlab = "Attribute Value (a)", ylab = "Pr(A=a)", 
     pch = 19, main = "d1 Sampling Design")
plot(sam.avg[avg.ord], d2[avg.ord], xlab = "Attribute Value (a)", ylab = "Pr(A=a)", 
     pch = 19, col = 2, main = "d2 Sampling Design")

plot(sam.avg[avg.ord], cumsum(d1[avg.ord]), xlab = "Attribute Value (a)", ylab = expression("Pr(A" <= 
                                                                                              "a)"), pch = 19, type = "s", ylim = c(0, 1))
plot(sam.avg[avg.ord], cumsum(d2[avg.ord]), xlab = "Attribute Value (a)", ylab = expression("Pr(A" <= 
                                                                                              "a)"), pch = 19, col = 2, type = "s", ylim = c(0, 1))

# Evaluate the sampling error associated with the attribute with respect to both designs
# 1. Sampling bias
exp1 = sum(sam.avg * d1)
exp2 = sum(sam.avg * d2)
sam.bias = c(exp1, exp2) - mean(pop5)
round(sam.bias, 5)

# 2. Sampling Variance
sam.var = c(sum((sam.avg - exp1)^2 * d1), sum((sam.avg - exp2)^2 * d2))
round(sam.var, 5)

# 3. Sampling MSE
sam.MSE = sam.var + sam.bias^2
round(sam.MSE, 5)

# Alternative MSE calculation
MSE = c(sum((sam.avg - mean(pop5))^2 * d1), sum((sam.avg - mean(pop5))^2 * d2))
round(MSE, 5)