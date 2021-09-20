library(MASS)
data(UScereal)
head(UScereal[, c('sugars', 'calories')])

x <- UScereal$sugars
y <- UScereal$calories

# Plot sugars vs. number of calories and overlay a regression line
plot(x, y, pch=19, col=adjustcolor("black", 0.3),
     xlab="Sugars", ylab="Calories")
abline(lm(y ~ x, data.frame(y=y, x=x)), col=1)

# Need to worry about discrete numbers because there are overlaps

# Plot regression line with outliers removed (y>300)
abline(lm(y ~ x, data.frame(y=y, x=x), weights=as.numeric(y<300)), col=2)
