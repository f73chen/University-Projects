library(carData)
data(TitanicSurvival)
Titanic = na.omit(TitanicSurvival)
Titanic3 = Titanic[Titanic$passengerClass == "3rd",]
age <- Titanic3$age
survived <- Titanic3$survived

# Make a boxplot of age and survived
# Not helpful because doesn't show the density distribution
boxplot(age ~ survived, Titanic3,
        xlab="survived", ylab="age")

# Convert survival status into boolean
# Aside from died having a wider spread, not much can be learned
  # survived1 = ifelse(survived=="yes", 1, 0)
survived1 = as.numeric(survived == "yes")
plot(age, survived1)

# Convert age into a discrete variable by binning ages
  # bins = c(seq(0, 50, by=10), 80)
  # freq = hist(age, breaks=bins, include.lowest=TRUE, plot=FALSE)
ag = numeric(length(age))
ag[age <= 10] = 1
ag[age > 10 & age <= 20] = 2
ag[age > 20 & age <= 30] = 3
ag[age > 30 & age <= 40] = 4
ag[age > 40 & age <= 50] = 5
ag[age > 50] = 6
table(ag)

# Calculate the average age within each bin
average.age = sapply(1:6, function(z) { mean(age[ag == z]) })
round(average.age, 2)

# Summarize the ages within each bin with a more appropriate metric
median.age = sapply(1:6, function(z) { median(age[ag == z]) })
round(median.age, 2)

# For each bin, calculate the proportion of individuals who survived and died
  # average.survived = sapply(1:6, function(z) { mean(survived1[ag == z]) })
  # round(average.survived, 2)
prop.survived = round(as.matrix(table(ag, survived)) / as.numeric(table(ag)), 3)
prop.survived

# Add dots representing the proportion of survived at average age per bin
  # plot(c(age, average.age), c(survived1, prop.survived[,2]))
bin.pts = data.frame(average.age, prop=prop.survived[,2])
plotiv <- function() {
  plot(age, survived1, pch=19, col=adjustcolor("black", 0.3),
       xlab="Age", ylab="Survived")
  points(bin.pts, pch=19, col=adjustcolor("firebrick", 0.6))
}
plotiv()

# Apply least squares and fit a regression line
# Roughly -0.006 survivability per year
fit = lm(survived1 ~ age) # fit y to x
summary(fit)
abline(fit, col="red", lwd=2)

# Predict age at 25% survivability
age.pred <- function(y, fit) {
  return((y-fit$coefficients['(Intercept)']) / fit$coefficients['age'])
}
threshold = age.pred(0.25, fit)

# Proportion of ages smaller than that age
  # length(age[age < threshold])/length(age)
mean(age <= threshold)

# Plot the logits of proportions
plot(bin.pts$average.age, log(bin.pts$prop / (1-bin.pts$prop)))

# Fit and report a regression line on the transformed data
# Need ag to weigh each average age according to bin counts 
sur.fit = lm(I (log(prop / (1-prop))) ~ average.age, data = bin.pts, weights=table(ag))
summary(sur.fit)

# Unlog the new regression line and plot on the old data
# Now the line doesn't go lower than 0 no matter the age
plotiv()

log.fn <- function(z) { 1/(1+exp(-z)) } # Unlogs regression
z = seq(-5, 80, length.out=100)
lines(z, log.fn(sur.fit$coefficients[1] + sur.fit$coefficients[2]*z))
abline(coef=sur.fit$coef) # Not sure what this line does lol
