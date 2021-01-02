library(datasets)
data("iris")
library(e1071)
model <- svm(Species ~ ., data = iris)   #第一种建立模式，a
x <- iris[, -5]
y <- iris[, 5]
model <- svm(x, y, kernel = "radial", gamma = if(is.vector(x)) 1 else 1/ncol(x))   #第二种建立模式，b
summary(model)
predict_data <- iris[, 1:4]   #确认需要进行预测的样本特征矩阵
pred <- predict(model, predict_data)   #根据模型model对x数据进行预测
pred[sample(1:150, 3)]   #随机挑选3个预测结果进行展示
table(pred, y)   #模型预测精度展示

attach(iris)
x <- subset(iris, select = -Species)  #确定特征变量为数据集iris中除去Species的其他项
y <- Species   #确定结果变量为数据集iris中的Species项
type <- c("C-classification", "nu-classification", "one-classification")   #确定要使用的分类格式
kernel <- c("linear", "polynomial", "radial", "sigmoid")   #确定将要使用的核函数
pred <- array(0, dim = c(150, 3, 4))   #初始化预测结果矩阵的三维长度为150, 3, 4
accuracy <- matrix(0, 3, 4)   #初始化模型精准度矩阵的两维分别为3, 4
yy <- as.integer(y)   #为方便精度计算，将结果变量数量化为1, 2, 3
for(i in 1:3){   #确认j影响的维度代表核函数
  for(j in 1:4){   #确认j影响的维度代表核函数
    pred[, i, j] <- predict(svm(x, y, type = type[i], kernel = kernel[j]), x)   #对每一模型进行预测
    if(i > 2)
      accuracy[i, j] = sum(pred[, i, j] != 1)
    else
      accuracy[i, j] = sum(pred[, i, j] != yy)
  }
}
dimnames(accuracy) = list(type, kernel)   #确定模型精度变量的列名和行名
detach(iris)
table(pred[, 1, 3], y)

plot(cmdscale(dist(iris[, -5])), col = c("lightgray", "black", "gray")[as.integer(iris[, 5])], pch = c("o", "+")[1:150 %in% model$index + 1])  #绘制模型分类散点图
legend(2, -0.8, c("setosa", "versicolor", "vorginica"), col = c("lightgray", "black", "gray"), lty = 1)

data("iris")
model <- svm(Species ~ ., data = iris)
plot(model, iris, Petal.Width ~ Petal.Length, fill = FALSE, symbolPalette = c("lightgray", "black", "grey"), svSymbol = c("+"))   #绘制模型类别关于花萼宽度和长度的分类情况
legend(1, 2.5, c("setosa", "versicolor", "virginica"), col = c("lightgray", "black", "gray"), lty = 1)

wts <- c(1, 500, 500)   #确定各类别的比重为1:500:500
names(wts) <- c("setosa", "versicolor", "virginica")   #确定各个比重对应的类别
model3 <- svm(x, y, class.weights = wts)
pred3 <- predict(model3, x)
table(pred3, y)
