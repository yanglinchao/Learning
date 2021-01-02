t.test(cars$speed, mu = 18, alternative = "two.side")   #H0:理论均值等于参考值
t.test(cars$speed, mu = 18, alternative = "greater")   #H0:理论均值小于等于参考值
t.test(cars$speed, mu = 18, alternative = "less")   #H0:理论均值大于等于参考值
library(MASS)
t.test(Prob ~ So, data = UScrime)
sapply(UScrime[c("U1", "U2")], function(x)(c(mean = mean(x), sd = sd(x))))
with(UScrime, t.test(U1, U2, paired = TRUE))
str(UScrime)
attach(UScrime)
prob_so1 <- Prob[So == 1]
prob_so0 <- Prob[So == 0]
var.test(prob_so0, prob_so1)
detach(UScrime)
table(UScrime$So)
prop.test(16, 47, 0.33, alternative = "two.sided", correct = FALSE)
binom.test(16, 47, 0.33, alternative = "two.sided")
str(mtcars)
mytable <- table(mtcars$vs, mtcars$am)
prop.test(mytable, correct = FALSE)
shapiro.test(cars$speed)
x <- c(210, 312, 170, 85, 223)
chisq.test(x)   #检验x是否服从均匀分布
x <- c(25, 45, 50, 54, 55, 61, 64, 68, 72, 75, 75, 78, 79, 81, 83, 84, 84, 84, 85, 86, 86, 86, 87, 89, 89, 89, 90, 91, 91, 92, 100)
A <- table(cut(x, breaks = c(0, 69, 79, 89, 100)))   #对样本数据进行分组
A
p <- pnorm(c(70, 80, 90, 100), mean(x), sd(x))   #获得理论分布的概率值
p <- c(p[1], p[2]-p[1], p[3]-p[2], 1-p[3])
chisq.test(A, p = p)   #检验是否服从正态分布
x <- c(335, 125, 160)
p <- c(9/16, 3/16, 4/16)
chisq.test(x, p = p)
weights <- c(165.1, 171.5, 168.1, 165.6, 166.8, 170.0, 168.8, 171.1, 168.8, 173.6, 163.5, 169.9, 165.4, 174.4, 171.8, 166.0, 174.6, 174.5, 166.4, 173.8)
ks.test(weights, "pnorm", 170, sqrt(10), alternative = "two.sided")
x <- c(420, 500, 920, 1380, 1510, 1650, 1760, 2100, 2300, 2350)
ks.test(x, "pexp", 1/1500)
ks.test(rnorm(50), rnorm(50))
m0 <- 130
prices <- c(230, 148, 126, 134.62, 155, 157.70, 160, 225, 125, 109, 157, 115, 125, 225, 118, 179, 176, 125, 123, 180, 151, 120, 143, 170, 190, 233, 148.72, 189, 121, 149, 225, 240)
prop.test(sum(prices-m0 > 0), 32, 0.5, "greater")
binom.test(sum(prices > 130), length(prices), p = 0.5, "greater")
im <- read.csv("Intima_Media_Thickness.csv")
attach(im)
Me <- median(AGE[GENDER==2 & tobacco>0])
tab.obs <- table(tobacco[tobacco>0 & GENDER==2 & AGE!=Me], AGE[GENDER==2 & tobacco>0 & AGE!=Me] > Me)
rownames(tab.obs) <- c("Former smoker", "Smoker")
colnames(tab.obs) <- c("AGE<Me", "AGE>ME")
tab.obs
fisher.test(tab.obs, alternative = "greater")
detach(im)
dose.lab1 <- c(22, 18, 28, 26, 13, 8, 21, 26, 27, 29, 25, 24, 22, 28, 15)
dose.lab2 <- c(25, 21, 31, 27, 11, 10, 25, 26, 29, 28, 26, 23, 22, 25, 17)
binom.test(sum(dose.lab1 > dose.lab2), sum(dose.lab1 != dose.lab2))
require(MASS)
with(UScrime, by(Prob, So, median))
wilcox.test(Prob ~ So, data = UScrime)
wilcox.test(dose.lab1, dose.lab2, paired = T, exact = FALSE)
##worksheet A
mu <- replicate(50000, rnorm(20, mean = -1.2, sd = sqrt(2)), simplify = TRUE)
inter.mu <- function(x) t.test(x, conf.level = 0.9)$conf.int
res <- t(apply(mu, MARGIN = 2, FUN = inter.mu))
str(res)
p <- sum((res[, 1]<-1.2) & res[, 2]>-1.2)/50000
p
##worksheet B
mu <- replicate(500, rnorm(20, mean = 1.2, sd = sqrt(4)), simplify = TRUE)
ftest <- function(x) t.test(x, conf.level = 0.95, alternative = "two.side")$p.value
res <- apply(mu, MARGIN = 2, FUN = ftest)
str(res)
sum(res < 0.05)
##worksheet C
niu <- c(1:8)
before <- c(12000, 13000, 21500, 17000, 15000, 22000, 11000, 21000)
after <- c(11000, 20000, 21000, 28000, 26000, 3000, 16000, 29000)
mydata <- data.frame(niu, before, after)
mydata
t.test(before, after, paired = TRUE, alternative = "greater")
binom.test(sum(before > after), sum(before != after), alternative = "greater")
wilcox.test(before, after, paired = T, exact = FALSE, aliernative = "greater")
xiong <- c(3.22, 3.07, 3.17, 2.91, 3.40, 3.58, 3.23, 3.11, 3.62)
t.test(xiong, mu = 3.1, alternative = "two.side")
beforedrink <- c(57, 54, 62, 64, 71, 65, 70, 75, 68, 70, 77, 74, 80, 83)
afterdrink <- c(55, 60, 68, 69, 70, 73, 74, 74, 75, 76, 76, 78, 81, 90)
t.test(beforedrink, afterdrink, paired = T, alternative = "less")
light <- c(850, 740, 900, 1070, 930, 850, 950, 980, 980, 880, 1000, 980, 930, 1050, 960, 810, 1000, 1000, 960, 960)
shapiro.test(light)
t.test(light, mu = 0)
t.test(light)$conf
A <- c(46.3, 42.5, 43.0, 43.9, 42.0, 41.5, 41.6, 44.4, 40.7)
B <- c(47.1, 44.5, 45.8, 49.0, 44.6, 43.7, 44.5, 47.4)
var.test(A, B)
t.test(A, B, alternative = "less")
data <- matrix(c(0, 8, 9, 3), nrow = 2, ncol = 2)
colnames(data) <- c("before", "after")
rownames(data) <- c("dead", "alive")
data
chisq.test(data)
mouth <- c(6, 7, 8)
number1 <- c(1500, 1600, 1450)
number2 <- c(675, 720, 610)
chisq.test(number2/number1)
