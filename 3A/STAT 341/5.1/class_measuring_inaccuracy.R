filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "temperature.csv", sep="/")
temperature <- read.csv(filename, header=TRUE)

# Helper functions for fitting higher order polynomials
  # From accuracy_of_prediction
getXYpop <- function(xvarname, yvarname, pop) {
  popData <- pop[, c(xvarname, yvarname)]
  names(popData) <- c("x", "y")
  popData
}

getmuhat <- function(sampleXY, complexity) {
  formula <- paste0("y ~ ", 
    if (complexity == 0) "1" 
    else {
      if (complexity < 20) { paste0("poly(x, ", complexity, ", raw = FALSE)") } 
      else { paste0("bs(x, ", complexity, ")") }
    })
  fit <- lm(as.formula(formula), data = sampleXY)
  
  ## From this we construct the predictor function
  muhat <- function(x) {
    if ("x" %in% names(x)) { newdata <- x } 
    else { newdata <- data.frame(x = x) }
    suppressWarnings({
      ypred = predict(fit, newdata = newdata, silent = TRUE)
    })
    ypred
  }
  muhat
}

apse <- function(y, x, predfun) { mean((y - predfun(x))^2, na.rm = TRUE) }

getmuFun <- function(pop, xvarname, yvarname) {
  pop = na.omit(pop[, c(xvarname, yvarname)])
  muFun = approxfun(pop[, xvarname], pop[, yvarname], rule = 2, ties = mean)
  return(muFun)
}



# More helper functions

# Given a population (pop) of size N and a sample of size n
  # Return an N-element vector containing n TRUE and N-n FALSE values
  # TRUE = unit is included in the training set
  # FALSE = unit is included in the test set
getSampleComp <- function(pop, size, replace = FALSE) {
  N <- popSize(pop)
  samp <- rep(FALSE, N)
  samp[sample(1:N, size, replace = replace)] <- TRUE
  samp
}

# Extracts a given sample of units from a population
  # Returns a dataframe containing just x and y
getXYSample <- function(xvarname, yvarname, samp, pop) {
  sampData <- pop[samp, c(xvarname, yvarname)]
  names(sampData) <- c("x", "y")
  sampData
}

popSize <- function(pop) {
  nrow(as.data.frame(pop))
}

sampSize <- function(samp) {
  popSize(samp)
}




# Visualize the temperature dataset
plot(temperature$YEAR, temperature$ANNUAL, xlab = "YEAR", ylab = "Annual Temperature", 
     main = "Global Annual Temperature", col = adjustcolor("firebrick", 0.6), 
     pch = 19)
temppop = getXYpop(xvarname = "YEAR", yvarname = "ANNUAL", pop = temperature)


# Sample 25 observations
set.seed(341)
sample.temperature <- getSampleComp(temperature, 25)
sample.Data = getXYSample("YEAR", "ANNUAL", samp = sample.temperature, pop = temperature)
plot(sample.Data, main = "Sample Data", xlab = "Year", ylab = "Annual Temperature", 
     pch = 19, col = adjustcolor("black", 0.5), xlim = range(temperature$YEAR))


# Fit models on the training set
  # Evaluate on both training and test set
# Helper function: fit a model to S and plot both S and T with the model overlay
plotTemperatureSTfit <- function(muhat = NULL, Sam = NULL, complexity = NULL) {
  
  if (is.null(complexity)) {
    titleS <- bquote(hat(mu) ~ "(piecewise) on S")
    titleT <- bquote(hat(mu) ~ "(piecewise) on T")
  } else {
    titleS <- bquote(hat(mu) ~ "(degree =" ~ .(complexity) * ") on S")
    titleT <- bquote(hat(mu) ~ "(degree =" ~ .(complexity) * ") on T")
  }
  title = c(paste0("muhat (degree=", complexity, ") on S"), 
            paste0("muhat (degree=", complexity, ") on T"))
  
  xlim <- extendrange(temperature[, "YEAR"])
  ylim <- extendrange(temperature[, "ANNUAL"])
  
  plot(temperature[Sam, c("YEAR", "ANNUAL")], main = titleS, xlab = "Year", 
       ylab = "Annual Temperature", pch = 19, col = adjustcolor("black", 0.5), 
       xlim = xlim, ylim = ylim)
  
  curve(muhat, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
        lwd = 2, n = 1000)
  
  Tpop = !Sam
  
  plot(temperature[Tpop, c("YEAR", "ANNUAL")], main = titleT, xlab = "Year", 
       ylab = "Annual Temperature", pch = 19, col = adjustcolor("black", 0.5), 
       xlim = xlim, ylim = ylim)
  
  curve(muhat, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
        lwd = 2, n = 1000)
}


# Example: linear predictor
muhat <- getmuhat(sample.Data, 1)
par(mfrow = c(1, 2))
plotTemperatureSTfit(muhat, sample.temperature, 1)

# APSE over sample S:
apse(y = temperature[sample.temperature, "ANNUAL"], 
     x = temperature[sample.temperature, "YEAR"], 
     predfun = muhat)

# APSE over test set T:
Tpop <- !sample.temperature
apse(y = temperature[Tpop, "ANNUAL"], 
     x = temperature[Tpop, "YEAR"], 
     predfun = muhat)

# Consider higher order polynomials
dset = c(2, 4, 10)
muhats = lapply(dset, getmuhat, sampleXY = sample.Data)
muhatFun = getmuFun(sample.Data, "x", "y")

par(mfcol = c(2, 4), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in 1:length(dset)) 
  plotTemperatureSTfit(muhats[[i]], sample.temperature, dset[i])
plotTemperatureSTfit(muhatFun, sample.temperature)


# Calculate the APSE over S and T for each model
apseST <- function(y, x, sam, predfun) {
  apseS = apse(y[sam], x[sam], predfun)
  Tpop = !sam
  apseT = apse(y[Tpop], x[Tpop], predfun)
  c(apseS, apseT)
}

muhats[[4]] = muhatFun

temp.apse = sapply(muhats, apseST, y = temppop$y, x = temppop$x, sam = sample.temperature)

rownames(temp.apse) = c("APSE on S", "APSE on T")
colnames(temp.apse) = c(paste("deg=", dset), "piecewise linear ")
round(temp.apse, 3)




# Modify getmuhat function to extrapolate beyond the min and max of the sample
  # Set to constants
getmuhat.ext <- function(sampleXY, complexity = 1) {
  formula <- paste0("y ~ ", if (complexity == 0) 
    "1" else {
      if (complexity < 3) { paste0("poly(x, ", complexity, ", raw = FALSE)") } 
      else { paste0("bs(x, ", complexity, ")") }
    })
  
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
    suppressWarnings({
      ypred = predict(fit, newdata = newdata, silent = TRUE)
    })
    ypred[newdata$x < range.X[1]] = val.rY[1]
    ypred[newdata$x > range.X[2]] = val.rY[2]
    ypred
  }
  muhat
}



# Re-create the plots from before with the new muhat
library(splines)

dset = c(2, 4, 10, 20)
muhats = lapply(dset, getmuhat.ext, sampleXY = sample.Data)
muhatFun = getmuFun(sample.Data, "x", "y")

par(mfcol = c(2, 4), mar = 2.5 * c(1, 1, 1, 0.1))
for (i in 1:length(dset)) 
  plotTemperatureSTfit(muhats[[i]], sample.temperature, dset[i])




# Consider a larger collection of polynomials to pick the best model
  # Compare APSE on the sample and complement set:
dset = 0:25
muhats = lapply(dset, getmuhat.ext, sampleXY = sample.Data)

temp.apse = sapply(muhats, apseST, y = temppop$y, x = temppop$x, sam = sample.temperature)

rownames(temp.apse) = c("APSE on S", "APSE on T")
colnames(temp.apse) = paste("deg=", dset)

par(mfrow=c(1,1))
plot(dset, temp.apse[1, ], type = "l", col = 1, lwd = 2, xlab = "Degree", ylab = "APSE", 
     main = "APSE on a Sample and Complement")
lines(dset, temp.apse[2, ], type = "l", col = 4, lwd = 2)
legend("top", legend = paste("APSE on ", c("S", "T")), 
       col = c(1, 4), lwd = c(2, 2), bty = "n")