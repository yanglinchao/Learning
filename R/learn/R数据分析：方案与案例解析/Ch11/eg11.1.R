dat <- read.csv(file = "eg11.1.csv")
attach(dat)
dat
lm3 <- lm(revenue ~ industry + agriculture + construction + consumption + pop + disaster)
lm3.summary <- summary(lm3)
lm3.summary
cor(dat[, -c(1, 8)])    #去掉第1列(t)和第八列(revenue)
x <- cbind(rep(1, length(dat[, 1])), dat[, -c(1, 8)])     #第1列对应的是截距项
x <- as.matrix(x)
eigen(t(x)%*%x)
CI <- eigen(t(x)%*%x)$values[1]/eigen(t(x)%*%x)$values[7]
CI
#install.packages("bstats")
#library(bstats)     #bstats包中的vif()函数可以用于求方差膨胀因子
#vif(lm3)
step(lm3, derection = "forward")   #向前逐步回归
step(lm3, direction = "backward")    #向后逐步回归
step(lm3, direction = "both")      #向前向后逐步回归
library(MASS)   #MASS包中的lm.ridge()函数可以用来做岭回归
lm.r <- lm.ridge(revenue ~ industry + agriculture + construction +consumption + pop + disaster)
lm.r    #当不指定lambda的值时，岭回归与普通最小二乘估计结果一致
plot(lm.ridge(revenue ~ industry + agriculture + construction +consumption + pop + disaster, lambda = seq(0, 0.3, 0.001)))
select(lm.ridge(revenue ~ industry + agriculture + construction +consumption + pop + disaster, lambda = seq(0, 0.3, 0.001)))
lm.ridge(revenue ~ industry + agriculture + construction +consumption + pop + disaster, lambda = 0.004)