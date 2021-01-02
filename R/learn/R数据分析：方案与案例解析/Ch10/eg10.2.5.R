data <- read.table("eg10.2.5.txt", header = T)
attach(data)
plot(x, y, xlab = "人口数", ylab = "医疗机构数")
abline(lm(y~x))
cor(x,y)
lm <- lm(y~x)
lm.summary <- summary(lm)
lm.summary
lm.summary$r.squared
lm.summary$adj.r.squared
lm2 <- lm(y ~ 0 + x)
lm2.summary <- summary(lm2)
lm2.summary
#lm3 <- lm(y ~ -1 + x)
#lm3.summary <- summary(lm3)
#lm3.summary
#lm(y ~ 0 + x)和lm(y ~ -1 + x)效果一样
par(mfrow=c(1, 1))
sx <- sort(x)
conf <- predict(lm2, data.frame(x=sx), interval = "confidence")
pred <- predict(lm2, data.frame(x=sx), interval = "prediction")
plot(x, y)
abline(lm2)
lines(sx, conf[,2])
lines(sx, conf[,3])
lines(sx, pred[,2], lty=3)
lines(sx, pred[,3], lty=3)