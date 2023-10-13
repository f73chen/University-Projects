# Calculate p-value* --> the p-value that accounts for multiple discrepancy
# measures in the context of multiple testing
# Note that sapply, Map, and Reduce are used instead of nested loops for efficiency
calculateSLmulti <- function(pop, discrepancies, M_outer = 1000, M_inner) {
  # pop is a list whose two members are two sub-populations
  
  if (missing(M_inner)) 
    M_inner <- M_outer
  ## Local function to calculate the significance levels over the discrepancies
  ## and return their minimum
  
  getSLmin <- function(basePop, discrepanies, M) {
    observedVals <- sapply(discrepancies, FUN = function(discrepancy) {
      discrepancy(basePop)
    })
    
    K <- length(discrepancies)
    
    total <- Reduce(function(counts, i) {
      # mixRandomly mixes the two populations randomly, so the new sub-populations
      # are indistinguishable
      NewPop <- mixRandomly(basePop)
      
      ## calculate the discrepancy and counts
      Map(function(k) {
        Dk <- discrepancies[[k]](NewPop)
        if (Dk >= observedVals[k]) 
          counts[k] <<- counts[k] + 1
      }, 1:K)
      counts
    }, 1:M, init = numeric(length = K))
    
    SLs <- total/M
    min(SLs)
  }
  
  SLmin <- getSLmin(pop, discrepancies, M_inner)
  
  total <- Reduce(function(count, m) {
    basePop <- mixRandomly(pop)
    if (getSLmin(basePop, discrepancies, M_inner) <= SLmin) 
      count + 1 else count
  }, 1:M_outer, init = 0)
  
  SLstar <- total/M_outer
  SLstar
}



# For example, compare the lengths of Aus vs. USA sharks
  # Two discrepancies: one compares averages and the other compares stdevs
  # Technically multiple testing scenario because testing the same null hypothesis with multiple discrepancy measures
mixRandomly <- function(pop) {
  pop1 <- pop$pop1
  n_pop1 <- nrow(pop1)
  
  pop2 <- pop$pop2
  n_pop2 <- nrow(pop2)
  
  mix <- rbind(pop1, pop2)
  select4pop1 <- sample(1:(n_pop1 + n_pop2), n_pop1, replace = FALSE)
  
  new_pop1 <- mix[select4pop1, ]
  new_pop2 <- mix[-select4pop1, ]
  list(pop1 = new_pop1, pop2 = new_pop2)
}


getSDRatioFn <- function(variate) {
  function(pop) {
    sd(pop$pop1[, variate])/sd(pop$pop2[, variate])
  }
}

getAbsAveDiffsFn <- function(variate) {
  function(pop) {
    abs(mean(pop$pop1[, variate]) - mean(pop$pop2[, variate]))
  }
}

discrepancies <- list(getAbsAveDiffsFn("Length"), getSDRatioFn("Length"))

filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "sharks.csv", sep="/")
sharks <- read.csv(filename, header=TRUE)
pop <- list(pop1 = subset(sharks, sharks$Australia == 1), 
            pop2 = subset(sharks, sharks$USA == 1))

# This step takes very long, so use smaller values of M for demonstration:
# Since the p-value is large (0.56), there is no evidence against H0
set.seed(341)
SLstar = calculateSLmulti(pop, discrepancies, M_outer = 100, M_inner = 100)
SLstar
