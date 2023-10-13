data(faithful)

summary(faithful)
boxplot(faithful)

par(mfrow=c(1, 2))
e <- faithful$eruptions
w <- faithful$waiting
boxplot(e)
boxplot(w)

# Print STDEV and COEVAR for both eruptions and waiting
out = round(apply(faithful, 2, function(z) {
  c(sdn(z), sdn(z)/mean(z))
}), 3)
row.names(out) = c("Standard Deviation", "Coefficient of Variation")
out

# Histograms for eruptions
par(mfrow=c(1, 2))
hist(e, breaks=seq(min(e), max(e), length.out=6))
hist(e, breaks=quantile(e, p=seq(0, 1, length.out=6)))

# Equal bin width with an appropriate number of bins
hist(e, breaks=9, main="10 Bins")

# Quantile plot
qvals <- sort(e)
pvals <- (1:length(e) / length(e))
plot(pvals, qvals, pch=19, col=adjustcolor("grey", alpha=0.7),
     xlim=c(0, 1), xlab="Quantiles", ylab="Proportion p", main="Eruptions")