vee <- function(z, q) {
  val = q*z
  val[z < 0] = (q-1) * z[z<0]
  return(val)
}

z = seq(-3, 3, 0.01)
par(mfrow=c(1, 5), mar=2.5*c(1, 1, 1, 0.1))
plot(z, vee(z, q=1/10), main="q=0.1", type="l")
plot(z, vee(z, q=1/4), main="q=0.25", type="l")
plot(z, vee(z, q=1/2), main="q=0.5", type="l")
plot(z, vee(z, q=3/4), main="q=0.75", type="l")
plot(z, vee(z, q=9/10), main="q=0.9", type="l")

# Determine the 30th quantile by minimizing a sum of vee functions
set.seed(341)
y.pop <- rnorm(25, 10, 3)

# Calculate objective function by summing over the population
rho.fun <- function(theta, q.val) {
  return(sum(sapply(X=y.pop-theta, FUN=vee, q=q.val)))
}

theta = seq(6, 10, length.out=1000)
rho.vals = numeric(length(theta))
for (i in 1:length(theta)) {
  rho.vals[i] = rho.fun(theta[i], q.val=0.3)
}
plot(theta, rho.vals, type="l",
     xlab=bquote(theta), ylab=bquote(rho[]),
     main="Loss Function to be Minimized")

# Use a numerical minimizer to find the minimizing value
# All 3 methods return the minimum ($par) and $objective
nlminb(start=0.5, objective=rho.fun, q.val=0.3)
optimize(f=rho.fun, interval=range(y.pop), q.val=0.3)
optim(par=0.5, fn=rho.fun, q.val=0.3)

# Note, there are different types of quantiles
quantile(y.pop, 0.3, type=7)
quantile(y.pop, 0.3, type=1)

# Example: Regression line for FE Heroes
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "feh.csv", sep="/")
plot(feh$RES, feh$DEF, main="", pch=19, cex=1.5,
     col=adjustcolor("black", alpha=0.3),
     xlab="Resistance", ylab="Defense")

fit = lm(DEF ~ RES, data=feh)
abline(fit, col="red", lwd=2)

# Influence of implicitly defined attributes on individual coefficient estimates
N = nrow(feh)
delta = matrix(0, nrow=N, ncol=2)
for (i in 1:N) {
  # Fit for all except the ith row
  fit.no.i = lm(DEF ~ RES, data=feh[-i, ])
  delta[i, ] = abs(fit$coef - fit.no.i$coef)
}

par(mfrow = c(2, 2))
hist(delta[, 1], breaks="FD", col=adjustcolor("grey", 0.6),
     xlab=bquote(Delta[alpha]), main=bquote("Influence on" ~ alpha))
plot(delta[, 1], pch=19, col=adjustcolor("grey", 0.6),
     ylab=bquote(Delta[alpha]), main=bquote("Influence on" ~ alpha))
hist(delta[, 2], breaks="FD", col=adjustcolor("grey", 0.6),
     xlab=bquote(Delta[beta]), main=bquote("Influence on" ~ beta))
plot(delta[, 2], pch=19, col=adjustcolor("grey", 0.6),
     ylab=bquote(Delta[beta]), main=bquote("Influence on" ~ beta))

# Influence of each unit on the regression line as a whole
# Define influnece for a vector valued attribute using Euclidean norm
par(mfrow=c(1, 2))
delta2 = apply(X=delta, MARGIN=1, FUN=function(z) {
  sqrt(sum(z^2))
})
hist(delta2, breaks="FD", col=adjustcolor("grey", 0.6),
     xlab=bquote(Delta), main=bquote("Influence on" ~ theta))
plot(delta2, pch=19, col=adjustcolor("grey", 0.6),
     ylab=bquote(Delta), main=bquote("Influence on" ~ theta))

# Units with the largest overall influence:
# One is the weakest and one is the strongest
feh[delta > 0.5, ]

col.nam = c(adjustcolor("black", alpha=0.3), adjustcolor("firebrick", alpha=0.6))
# Note for color: if true, then col.nam[2] (red), else col.nam[1] (black)
plot(feh$RES, feh$DEF, main="", pch=19, cex=1.5, col=col.nam[(delta2 > 0.5)+1],
     xlab="Resistance", ylab="Defense")
abline(fit, col=2, lwd=2)