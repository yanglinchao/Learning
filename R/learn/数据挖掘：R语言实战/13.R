##读入数据
wine <- read.table("winequality.txt", header = FALSE, sep = ";")
names(wine) <- c("FixedAcidity", "VolatileAcidity", "CitricAcid", "ResidualSugar", "Chlorides", "FreeSulfurDioxide", "TotalSulfurDioxide", "Density", "PH", "Sulphates", "Alcohol", "Quality")
wine$Quality[which(wine$Quality == 3)] <- "bad"
wine$Quality[which(wine$Quality == 4)] <- "bad"
wine$Quality[which(wine$Quality == 5)] <- "bad"
wine$Quality[which(wine$Quality == 6)] <- "mid"
wine$Quality[which(wine$Quality == 7)] <- "good"
wine$Quality[which(wine$Quality == 8)] <- "good"
wine$Quality[which(wine$Quality == 9)] <- "good"
wine$Quality <- ordered(wine$Quality, levels = c("bad", "mid", "good"))
summary(wine)

##数据标准化
scale01 <- function(x){
  ncol <- dim(x)[2]-1   #提取预处理样本集中特征向量的个数
  nrow <- dim(x)[1]   #提取预处理样本集中样本总量
  new <- matrix(0, nrow, ncol)
  for(i in 1:ncol){
    max <- max(x[, i])
    min <- min(x[, i])
    for(j in 1:nrow){
      new[j, i] <- (x[j, i] - min)/(max-min)
    }
  }
  new
}

##建立模型
##第一种建模方式
set.seed(71)
samp <- sample(1:4898, 3000)   #从总样本集中抽取3000个样本作为训练集
wine[samp, 1:11] <- scale01(wine[samp, ])   #对样本进行预处理
r <- 1/max(abs(wine[samp, 1:11]))   #确定参数rang的变化范围
set.seed(101)
library(nnet)
model1 <- nnet(Quality ~ . , data = wine, subset = samp, size = 4, rang = r, decay = 5e-4, maxit = 200)
set.seed(101)
summary(model1)
##第二种建模方式
x <- subset(wine, select = -Quality)
y <- wine[, 12]
y <- class.ind(y)
set.seed(101)
model2 <- nnet(x, y, decay = 5e-4, maxit = 200, size = 4, rang = r)


##进行预测
##针对第一种建模方式
x <- wine[, 1:11]
pred <- predict(model1, x, type = "class")
pred[sample(1:4898, 3)]   #挑选3个进行展示
##针对第二种建模方式
xt <- wine[, 1:11]
pred <- predict(model2, xt)
dim(pred)   #查看预测结果的维度
pred[sample(1:4898, 4), ]
name <- c("bad", "mid", "good")
prednew <- max.col(pred)   #每行最大值所在的列
prednewn <- name[prednew]
prednewn[sample(1:4898, 4)]

true <- max.col(y)   #确定真实值每行中最大值所在的列
table(true, prednewn)   #模型预测精度展示

library(nnet)
set.seed(71)
wine <- wine[sample(1:4898, 3000), ]
nrow.wine <- dim(wine)[1]
set.seed(444)
samp <- sample(1:nrow.wine, nrow.wine*0.7)   #从样本中抽取70%作为训练集
wine[samp, 1:11] <- scale01(wine[samp, ])   #对训练集样本进行预处理
wine[-samp, 1:11] <- scale01(wine[-samp, ])   #对测试样本进行预处理
r <- 1/max(abs(wine[samp, 1:11]))   #确定rang的变化范围
n <- length(samp)
err1 <- 0
err2 <- 0
for(i in 1:17){
  set.seed(111)
  model <- nnet(Quality ~ . , data = wine, maxit = 400, rang = r, size = i, subset = samp, decay = 5e-4)
  err1[i] <- sum(predict(model, wine[samp, 1:11], type = 'class') != wine[samp, 12])/n
  err2[i] <- sum(predict(model, wine[-samp, 1:11], type = 'class') != wine[-samp, 12])/(nrow.wine - n)
}
plot(1:17, err1, "l", col = 1, lty = 1, ylab = "模型误差率", xlab = "隐藏节点个数", ylim = c(min(min(err1), min(err2)), max(max(err1), max(err2))))
lines(1:17, err2, col = 1, lty = 3)
points(1:17, err1, col = 1, pch = "+")
points(1:17, err2, col = 1, pch = "o")
legend(1, 0.53, "测试集误判率", bty = "n", cex = 1.5)
legend(1, 0.40, "训练集误判率", bty = "n", cex = 1.5)

errl1 <- 0
errl2 <- 0
for(i in 1:500){
  set.seed(111)
  model <- nnet(Quality ~ ., data = wine, maxit = i, rang = r, size = 3, subset = samp)
  errl1[i] <- sum(predict(model, wine[samp, 1:11], type = 'class') != wine[samp, 12])/n
  errl2[i] <- sum(predict(model, wine[-samp, 1:11], type = 'class') != wine[-samp, 12])/(nrow.wine-n)
}
plot(1:length(errl1), errl1, 'l', ylab = "模型误判率", xlab = "训练周期", col = 1, ylim = c(min(min(errl1), min(errl2)), max(max(errl1), max(errl2))))
lines(1:length(errl1), errl2, col = 1, lty = 3)
legend(250, 0.47, "测试集误差率", bty = "n", cex = 1.2)
legend(250, 0.425, "训练集误判率", bty = "n", cex = 1.2)

set.seed(111)
model <- nnet(Quality ~ . , data = wine, maxit = 300, rang = r, size = 3, subset = samp)
x <- wine[-samp, 1:11]
pred <- predict(model, x, type = "class")
table(wine[-samp, 12], pred)
