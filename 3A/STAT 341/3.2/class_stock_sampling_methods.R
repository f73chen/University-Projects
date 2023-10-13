# Create a sampling mechanism
createSamplingMechanism <- function(pop, method = c("withoutReplacement", "withReplacement", 
                                                    "withUnique")) {
  
  if (method == "withoutReplacement") {
    function(sampSize) {
      sample(pop, sampSize, replace = TRUE)
    }
  } else if (method == "withReplacement") {
    function(sampSize) {
      sample(pop, sampSize, replace = FALSE)
    }
  } else if (method == "withUnique") {
    function(sampSize) {
      unique(sample(pop, sampSize, replace = TRUE))
    }
  } else {
    stop(paste("No sampling mechanism:", method))
  }
}


# For example, create SRSWOR on the population of sharks
# Returns a function that accepts the sample size and returns a sample
srswor <- createSamplingMechanism(popSharks)
srswor(5)

# Note: different sample sizes can result from this method
uniquewr <- createSamplingMechanism(popSharks, method="withUnique")
uniquewr(30)