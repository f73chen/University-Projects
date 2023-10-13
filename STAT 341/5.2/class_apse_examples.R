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
  val.rY  = c( mean(ty[tx == range.X[1]]), 
               mean(ty[tx == range.X[2]]) )
  
  ## From this we construct the predictor function
  muhat <- function(x){
    if ("x" %in% names(x)) {
      ## x is a dataframe containing the variate named
      ## by xvarname
      newdata <- x
    } else 
      ## x is a vector of values that needs to be a data.frame
    { newdata <- data.frame(x = x) }
    ## The prediction
    ## 
    val = predict(fit, newdata = newdata)
    val[newdata$x < range.X[1]] = val.rY[1]
    val[newdata$x > range.X[2]] = val.rY[2]
    val
  }
  ## muhat is the function that we need to calculate values 
  ## at any x, so we return this function from getmuhat
  muhat
}


getmubar <- function(muhats) {
  function(x) {
    Ans <- sapply(muhats, FUN=function(muhat){muhat(x)})
    apply(Ans, MARGIN=1, FUN=mean)
  }
}

getmuFun <- function(pop, xvarname, yvarname){
  pop   = na.omit(pop[, c(xvarname, yvarname)])
  
  # rule = 2 means return the nearest y-value when extrapolating, same as above.
  # ties = mean means that repeated x-values have their y-values averaged, as above.
  tauFun = approxfun(pop[,xvarname], pop[,yvarname], rule = 2, ties = mean)
  return(tauFun)
}

apse_all <- function(Ssamples, Tsamples, complexity, tau){
  ## average over the samples S
  ##
  N_S <- length(Ssamples)
  muhats <- lapply(Ssamples, 
                   FUN=function(sample) getmuhat(sample, complexity)
  )
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  rowMeans(sapply(1:N_S, 
                  FUN=function(j){
                    T_j <- Tsamples[[j]]
                    S_j <- Ssamples[[j]]
                    muhat <- muhats[[j]]
                    ## Take care of any NAs
                    T_j <- na.omit(T_j)
                    y <- c(S_j$y, T_j$y)
                    x <- c(S_j$x, T_j$x)
                    
                    tau_x    <- tau(x)
                    muhat_x <- muhat(x)
                    mubar_x <- mubar(x)
                    
                    apse        <- (y - muhat_x)
                    bias2       <- (mubar_x - tau_x)
                    var_mutilde <-  (muhat_x - mubar_x)
                    var_y       <- (y - tau_x)
                    
                    squares <- rbind(apse, var_mutilde, bias2, var_y)^2
                    
                    ## return means
                    rowMeans(squares)
                  }
  ))
}

apse_test <- function(Ssamples, Tsamples, complexity, tau){
  ## average over the samples S
  ##
  N_S <- length(Ssamples)
  muhats <- lapply(Ssamples, 
                   FUN=function(sample) getmuhat(sample, complexity)
  )
  ## get the average of these, mubar
  mubar <- getmubar(muhats)
  
  rowMeans(sapply(1:N_S, 
                  FUN=function(j){
                    T_j <- Tsamples[[j]]
                    muhat <- muhats[[j]]
                    ## Take care of any NAs
                    T_j <- na.omit(T_j)
                    y <- T_j$y
                    x <- T_j$x
                    tau_x <- tau(x)
                    muhat_x <- muhat(x)
                    mubar_x <- mubar(x)
                    
                    apse         <- (y - muhat_x)
                    bias2        <- (mubar_x - tau_x)
                    var_mutilde <-  (muhat_x - mubar_x)
                    var_y <- (y - tau_x)
                    
                    ## Put them together and square them
                    squares <- rbind(apse, var_mutilde, bias2, var_y)^2
                    rowMeans(squares)
                  }
  ))
}



# Example 1: Global Temperature
# Sensitivity to n and Ns
  # Compare Ns = 9 and n = 25 with Ns = 25 and n = 100
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "temperature.csv", sep="/")
temperature <- read.csv(filename, header=TRUE)

plot(temperature$YEAR, temperature$ANNUAL, xlab = "YEAR", ylab = "Annual Temperature", 
     main = "Global Annual Temperature", col = adjustcolor("black", 0.5), pch = 19)

# Take Ns = 9 samples of size n = 25 from the population
xnam <- "YEAR"
ynam <- "ANNUAL"
pop <- temperature
n <- 25
N_S <- 9

set.seed(1)  # for reproducibility
samples <- lapply(1:N_S, FUN = function(i) {
  getSampleComp(pop, n)
})
Ssam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, Si, pop)
})
Tsam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, !Si, pop)
})

# Fit different degree polynomials
degrees <- 1:15
tau.annual = getmuFun(pop, xnam, ynam)
apse_vals <- sapply(degrees, FUN = function(deg) {
  apse_all(Ssam, Tsam, complexity = deg, tau = tau.annual)
})
colnames(apse_vals) = paste("deg=", degrees, sep = "")
round(apse_vals, 3)

# Visualize fits
plot(degrees, apse_vals[3, ], xlab = "Degree", ylab = "", type = "l", 
     ylim = c(0, 0.026), col = "firebrick", lwd = 2)
lines(degrees, apse_vals[2, ], xlab = "Degree", ylab = "", 
      col = "steelblue", lwd = 2)
lines(degrees, apse_vals[1, ], col = "purple", lwd = 2)
lines(degrees, apse_vals[4, ], col = "black", lwd = 2)


# Instead, take Ns = 25 samples of size n = 100
N_S <- 25
xnam <- "YEAR"
ynam <- "ANNUAL"
pop <- temperature
n <- 100


set.seed(341)  # for reproducibility
samples <- lapply(1:N_S, FUN = function(i) {
  getSampleComp(pop, n)
})
Ssam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, Si, pop)
})
Tsam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, !Si, pop)
})

degrees <- 1:20
tau.annual = getmuFun(pop, xnam, ynam)

apse_vals <- sapply(degrees, FUN = function(deg) {
  apse_all(Ssam, Tsam, complexity = deg, tau = tau.annual)
})

apse_vals_test <- sapply(degrees, FUN = function(deg) {
  apse_test(Ssam, Tsam, complexity = deg, tau = tau.annual)
})

colnames(apse_vals) = paste("deg=", degrees, sep = "")
colnames(apse_vals_test) = paste("deg=", degrees, sep = "")

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





# Example 2: Loblolly Pine data
# Visualize the relationship between height and age:
par(mfrow = c(1, 1))
plot(Loblolly$age, Loblolly$height, xlab = "Age (years)", ylab = "Height (feet)", 
     main = "Loblolly Pines", col = adjustcolor("firebrick", 0.4), pch = 19)

# Set Ns = 25 and n = 40
N_S <- 25
xnam <- "age"
ynam <- "height"
pop <- Loblolly
n <- 40

set.seed(341)  # for reproducibility
samples <- lapply(1:N_S, FUN = function(i) {
  getSampleComp(pop, n)
})
Ssam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, Si, pop)
})
Tsam <- lapply(samples, FUN = function(Si) {
  getXYSample(xnam, ynam, !Si, pop)
})

# Fit polynomials of different degrees to each of the Ns = 25 samples
  # And calculate the APSE
degrees <- 1:5
tau.age = getmuFun(pop, xnam, ynam)
set.seed(341)
apse_vals <- sapply(degrees, FUN = function(deg) {
  apse_test(Ssam, Tsam, complexity = deg, tau = tau.age)
})
colnames(apse_vals) = paste("deg=", degrees, sep = "")
round(apse_vals, 4)