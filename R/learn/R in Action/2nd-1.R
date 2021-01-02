age <- c(1, 3, 5, 2, 11, 9, 3, 9, 12, 3)
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6.0, 10.4, 10.2, 6.1)
mean(weight)
sd(weight)
cor(age, weight)
plot(age, weight)
data <- data.frame(age, weight)
plot(age, weight)
abline(lm(weight ~ age), col = "red", lwd = 2, lty = 1)
lines(lowess(age, weight), col = "blue")
demo(graphics)
library(vcd)
Arthritis
help("Arthritis")
PatientID <- c(1, 2, 3, 4)
date <- c("10/15/2009", "11/01/2009", "10/21/2009", "10/28/2009")
AdmDate <- as.Date(date, "%m/%d/%Y")
Age <- c(25, 34, 28, 52)
Diabetas <- c("Type1", "Type2", "Type1", "Type1")
Status <- c("Poor", "Improved", "Excellent", "Poor")
Patient <- data.frame(PatientID, AdmDate, Age, Diabetas, Status)
mydata <- data.frame(age=numeric(0), gender=character(0), weight=numeric(0))
fix(mydata)
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
plot(dose, drugA)
plot(dose, drugA, type = "b")
help(plot)
par()
opar <- par(no.readonly = TRUE)   #复制当前的图形参数设置
par(lty=2, pch=17)   #将默认的线条类型改为虚线
plot(dose, drugA, type = "b")   #绘制图形
par(opar)   #还原原始设置，因为par()函数修改的参数值除非再次修改，否则在会话结束前一直保持不变
?par
?pch
par(pin = c(2, 3))
par(lwd = 2, cex = 1.5)
par(cex.axis = 0.75, font.axis = 3)
plot(dose, drugA, type = "b", pch = 19, lty = 2, col = "red")
plot(dose, drugB, type = "b", pch = 23, lty = 6, col = "blue", bg = "green")
par(opar)
plot(dose, drugA, type = "b", pch = 2, col = "blue",
     main = "drugA vs. durgB", ylab = "Drug Response", xlab = "Drug Dosage")
lines(dose, drugB, type = "b", pch = 4, col = "red")
abline(h = c(30), lwd = 1.5, lty = 2, col = "grey")
library(Hmisc)
minor.tick(nx = 2, ny = 2, tick.ratio = 0.5)
legend("topleft", inset = 0.05, title = "Drug Type", legend = c("A", "B"), lty = c(1, 1), pch = c(2, 4), col = c("blue", "red"))
attach(mtcars)
plot(wt, mpg,
     main = "Mileage vs. Car Weight",
     xlab = "Weight", ylab = "Mileage",
     pch = 18, col = "blue")
text(wt, mpg,
     row.names(mtcars),
     cex = 0.6, pos = 4, col = "red",
     adj = 1)
detach(mtcars)
opar <- par(no.readonly = TRUE)
plot(1:7, 1:7, type = "n")
text(3, 3, "sqrt(x)")
par(opar)
manager <- c(1, 2, 3, 4, 5)
date <- as.Date(c("10/24/08", "10/28/08", "10/01/08", "10/12/08", "05/01/09"), "%m/%d/%y")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 23, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)
leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5)
leadership$sumq <- leadership$q1 + leadership$q2
leadership <- transform(leadership, sum = q1 + q2, meanx = (q1 + q2)/2)
leadership <- within(leadership, {
  agecat <- NA
  agecat[age>75] <- "Elder"
  agecat[age>=55 & age<75] <- "Middle Aged"
  agecat[age<55] <- "Young"
})
fix(leadership)
is.na(leadership)
gender1 <- as.character(gender)
gender1
roster <- read.csv("roster_ch5.csv")
attach(roster)
runif(5)
set.seed(3214)
runif(5)
library(MASS)
set.seed(1234)
mean <- c(230.7, 146.7, 3.6)
sigma <- matrix(c(15360.8, 6721.2, -47.1,
                  6721.2, 4700.9, -16.5,
                  -47.1, -16.5, 0.3),
                nrow = 3, ncol = 3)
mydata <- mvrnorm(500, mean, sigma)
mydata <- as.data.frame(mydata)
names(mydata) <- c("y", "x1", "x2")
dim(mydata)
roster <- read.csv("roster_ch5.csv")
z <- scale(roster[, 2:4])
score <- apply(z, 1, mean)
roster <- cbind(roster, score)
y <- quantile(score, c(.2, .4, .6, .8))
y
roster$grade[score >= y[4]] <- "A"
roster$grade[score < y[4] & score >= y[3]] <- "B"
roster$grade[score < y[3] & score >= y[2]] <- "C"
roster$grade[score < y[2] & score >= y[1]] <- "D"
roster$grade[score < y[1]] <- "F"
roster
is.character(roster$Name)
roster$Name <- as.character(roster$Name)
name <- strsplit((roster$Name), " ")
name
lastname <- sapply(name, "[", 2)
firstname <- sapply(name, "[", 1)
roster_grade <- cbind(firstname, lastname, roster$grade)
roster_grade <- roster_grade[order(lastname, firstname), ]
roster_grade
cars <- mtcars[1:5, 1:4]
cars
t(cars)
attach(mtcars)
aggdata <- aggregate(mtcars, by = list(cyl, gear), FUN = mean, na.rm = TRUE)
aggdata
mydata <- data.frame()
fix(mydata)
mydata
library(reshape)
md <- melt(mydata, id = (c("ID", "Time")))
md
newdata <- cast(md, Time ~ variable, mean)
newdata
newdata1 <- cast(md, ID ~ variable + Time)
newdata1
library(vcd)
attach(Arthritis)
detach(Arthritis)
counts <- table(Arthritis$Improved)
counts
barplot(counts,
        main = "Simple Bar Plot",
        xlab = "Improment", ylab = "Frequency")
barplot(counts,
        main = "Horizontal Bar Plot",
        xlab = "Frequency", ylab = "Improment",
        horiz = TRUE)
counts <- table(Arthritis$Improved, Arthritis$Treatment)
counts
barplot(counts,
        main = "Stacked Bar Plot",
        xlab = "Treatment", ylab = "Frequency",
        col = c("red", "yellow", "green"),
        legend = rownames(counts))
barplot(counts,
        main = "Group Bar Plot",
        xlab = "Treatment", ylab = "Frequency",
        col = c("red", "yellow", "green"),
        legend = rownames(counts), beside = TRUE)
counts <- table(Arthritis$Treatment, Arthritis$Improved)
spine(counts, main = "Spinogram Example")
mtcars
par(mfrow = c(2, 2))
hist(mtcars$mpg)
hist(mtcars$mpg,
     breaks = 12,
     col = "red",
     xlab = "Miles Per Gallon", 
     main = "Colored histogram with 12 bins")
hist(mtcars$mpg,
     freq = FALSE,
     breaks = 12,
     col = "red",
     xlab = "Miles Per Gallon",
     main = "Histogram, rug plot, density curve")
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg), col = "blue", lwd = 2)
x <- mtcars$mpg
h <- hist(x,
          breaks = 12,
          col = "red",
          xlab = "Miles Per Gallon",
          main = "Histogram with normal curve and box")
xfit <- seq(min(x), max(x), length = 40)
yfit <- dnorm(xfit, mean = mean(x), sd = sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col = "blue", lwd = 2)
box()
par(mfrow = c(2, 1))
d <- density(mtcars$mpg)
plot(d, main = "Kernel Density of Miles Per Gallon")
polygon(d, col = "red", border = "blue")
plot(d, main = "Kernel Density of Miles Per Gallon")
polygon(d, col = "red", border = "blue")
rug(mtcars$mpg, col = "brown")
library(sm)
attach(mtcars)
par(lwd = 2)
sm.density.compare(mpg, cyl, xlab = "Miles Per Gallon")
title(main = "MPG Distribtion by Car Cylinders")
colfill <- c(2:(1 + length(levels(cyl.f))))
legend(locator(1), levels(cyl.f), fill = colfill)
detach(mtcars)
vars <- c("mpg", "hp", "wt")
vars <- mtcars[vars]
summary(vars)
library(psych)
describe(mtcars[vars])
aggregate(mtcars[vars], by = list(am=mtcars$am), mean)
describe.by(mtcars[vars], mtcars$am)
library(reshape)
dstats <- function(x)(c(n = length(x), mean = mean(x), sd = sd(x)))
dfm <- melt(mtcars, measure.vars = c("mpg", "hp", "wt"), id.vars = c("am", "cyl"))
cast(dfm, am + cyl + variable ~ ., dstats)