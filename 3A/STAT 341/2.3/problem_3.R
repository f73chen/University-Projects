library(MASS)
data(UScereal)
head(UScereal[, c('sugars', 'calories')])

x <- UScereal$sugars
y <- UScereal$calories

# Plot sugars vs. number of calories and overlay a regression line
plot(x, y, pch=19, col=adjustcolor("black", 0.3),
     xlab="Sugars", ylab="Calories")
abline(lm(y ~ x, data.frame(y=y, x=x)), col=1)

# Need to worry about discrete numbers because there are overlaps

# Plot regression line with outliers removed (y>300)
abline(lm(y ~ x, data.frame(y=y, x=x), weights=as.numeric(y<300)), col=2)

# Plot the derivative of r^2 over the range [-4, 4]
# Similar to the sensitivity curve for the mean
r = seq(-4, 4, 0.01)
plot(r, 2*r, type='l')

# Plot the first derivative of the Huber function with k=1
# Similar to the sensitivity curve for the median
huber.fn1 <- function(r, k=1) {
  val = r
  subr = abs(r) > k
  val[subr] = k * sign(r[subr])
  return(val)
}
plot(r, huber.fn1(r, k=1), type='l')

# Plot the first derivative of Tukey's biweight function
# Different from the others because the 1st derivative comes back to the horizontal axis
TukeyBiweightpsi <- function(r, c=1) {
  psivals <- rep(0, length(r))
  middlevals <- {abs(r) <= c}
  psivals[middlevals] <- r[middlevals] * (1 - (r[middlevals]/c)^2)^2
  return(psivals)
}
plot(r, TukeyBiweightpsi(r), type='l',
     ylab="psi(r)", xlab='r', main="Tukey's Biweight psi, k=1")

# Plot g(r) = 2r/(1+r^2)
# This would be resistant to outliers because the curve goes back to 0
plot(r, 2*r/(1+r^2), type='l')
