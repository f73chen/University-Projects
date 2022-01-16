data(Loblolly)
head(Loblolly)

# Relate height and age
plot(Loblolly$age, Loblolly$height, xlab = "Age (years)", ylab = "Height (feet)", 
     main = "Loblolly Pines", col = adjustcolor("firebrick", 0.4), pch = 19)

# Fit a linear or quadratic (age) model using a power transform
par(mfrow = c(1, 2))

plot(Loblolly$age[order(Loblolly$age)], Loblolly$height[order(Loblolly$age)], 
     xlab = "Age (years)", ylab = "Height (feet)", main = "Linear", 
     col = adjustcolor("firebrick", 0.4), pch = 19)
lm.age = lm(height ~ age, data = Loblolly)
age.seq = seq(0, 30, by = 0.1)
lines(age.seq, predict(lm.age, newdata = data.frame(age = age.seq)))

plot(Loblolly$age[order(Loblolly$age)], Loblolly$height[order(Loblolly$age)], 
     xlab = "Age (years)", ylab = "Height (feet)", main = "Quadratic", 
     col = adjustcolor("firebrick", 0.4), pch = 19)
lm.age2 = lm(height ~ poly(age, 2), data = Loblolly)
lines(age.seq, predict(lm.age2, newdata = data.frame(age = age.seq)))



# Helper function: select only relevant columns from DataFrame
getXYpop <- function(xvarname, yvarname, pop) {
  popData <- pop[, c(xvarname, yvarname)]
  names(popData) <- c("x", "y")
  popData
}

# Helper function: use least squares to fit polynomial response models
library(splines)

getmuhat <- function(sampleXY, complexity) {
  formula <- paste0("y ~ ", if (complexity == 0) 
    "1" else {
      if (complexity < 20) {
        paste0("poly(x, ", complexity, ", raw = FALSE)")
        ## due to Numerical overflow
      } else {
        ## if complexity >= 20 use a spline.
        paste0("bs(x, ", complexity, ")")
      }
    })
  
  fit <- lm(as.formula(formula), data = sampleXY)
  
  ## From this we construct the predictor function
  muhat <- function(x) {
    if ("x" %in% names(x)) {
      ## x is a dataframe containing the variate named by xvarname
      newdata <- x
    } else ## x is a vector of values that needs to be a data.frame
    {
      newdata <- data.frame(x = x)
    }
    ## The suppress warnings prediction
    suppressWarnings({
      ypred = predict(fit, newdata = newdata, silent = TRUE)
    })
    ypred
  }
  ## muhat is the function that we need to calculate values at any x, so we
  ## return this function from getmuhat
  muhat
}


# Helper function: plot the Loblolly Pine data and overlay the fitted model muhat
plotLoblollyfit <- function(muhat, complexity = NULL) {
  if (is.null(complexity)) 
    title = bquote(hat(mu) ~ "(Piecewise)") else title = bquote(hat(mu) ~ "(degree =" ~ .(complexity) * ")")
    plot(Loblolly[, c("age", "height")], main = title, xlab = "Age (years)", 
         ylab = "Height (feet)", pch = 19, col = adjustcolor("black", 0.5))
    xlim = extendrange(Loblolly[, "age"])
    curve(muhat, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
          lwd = 2, n = 1000)
}

# Use the helper functions to fit and plot the quadratic model
Lobpop <- getXYpop(xvarname = "age", yvarname = "height", pop = Loblolly)
muhat <- getmuhat(Lobpop, complexity = 2)
plotLoblollyfit(muhat, complexity = 2)

# Try fitting higher order polynomials
par(mfrow = c(2, 3), mar = 2.5 * c(1, 1, 1, 0.1))
dset = 0:5
muhats = lapply(dset, getmuhat, sampleXY = Lobpop)
for (deg in dset) plotLoblollyfit(muhats[[deg + 1]], complexity = deg)


# Use APSE (or MSE) to quantify the accuracy of each model
apse <- function(y, x, predfun) { mean((y - predfun(x))^2, na.rm = TRUE) }


# Calculate the APSE over the entire population for each model
dset = 0:5
Lob.apse = unlist(lapply(muhats, apse, y = Lobpop$y, x = Lobpop$x))

temp = rbind(0:5, round(unlist(Lob.apse), 2))
row.names(temp) = c("Polynomial Degree", "APSE")
dimnames(temp)[[2]] = rep("", 6)
temp



# Fit piecewise function (since there are only 6 unique x-values)
unique(Loblolly$age)


# Consider three approaches: Piecewise constant with...
  # Linear interpolation (getmuFun)
  # Each unique age defining the left endpoint of a piece (getmuFun2)
  # Each unique age in the middle of a piece (getmuFun3)

getmuFun <- function(pop, xvarname, yvarname) {
  pop = na.omit(pop[, c(xvarname, yvarname)])
  # rule = 2 means return the nearest y-value when extrapolating, same as above.  
  # ties = mean means that repeated x-values have their y-values averaged, as above.
  muFun = approxfun(pop[, xvarname], pop[, yvarname], rule = 2, ties = mean)
  return(muFun)
}

getmuFun2 <- function(pop, xvarname, yvarname) {
  pop = na.omit(pop[, c(xvarname, yvarname)])
  muFun = approxfun(pop[, xvarname], pop[, yvarname], method = "constant", 
                    rule = 2, ties = mean, f = 1/2)
  return(muFun)
}

getmuFun3 <- function(pop, xvarname, yvarname) {
  ## First remove NAs
  pop <- na.omit(pop[, c(xvarname, yvarname)])
  x <- pop[, xvarname]
  y <- pop[, yvarname]
  xks <- unique(x)
  muVals <- sapply(xks, FUN = function(xk) {
    mean(y[x == xk])
  })
  ## Put the values in the order of xks
  ord <- order(xks)
  xks <- xks[ord]
  xkRange <- xks[c(1, length(xks))]
  minxk <- min(xkRange)
  maxxk <- max(xkRange)
  ## mu values
  muVals <- muVals[ord]
  muRange <- muVals[c(1, length(muVals))]
  muFun <- function(xVals) {
    ## vector of predictions same size as xVals and NA in same locations
    predictions <- xVals
    ## Take care of NAs
    xValsLocs <- !is.na(xVals)
    ## Just predict non-NA xVals
    predictions[xValsLocs] <- sapply(xVals[xValsLocs], FUN = function(xVal) {
      if (xVal < minxk) {
        result <- muRange[1]
      } else if (xVal > maxxk) {
        result <- muRange[2]
      } else if (any(xVal == xks)) {
        result <- muVals[xks == xVal]
      } else {
        xlower <- max(c(minxk, xks[xks < xVal]))
        xhigher <- min(c(maxxk, xks[xks >= xVal]))
        mulower <- muVals[xks == xlower]
        muhigher <- muVals[xks == xhigher]
        
        midx = (xlower + xhigher)/2
        if (xVal <= midx) 
          result <- mulower else result <- muhigher
      }
      result
    })
    ## Now return the predictions (including NAs)
    predictions
  }
  muFun
}


# Fit the three functions to the population
par(mfrow = c(1, 3), mar = 2.5 * c(1, 1, 1, 0.1))

mu.age = getmuFun(pop = Loblolly, xvarname = "age", yvarname = "height")
plotLoblollyfit(mu.age)

mu.age2 = getmuFun2(pop = Loblolly, xvarname = "age", yvarname = "height")
plotLoblollyfit(mu.age2)

mu.age3 = getmuFun3(pop = Loblolly, xvarname = "age", yvarname = "height")
plotLoblollyfit(mu.age3)


# Understand how the functions differ by evaluating them before, at, and after x=10
x = c(9.9, 10, 10.1)
round(cbind(x, mu = mu.age(x), mu2 = mu.age2(x), mu3 = mu.age3(x)), 2)




# Compare annual global temperatures over time
# Fit a variety of polynomials and piecewise functions to find the most appropriate one
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "temperature.csv", sep="/")
temperature <- read.csv(filename, header=TRUE)
head(temperature)

plot(temperature$YEAR, temperature$ANNUAL, xlab = "YEAR", ylab = "Annual Temperature", 
     main = "Global Annual Temperature", col = adjustcolor("firebrick", 0.6), 
     pch = 19)



# Helper function: plot the temperature data and overlay the fitted model muhat
plotTemperaturefit <- function(muhat, complexity = NULL) {
  if (is.null(complexity)) 
    title = "" else title = paste0("polynomial degree=", complexity, "")
    plot(temperature[, c("YEAR", "ANNUAL")], main = title, xlab = "age", ylab = "height", 
         pch = 19, col = adjustcolor("Grey", 0.8))
    xlim = extendrange(temperature[, "YEAR"])
    curve(muhat, from = xlim[1], to = xlim[2], add = TRUE, col = "steelblue", 
          lwd = 2, n = 1000)
}


# Polynomial regression (low degree)
par(mfrow = c(2, 3), mar = 2.5 * c(1, 1, 1, 0.1))
temppop = getXYpop(xvarname = "YEAR", yvarname = "ANNUAL", pop = temperature)
dset = 0:5
muhats = lapply(dset, getmuhat, sampleXY = temppop)
for (i in 1:length(dset)) plotTemperaturefit(muhats[[i]], dset[i])

# Calculate the APSE over the population for each model
dset = 0:5
temp.apse = unlist(lapply(muhats, apse, y = temppop$y, x = temppop$x))
tab = rbind(0:5, round(unlist(temp.apse), 4))
row.names(tab) = c("Polynomial Degree", "APSE")
dimnames(tab)[[2]] = rep("", 6)
tab


# Polynomial regression (high degree)
par(mfrow = c(2, 3), mar = 2.5 * c(1, 1, 1, 0.1))
dset = c(1, 5, 10, 15, 20, 25)
muhats = lapply(dset, getmuhat, sampleXY = temppop)
for (i in 1:length(dset)) plotTemperaturefit(muhats[[i]], dset[i])

# Calculate the APSEs
temp.apse = unlist(lapply(muhats, apse, y = temppop$y, x = temppop$x))
dset = c(1, 5, 10, 15, 20, 25)
tab = rbind(dset, round(unlist(temp.apse), 4))
row.names(tab) = c("Polynomial Degree", "APSE")
dimnames(tab)[[2]] = rep("", 6)
tab

##                                                              
## Polynomial Degree 1.0000 5.0000 1e+01 15.0000 20.0000 25.0000
## APSE              0.0258 0.0132 9e-03  0.0084  0.0077  0.0071



# Fit piecewise constant functions
par(mfrow = c(1, 3), mar = 2.5 * c(1, 1, 1, 0.1))

mu.year = getmuFun(pop = temperature, xvarname = "YEAR", yvarname = "ANNUAL")
plotTemperaturefit(mu.year)

mu.year2 = getmuFun2(pop = temperature, xvarname = "YEAR", yvarname = "ANNUAL")
plotTemperaturefit(mu.year2)

mu.year3 = getmuFun3(pop = temperature, xvarname = "YEAR", yvarname = "ANNUAL")
plotTemperaturefit(mu.year3)