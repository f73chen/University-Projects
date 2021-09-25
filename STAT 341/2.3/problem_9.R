x <- seq(0, 5, 0.01)

# Plot the sine function
plot(x, sin(x), type='l')

# Optimize over the range [3, 4]
optimize(sin, interval=c(3, 4))

# Find max of sine over the range[0, 5]
# Returns PI/2, which is expected
optimize(sin, interval=c(0, 5), maximum=TRUE)

vee <- function(z, q=1/2) {
  val = q*z
  val[z < 0] = -(1-q)*z[z<0]
  return(val)
}

createVeeFunc <- function(y.pop, q){
  function(theta){
    sum(vee(y.pop-theta, q))
  }
}

# A function optimized this way returns 4.5 instead of 3.5
# optimize() over-estimates the standard definition of median when the number of units is even
med <- seq(1, 6, length.out=6)
vee.i <- createVeeFunc(med, 0.5)
ans <- optimize(vee.i, interval=c(1, 6))

# However, any value in the interval [3, 4] would return this estimate
plot(med, sapply(med, function(t){vee.i(t)}), type='l')
abline(v=median(med))
abline(v=ans$minimum, col="blue")