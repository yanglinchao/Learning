dat <- read.table("eg10.4.txt", header = T)
attach(dat)
par(mfrow=c(1, 3))
plot(GDP, tax, xlab = "GDP", ylab = "tax");abline(lm(tax ~ GDP))
plot(expand, tax, xlab = "expand", ylab = "tax"); abline(lm(tax ~ expand))
plot(CPI, tax, xlab = "CPI", ylab = "tax"); abline(lm(tax ~ CPI))
par(mfrow=c(1,1))
c(cor(GDP, tax), cor(expand, tax), cor(CPI, tax))
lm3 <- lm(tax ~ GDP + expand + CPI)
lm3.summary <- summary(lm3)
lm3.summary
lm3.summary$r.squared
lm3.summary$coef
coef(lm3)
coef(lm3)[1] + coef(lm3)[2]*520000 + coef(lm3)[3]*130000 + coef(lm3)[4]*103
predict(lm3, newdata = data.frame(GDP=520000, expand=130000, CPI=103))