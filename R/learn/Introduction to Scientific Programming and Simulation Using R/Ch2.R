#2.1算数

(1 + 1/100)^100
17 %% 5   #取模
17 %/% 5   #整除

exp(1)
options(digits = 16)   #设置有效数字为16位
exp(1)

pi   #圆周率
sin(pi/6)
options(digits = 2)
sin(pi/6)


#2.2 变量
x <- 100
x
(1+ 1/x)^x
n <- 1
n <- n+1
n


#2.3 函数
seq(from = 1, to = 9, by = 2)
seq(1, 9, 2)


#2.4 向量
(x <- seq(1, 20, by = 2))
(y <- rep(3, 4))
(z <- c(y, x))
(x <- 100:110)
i <- c(1, 3, 2)
x[i]

j <- c(-1, -2, -3)
x[j]

x <- c()
length(x)

x <- c(1, 2, 3)
y <- c(4, 5, 6)
x*y
x+y
x^y

sqrt(1:6)
sort(c(5, 1, 3, 4, 2))

#2.4.1 均值与方差
x <- c(1.2, 0.9, 0.8, 1, 1.2)
x.mean <- sum(x)/length(x)
x.mean - mean(x)

x.var <- sum((x-mean(x))^2/(length(x)-1))
x.var - var(x)



#简单数值积分
dt <- 0.005
t <- seq(0, pi/6, by = dt)
ft <- cos(t)
(I <- sum(ft)*dt)

#指数的极限形式
x <- seq(10, 200, by = 10)
y <- (1+1/x)^x
exp(1) - y
plot(x, y)


#2.5 缺失值
a <- NA
is.na(a)

a <- c(11, NA, 13)
is.na(a)
mean(a)
mean(a, na.rm = TRUE)


#2.6 表达式及其赋值
seq(10, 20, by = 3)
mean(c(1, 2, 3))
1 > 2


#2.7 逻辑表达式
c(0, 0, 1, 1) | c(0, 1, 0, 1)   #或运算，A和B中至少有一个是TRUE，则A|B就是TRUE
xor(c(0, 0, 1, 1), c(0, 1, 0, 1))   #执行异或运算，即A或者B是TRUE，但两者不能都是TRUE，可以使用xor()
c(0, 0, 1, 1) & c(0, 1, 0, 1)   #和运算，A和B均为TRUE，则A&B是TRUE
1 & 0

x <- c(1, NA, 3, 4)
x > 2
x[x > 2]
subset(x, subset = x > 2)

#2.8矩阵
A <- matrix(c(2, 3, 5, 4), nrow = 2, ncol = 2)
det(A)