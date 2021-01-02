library("VIM")
##加载数据集
data(sleep, package = "VIM")
##列出没有缺失值的行
sleep[complete.cases(sleep), ]
##列出有一个或多个缺失值的行
sleep[!complete.cases(sleep), ]
sum(is.na(sleep$Dream))
mean(is.na(sleep$Dream))
mean(!complete.cases(sleep))
##列表显示缺失值
library(mice)
data(sleep, package = "VIM")
md.pattern(sleep)
library(VIM)
aggr(sleep, prop = FALSE, numbers = TRUE)
matrixplot(sleep)
marginplot(sleep[c("Gest", "Dream")], pch = c(20), col = c("darkgray", "red", "blue"))
x <- as.data.frame(abs(is.na(sleep)))
y <- x[which(sapply(x, sd) > 0)]
cor(y)
library(VIM)
sleep.new <- sleep[complete.cases(sleep), ]   #或者使用sleep.new <- na.omit(sleep)
fit <- lm(Dream ~ Span + Gest, data = na.omit(sleep))   #应用行删除发的线性回归
summary(fit)
library(mice)
data(sleep, package = "VIM")
imp <- mice(sleep, seed = 1234)
fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit)
summary(pooled)
imp$imp$Dream   #通过提取imp对象的子成分，可以观测到实际的插补值
dataset3 <- complete(imp, action = 3)   #利用complete()函数可以观察m个插补数据集中的任意一个
dataset3
