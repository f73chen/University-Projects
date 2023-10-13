filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)
agpop[agpop == -99] = NA

# One histogram with bin width of 100
hist(agpop$farms87, col=adjustcolor("grey", alpha=0.5),
     main="Number of farms per county in 1987",
     xlab="Number of farms",
     breaks=100, prob=TRUE)
abline(v=c(mean(agpop$farms87), median(agpop$farms87)),
       col=c("blue", "red"), lwd=2, lty=2)
legend("topright", c("Mean", "Median"),
       col=c("blue", "red"), lwd=2, lty=2)

# Bins of equal size vs. equal elements
x = agpop$farms87
par(mfrow=c(2, 3), mar=2.5*c(1, 1, 1, 0.1))
rx = range(x)
hist(x, breaks=seq(rx[1], rx[2], length.out=4), prob=TRUE, main="3 Bins", col="grey")
hist(x, breaks=seq(rx[1], rx[2], length.out=6), prob=TRUE, main="5 Bins", col="grey")
hist(x, breaks=seq(rx[1], rx[2], length.out=16), prob=TRUE, main="15 Bins", col="grey")

hist(x, breaks=quantile(x, p=seq(0, 1, length.out=4)), prob=TRUE, main="3 Bins", col="grey")
hist(x, breaks=quantile(x, p=seq(0, 1, length.out=6)), prob=TRUE, main="5 Bins", col="grey")
hist(x, breaks=quantile(x, p=seq(0, 1, length.out=16)), prob=TRUE, main="15 Bins", col="grey")

# Bin size according to Sturges, Freedman-Diaconis, and Scott's rule
par(mfrow=c(2,3), mar=2.5*c(1, 1, 1, 0.1))
x = agpop$farms87
hist(x, prob=TRUE, xlab="", main="Sturges")
hist(x, breaks="FD", prob=TRUE, xlab="", main="Freedman-Diaconis")
hist(x, breaks="scott", prob=TRUE, xlab="", main="Scott")

x = log(agpop$farms87 + 1)
hist(x, prob=TRUE, xlab="", main="Sturges")
hist(x, breaks="FD", prob=TRUE, xlab="", main="Freedman-Diaconis")
hist(x, breaks="scott", prob=TRUE, xlab="", main="Scott")

# Scatter plot
par(mfrow=c(1, 2))
plot(agpop$farms87, agpop$acres87, pch=19, cex=0.5,
     col=adjustcolor("black", alpha=0.3),
     xlab="Number of farms", ylab="Total acreage of farming",
     main="US counties 1987")
plot(agpop$acres87, agpop$farms87, pch=19, cex=0.5,
     col=adjustcolor("black", alpha=0.3),
     ylab="Number of farms", xlab="Total acreage of farming",
     main="US counties 1987")

# Log-transformed scatterplot
par(mfrow=c(1, 2))
plot(log(agpop$farms87+1), log(agpop$acres87+1), pch=19, cex=0.5,
     col=adjustcolor("black", alpha=0.3),
     xlab="log(Number of farms + 1)", ylab="log(Total acreage of farming + 1)",
     main="US counties 1987")
plot(log(agpop$farms87+1), log(agpop$acres87+1), pch=19, cex=0.5,
     col=adjustcolor("black", alpha=0.3),
     ylab="log(Number of farms + 1)", xlab="log(Total acreage of farming + 1)",
     main="US counties 1987")

# FEH scatter-plot change colours
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "feh.csv", sep="/")
feh <- read.csv(filename, header=TRUE)

par(mfrow=c(2, 2), mar=c(4, 4, 1, 1))
cex.seq = rep(c(1, 1.5), times=2)
shade.seq = rep(c(0.7, 0.3), each=2)

for (i in 1:4) {
  plot(feh$RES, feh$DEF, main="", pch=19,
       cex=cex.seq[i],
       col=adjustcolor("black", alpha=shade.seq[i]),
       xlab="Resistance", tlab="Defense")
}

# Adding jitter so points don't stack
y.example <- rep(1, 100)
par(mfrow=c(1, 3))
fact.seq = c(0, 1, 2)

for (i in 1:3) {
  plot(jitter(y.example, factor=fact.seq[i]),
       ylim=c(0.9, 1.1), ylab="Measured Values",
       cex.lab=1.5, cex.axis=1.5, pch=19)
}

# FEH scatter-plot with jitter
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "feh.csv", sep="/")
feh <- read.csv(filename, header=TRUE)

plot(jitter(feh$RES, factor=1.5), jitter(feh$DEF, factor=1.5),
     main="Raw Vales + Jitter", pch=19, cex=0.5,
     col=adjustcolor("black", alpha=0.3),
     xlab="Resistance", ylab="Defense", type="p")


