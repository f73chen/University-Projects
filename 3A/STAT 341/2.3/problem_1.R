data(faithful)

powerfun <- function(x, alpha) {
  if(sum(x <= 0) > 1) stop("x must be positive")
  if (alpha == 0)
    log(x)
  else if (alpha > 0) {
    x^alpha
  } else -x^alpha
}

# The values are not continuous
# There is a higher prevalence of multiples of 0.005 and 0.003 than normal
faithful$eruptions

# Calculate Pearson's second skewness coefficient
sdn <- function( z ) { 
  N = length(z)
  sd(z)*sqrt( (N-1)/N )
}
skew  <- function(z) { 3*(mean(z) - median(z))/sdn(z) }

# A function that makes a skew function of power-transformed inputs
createSkewFunction <- function(pop){
  function(alpha) {
    skew(powerfun(pop, alpha))
  }
}

er.skew <- createSkewFunction(faithful$eruptions)
wa.skew <- createSkewFunction(faithful$waiting)
c(er.skew(alpha=1), wa.skew(alpha=1))

# Use uniroot to find power transformation with skew = 0
alpha.er = uniroot(er.skew, interval=c(-20, 20))$root
alpha.wa = uniroot(wa.skew, interval=c(-20, 20))$root
c(alpha.er, alpha.wa)

# Plot the transformed variables
plot(powerfun(eruptions, alpha.er) ~ powerfun(waiting, alpha.wa),
     data=faithful, pch=19, col=adjustcolor("firebrick", 0.33))

# Plot the original variables
# In this plot's it's easier to visually separate the two groups
plot((eruptions ~ waiting), data=faithful, 
     pch=19, col=adjustcolor("firebrick", 0.33))
