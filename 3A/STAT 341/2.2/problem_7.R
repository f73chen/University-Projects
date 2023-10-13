library(ISLR)
data("Hitters")
hit <- na.omit(Hitters)
head(hit)

# Define power function
powerfun <- function(x, alpha) {
  if (sum(x <= 0) > 0) stop("x must be positive")
  if (alpha == 0) { log(x) }
  else if (alpha > 0) { x^alpha }
  else { -x ^ alpha }
}

# Find range of alpha where histogram is symmetric
par(mfrow=c(2,5), mar=2.5*c(1, 1, 1, 0.1))
a = rep(c(0, 0.2, 1/2, 3/4, 1))
for (i in 1:5) {
  hist(powerfun(hit$CAtBat, a[i]))
}
for (i in 1:5) {
  hist(powerfun(hit$CRBI, a[i]))
}

# Plot CAtBat against CRBI with alpha = 0.2 (most symmetric hist)
plot(powerfun(hit$CAtBat, 0.2), powerfun(hit$CRBI, 0.2),
     pch=19, col=adjustcolor("firebrick", alpha=0.5))
abline(lm(I(powerfun(hit$CRBI, 0.2)) ~ I(powerfun(hit$CAtBat, 0.2))))

# Plot CWalks against CRuns
plot(hit$CWalks, hit$CRuns)
par(mfrow=c(2,5), mar=2.5*c(1, 1, 1, 0.1))
a = rep(c(0.1, 0.2, 0.3, 0.4, 0.5))
for (i in 1:5) {
  hist(powerfun(hit$CWalks, a[i]))
}
for (i in 1:5) {
  hist(powerfun(hit$CRuns, a[i]))
}
plot(powerfun(hit$CWalks, 0.3), powerfun(hit$CRuns, 0.3))
