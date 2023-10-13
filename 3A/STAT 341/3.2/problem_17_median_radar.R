data(radarImage, package="robustbase")
head(radarImage)

# a.i. Generate m=10000 samples with sample size n=75
set.seed(341)
data(radarImage, package="robustbase")
sam.band2 = sapply(1:10^4, function(i) {radarImage$Band.2[sample(1573, 75)]})
pop.val = median(radarImage$Band.2)

# For each sample, calculate the trimmed average with various fractions of trimming
trim.seq = seq(0, 0.5, 0.05)
samp.properties = sapply(trim.seq, function(trim.amount) {
  avg.trim = apply(sam.band2, 2, mean, trim=trim.amount)
  c(mean(avg.trim - pop.val), sd(avg.trim))
})

# a.ii. Report the sampling bias, sampling stdev, and rmse in a table
samp.properties = rbind(samp.properties,
                        apply(samp.properties, 2, function(z) {sqrt(z[1]^2 + z[2]^2)}))
dimnames(samp.properties)[[2]] = paste("trim=", trim.seq, sep="")
dimnames(samp.properties)[[1]] = c("SB", "SD", "RMSE")
round(t(samp.properties), 2)

# a.iii. Plot a histogram of the population
# Plot SB, SD, and RMSE against the fraction of observations to be trimmed in 3 graphs
# Bias increases with proportion
# SD and RMSE increases at both extremes
# Trim fraction of 0.15 to 0.2 yields the smallest RMSE

par(mfrow=c(2,2))
hist(radarImage$Band.2, breaks="FD", main="Band2", xlab="" )
plot(trim.seq, samp.properties[1,], 
     ylim = c(-1,1)*max(abs(samp.properties[1,]) ),
     xlab = "Trimmed Proportion",
     ylab = "Sampling Bias")
abline(h=0)
plot(trim.seq, samp.properties[2,],
     xlab = "Trimmed Proportion",
     ylab = "Sampling Standard Deviation")
plot(trim.seq, apply(samp.properties,2, function(z) { sqrt(z[1]^2 + z[2]^2) } ), 
     xlab = "Trimmed Proportion",
     ylab = "RMSE")