#2.1����

(1 + 1/100)^100
17 %% 5   #ȡģ
17 %/% 5   #����

exp(1)
options(digits = 16)   #������Ч����Ϊ16λ
exp(1)

pi   #Բ����
sin(pi/6)
options(digits = 2)
sin(pi/6)


#2.2 ����
x <- 100
x
(1+ 1/x)^x
n <- 1
n <- n+1
n


#2.3 ����
seq(from = 1, to = 9, by = 2)
seq(1, 9, 2)


#2.4 ����
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

#2.4.1 ��ֵ�뷽��
x <- c(1.2, 0.9, 0.8, 1, 1.2)
x.mean <- sum(x)/length(x)
x.mean - mean(x)

x.var <- sum((x-mean(x))^2/(length(x)-1))
x.var - var(x)



#����ֵ����
dt <- 0.005
t <- seq(0, pi/6, by = dt)
ft <- cos(t)
(I <- sum(ft)*dt)

#ָ���ļ�����ʽ
x <- seq(10, 200, by = 10)
y <- (1+1/x)^x
exp(1) - y
plot(x, y)


#2.5 ȱʧֵ
a <- NA
is.na(a)

a <- c(11, NA, 13)
is.na(a)
mean(a)
mean(a, na.rm = TRUE)


#2.6 ����ʽ���丳ֵ
seq(10, 20, by = 3)
mean(c(1, 2, 3))
1 > 2


#2.7 �߼�����ʽ
c(0, 0, 1, 1) | c(0, 1, 0, 1)   #�����㣬A��B��������һ����TRUE����A|B����TRUE
xor(c(0, 0, 1, 1), c(0, 1, 0, 1))   #ִ��������㣬��A����B��TRUE�������߲��ܶ���TRUE������ʹ��xor()
c(0, 0, 1, 1) & c(0, 1, 0, 1)   #�����㣬A��B��ΪTRUE����A&B��TRUE
1 & 0

x <- c(1, NA, 3, 4)
x > 2
x[x > 2]
subset(x, subset = x > 2)

#2.8����
A <- matrix(c(2, 3, 5, 4), nrow = 2, ncol = 2)
det(A)