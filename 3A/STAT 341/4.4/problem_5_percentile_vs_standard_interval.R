filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)

agpop92 = agpop[,c('county', 'acres87', 'acres92')]
agpop92[agpop92 == -99] = NA
agpop92  = na.omit(agpop92)
N = nrow(agpop92)

# Suppose we obtain the following sample
y = agpop92$acres92
set.seed(341)
ysam = sample(y, size=20)
ysam

# Using B=10,000 bootstrap samples, construct a 95% CI using the percentile
# and the standard bootstrap interval for the following attributes:
  # 1. Total number of acres in 1992
  # 2. Variance in the number of acres in 1992
  # 3. STDEV in the number of acres in 1992

# Define bootstrap samples and summary function
B = 10^4

Boot.samples <- matrix(
  sample(ysam, B*length(ysam), replace=TRUE),
  nrow=B, ncol=length(ysam) )

bootstrap.CIs <- function(boot.estimates, sam.est) {
  total.tab = matrix(0, 2, 2)
  rownames(total.tab) = c("Percentile Interval", "Standard Interval")
  colnames(total.tab) = c("Lower", "Upper")
  
  # percentile interval
  total.tab[1,] <- quantile(boot.estimates, probs=c(0.025, 0.975))
  total.tab[2,] <- sam.est + c(-1, 1) * 1.96 * sd(boot.estimates)
  total.tab
}

# 1. Total number of acres in 1992
boot.total.est <- apply(Boot.samples, 1, 
                        function(boot.sam) { 
                          3044*mean(boot.sam)
                        })
bootstrap.CIs(boot.total.est, 3044*mean(ysam))

# 2. Variance in the number of acres in 1992
boot.var.est <- apply(Boot.samples, 1, var)
round(bootstrap.CIs(boot.var.est, var(ysam)),2)

# 3. STDEV in the number of acres in 1992
boot.sd.est <- apply(Boot.samples, 1, sd)
round(bootstrap.CIs(boot.sd.est, sd(ysam)),2)