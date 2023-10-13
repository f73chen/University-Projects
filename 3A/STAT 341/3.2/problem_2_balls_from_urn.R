createSamplingMechanism <- function (pop, method = c("withoutReplacement","withReplacement", 
                                                     "withUnique")) {
  
  method = match.arg(method)
  switch (
    method,
    "withReplacement"  = function(sampSize) {
      sample(pop, sampSize, replace=TRUE)
    },
    "withoutReplacement" = function(sampSize) {
      sample(pop, sampSize, replace=FALSE)
    },
    "withUnique" = function(sampSize) {
      unique(sample(pop, sampSize, replace=TRUE))
    },
    stop(paste("No sampling mechanism:", method))
  )
}


# All plots are roughly symmetric
# The estimate of the proportion ranges from 0.1 to 0.8, which is wide
N = 40
M = 20
ball.pop = 1:N
ball.col = rep(1:0, times=c(M, N-M)) #x=1 means black

d = 25
m = 5000

sam.Scheme = createSamplingMechanism(pop=ball.pop, method = "withUnique") 

set.seed(341)
M.samples <- Map( function(rep){ sam.Scheme(sampSize = d) }, 1:m)

x  = unlist( Map( function(sam){   sum(ball.col[sam]) }, M.samples ) )
n  = unlist( Map( function(sam){ length(ball.col[sam]) }, M.samples ) )

ratio = x/n

par(mfrow=c(1,3))
hist(x,col='grey')
hist(n,col='grey')
hist(ratio,col='grey')



# Scatterplot of x vs. n shows a positive relationship
par(mfrow=c(1,2))
plot( x, n, pch=19, cex=2 )
plot( x, n, pch=19, col=adjustcolor("black", alpha = 0.05), cex=2 )