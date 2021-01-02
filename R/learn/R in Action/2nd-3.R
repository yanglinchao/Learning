###11.1
library(gclus)
mydata <- mtcars[c(1, 3, 5, 6)]
mydata.corr <- abs(cor(mydata))
mycolors <- dmat.color(mydata.corr)
myorder <- order.single(mydata.corr)
cpairs(mydata,
       myorder,
       panel.colors = mycolors,
       gap = .5,
       main = "Variables Ordered and Colored by Correlation")
##11.2
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
t1 <- subset(Orange, Tree == 1)
plot(t1$age, t1$circumference,
     xlab = "Age (days)",
     ylab = "Circumference (mm)",
     main = "Orange Tree 1 Growth")
plot(t1$age, t1$circumference,
     xlab = "Age (days)",
     ylab = "Circumference (mm)",
     main = "Orange Tree 1 Growth",
     type = "b")
par(opar)
library(coin)
score <- c(40, 57, 45, 55, 58, 57, 64, 55, 62, 65)
treatment <- factor(c(rep("A", 5), rep("B", 5)))
mydata <- data.frame(treatment, score)
t.test(score ~ treatment, data = mydata, var.equal = TRUE)
oneway_test(score ~ treatment, data = mydata, distribution = "exact")
library(MASS)
UScrime <- transform(UScrime, So = factor(So))
wilcox_test(Prob ~ So, data = UScrime, distribution = "exact")
wilcox.test(Prob ~ So, data = UScrime)
library(multcomp)
set.seed(1234)
oneway_test(response ~ trt, data = cholesterol, distribution = approximate(B = 9999))
data("Affairs", package = "AER")
summary(Affairs)
head(Affairs)
table(Affairs$affairs)
Affairs$ynaffair[Affairs$affairs == 0] <- 0
Affairs$ynaffair[Affairs$affairs >0] <- 1
head(Affairs)
Affairs$ynaffair <- factor(Affairs$ynaffair, levels = c(0, 1), labels = c("No", "Yes"))
table(Affairs$ynaffair)
fit.full <- glm(ynaffair ~ gender + age + yearsmarried + children + religiousness + education + occupation + rating, data = Affairs, family = binomial())
summary(fit.full)
fit.reduced <- glm(ynaffair ~ age + yearsmarried + religiousness + rating, data = Affairs, family = binomial())
summary(fit.reduced)
anova(fit.full, fit.reduced, test = "Chisq")
coef(fit.reduced)
confint(fit.reduced)
exp(confint(fit.reduced))
testdata <- data.frame(rating = c(1, 2, 3, 4, 5), age = mean(Affairs$age), yearsmarried = mean(Affairs$yearsmarried), religiousness = mean(Affairs$religiousness))
testdata
testdata$prob <- predict(fit.reduced, newdata = testdata, type = "response")
testdata
testdata <- data.frame(rating = mean(Affairs$rating), age = seq(17, 57, 10), yearsmarried = mean(Affairs$yearsmarried), religiousness = mean(Affairs$religiousness))
testdata$prob <- predict(fit.reduced, newdata = testdata, type = "response")
testdata
##13.3
data(breslow.dat, package = "robust")
head(breslow.dat)
summary(breslow.dat[c(6, 7, 8, 10)])
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
attach(breslow.dat)
hist(sumY, breaks = 20, xlab = "Seizure Count",
     main = "Distribution of Seizures")
boxplot(sumY ~ Trt, xlab = "Treatment", main = "Group Comparisons")
par(opar)
fit <- glm(sumY ~ Base + Age + Trt, data = breslow.dat, family = poisson())
summary(fit)
coef(fit)
exp(coef(fit))
install.packages("qcc")
library(qcc)   #qcc包提供了一个对泊松模型过度离势的检验方法
qcc.overdispersion.test(breslow.dat$sumY, type = "poisson")
fit.od <- glm(sumY ~ Base + Age + Trt, data = breslow.dat, family = quasipoisson())
summary(fit.od)
##14.2
library(psych)
fa.parallel(USJudgeRatings[, -1], fa = "pc", n.iter = 100, show.legend = FALSE, main = "Scree plot with parallel analysis")
#特征值大于1准则(水平线),100次模拟的平行分析(虚线)
pc <- principal(USJudgeRatings[, -1], nfactors = 1)
pc
##14.3
covariances <- ability.cov$cov
correlations <- cov2cor(covariances)
fa.parallel(correlations, n.obs = 112, fa = "both", n.iter = 100, main = "Scree plots with parallel analysis")
