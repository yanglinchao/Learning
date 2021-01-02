fichier <- "http://www.biostatisticien.eu/springeR/Weight_birth.csv"
mydata <- read.table(fichier, header = TRUE, sep = "\t")
mydata <- transform(mydata, LWT = LWT*0.4535923)
attach(mydata)
head(mydata)
plot(BWT ~ LWT, xlab = "Mother weight", ylab = "Child weight at birth")
abline(lm(BWT ~ LWT))
model1 <- lm(BWT ~ LWT, data = mydata)
model1
res <- summary(model1)
res
anova(model1)
confint(model1)   #回归系数的置信区间
lwt0 <- 56
predict(model1, data.frame(LWT = lwt0), interval = "prediction")   #计算一个Y(X=56时)的预测值及预测区间
predict(model1, data.frame(LWT = lwt0), interval = "confidence", level = 0.95)   #计算一个特定的Y群体(X均为56)时的平均预测值的置信区间
x <- seq(min(LWT), max(BWT), length = 50)
predint <- predict(model1, data.frame(LWT=x), interval = "prediction")[, c("lwr", "upr")]
confint <- predict(model1, data.frame(LWT=x), interval = "confidence")[, c("lwr", "upr")]
plot(BWT~ LWT, xlab = "Mother weight", ylab = "Child weight")
abline(model1)
matlines(x, cbind(confint, predint), lty = c(2, 2, 3, 3), col = c("red", "red", "blue", "blue"), lwd = c(2, 2, 1, 1))
legend("bottomright", lty = c(2, 3), lwd = c(2, 1), c("confidence", "prediction"), col = c("red", "blue"))
qqnorm(resid(model1), datax = TRUE)
require(car)
qqPlot(model1)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
qqnorm(resid(fit), datax = TRUE)
require(tseries)
jarque.bera.test(residuals(fit))   #H0:正态性
anova(fit)
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
anova(fit1, fit2)
states$add <- c(rep(1:3, times = 16), 2, 3)
fit3 <- lm(Murder ~ Population + Illiteracy + Income + Frost + factor(add), data = states)
summary(fit3)
fit4 <- lm(Murder ~ Population + Illiteracy + Income + Frost + relevel(factor(add), ref = 3), data = states)   #使用relevel改变参照组
summary(fit4)
fit5 <- lm(Murder ~ Population + Illiteracy, data = states)
fit6 <- lm(Murder ~ Population + Illiteracy + Population:Illiteracy, data = states)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
summary(fit)
threshold.dffit <- 2*sqrt((4+1)/45)
rownames(states)[abs(dffits(fit)) >= threshold.dffit]
##worksheet A
im <- read.csv("Intima_Media_Thickness.csv")
attach(im)
str(im)
plot(measure ~ AGE)
cor(AGE, measure)
abline(lm(measure ~ AGE))
fit <- lm(measure ~ AGE)
require(car)
qqPlot(fit)
require(tseries)
jarque.bera.test(residuals(fit))
predict(fit, data.frame(AGE = 33), interval = "prediction")
predict(fit, data.frame(AGE = 33), interval = "confidence")
summary(fit)
fit2 <- lm(measure ~ sqrt(AGE))
summary(fit2)
qqPlot(fit2)
outlierTest(fit)
hat.plot <- function(fit){
   p <- length(coefficients(fit))
   n <- length(fitted(fit))
   plot(hatvalues(fit), main = "Idex Plot of Hat Values")
   abline(h = c(2, 3)*p/n, col = "red", lty = 2)
   identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}
hat.plot(fit)
newim <- im[-c(68, 72, 45, 81, 82, 63, 104, 39, 92, 97, 60, 79, 43, 91), ]
fit3 <- lm(measure ~ AGE, data = newim)
summary(fit3)
qqPlot(fit3)
hat.plot(fit3)
outlierTest(fit3)
##worksheetB
str(unemployment)
attach(unemployment)
plot(unemp ~ gdprate, data = unemployment)
fit1 <- lm(unemp ~ gdprate)
abline(fit1)
summary(fit1)
require(car)
scatterplotMatrix(unemployment[, -1], spread = FALSE, lty.smooth = 2)
cor(unemployment[, -1])
fit2 <- lm(unemp ~ gdprate + govspend + taxb + salav + infl)
summary(fit2)
vif(fit2)
step(fit2, derection = "backward", level = 0.80)
fit3 <- lm(unemp ~ govspend + salav)
summary(fit3)
predict(fit3, data.frame(govspend = govspend[year==1993], salav = salav[year==1993]), interval = "prediction", level = 0.95)
unemp[year == 1993]
detach(unemployment)
##worksheetC
n <- 1000
x <- runif(n, min = -2, max = 2)
eps <- rnorm(n)
y <- x + 2*x^2 + 3.5*x^3 -2.3*x^4 + eps
plot(y ~ x)
curve(x + 2*x^2 + 3.5*x^3 -2.3*x^4, add = T, col = "blue")
fit1 <- lm(y ~ x)
summary(fit1)
qqPlot(fit1)
attach(fitpoly)
str(fitpoly)
plot(Y ~ X)
abline(lm(Y ~ X))
poly.model <- lm(Y~poly(X,3,raw=TRUE),data=fitpoly)
coef <- coef(poly.model)
curve(coef[1]+coef[2]*x+coef[3]*x^2+coef[4]*x^3,add=TRUE)
x <- seq(-3.5,3.5,length=50)
pred.int <- predict(poly.model,data.frame(X=x),
                    interval="prediction")[,c("lwr","upr")]
conf.int <- predict(poly.model,data.frame(X=x),
                    interval="confidence")[,c("lwr","upr")]
matlines(x,cbind(conf.int,pred.int),lty=c(2,2,3,3),
         col=c("red","red","blue","blue"),lwd=c(2,2,1,1))
legend("bottomright",lty=c(2,3),lwd=c(2,1),
       c("confidence","prediction"),col=c("red","blue"))
