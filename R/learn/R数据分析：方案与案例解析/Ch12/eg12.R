dat <- read.table(file = "eg12.txt", header = T)
attach(dat)
ym <- y/m   #单位播种面积产量
lm <- l/m   #单位播种面积农业劳动力
km <- k/m   #单位播种面积化肥使用量
summary(ym)
summary(lm)
summary(km)
nls.dat <- nls(ym ~ A*(lm^a)*(km^(1-a)), start = list(A=0.5, a=1), trace = T) 
#使用非线性最小二乘法时赋予初始值A=0.5,a=1,tarce=T把迭代过程都返回。nls()默认使用的是高斯-牛顿算法
summary(nls.dat)
plot(ym ~ lm)
lines(lm, fitted(nls.dat))
plot(ym ~ km)
lines(km, fitted(nls.dat))
Rsq <- 1-sum(resid(nls.dat)^2)/(sum((ym-mean(ym))^2))
Rsq
adjRsq <- 1-(length(ym)-1)/(length(ym)-2)*(1-Rsq)
adjRsq
lm.dat <- lm(ym ~ lm + km)   
anova(nls.dat, lm.dat)   #F test
Q <- -2*(logLik(nls.dat)-logLik(lm.dat))   #似然比检验
df.Q <- df.residual(nls.dat) - df.residual(lm.dat)
1-pchisq(Q, df.Q)
