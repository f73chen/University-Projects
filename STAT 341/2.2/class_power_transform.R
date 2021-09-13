powerfun <- function(x, alpha) {
  if (sum(x <= 0) > 0) stop("x must be positive")
  if (alpha == 0) { log(x) }
  else if (alpha > 0) { x^alpha }
  else { -x ^ alpha }
}

# Apply power function to the number of farms in 1987
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "agpop_data.csv", sep="/")
agpop <- read.csv(filename, header=TRUE)
agpop[agpop == -99] = NA
x = agpop$farms87

par(mfrow=c(3, 3))
a = seq(-1/2, 1.5, length.out=9)

for (i in 1:9) {
  hist(powerfun(x + 1, a[i]),
       col=adjustcolor("grey", alpha=0.5),
       main=bquote(alpha == .(a[i])), xlab="", breaks=50)
}

# Apply power transformations on scatterplots
par(mfrow=c(3, 3), mar=2.5*c(1, 1, 1, 0.1))
a = rep(c(0, 1/4, 1/2), each=3)
b = rep(c(0, 1/4, 1/2), times=3)
subdata = na.omit(agpop[, c('farms87', 'acres87')])
fa = subdata$farms87
ac = subdata$acres87

for (i in 1:9) {
  plot(powerfun(fa+1, a[i]), powerfun(ac+1, b[i]),
       pch=19, cex=0.5, col=adjustcolor("black", alpha=0.3),
       xlab="", ylab="", main = bquote(alpha[x] == .(a[i]) ~ "," ~  alpha[y] == .(b[i])))
}