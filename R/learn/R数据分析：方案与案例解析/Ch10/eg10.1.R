consume <- c(594, 638, 1122, 1155, 1408, 1595, 1969, 2078, 2585, 2530)
income <- c(800, 1100, 1400, 1700, 2000, 2300, 2600, 2900, 3200, 3500)
cor(income, consume)   #Pearson相关系数
plot(income, consume)   #散点图
abline(lm(consume ~ income))    #添加回归趋势线
lm1 <- lm(consume ~ income)    #将回归结果保存在lm对象中
coef(lm1)       #提取估计系数，默认包含截距项
coef(lm(consume ~ -1 + income))     #不包含截距项
slm <- summary(lm1)
slm$coef     #得到系数有关的矩阵
slm$r.squared    #R方
predict(lm1, newdata <- data.frame(income=4000))     #预测值
predict(lm1, newdata <- data.frame(income=4000), interval = "confidence", level = 0.95)  #置信区间
predict(lm1, newdata = data.frame(income=4000), interval = "prediction", level = 0.95)   #个值预测区间
sx <- sort(income)   #把自变量大小排序
conf <- predict(lm1, newdata <- data.frame(income=sx), interval = "confidence", level = 0.95)  #置信区间
pred <- predict(lm1, newdata = data.frame(income=sx), interval = "prediction", level = 0.95)   #个值预测区间
lines(sx, conf[,2]); lines(sx, conf[,3])
lines(sx, pred[,2], lty=3); lines(sx, pred[,3], lty=3)