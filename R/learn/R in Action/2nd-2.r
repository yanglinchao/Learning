library(vcd)
head(Arthritis)
mytable <- with(Arthritis,table(Improved))
mytable
prop.table(mytable)
mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable1 <- with(Arthritis, table(Treatment, Improved))
mytable
mytable1
margin.table(mytable, 1)
prop.table(mytable, 2)
addmargins(mytable)   #添加边际和
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)
mytable <- xtabs(~ Treatment + Sex + Improved, data = Arthritis)
mytable
margin.table(mytable, 1)
ftable(mytable)
ftable(prop.table(mytable, c(1, 2)))
ftable(addmargins(prop.table(mytable, c(1, 2)), 3))
library(vcd)
attach(Arthritis)
mytable <- xtabs(~ Treatment + Improved)
chisq.test(mytable)
mytable1 <- xtabs(~ Improved + Sex)
chisq.test(mytable1)
mytable2 <- xtabs(~ Treatment + Improved)
fisher.test(mytable2)
mytable3 <- xtabs(~ Treatment + Improved + Sex)
mantelhaen.test(mytable3)
states <- state.x77[, 1:6]
cor(states)
cov(states)
cor(states, method = "spearman")
library(ggm)
pcor(c(1, 5, 2, 3, 6), cov(states))
cor.test(states[, 3], states[, 5])
library(psych)
corr.test(states, use = "complete")
library(MASS)
head(UScrime)
t.test(Prob ~ So, data = UScrime)
with(UScrime, t.test(U1, U2, paired = TRUE))
with(UScrime, by(Prob, So, median))
wilcox.test(Prob ~ So, data = UScrime)
states <- as.data.frame(cbind(state.region, state.x77))
kruskal.test(Illiteracy ~ state.region, data = states)
mydata <- read.csv("formcnemar.csv")
names(mydata) <- c("问卷编号", "X", "Y")
mytable <- xtabs(~ X + Y, data = mydata)
mytable
mcnemar.test(mytable)
women
fit <- lm(weight ~ height, data = women)
summary(fit)
fitted(fit)
weight
women$weight
residuals(fit)
plot(women$weight ~ women$height)
abline(fit)
###8.2.4
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
cor(states)   #检查变量间的相关性
library(car)
scatterplotMatrix(states, spread = FALSE, lty.smooth = 2,
                  main = "Sctter Plot Matrix")
#在非对角线区域绘制变量间的散点图，并添加平滑和线性拟合曲线。对现象区域绘制每个变量的密度图和轴须图。
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
summary(fit)
###8.2.5
fit <- lm(mpg ~ hp + wt + hp:wt, data = mtcars)
summary(fit)
library(effects)
plot(effect("hp:wt", fit, 
            list(wt=c(2.2, 3.2, 4.2))),
     multiline = TRUE)
###8.3.1
fit <- lm(weight ~ height, data = women)
par(mfrow = c(2, 2))
plot(fit)
par(mfrow = c(1, 1))
###8.3.2
library(car)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
qqPlot(fit, labels = row.names(states), id.method = "identify", 
       simulate = TRUE, main = "Q-Q Plot")
       #id.method = "identify"选项可以交互式绘图,当simulate = TRUE时,95%的置信区间将会使用参数自助法
residplot <- function(fit, nbreaks = 10){
  z <- rstudent(fit)
  hist(z, breaks = nbreaks, freq = FALSE,
       xlab = "Studentized Residual",
       main = "distribution of Errors")
  rug(jitter(z), col = "brown")
  curve(dnorm(x, mean = mean(z), sd = sd(z)),
        add = TRUE, col = "blue", lwd = 2)
  lines(density(z)$x, density(z)$y,
        col = "red", lwd = 2, lty = 2)
  legend("topright",
         legend = c("Normal Curve", "Kernel Density Curve"),
         lty = 1:2, col = c("blue", "red"), cex = 0.7)
}
residplot(fit)
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
library(car)
durbinWatsonTest(fit)
crPlots(fit)
ncvTest(fit)
spreadLevelPlot(fit)
library(gvlma)
gvmodel <- gvlma(fit)
summary(gvmodel)
vif(fit)
sqrt(vif(fit)) > 2   #一般原则下，sqrt(vif)>2就表明存在多重共线性问题
###8.4.1
library(car)
outlierTest(fit)
###8.4.2
hat.plot <- function(fit){
  p <- length(coefficients(fit))
  n <- length(fitted(fit))
  plot(hatvalues(fit), main = "Idex Plot of Hat Values")
  abline(h = c(2, 3)*p/n, col = "red", lty = 2)
  identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}
hat.plot(fit)
cutoff <- 4/(nrow(states) - length(fit$coefficients) - 2)
plot(fit, which = 4, cook.levels = cutoff)
abline(h = cutoff, lty = 2, col = "red")
influencePlot(fit, id.method = "identify", main = "Influence Plot",
              sub = "Circle size is proportional to Cook's distance")
states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
library(car)
summary(powerTransform(states$Murder))
boxTidwell(Murder ~ Population + Illiteracy, data = states)
library(MASS)
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
stepAIC(fit1, direction = "backward")
library(leaps)
leaps <- regsubsets(Murder ~ Population + Illiteracy + Income + Frost, data = states, nbest = 4)
plot(leaps, scale = "adjr2")
library(car)
subsets(leaps, statistic = "cp", main = "Cp Plot for All Subsets Regression")
abline(1, 1, lty = 2, col = "red")
relweights <- function(fit, ...){
  R <- cor(fit$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda^2
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta^2)
  rawwgt <- lambdasq %*% beta^2
  import <- (rawwgt / rsquare)*100
  lbls <- names(fit$model[2:nvar])
  rownames(import) <- lbls
  colnames(import) <- "Weights"
  barplot(t(import), names.arg = lbls,
          ylab = "% of R-Square",
          xlab = "Predictor Variables",
          main = "Relative Importance of Predictor Variables",
          sub = paste("R-Square =", round(rsquare, digits = 3)),
          ...)
  return(import)
}
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
relweights(fit, col = "lightgrey")
library(multcomp)
attach(cholesterol)
table(trt)   #各组样本大小
aggregate(response, by = list(trt), FUN = mean)   #各组均值
aggregate(response, by = list(trt), FUN = sd)   #各组标准差
fit <- aov(response ~ trt)   #检验组间差异（ANOVA）
summary(fit)
library(gplots)
plotmeans(response ~ trt, xlab = "Treatment", ylab = "Response",
          main = "Mean Plot/nwith 95% CI")   #绘制各组均值及其置信区间的图形
detach(cholesterol)
library(multcomp)
par(mar = c(5, 4, 6, 2))   #增大顶部边界面积
tuk <- glht(fit, linfct = mcp(trt = "Tukey"))
plot(cld(tuk, level = .05), col = "lightgrey")
data(litter, package = "multcomp")
attach(litter)
table(dose)
aggregate(weight, by = list(dose), FUN = mean)
fit <- aov(weight ~ gesttime + dose)
summary(fit)
library(effects)
effect("dose", fit)
library(multcomp)
fit2 <- aov(weight ~ gesttime*dose, data = litter)
summary(fit2)
library(HH)
ancova(weight ~ gesttime*dose, data.in = litter)
detach(cholesterol)
attach(ToothGrowth)
table(supp, dose)
aggregate(len, by = list(supp, dose), FUN = mean)
aggregate(len, by = list(supp, dose), FUN = sd)
fit <- aov(len ~ supp*dose)
summary(fit)
interaction.plot(dose, supp, len, type = "b",
                 col = c("red", "blue"), pch = c(16, 18),
                 main = "Interaction between Dose and Supplement Type")
library(gplots)
plotmeans(len ~ interaction(supp, dose, sep = " "),
          connect = list(c(1, 3, 5), c(2, 4, 6)),
          col = c("red", "darkgreen"),
          main = "Interaction Plot with 95% CIs",
          xlab = "Treatment and Dose Combination")
library(HH)
interaction2wt(len ~ supp*dose)
attach(CO2)
w1b1 <- subset(CO2, Treatment == 'chilld')
fit <- aov(uptake ~ conc*Type + Error(Plant/(conc), w1b1))
summary(fit)
detach(CO2)
library(MASS)
attach(UScereal)
y <- cbind(calories, fat, sugars)   #将三个因变量合并成一个矩阵
aggregate(y, by = list(shelf), FUN = mean)
cov(y)
fit <- manova(y ~ shelf)
summary(fit)
summary.aov(fit)   #由于多元显著，使用summary.aov()对每一个变量做单因素方差分析
detach(UScereal)
center <- colMeans(y)
n <- nrow(y)
p <- ncol(y)
cov <- cov(y)
d <- mahalanobis(y, center, cov)
coord <- qqplot(qchisq(ppoints(n), df = p), d,
                main = "Q-Q Plot Assessing Multivariate Normality",
                ylab = "Mahalanobis D2")
abline(a = 0, b = 1)
identify(coord$x, coord$y, labels = row.names(UScereal))
###10.2
library(pwr)
pwr.t.test(d = .8, sig.level = .05, power = .9, type = "two.sample", alternative = "two.sided")
pwr.t.test(n = 20, d = .5, sig.level = .01, type = "two.sample", alternative = "two.sided")
pwr.anova.test(k = 5, f = .25, sig.level = .05, power = .8)
pwr.r.test(r = .25, sig.level = 0.05, power = .90, alternative = "greater")
pwr.f2.test(u = 3, f2 = 0.0769, sig.level = 0.05, power = 0.90)
pwr.2p.test(h=ES.h(.65, .6), sig.level = .05, power = .9, alternative = "greater")
prob <- matrix(c(.42, .28, .03, .07, .10, .10), byrow = TRUE, nrow = 3)
ES.w2(prob)
pwr.chisq.test(w = ES.w2(prob), df = 2, sig.level = .05, power = .9)
###11.1
attach(mtcars)
plot(wt, mpg,
     main = "Basic Scatter plot of MPG vs. Weight",
     xlab = "Car Weight (lbs/1000",
     ylab = "Miles Per Gallon", pch = 19)
abline(lm(mpg ~ wt), col = "red", lwd = 2, lty = 1)
lines(lowess(wt, mpg), col = "red", lwd = 2, lty = 1)
library(car)
scatterplot(mpg ~ wt | cyl, data = mtcars, lwd = 2,
            main = "Scatter Plot of MPG vs. Weight by # Cylinders",
            xlab = "Weight of Car(lbs/1000)",
            ylab = "Miles Per Gallon",
            legend.method = "identify",
            labels = row.names(mtcars),
            boxplots = "xy")
pairs(~ mpg + disp + drat + wt, data = mtcars,
      main = "Basic Sctterplot Matrix", upper.panel = NULL)
scatterplotMatrix(~ mpg + disp + drat + wt, data = mtcars,
                  spread = FALSE, lty.smooth = 2,
                  main = "Scatter Plot Matrix via car Packages",
                  upper.panel = NULL)
scatterplotMatrix(~ mpg + disp + drat + wt | cyl, data = mtcars,
                  spread = FALSE, diagonal = "histogram",
                  main = "Scatter Plot Matrix via car Package")
cor(mtcars[c("mpg", "wt", "disp", "drat")])
library(gclus)

