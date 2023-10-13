library(robustbase)
head(Animals2, n=5)
summary(Animals2)

# Scatterplot doesn't show much due to highly skewed dataset
plot(Animals2, pch=16, col=adjustcolor("black", alpha.f=0.3),
     xlab="Body Weight (kg)", ylab="Brain Weight (g)", main="Brain vs. Body Weight")

# Since scatterplot is on the bottom-left quadrant, should power transform (-, -)
# Decrease both alpha_x and alpha_y
powerfun <- function(x, alpha) {
  if (sum(x <= 0) > 1)
    stop("x must be positive")
  if (alpha == 0) 
    log(x)
  else if (alpha > 0) {
    x ^ alpha
  else
    -x^alpha
  }
}

par(mfrow=c(3, 3), mar=2.5*c(1, 1, 1, 0.1))
a = rep(c(0, 1/2, 1), each=3)
a = rep(c(0, 1/2, 1), times=3)

for (i in 1:9) {
  plot(powerfun(Animals2$body, a[i]), powerfun(Animals2$brain, b[i]),
       pch=19, cex=0.5, col=adjustcolor("black", alpha=0.3),
       xlab="", ylab="", main=bquote(alpha[x] == .(a[i]) ~ ", " ~ alpha[y] == .(b[i])))
}

# Appears to have a linear relationship on the log scale
# Except 3 outliers that might have large influence
plot(log(Animals2$body), log(Animals2$brain), pch=16, col=adjustcolor("black", alpha.f=0.3),
     main="Brain vs. Body Weight (log)", xlab="log(Body Weight)", ylab="log(Brain Weight)")

# Calculate the regression line for the log transform
abline(lm(log(brain) ~ log(body), Animals2), col="red")

# Calculate residuals
mod = lm(log(brain) ~ log(body), Animals2)
plot(residuals(mod), pch=19, col=adjustcolor("black", alpha=0.3),
     ylab="Residuals", xlab="Index")

# Can either:
  # Remove the outliers
  # Assign weights to observations according to variation
  # Calculate a robust regression line

# Plot new regression line while removing the three outliers
idx = which(log(Animals2$body) > 9)
W = rep(1, 65)
W[idx] = 0
abline(lm(log(brain) ~ log(body), Animals2, weights=W), col="blue")

# Print the 3 special data points
# They're all dinosaurs, while the rest are mammals
Animals2[idx, ]

# Influence of the points on alpha, beta, and theta (regression)
# Note: have large influence on beta (slope) but not intercept (alpha)
# DIRECTLY COPIED
model.pop <- lm(log(Animals2$brain) ~ log(Animals2$body))
theta.hat <- model.pop$coef
N = nrow(Animals2)
delta = matrix(0, nrow = N, ncol = 2)

for (i in 1:N) {
  temp.model = lm(brain ~ body, data = log(Animals2[-i, ]))
  delta[i, ] = abs(theta.hat - temp.model$coef)
}

par(mfrow = c(1, 3))
plot(delta[, 1], pch = 19, col = adjustcolor("grey", 0.6), 
     main = bquote("Influence on" ~ alpha), ylab = bquote(Delta[alpha]))

obs = c(6, 16, 26)
text(obs, delta[obs, 1] + 0.001, obs)

plot(delta[, 2], pch = 19, col = adjustcolor("grey", 0.6), 
     ylab = bquote(Delta[beta]), main = bquote("Influence on" ~ beta))

obs = c(6, 16, 26)
text(obs + 3, delta[obs, 2], obs)

delta2 = apply(X = delta, MARGIN = 1, FUN = function(z) { sqrt(sum(z^2)) })
plot(delta2, pch = 19, col = adjustcolor("grey", 0.6),
     ylab = bquote(Delta), main = bquote("Influence on" ~ theta))

text(obs + 3, delta2[obs], obs)

# Calculate residual stdev for the outliers and remaining points:
res = residuals(lm(log(brain) ~ log(body), Animals2))
outlier.sd = sqrt(sum(res[idx]^2 / length(idx)))
remaining.sd = sqrt(sum(res[-idx]^2) / length(res[-idx]))
c(outlier.sd, remaining.sd)

# Relative ratio between the stdevs:
# Let weight = 1 for mammals and stdev ratio for dinosaurs
wt = rep(1, 65)
wt[obs] = remaining.sd/outlier.sd
abline(lm(log(brain) ~ log(body), Animals2, weights=wt), col="purple")

legend("bottomright", legend=c("LS line", "LS Line (no outliers)", "WLS Line"),
       col=c("red", "blue", "purple"), cex=0.75, bty="n", lty=1)

# Robust Regression (no manual tuning)
# General Huber Function:
huber.fn <- function(r, k) {
  val = r^2/2
  subr = abs(r) > k
  val[subr] = k * (abs(r[subr]) - k/2)
  return(val)
}

# Huber Function for different thresholds k
# DIRECTLY COPIED
r = seq(-4, 4, 0.01)
plot(r, huber.fn(r, k = 1.345), type = "l", col = 4, main = "Huber vs. Quadratic Loss", 
     ylab = "")
lines(r, huber.fn(r, k = 2), type = "l", col = 2)
lines(r, huber.fn(r, k = 1), type = "l", col = 3)
lines(r, r^2/2, type = "l")
text(0, 4, "Least Squares", bty = "n")
text(0, 3.5, "Huber (k=2)", bty = "n", col = 2)
text(0, 3, "Huber (k=1.345)", bty = "n", col = 4)
text(0, 2.5, "Huber (k=1)", bty = "n", col = 3)

# Implement Huber Loss and Least Absolute Deviations (LAD)
# DIRECTLY COPIED
plot(x = log(Animals2$body), y = log(Animals2$brain), main = "", xlab = "log(body weight)", 
     ylab = "log(brain weight)", pch = 16, col = adjustcolor("black", alpha.f = 0.3))

abline(lm(log(Animals2$brain) ~ log(Animals2$body)), col = "red")
W = rep(1, 65)
W[which(log(Animals2$body) > 9)] = 0
abline(lm(log(Animals2$brain) ~ log(Animals2$body), weights = W), col = "blue")
wt = rep(1, 65)
wt[obs] = remaining.sd/outlier.sd
abline(lm(log(Animals2$brain) ~ log(Animals2$body), weights = wt), col = "purple")

library(MASS)
abline(rlm(log(Animals2$brain) ~ log(Animals2$body), psi = "psi.huber"), col = "green")

library(L1pack)
abline(lad(log(Animals2$brain) ~ log(Animals2$body)), col = "orange")

legend("bottomright", legend = c("LS line", "LS line (no outliers)", "WLS Line", 
                                 "Huber Line", "LAD Line"), col = c("red", "blue", "purple", "green", "orange"), 
       cex = 0.75, bty = "n", lty = 1)