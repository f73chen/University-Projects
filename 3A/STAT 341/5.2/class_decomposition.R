# Helper functions
ave_y_mu_sq <- function(sample, predfun, na.rm = TRUE){
  mean((sample$y - predfun(sample$x))^2, na.rm = na.rm)
}

ave_mu_mu_sq <- function(predfun1, predfun2, x, na.rm = TRUE){
  mean((predfun1(x) - predfun2(x))^2, na.rm = na.rm)
}

getSampleComp <- function(pop, size, replace=FALSE) {
  N <- popSize(pop)
  samp <- rep(FALSE, N)
  samp[sample(1:N, size, replace = replace)] <- TRUE
  samp
}

getXYSample <- function(xvarname, yvarname, samp, pop) {
  sampData <- pop[samp, c(xvarname, yvarname)]
  names(sampData) <- c("x", "y")
  sampData
}

popSize <- function(pop) {nrow(as.data.frame(pop))}
sampSize <- function(samp) {popSize(samp)}

getmuhat <- function(sampleXY, complexity = 1) {
  formula <- paste0("y ~ ",
    if (complexity==0) { "1" } 
    else paste0("poly(x, ", complexity, ", raw = FALSE)") )
  
  fit <- lm(as.formula(formula), data = sampleXY)
  tx = sampleXY$x
  ty = fit$fitted.values
  
  range.X = range(tx)
  val.rY = c(mean(ty[tx == range.X[1]]), mean(ty[tx == range.X[2]]))
  
  ## From this we construct the predictor function
  muhat <- function(x) {
    if ("x" %in% names(x)) { newdata <- x } 
    else { newdata <- data.frame(x = x) }
    
    ## The prediction
    val = predict(fit, newdata = newdata)
    val[newdata$x < range.X[1]] = val.rY[1]
    val[newdata$x > range.X[2]] = val.rY[2]
    val
  }
  muhat
}

# Fits a piecewise constant to the population with linear interpolation
getmuFun <- function(pop, xvarname, yvarname) {
  pop = na.omit(pop[, c(xvarname, yvarname)])
  tauFun = approxfun(pop[, xvarname], pop[, yvarname], rule = 2, ties = mean)
  return(tauFun)
}



# Visualize the conditional average for the datasets:
filename <- paste("C:/Users/User/source/repos/Uni-Projects/STAT 341/Data", "temperature.csv", sep="/")
temperature <- read.csv(filename, header=TRUE)
data(Loblolly)

par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))

plot(Loblolly$age[order(Loblolly$age)], Loblolly$height[order(Loblolly$age)], 
     xlab = "Age", ylab = "Height", col = adjustcolor("grey", 0.7), pch = 19, 
     main = "Loblolly")
tau.age = getmuFun(pop = Loblolly, xvarname = "age", yvarname = "height")
curve(tau.age, 0, 30, add = TRUE, n = 100)

plot(temperature$YEAR, temperature$ANNUAL, xlab = "Year", ylab = "Annual Temperature", 
     col = adjustcolor("grey", 0.7), pch = 19, main = "Temperature")
tau.annual = getmuFun(pop = temperature, xvarname = "YEAR", yvarname = "ANNUAL")
curve(tau.annual, 1840, 2020, add = TRUE, 181)

# Calculate the first term: Ave_x(Var[Y|x])
mat = matrix(0, nrow = 2, ncol = 1)
mat[, 1] = c(mean((Loblolly$height - tau.age(Loblolly$age))^2), 
             mean((temperature$ANNUAL - tau.annual(temperature$YEAR))^2))
rownames(mat) = c("Loblolly", "Temperature")
colnames(mat) = "Ave_x Var(Y|x)"
round(mat, 2)





# The second term: Var[mu~]
plot(temperature$YEAR, temperature$ANNUAL, xlab = "YEAR", ylab = "Annual Temperature", 
     main = "Global Annual Temperature", col = adjustcolor("black", 0.5), pch = 19)

# Take Ns = 9 samples of size n = 25 from this population
# And split into sample & test sets
xnam <- "YEAR"
ynam <- "ANNUAL"
pop <- temperature
n <- 25
N_S <- 9
set.seed(1)
samples <- lapply(1:N_S, FUN = function(i) {
  getSampleComp(pop, n)
})
Ssam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, Si, pop)
})
Tsam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, !Si, pop)
})

# Fit polynomials of degree 2 and 9 to each sample
muhats2 <- lapply(Ssam, getmuhat, complexity = 2)
muhats9 <- lapply(Ssam, getmuhat, complexity = 9)

par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))

xlim <- extendrange(temperature[, xnam])
ylim <- extendrange(temperature[, ynam])

for (i in 1:N_S) {
  plot(Ssam[[i]], main = bquote(hat(mu) ~ "(Degree=2,9) on S"[.(i)]), xlab = xnam, 
       ylab = ynam, pch = 19, col = adjustcolor("black", 0.5), ylim = ylim, 
       xlim = xlim)
  tempfn = muhats2[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
        lwd = 2)
  tempfn = muhats9[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "firebrick", 
        lwd = 2)
  legend("topleft", col = c("steelblue", "firebrick"), lwd = 2, legend = c("Degree 2", 
                                                                           "Degree 9"), bty = "n", cex = 0.8)
}

# Visualize sampling variability by ploting all Ns=9 curves on the same plot
par(mfrow = c(1, 2), mar = 2.5 * c(1, 1, 1, 0.1))
plot(Ssam[[i]], main = bquote(hat(mu) * "'s (Degree=2) from S"[1] * ",...,S"[9]), 
     xlab = xnam, ylab = ynam, pch = 19, col = 0, ylim = ylim, xlim = xlim)
for (i in 1:N_S) {
  tempfn = muhats2[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
        lwd = 2)
}
plot(Ssam[[i]], main = bquote(hat(mu) * "'s (Degree=9) from S"[1] * ",...,S"[9]), 
     xlab = xnam, ylab = ynam, pch = 19, col = 0, ylim = ylim, xlim = xlim)
for (i in 1:N_S) {
  tempfn = muhats9[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "firebrick", 
        lwd = 2)
}


# Consider variability for degrees 1-9:
degrees <- 1:9
muhats <- Map(function(i) {
  lapply(Ssam, getmuhat, complexity = i)
}, degrees)

# Calculate the average fitted polynomial
getmubar <- function(muhats) {
  function(x) {
    Ans <- sapply(muhats, FUN = function(muhat) {
      muhat(x)
    })
    apply(Ans, MARGIN = 1, FUN = mean)
  }
}

mubars <- lapply(muhats, getmubar)


# Another way to visualize sampling variability:
# The difference between each model and the average model
  # Difference between each grey line and the green line
par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in degrees) {
  plot(Ssam[[i]], main = bquote(hat(mu)["S"[j]] - bar(hat(mu)) ~ "(Degree=" * 
                                  .(i) * ") from S"[1] * ",...,S"[9]), xlab = xnam, ylab = ynam, pch = 19, 
       col = 0, ylim = c(-0.2, 0.2), xlim = xlim)
  for (j in 1:N_S) {
    tempfn1 = muhats[[i]][[j]]
    tempfn2 = mubars[[i]]
    tempnew = function(z) {
      tempfn1(z) - tempfn2(z)
    }
    curve(tempnew, from = xlim[1], to = xlim[2], add = TRUE, col = "slateblue", 
          lwd = 2)
  }
}


# Calculate Var[mu~] numerically using the function var_mutilde:
var_mutilde <- function(Ssamples, Tsamples, complexity) {
  ## get the predictor function for every sample S
  muhats <- lapply(Ssamples, FUN = function(sample) {
    getmuhat(sample, complexity)
  })
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  ## average over all samples S
  N_S <- length(Ssamples)
  mean(sapply(1:N_S, FUN = function(j) {
    ## get muhat based on sample S_j
    muhat <- muhats[[j]]
    ## average over (x_i,y_i) in a single sample T_j the squares (y - muhat(x))^2
    T_j <- Tsamples[[j]]
    ave_mu_mu_sq(muhat, mubar, T_j$x)
  }))
}


# Apply the function to the example:
degrees <- 1:9
varmu <- sapply(degrees, FUN = function(deg) {
  var_mutilde(Ssam, Tsam, complexity = deg)
})
Vmat = matrix(varmu, nrow = 1, 
              dimnames = list("Var(mu)", paste("deg=", degrees, sep = "")))
round(Vmat, 4)


# Compare the average estimated model to the model fitted on the population:
  # Green --> average fitted function mu^bar(x)
  # Orange --> function on the entire population mu^p(x)
par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in degrees) {
  plot(Ssam[[i]], main = bquote(bar(hat(mu)) ~ "and" ~ hat(mu)[P] ~ "(Degree=" * 
                                  .(i) * ")"), xlab = xnam, ylab = ynam, pch = 19, col = 0, ylim = ylim, 
       xlim = xlim)
  tempfn = getmuhat(getXYSample(xnam, ynam, rep(TRUE, 166), pop), complexity = i)
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "darkgreen", 
        lwd = 2)
  tempfn = mubars[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "orange", 
        lwd = 2)
}




# Compare the difference between the average estimated function
  # And the true piecewise function defined on P
par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in degrees) {
  plot(Ssam[[i]], main = bquote(bar(hat(mu)) ~ "and" ~ tau ~ "(Degree=" * 
                                  .(i) * ")"), xlab = xnam, ylab = ynam, pch = 19, col = 0, ylim = ylim, 
       xlim = xlim)
  tempfn = getmuFun(temperature, xnam, ynam)
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "black", lwd = 2)
  tempfn = mubars[[i]]
  curve(tempfn, from = xlim[1], to = xlim[2], add = TRUE, col = "darkgreen", 
        lwd = 2)
}


# Or plot the bias (difference between the curves)
par(mfrow = c(3, 3), mar = 2.5 * c(1, 1, 1, 0.1))

for (i in degrees) {
  plot(Ssam[[i]], main = paste0("Bias (Degree=", i, ")"), xlab = xnam, ylab = ynam, 
       pch = 19, col = 0, ylim = c(-0.4, 0.4), xlim = xlim)
  tempfn1 = getmuFun(temperature, xnam, ynam)
  tempfn2 = mubars[[i]]
  tempnew = function(z) {
    tempfn1(z) - tempfn2(z)
  }
  curve(tempnew, from = xlim[1], to = xlim[2], add = TRUE, col = "black", 
        lwd = 2)
  abline(h = 0, lty = 2)
}


# Calculate Bias[mu~] numerically:
bias2_mutilde <- function(Ssamples, Tsamples, tau, complexity) {
  ## get the predictor function for every sample S
  muhats <- lapply(Ssamples, FUN = function(sample) getmuhat(sample, complexity))
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  ## average over all samples S
  N_S <- length(Ssamples)
  mean(sapply(1:N_S, FUN = function(j) {
    ## average over (x_i,y_i) in a single sample T_j the squares (y - muhat(x))^2
    T_j <- Tsamples[[j]]
    ave_mu_mu_sq(mubar, tau, T_j$x)
  }))
}

# Apply the function to the example
tau.annual = getmuFun(pop, xnam, ynam)
bias2 <- sapply(degrees, FUN = function(deg) {
  bias2_mutilde(Ssam, Tsam, complexity = deg, tau = tau.annual)
})

Bmat = matrix(bias2, nrow = 1, dimnames = list("[Bias(mu)]^2", 
                                               paste("deg=", degrees, sep = "")))
round(Bmat, 4)



# Combine the three components to obtain the APSE
BVmat = rbind(0, Bmat, Vmat, Bmat + Vmat)
rownames(BVmat)[1] = "Var(y|x)"
rownames(BVmat)[4] = "APSE"
round(BVmat, 3)

# Visualize the results
par(mfrow = c(1, 1))
plot(1:9, BVmat[2, ], xlab = "Degree", ylab = "", type = "l", ylim = c(0, 0.1), 
     col = "firebrick", lwd = 2)
lines(1:9, (BVmat[1, ]^2), xlab = "Degree", ylab = "", col = "black", lwd = 2)
lines(1:9, BVmat[3, ], xlab = "Degree", ylab = "", col = "steelblue", lwd = 2)
lines(1:9, BVmat[4, ], col = "purple", lwd = 2)
text(2, 0.08, "APSE", col = "purple")
text(2, 0.07, "Bias[mu.tilde]^2", col = "firebrick")
text(2, 0.06, "Var[mu.tilde]", col = "steelblue")
text(2, 0.05, "Ave.Var[y|x]", col = "black")


# Helper function: calculates the APSE and each of its components all at once
apse_all <- function(Ssamples, Tsamples, complexity, tau) {
  ## average over the samples S
  N_S <- length(Ssamples)
  muhats <- lapply(Ssamples, FUN = function(sample) getmuhat(sample, complexity))
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  rowMeans(sapply(1:N_S, FUN = function(j) {
    T_j <- Tsamples[[j]]
    S_j <- Ssamples[[j]]
    muhat <- muhats[[j]]
    ## Take care of any NAs
    T_j <- na.omit(T_j)
    y <- c(S_j$y, T_j$y)
    x <- c(S_j$x, T_j$x)
    
    tau_x <- tau(x)
    muhat_x <- muhat(x)
    mubar_x <- mubar(x)
    
    apse <- (y - muhat_x)
    bias2 <- (mubar_x - tau_x)
    var_mutilde <- (muhat_x - mubar_x)
    var_y <- (y - tau_x)
    
    squares <- rbind(apse, var_mutilde, bias2, var_y)^2
    
    ## return means
    rowMeans(squares)
  }))
}


# Apply the helper function to the example
degrees <- 1:15
tau.annual = getmuFun(pop, xnam, ynam)
apse_vals <- sapply(degrees, FUN = function(deg) {
  apse_all(Ssam, Tsam, complexity = deg, tau = tau.annual)
})
colnames(apse_vals) = paste("deg=", degrees, sep = "")
round(apse_vals, 3)


# Visualize the results
plot(degrees, apse_vals[3, ], xlab = "Degree", ylab = "", type = "l", 
     ylim = c(0, 0.026), col = "firebrick", lwd = 2)
lines(degrees, apse_vals[2, ], xlab = "Degree", ylab = "", 
      col = "steelblue", lwd = 2)
lines(degrees, apse_vals[1, ], col = "purple", lwd = 2)
lines(degrees, apse_vals[4, ], col = "black", lwd = 2)



# Recall: can also calculate the APSE using only the training data T
# The difference is that apse_all calculates APSE on the entire population P
apse_test <- function(Ssamples, Tsamples, complexity, tau) {
  ## average over the samples S
  N_S <- length(Ssamples)
  muhats <- lapply(Ssamples, FUN = function(sample) getmuhat(sample, complexity))
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  rowMeans(sapply(1:N_S, FUN = function(j) {
    T_j <- Tsamples[[j]]
    muhat <- muhats[[j]]
    ## Take care of any NAs
    T_j <- na.omit(T_j)
    y <- T_j$y
    x <- T_j$x
    tau_x <- tau(x)
    muhat_x <- muhat(x)
    mubar_x <- mubar(x)
    
    apse <- (y - muhat_x)
    bias2 <- (mubar_x - tau_x)
    var_mutilde <- (muhat_x - mubar_x)
    var_y <- (y - tau_x)
    
    ## Put them together and square them
    squares <- rbind(apse, var_mutilde, bias2, var_y)^2
    rowMeans(squares)
  }))
}


# Apply apse_test to the example
# Note: APSE calculated using only the test sample doesn't have the additive property
degrees <- 1:15
tau.annual = getmuFun(pop, xnam, ynam)
apse_vals_test <- sapply(degrees, FUN = function(deg) {
  apse_test(Ssam, Tsam, complexity = deg, tau = tau.annual)
})
colnames(apse_vals_test) = paste("deg=", degrees, sep = "")
round(apse_vals_test, 3)


# Visualize both apse_all and apse_test
par(mfrow = c(1, 2))

plot(degrees, apse_vals[3, ], xlab = "Degree", ylab = "", type = "l", 
     ylim = c(0, 0.026), col = "firebrick", lwd = 2, main = "P")
lines(degrees, apse_vals[2, ], xlab = "Degree", ylab = "", 
      col = "steelblue", lwd = 2)
lines(degrees, apse_vals[1, ], col = "purple", lwd = 2)
lines(degrees, apse_vals[4, ], col = "black", lwd = 2)

plot(degrees, apse_vals_test[3, ], xlab = "Degree", ylab = "", type = "l", 
     ylim = c(0, 0.026), col = "firebrick", lwd = 2, main = "T")
lines(degrees, apse_vals_test[2, ], xlab = "Degree", ylab = "", 
      col = "steelblue", lwd = 2)
lines(degrees, apse_vals_test[1, ], col = "purple", lwd = 2)
lines(degrees, apse_vals_test[4, ], col = "black", lwd = 2)