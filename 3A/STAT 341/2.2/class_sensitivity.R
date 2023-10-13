sc = function(y.pop, y, attr, ...) {
  N <- length(y.pop) + 1
  # For every value in the vector y, run this function
  sapply(y, function(y.new) {
    N * (attr(c(y.new, y.pop), ...) - attr(y.pop, ...))
  })
}

# Sample sensitivity curve plot
set.seed(341)
ys <- rnorm(1000)
y <- seq(-5, 5, length.out=1001)

par(mfrow=c(1,2))
plot(y, sc(ys, y, mean), type="l", lwd=2,
     main="Sensitivity curve for the Mean",
     ylab="sensitivity")
abline(h=0, v=0, col="grey")
plot(y, sc(ys, y, mean), type="l", lwd=2,
     main="Sensitivity curve for the Mean (zoom)",
     ylab="sensitivity",
     xlim=c(-.01, .01), ylim=c(-.01, .01))
abline(h=0, v=0, col="grey")