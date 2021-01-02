library(mice)
data(nhanes2)
nrow(nhanes2); ncol(nhanes2)
summary(nhanes2)
head(nhanes2)
describe <- function(x){
  par(mfrow=c(2, 2))
  hist(x)
  dotchart(x)
  boxplot(x, horizontal = T)
  qqnorm(x); qqline(x)
  par(mfrow=c(1, 1))
}
pay <- c(11, 19, 14, 22, 14, 28, 13, 81, 12, 43, 11, 16, 23, 42, 22, 26, 17, 22, 13, 27, 180, 16, 43, 82, 14, 11, 51, 76, 28, 66, 29, 14, 14, 65, 37, 16, 37, 35, 39, 27, 14, 17, 13, 38, 28, 40, 85, 32, 25, 26, 16, 12, 54, 40, 18, 27, 16, 14, 33, 29, 77, 50, 19, 34)
describe(pay)
sum(is.na(nhanes2))   #计算nhanes2中缺失值的数量
sum(complete.cases(nhanes2))   #计算nhanes2中缺失值的情况
library(mice)
md.pattern(nhanes2)
sub <- which(is.na(nhanes2[, 4])==TRUE)   #返回nhanes2数据集中第4列为NA的行
dataTR <- nhanes2[-sub, ]   #将第4列不为NA的数存入数据集dataTR中
dataTE <- nhanes2[sub, ]   #将第4列为NA的数存入数据集dataTE中
dataTE[ ,4] <- sample(dataTR[, 4], length(dataTE[, 4]), replace = T)   #在非缺失值中简单抽样
dataTE
total.nhanes2 <- rbind(dataTE, dataTR)
total.nhanes2
sub <- which(is.na(nhanes2[, 4])==TRUE)   #返回nhanes2数据集中第4列为NA的行
dataTR <- nhanes2[-sub, ]   #将第4列不为NA的数存入数据集dataTR中
dataTE <- nhanes2[sub, ]   #将第4列为NA的数存入数据集dataTE中
dataTE[ ,4] <- mean(dataTR[, 4])   #用非缺失值的均值代替缺失值
dataTE
sub <- which(is.na(nhanes2[, 4])==TRUE)   #返回nhanes2数据集中第4列为NA的行
dataTR <- nhanes2[-sub, ]   #将第4列不为NA的数存入数据集dataTR中
dataTE <- nhanes2[sub, ]   #将第4列为NA的数存入数据集dataTE中
lm <- lm(chl ~ age, data = dataTR)   #利用dataTR中age为自变量，chl为因变量构成线性回归模型lm
nhanes2[sub, 4] <- round(predict(lm, dataTE))   #利用dataTE中的数据按照模型lm对nhanes2中chl中的缺失数据进行预测
nhanes2
accept <- nhanes2[which(apply(is.na(nhanes2), 1, sum)!=0), ]   #存在缺失值的样本
donate <- nhanes2[which(apply(is.na(nhanes2), 1, sum)==0), ]   #无缺失值的样本
accept[1, ]
donate[1, ]
accept[2, ]
sa <- donate[which(donate[, 1] == accept[2, 1] & donate[, 3] == accept[2, 3] & donate[, 4] == accept[2, 4]), ]   #寻找与accept中第2个样本相似的样本
sa
accept[2, 2] <- sa[1, 2]   #用找到的样本的对应值替代缺失值
accept[2, ]
level1 <- nhanes2[which(nhanes2[, 3] == "yes"), ]   #按照变量hyp分层
level1
level1[4, 4] <- mean(level1[1:3, 4])   #用层内均值代替第4个样本的缺失值
level1
library(outliers)
set.seed(1)   #设置随机数种子，保证每次出现的随机数相同
y <- rnorm(100)   #生成100个标准正态随机数
outlier(y)   #找出其中离群最远的值
outlier(y, opposite = TRUE)   #找出最远离群值相反的值
dotchart(y)   #对y绘制点图
dim(y) <- c(20, 5)   #将y中的数据重新划分成20行5列的矩阵
outlier(y)   #求矩阵中每列的离群最远值
outlier(y, opposite = TRUE)   #求矩阵中每列的离群最远值的相反值
set.seed(1)   #设置随机数种子，保证每次出现的随机数相同
y <- rnorm(10)   #生成10个标准正态随机数
outlier(y, logical = TRUE)   #返回相应逻辑值，离群最远值用TRUE标记
plot(y)
set.seed(1)
x <- rnorm(12)   #生成12个标准正态随机数
x <- sort(x)   #将数据从小到大排序
dim(x) <- c(3, 4)   #将数据从小到大排序
x[1, ] <- apply(x, 1, mean)[1]   #用第一行的均值代替第一行中的数据
x[2, ] <- apply(x, 1, mean)[2]   #用第二行的均值代替第二行中的数据
x[3, ] <- apply(x, 1, mean)[3]   #用第三行的均值代替第三行中的数据
x
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE, FALSE, TRUE))   #生成列表
probs <- c(1:3/4)
rt.value <- c(0, 0, 0)   #设置返回值为3个数字
vapply(x, quantile, FUN.VALUE = rt.value, probs = probs)
##若将probs<-c(1:3/4)改成probs<-c(1:4/4),会导致返回值与要求格式不一致
probs <- c(1:4/4)   #设置四个分位点
vapply(x, quantile, FUN.VALUE = rt.value, probs = probs)
#结果显示错误，要求返回值长度必须为3，但FUN(X[1])返回的结果长度却是4，两者不一致导致错误
rt.value <- c(0, 0, 0, " ")   #设置返回值为3个数字和1个字符串
vapply(x, quantile, FUN.VALUE = rt.value, probs = probs)
x <- cbind(sample(c(1:50), 10), sample(c(1:50), 10))   #生成由两列不相关的定性数据组成的矩阵x
chisq.test(x)   #检验是否相关
x <- cbind(sample(c(1:50), 10, replace = T), rnorm(10), rnorm(10))   #随机生成数据集，其中第一列为样本编号，若样本编号相同则认为存在重复
head(x)   #去点重复值前的数据集前若干个观测值
y <- unique(x[, 1])   #将样本编号去掉重复
sub <- rep(0, length(y))   #生成列向量备用
for(i in 1:length(y))   #循环，根据样本编号筛选数据集，去掉重复观测值
  sub[i] = which(x[, 1] == y[i])[1]
x <- x[sub,]
head(x)
set.seed(1)   #设施随机数种子，保证每次出现的随机数相同
a <- rnorm(5)   #生成一列随机数
b <- scale(a)   #对该列随机数标准化
b
a <- c(0.7063422, 0.7533599, 0.6675749, 0.9341495, 0.6069284, 0.3462011)
n <- length(a) 
la <- rep(0, n)
la[which(a>0.5)] <- 1
la
city <- c(6, 7, 6, 2, 2, 6, 2, 1, 5, 7, 2, 1, 1, 6, 1, 3, 8, 8, 1, 1)
province <- rep(0, 20)
province[which(city>4)] <- 1
province
