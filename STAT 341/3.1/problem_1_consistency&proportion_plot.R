library(ISLR)
data("Hitters")
C_Hitters <- na.omit(Hitters)

CHits.Experienced = C_Hitters$CHits[C_Hitters$Years>15]

hist(CHits.Experienced, col=adjustcolor('grey', alpha=0.5),
     main='Histogram of Experienced CHits', breaks=20)

# Pearson's moment coefficient of Skewness
pearson.moment.skewness = function(x){
  temp1 <- (x-mean(x))^3
  temp2 <- mean(temp1)/(sd(x)^3)
  return(temp2)
}

# Pearson's second skewness coefficient
second.skewness.coefficient = function(x){
  temp <- 3*( mean(x)-median(x) )/sd(x)
  return(temp)
}

# Bowley's measure of skewness based on the quantiles
Bowly.skewness.coefficient = function(x){
  quart = quantile(x, c(1,2,3)/4 )
  val   = (quart[1] - 2*quart[2] + quart[3])/( quart[3] - quart[1]  )
  return(val)
}

# For each skewness attribute, generate 4 histograms
# Sample sizes n = 3, 9, 13, 16
fourHist = function(attr, pop=CHits.Experienced) {
  indx = 1:length(pop)
  n = c(3, 9, 13, 16)
  par(mfrow=c(2, 2))
  
  for (i in 1:4) {
    samples <- combn(indx, n[i])
    attrSamp <- apply(samples, MARGIN=2, FUN=function(s){attr(pop[s])})
    hist(attrSamp, breaks=20, xlim=c(-2, 2.5))
    
    attrPop <- attr(pop)
    abline(v=attrPop, col='red', lty=3, lwd=2)
  }
}

# For all skewness attributes, the concentration increases with sample size
# Since the population contains one large outlier, samples don't usually contain it
  # So has negative skew from population attribute
fourHist(pearson.moment.skewness)
fourHist(second.skewness.coefficient)
fourHist(Bowly.skewness.coefficient)

# Generate consistency plots based on relative absolute sample error
# One plot for each attribute
# Include 4 curves for n = 3, 9, 13, 16
plotProportions <- function(attr, n, pop=CHits.Experienced) {
  samples <- combn(1:length(pop), n)
  popAtt = attr(pop)
  sampAtt = apply(samples, MARGIN=2, FUN=function(s){attr(pop[s])})
  
  error <- sort(abs(sampAtt - popAtt) / abs(popAtt))  # Relative error
  consistency = function(c.val){mean(error < c.val)}
  
  c.val.max = max(error) + (max(error) - min(error))/2
  c.val = seq(0, c.val.max, length=1000)
  proportion = sapply(c.val, consistency)
  
  return(list(Proportion=proportion, C.values=c.val))
}

# For all attributes, the consistency increases with sample size
# Pearson's moment coefficient is best because it flattens out fastest
  # Beware of x-axis scale
# COPIED
n=c(3,9,13,16)
Pearson1.1=plotProportions(attr=pearson.moment.skewness, n=n[1])
Pearson1.2=plotProportions(attr=pearson.moment.skewness, n=n[2])
Pearson1.3=plotProportions(attr=pearson.moment.skewness, n=n[3])
Pearson1.4=plotProportions(attr=pearson.moment.skewness, n=n[4])

plot(Pearson1.1$Proportion~Pearson1.1$C.values, main = "Person's Moment Coefficient of Skewness",
     col= 1, type='l', lwd=3,
     xlab= "Relative Sample Error (c)",
     ylab= "Proportion",xlim=c(0,2))

lines(Pearson1.2$Proportion~Pearson1.2$C.values, lwd=3,col='red')
lines(Pearson1.3$Proportion~Pearson1.3$C.values, lwd=3,col='blue')
lines(Pearson1.4$Proportion~Pearson1.4$C.values, lwd=3,col='darkgreen')

text(1.75,.1,'----- : n=3' , col='black' , cex=1.2)
text(1.75,.2,'----- : n=9' , col='red' , cex=1.2)
text(1.75,.3,'  ----- : n=13' , col='blue' , cex=1.2)
text(1.75,.4,'  ----- : n=16' , col='darkgreen' , cex=1.2)

#
Pearson2.1=plotProportions(attr=second.skewness.coefficient, n=n[1])
Pearson2.2=plotProportions(attr=second.skewness.coefficient, n=n[2])
Pearson2.3=plotProportions(attr=second.skewness.coefficient, n=n[3])
Pearson2.4=plotProportions(attr=second.skewness.coefficient, n=n[4])

plot(Pearson2.1$Proportion~Pearson2.1$C.values, main = "Person's Second Coefficient of Skewness",
     col= 1, type='l', lwd=3,
     xlab= "Relative Sample Error (c)",
     ylab= "Proportion",xlim=c(0,12))

lines(Pearson2.2$Proportion~Pearson2.2$C.values, lwd=3,col='red')
lines(Pearson2.3$Proportion~Pearson2.3$C.values, lwd=3,col='blue')
lines(Pearson2.4$Proportion~Pearson2.4$C.values, lwd=3,col='darkgreen')

text(9.75,.1,'----- : n=3' , col='black' , cex=1.2)
text(9.75,.2,'----- : n=9' , col='red' , cex=1.2)
text(9.75,.3,'  ----- : n=13' , col='blue' , cex=1.2)
text(9.75,.4,'  ----- : n=16' , col='darkgreen' , cex=1.2)

#
Bowly1=plotProportions(attr=Bowly.skewness.coefficient, n=n[1])
Bowly2=plotProportions(attr=Bowly.skewness.coefficient, n=n[2])
Bowly3=plotProportions(attr=Bowly.skewness.coefficient, n=n[3])
Bowly4=plotProportions(attr=Bowly.skewness.coefficient, n=n[4])

plot(Bowly1$Proportion~Bowly1$C.values, main = "Bowly's Measure of Skewness",
     col= 1, type='l', lwd=3,
     xlab= "Relative Sample Error (c)",
     ylab= "Proportion",xlim=c(0,12))

lines(Bowly2$Proportion~Bowly2$C.values, lwd=3,col='red')
lines(Bowly3$Proportion~Bowly3$C.values, lwd=3,col='blue')
lines(Bowly4$Proportion~Bowly4$C.values, lwd=3,col='darkgreen')

text(9.75,.1,'----- : n=3' , col='black' , cex=1.2)
text(9.75,.2,'----- : n=9' , col='red' , cex=1.2)
text(9.75,.3,'  ----- : n=13' , col='blue' , cex=1.2)
text(9.75,.4,'  ----- : n=16' , col='darkgreen' , cex=1.2)

# For n=9, plot the proportion of the three attributes in one plot
plot(Pearson1.3$Proportion~Pearson1.3$C.values, main='n=9',
     col= 1, type='l', lwd=3,
     xlab= "Relative Sample Error (c)",
     ylab= "Proportion",xlim=c(0,8))
lines(Pearson2.3$Proportion~Pearson2.3$C.values, lwd=3,col='red')
lines(Bowly3$Proportion~Bowly3$C.values, lwd=3,col='blue')

text(4.5,.1,"----- : Pearson's moment coefficient" , col='black' , cex=1.2)
text(4.5,.2,"----- : Pearson's second coefficient" , col='red' , cex=1.2)
text(3.5,.3,"  ----- : Bowly's measure" , col='blue' , cex=1.2)