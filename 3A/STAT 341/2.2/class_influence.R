filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)

y = agpop$farms87
ybar = mean(y)
ybar

# Using a loop to calculate each delta
delta = rep(0, length(y))
for (i in 1:length(y)) {
  # y[-i] removes element i from the vector
  delta[i] = ybar - mean(y[-i])
}
delta

# Creating a matrix of populations of size N-1 and using apply
N = length(y)
popN_1 = matrix(rev(y), nrow=N-1, ncol=N)
attN_1 = apply(popN_1, 2, mean)
delta = ybar - attN_1
delta

# Using a loop and the simplified expression
delta = rep(0, length(y))
for(i in 1:length(y)) {
  delta[i] = (y[i]-ybar)/(length(y)-1)
}
delta

# Summing two numeric vectors
delta = (y-ybar)/(length(y)-1)
delta

# Plot the influence by observation number
y = agpop$farms87
N = length(y)
delta = sum(y)/N - (sum(y)-y)/(N-1)
par(mfrow=c(1,2))
plot(delta, main="Influence for Average", pch=19,
     col=adjustcolor("black", alpha=0.2),
     xlab="Index", ylab=bquote(Delta))
plot(y, delta, main="Influence for Average", pch=19,
     col=adjustcolor("black", alpha=0.2),
     xlab="Index", ylab=bquote(Delta))
