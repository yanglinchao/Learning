#读入数据
C2IT <- read.csv("C2IT.csv")
C2IT$Date <- as.Date(C2IT$Date, "%Y/%m/%d")
str(C2IT)

#求收益率
assets <- C2IT[, -1]
return <- log(tail(assets, -1) / head(assets, -1))

#建立拉格朗日定力指定的线性等式系统
#左侧:c(Q, 1, r)
#按行把协方差矩阵,根据数据集列数重复次数的1的组合向量，以及收益率的均值结合在一起
Q <- rbind(cov(return), rep(1, ncol(assets)), colMeans(return))
round(Q, 5)
#将矩阵的最后两行结合在一起生成新列放在矩阵的右部,为了拉格朗日定理(2*2矩阵)指定的线性系统的完整性,再将其他部分设为0
Q <- cbind(Q, rbind(t(tail(Q, 2)), matrix(0, 2, 2)))
round(Q, 5)
#右侧:c(0, 1, mu)
#在默认情况下,mu是0.005(在最小方差函数的参数中指定)
mu <- 0.005
b <- c(rep(0, ncol(assets)), 1, mu)

#求解
#成功建立线性系统的各个部分后求解,结果给出了最优权重和拉格朗日乘子
solve(Q, b)

#写一个minvariance()来一步完成上面的代码
minvariance <- function(assets, mu = 0.005){
  return <- log(tail(assets, -1) / head(assets, -1))
  Q <- rbind(cov(return), rep(1, ncol(assets)), colMeans(return))
  Q <- cbind(Q, rbind(t(tail(Q, 2)), matrix(0, 2, 2)))
  b <- c(rep(0, ncol(assets)), 1, mu)
  solve(Q, b)
}
minvariance(C2IT[, -1])

#以上求解过程还可以进一步深化.除了在给定的收益率水平上计算最小方差，还可以对更大范围的收益率求解最小方差
#求有效前沿(Portfolio Frontier)
frontier <- function(assets){
  return <- log(tail(assets, -1) / head(assets, -1))
  Q <- cov(return)
  n <- ncol(assets)
  r <- colMeans(return)
  Q1 <- rbind(Q, rep(1, n), r)
  Q1 <- cbind(Q1, rbind(t(tail(Q1, 2)), matrix(0, 2, 2)))
  rbase <- seq(min(r), max(r), length = 100)
  s <- sapply(rbase, function(x){
    y <- head(solve(Q1, c(rep(0, n), 1, x)), n)
    y %*% Q %*% y
  })
  plot(s, rbase, xlab = 'Return', ylab = "Variance")
}
frontier(C2IT[, -1])

#有效前沿还可以使用fPortfolio包
library(timeSeries)
C2IT <- timeSeries(C2IT[, 2:6], C2IT[, 1])
C2IT_return <- returns(C2IT)
library(fPortfolio)
plot(portfolioFrontier(C2IT_return))

#为了模仿上述代码中实现的内容,会出带有卖空约束的前沿图像
Spec <- portfolioSpec()
setSolver(Spec) <- "solveRshortExact"
Frontier <- portfolioFrontier(as.timeSeries(C2IT_return), Spec, constraints = "Short")
frontierPlot(Frontier, col = rep("orange", 2), pch = 19)
monteCarloPoints(Frontier, mcSteps = 1000, cex = 0.25, pch = 19)
grid()