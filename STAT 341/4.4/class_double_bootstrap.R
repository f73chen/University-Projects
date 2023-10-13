filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
popSharks <- rownames(sharks)

# The bootstrap_t_interval function is a general-purpose function used to calculate
# a bootstrap-t CI for any attribute
  # Inputs attribute 'a'
a <- function(S) {
  mean(sharks[S, "Length"])
}

bootstrap_t_interval <- function(S, a, confidence = 0.95, B = 1000, D = 30) {
  ## Here S is the sample, a is a scalar-valued function a(S) of a sample S
    ## which returns the value for S of that attribute of interest. 
  ## Confidence is the level of confidence. 
  ## B is the outer bootstrap count of replicates used to calculate the lower 
    ## and upper limits.
  ## D is the inner bootstrap count of replicates used to estimate the standard 
    ## deviation of the sample attribute for each (outer) bootstrap sample
  Pstar <- S
  aPstar <- a(Pstar)
  ## get (outer) bootstrap values
  bVals <- sapply(1:B, FUN = function(b) {
    Sstar <- getSample(Pstar, sampleSize, replace = TRUE)
    aSstar <- a(Sstar)
    ## get (inner) bootstrap values to estimate the SD
    Pstarstar <- Sstar
    SD_aSstar <- sdn(sapply(1:D, FUN = function(d) {
      Sstarstar <- getSample(Pstarstar, sampleSize, replace = TRUE)
      ## return the attribute value
      a(Sstarstar)
    }))
    z <- (aSstar - aPstar)/SD_aSstar
    ## Return the two values
    c(aSstar = aSstar, z = z)
  })
  SDhat <- sdn(bVals["aSstar", ])
  zVals <- bVals["z", ]
  ## Now use these zVals to get the lower and upper c values.
  cValues <- quantile(zVals, probs = c((1 - confidence)/2, (confidence + 1)/2), 
                      na.rm = TRUE)
  cLower <- min(cValues)
  cUpper <- max(cValues)
  interval <- c(lower = aPstar - cUpper * SDhat, middle = aPstar, upper = aPstar - 
                  cLower * SDhat)
  interval
}


# 95% bootstrap-t CI for the average shark length:
popSize <- function(pop) {
  if (is.vector(pop))
  {if (is.logical(pop)) 
    ## then assume TRUE values identify units
    sum(pop) else length(pop)}
  else nrow(pop)
}

getSample <- function(pop, size, replace=FALSE) {
  N <- popSize(pop)
  pop[sample(1:N, size, replace = replace)]
}

sdn <- function( y.pop ) { 
  N = length(y.pop)
  sqrt( var(y.pop)*(N-1)/(N)  )    } 

avePop <- mean(sharks[, "Length"])
sampleSize <- 6
S <- getSample(popSharks, size = 6, replace = TRUE)
bootstrap_t_interval(S, a)



# Estimate coverage probability (CI) with Double Bootstrap
numIntervals <- 100
samps <- sapply(1:numIntervals, FUN = function(i) getSample(1:65, sampleSize))

confidence <- 0.95
B <- 1000
set.seed(341)

intervals <- sapply(1:numIntervals, FUN = function(i) {
  bootstrap_t_interval(samps[, i], a = a, confidence = confidence, B = B, 
                       D = 30)
})