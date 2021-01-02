##进行描述统计
data(Affairs, package = "AER")
summary(Affairs)
table(Affairs$affairs)
##将affairs转化为二值型因子ynaffair
Affairs$ynaffair[Affairs$affairs > 0] <- 1
Affairs$ynaffair[Affairs$affairs == 0] <- 0
Affairs$ynaffair <- factor(Affairs$ynaffair, level = c(0, 1), labels = c("No", "Yes"))
table(Affairs$ynaffair)
##进行logistic回归
fit.full <- glm(ynaffair ~ gender + age + yearsmarried + children + religiousness + education + occupation + rating, data = Affairs, family = binomial())
summary(fit.full)
##去除不显著的变量重新拟合模型
fit.reduced <- glm(ynaffair ~ age + yearsmarried + religiousness + rating, data = Affairs, family = binomial())
summary(fit.reduced)
##对于两模型嵌套（后者是前者的子集），使用anova()函数对其进行比较
anova(fit.reduced, fit.full, test = "Chisq")
###结果卡方值不显著，表明两个模型拟合程度一样好，所以增加去掉的几个变量也不会将方程的预测精度更高。
##对系数结果指数化，可以更好解释模型系数
exp(coef(fit.reduced))
##获得系数置信区间
exp(confint(fit.reduced))
##用概率的形式思考比优势比更直观
##可以使用predict()函数，观察某个预测变量在各个水平时对结果概率的影响
testdata <- data.frame(rating = c(1, 2, 3, 4, 5), age = mean(Affairs$age), yearsmarried = mean(Affairs$yearsmarried), religiousness = mean(Affairs$religiousness))   #创建一个虚拟数据集，设定年龄、婚姻、宗教信仰为它们的均值，婚姻评分的范围为1~5
testdata
testdata$prob <- predict(fit.reduced, newdata = testdata, type = "response")   #使用测试数据集预测相应概率
testdata   #可以看出，当婚姻评分从1变至5时，婚外情概率从0.53降低至0.15
##再对年龄的影响进行预测
testdata2 <- data.frame(rating = mean(Affairs$rating), age = seq(17, 57, 10), yearsmarried = mean(Affairs$yearsmarried), religiousness = mean(Affairs$religiousness))
testdata2
testdata2$prob <- predict(fit.reduced, newdata = testdata2, type = "response")
testdata2   #可以看出，其他变量不变时，年龄从17增加到57，婚外情的概率将从0.34降低到0.11
##过度离势是指观测到的相应变量的方差大于期望的二项分布的方差，会导致奇异的标准误检验和不精确的显著性检验
##对过度离势进行检验
formula = ynaffair ~ age + yearsmarried + religiousness + rating
fit.test1 <- glm(formula = formula, family = binomial(), data = Affairs)
fit.test2 <- glm(formula = formula, family = quasibinomial(), data = Affairs)
pchisq(summary(fit.test2)$dispersion * fit.test1$df.residual, fit.test1$df.residual, lower = F)
###拒绝Φ=1的原假设，所以不存在过度离势