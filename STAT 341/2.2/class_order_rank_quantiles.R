filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)
agpop[agpop == -99] = NA

y <- agpop$acres87[agpop$region=="NE"]
y <- na.omit(y)
y.rank <- rank(y, ties.method="first")

# Quantile plot
plot(y.rank, y, pch=19, col=adjustcolor("grey", alpha=0.5),
     xlab="County rank by acreage",
     ylab="Farming acres in 1987",
     main="Counties in the North East USA")

N <- length(y)
p <- y.rank / N

# Proportion plot
plot(p, y, pch=19, col=adjustcolor("grey", alpha=0.5),
     xlab="Proportion p",
     ylab="Farming acres in 1987",
     main="Counties in the North East USA")

# Concentration in quantile plots
drawbox <- function(x, y, ...) {
  rect(xleft=x[1], ybottom=y[1], xright=x[2], ytop=y[2])
}

qvals <- sort(y)
pvals <- ppoints(length(qvals))
plot(pvals, qvals, pch=19, col=adjustcolor("grey", alpha=0.5),
     xlim=c(0, 1),
     xlab="Proportion of p",
     ylab=bquote("Q"["y"]~"(p)"),
     main="1987 Farming Acreage for North East Counties")

qrange <- extendrange(qvals)
bins <- seq(qrange[1], qrange[2], length.out=15)
col <- adjustcolor("steelblue", 0.2)
border <- adjustcolor("black", 0.7)

i <- 1
drawbox(c(min(pvals), pvals[sum(qvals <= bins[i+1])]),
        bins[i:(i+1)],
        lty=1, lwd=2, col=col, border=border)

for (i in c(3, 7, 12)) {
  y.bin <- c(sum(qvals <= bins[i]),
             sum(qvals <= bins[i+1]))
  drawbox(pvals[y.bin],
          bins[c(i, i+1)],
          lty=1, lwb=2, col=col, border=border)
}

# Plot all boxes with fixed height
for (i in 2:length(bins)) {
  y.bin <- c(sum(qvals <= bins[i]),
             sum(qvals <= bins[i+1]))
  drawbox(pvals[y.bin],
          bins[c(i, i+1)],
          lty=1, lwb=2, col=col, border=border)
}

# Move all boxes to the left for a histogram
i <- 1
drawbox(c(min(pvals), pvals[sum(qvals <= bins[i+1])]),
        bins[i:(i+1)],
        lty=1, lwd=2, col=col, border=border)

for (i in 2:length(bins)) {
  y.bin <- c(sum(qvals <= bins[i]),
             sum(qvals <= bins[i+1]))
  drawbox(c(0, diff(abs(pvals[y.bin]))),
          bins[c(i, i+1)],
          lty=1, lwb=2, col=col, border=border)
}