install.packages("quantreg")
library(quantreg)
data(engel)
attach(engel)
hist(foodexp)
plot(income, foodexp, xlab = "Household Income", ylab = "Food Expenditure", type = "n", cex=.5)
points(income, foodexp, cex=.5, col = "blue")
library(quantreg)
q_0.5 <- rq(foodexp ~ income, tau = 0.5, data = engel)
summary(q_0.5)
taus <- c(.05, .1, .25, .75, .9, .95)
xx <- seq(min(income), max(income), 100)
rqss <- rq((foodexp) ~ (income), tau = taus)
summary(rqss)
f <- coef(rqss)   #提取分位数回归系数
yy <- cbind(1, xx)%*%f   #计算分位数的回归拟合值
for(i in 1:length(taus)){
  lines(xx, yy[,i], col = "gray")
}
abline(lm(foodexp ~ income), col="red", lty=2)
abline(rq(foodexp ~ income), col="blue")
legend(2500, 500, c("mean (LSE) fit", "median (LAE) fit"), col=c("red", "blue"), lty=c(2,1))
plot(summary(rq(foodexp~income, tau=1:49/50, data = engel)))