# Helper functions

# Calculates the APSE for a single sample of data
  # Based on a predictor function predfun
ave_y_mu_sq <- function(sample, predfun, na.rm = TRUE) {
  mean((sample$y - predfun(sample$x))^2, na.rm = na.rm)
}

# Calculates the average squared distance between two predictor functions
  # Across all values in x
ave_mu_mu_sq <- function(predfun1, predfun2, x, na.rm = TRUE) {
  mean((predfun1(x) - predfun2(x))^2, na.rm = na.rm)
}

# Given a population of size N and a sample of size n
  # Return an N element vector containing n TRUE and N-n FALSE values
  # TRUE --> inclusion of a unit in the sample
  # FALSE --> inclusion of a unit in the test set
getSampleComp <- function(pop, size, replace = FALSE) {
  N <- popSize(pop)
  samp <- rep(FALSE, N)
  samp[sample(1:N, size, replace = replace)] <- TRUE
  samp
}

# Extracts a given sample of units from a given population
  # And returns a dataframe containing just x and y variates
getXYSample <- function(xvarname, yvarname, samp, pop) {
  sampData <- pop[samp, c(xvarname, yvarname)]
  names(sampData) <- c("x", "y")
  sampData
}

# Calculate the population size
popSize <- function(pop) {
  nrow(as.data.frame(pop))
}

# Calculate the sample size
sampSize <- function(samp) {
  popSize(samp)
}

# Use least squares to fit polynomial response models
  # For arbitrary degrees in x
# Performs the extrapolation
  # Previously referred to as getmuhat.ext
getmuhat <- function(sampleXY, complexity = 1) {
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

# Fits a piecewise constant to the population with linear interpolation
getmuFun <- function(pop, xvarname, yvarname) {
  pop = na.omit(pop[, c(xvarname, yvarname)])
  tauFun = approxfun(pop[, xvarname], pop[, yvarname], rule = 2, ties = mean)
  return(tauFun)
}