library(coin)
score <- c(40, 57, 45, 55, 58, 57, 64, 55, 62, 65)
treatment <- factor(c(rep("A", 5), rep("B", 5)))
mydata <- data.frame(treatment, score)
t.test(score ~ treatment, data = mydata, var.equal = TRUE)
oneway_test(score ~ treatment, data = mydata, distribution = "exact")
##distrubution="exact"是零假设下的精确分布,也可以根据渐进分布(asymptotic)和蒙特卡洛重抽样(approxiamate(B=#))来做近似计算
library(multcomp)
set.seed(1234)
oneway_test(response ~ trt, data = cholesterol, distribution = approximate(B = 9999))
library(MASS)
UScrime <- transform(UScrime, So = factor(So))   #coin包规定所有类别型变量都必须以因子形式编码
wilcox_test(Prob ~ So, data = UScrime, distribution = "exact")
library(vcd)
Arthritis <- transform(Arthritis, Improved = as.factor(as.numeric(Improved)))
set.seed(1234)
chisq_test(Treatment ~ Improved, data = Arthritis, distribution = approximate(B=9999))
states <- as.data.frame(state.x77)
set.seed(1234)
spearman_test(Illiteracy ~ Murder, data = states, distribution = approximate(B=9999))
###spearman_test()函数提供了两数值变量的独立性置换检验
##对单个统计量使用自助法
rsq <- function(formula, data, indices){
  d <- data[indices,]
  fit <- lm(formula, data = d)
  return(summary(fit)$r.square)
}
library(boot)
set.seed(1234)
results <- boot(data = mtcars, statistic = rsq, R = 1000, formula = mpg ~ wt + disp)
print(results)
plot(results)
boot.ci(results, type = c("perc", "bca"))
##多个统计量的自助法
bs <- function(formula, data, indices){
  d1 <- data[indices,]
  fit1 <- lm(formula, data = d1)
  return(coef(fit1))
}
library(boot)
set.seed(1234)
results1 <- boot(data = mtcars, statistic = bs, R = 1000, formula = mpg ~ wt + disp)
print(results1)
plot(results1, index=2)
boot.ci(results1, type = "bca", index = 1)
