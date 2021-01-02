dat <- read.csv(file = "eg11.3.csv")
attach(dat)
dat
x <- income
y <- expend
p <- cpi
yp <- y/p*100   #消除价格因素
xp <- x/p*100  #消除价格因素
lm.in <- lm(yp ~ xp)
summary(lm.in)
e <- resid(lm.in)
plot(e, type = "l")
abline(h=0, col="red")
plot(e[-1], e[-10])
library(lmtest)
dw <- dwtest(lm.in)
dw
install.packages("orcutt")   #orcutt包中的cochrane.orcutt()函数可以求解序列相关系数以及广义差分后结果
library(orcutt)
cochrane.orcutt(lm.in)