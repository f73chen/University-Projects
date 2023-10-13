library(carData)
data(TitanicSurvival)
Titanic = na.omit(TitanicSurvival)
x <- Titanic$age

# Plot a histogram of the age using 20 bins
x.range = range(x)
hist(x, breaks=seq(x.range[1], x.range[2], length.out=21), prob=TRUE, main="20 Bins", col="grey")
hist(x, breaks=quantile(x, p=seq(0, 1, length.out=21)), prob=TRUE, main="20 Bins", col="grey")

# Describe age with a boxplot
# Yes, the boxplot roughly describes the data, but it misses the bump near 0
boxplot(x, xlab="Passenger Age")

# Quantile plot of age
x.rank <- rank(x, ties.method="first")
N <- length(x)
p <- x.rank / N

plot(p, x, pch=19, col=adjustcolor("grey", alpha=0.5),
     xlab="Proportion p",
     ylab="Age",
     main="Age of Passengers on the Titanic")

# Draw the quantile plot but switch the axes
# As a function of age, p is the proportion of younger people
plot(x, p, pch=19, col=adjustcolor("grey", alpha=0.5),
     xlab="Age",
     ylab="Proportion p",
     main="Age of Passengers on the Titanic")

# Add a fixed-width box where height = concentration of points
# The bigger height, the high proportion of people in that age range
# Ratio of height to width = derivative or density
drawbox <- function(x, y, ...) {
  rect(xleft=x[1], ybottom=y[1], xright=x[2], ytop=y[2])
}

qvals <- sort(x)
pvals <- ppoints(length(qvals))
qrange <- extendrange(qvals)
bins <- seq(qrange[1], qrange[2], length.out=15)
col <- adjustcolor("steelblue", 0.2)
border <- adjustcolor("black", 0.7)

i <- 1
drawbox(bins[i:(i+1)],
        c(min(pvals), pvals[sum(qvals <= bins[i+1])]),
        lty=1, lwd=2, col=col, border=border)

for (i in 2:length(bins)) {
  y.bin <- c(sum(qvals <= bins[i]),
             sum(qvals <= bins[i+1]))
  drawbox(bins[c(i, i+1)],
          pvals[y.bin],
          lty=1, lwb=2, col=col, border=border)
}

# Draw all boxes but with bottom on p=0 axis
# Now the height of each bar represents the proportion of people in each age range
# Same relationship as between density & distribution function
i <- 1
drawbox(bins[i:(i+1)],
        c(min(pvals), pvals[sum(qvals <= bins[i+1])]),
        lty=1, lwd=2, col=col, border=border)

for (i in 2:length(bins)) {
  y.bin <- c(sum(qvals <= bins[i]),
             sum(qvals <= bins[i+1]))
  drawbox(bins[c(i, i+1)],
          c(0, diff(abs(pvals[y.bin]))),
          lty=1, lwb=2, col=col, border=border)
}