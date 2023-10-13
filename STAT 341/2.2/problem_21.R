library(lubridate)
filename <- paste("../source/repos/Uni-Projects/STAT 341/Data", "GretzkyGoals.csv", sep="/")
goals <- read.csv(filename, header=TRUE)
head(goals)

# Convert time to seconds, adding 20 minutes per period
goals$Time <- period_to_seconds(ms(goals$Time)) + (as.numeric(goals$Per.)-1)*20*60
goals <- subset(goals, Per. != "OT")  # Don't include shots during overtime period
t <- goals$Time

c(mean(t), median(t), range(t))

# Plot histograms
par(mfrow=c(1,4), mar=2.5*c(1, 1, 1, 0.1))
hist(t, prob=TRUE, xlab="", main="Sturges")
hist(t, breaks="FD", prob=TRUE, xlab="", main="Freedman-Diaconis")
hist(t, breaks="scott", prob=TRUE, xlab="", main="Scott")
boxplot(t, main="Box Plot")

# Histogram using unequal bins and 2 minute intervals
par(mfrow=c(1,2), mar=2.5*c(1, 1, 1, 0.1))
hist(t, breaks=quantile(t, p=seq(0, 1, length.out=9)))
hist(t, breaks=31)

# Quantile plot of the goal times
plot(seq(0, 1, length.out=length(t)), sort(t),
     xlab="Proportion", ylab="Time Quantile")

# Partition goal times into empty-net and against-golie
t.empty <- subset(goals, Goalie == "")$Time
t.against <- subset(goals, Goalie != "")$Time

par(mfrow=c(1,2), mar=2.5*c(1, 1, 1, 0.1))
hist(t.empty, breaks=quantile(t.empty, p=seq(0, 1, length.out=9)))
hist(t.against, breaks=quantile(t.against, p=seq(0, 1, length.out=9)))
