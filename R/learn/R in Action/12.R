library(coin)
score <- c(40, 57, 45, 55, 58, 57, 64, 55, 62, 65)
treatment <- factor(c(rep("A", 5), rep("B", 5)))
mydata <- data.frame(treatment, score)
t.test(score ~ treatment, data = mydata, var.equal = TRUE)
oneway_test(score ~ treatment, data = mydata, distribution = "exact")
##distrubution="exact"��������µľ�ȷ�ֲ�,Ҳ���Ը��ݽ����ֲ�(asymptotic)�����ؿ����س���(approxiamate(B=#))�������Ƽ���
library(multcomp)
set.seed(1234)
oneway_test(response ~ trt, data = cholesterol, distribution = approximate(B = 9999))
library(MASS)
UScrime <- transform(UScrime, So = factor(So))   #coin���涨��������ͱ�����������������ʽ����
wilcox_test(Prob ~ So, data = UScrime, distribution = "exact")
library(vcd)
Arthritis <- transform(Arthritis, Improved = as.factor(as.numeric(Improved)))
set.seed(1234)
chisq_test(Treatment ~ Improved, data = Arthritis, distribution = approximate(B=9999))
states <- as.data.frame(state.x77)
set.seed(1234)
spearman_test(Illiteracy ~ Murder, data = states, distribution = approximate(B=9999))
###spearman_test()�����ṩ������ֵ�����Ķ������û�����
##�Ե���ͳ����ʹ��������
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
##���ͳ������������
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