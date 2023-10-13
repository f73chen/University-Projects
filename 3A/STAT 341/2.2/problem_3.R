plot.sc <- function(y.pop, attr, name="Attribute") {
  N <- length(y.pop) + 1
  sc <- function(y, attr) { Map(function(y) { N * (attr(c(y, y.pop)) - attr(y.pop)) },y ) }
  
  y1 <- seq(-2, 2, length.out=1000)
  y2 <- seq(-1000, 1000, length.out=1000)
  
  par(mfrow=c(1, 2), oma=c(0, 0, 2, 0), mar=2.5*c(1, 1, 1, 0.1))
  plot(y1, sc(y1, attr), type="l", col="steelblue",
       xlab="y", ylab="SC(y)",main="")
  plot(y2, sc(y2, attr), type="l", col="steelblue",
       xlab="y", ylab="SC(y)",main="")
  mtext(paste("SC Curve for: ", name), outer=TRUE, cex=1.5)
}

p.second <- function(y.pop) {
  ybar <- mean(y.pop)
  ymed <- median(y.pop)
  ysd <- sd(y.pop)
  return(3 * (ybar-ymed) / ysd)
}

cv <- function(y.pop) { sd(y.pop) / mean(y.pop) }

midhinge <- function(y.pop) {
  mean(quantile(y.pop, c(0.25, 0.75)))
}

p.moment <- function(y.pop) {
  mean((y.pop - mean(y.pop))**3)/sd(y.pop)**3
}

N = 1000
set.seed(341)
ys = runif(N)
# plot.sc(ys, sd, name="Standard Deviation")
# plot.sc(ys, IQR, name="Inter-Quartile Range")
# plot.sc(ys, p.second, name="Median Skewness")
# plot.sc(ys, cv, name="Coefficient of Variation")
# plot.sc(ys, midhinge, name="Midhinge")
plot.sc(ys, p.moment, name="Pearson's Moment")
