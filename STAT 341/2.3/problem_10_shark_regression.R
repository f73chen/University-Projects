filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
shark <- read.csv(filename, header=TRUE)

# Histogram of shark length
hist(shark$Length, xlab="Shark Length",
     breaks=seq(min(shark$Length), max(shark$Length), length.out=21))

# Draw the quantile plot
y = shark$Length
qvals <- sort(y)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch=19, col=adjustcolor("black", 0.5))

# Plot shark length against fatality
plot(shark$Length, shark$Fatality, 
     pch=19, col=adjustcolor("black", 0.3),
     xlim=c(0, max(shark$Length)))
for (i in seq(0, 200, 50)){
  prop = mean(shark$Fatality[shark$Length > i & shark$Length <= i+50])
  points(i+25, prop, pch=19, col="firebrick")
}

# Fit a regression line
sh.lm = lm(Fatality ~ Length, data=shark)
abline(coef=sh.lm$coef)
