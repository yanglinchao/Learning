range <- c(582, 562, 653, 491, 541, 516, 601, 709, 392, 758, 582, 487)
A <- c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4)
B <- c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3)
plot(range ~ A, pch=B)
legend(1.5, 750, legend=1:3, pch=B)  #在（1.5,750）处添加图例
par(mfrow=c(1,2))
boxplot(range ~ A, xlab="A"); boxplot(range ~ B, xlab="B")
par(mfrow=(1,1))
A <- factor(A); B <- factor(B)   #将A、B转化为因子
(range.aov <- aov(range ~ A + B))    #拟合方差分析模型
summary(range.aov)