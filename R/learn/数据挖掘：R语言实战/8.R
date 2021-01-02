library(kknn)
data(miete)
head(miete)
dim(miete)
summary(miete)
library(sampling)   #加载用于获取分层抽样函数strata()的软件包sampling
n <- round(2/3*nrow(miete)/5)   #按照训练集占数据总量2/3的比例，计算每一等级中应抽取的样本量
n   #显示训练集中nmkat变量每一等级中需抽取样本量
sub_train <- strata(miete, strataname = "nmkat", size = rep(n, 5), method = "srswor")   #以nmkat变量的5个等级划分层次，进行分层抽样
data_train <- getdata(miete[, c(-1, -3, -12)], sub_train$ID_unit)   #获取如上ID_unit所对应的样本构成训练集，并踢出变量1、3、12
data_test <- getdata(miete[, c(-1, -3, -12)], -sub_train$ID_unit)   #获取除ID_unit所对应样本之外的数据构成训练集，并踢出变量1、3、12
dim(data_train); dim(data_test)
library(MASS)
fit_lda1 <- lda(nmkat~., data_train)   #以公式格式执行线性判别
names(fit_lda1)   #查看lda()可给出的输出项名称
fit_lda1$prior   #查看本次执行过程中所使用的先验概率
fit_lda1$counts   #查看数据集data_train中各类别的样本量
fit_lda1$means   #查看各变量在每一类别中的均值
fit_lda1
fit_lda2 <- lda(data_train[, -12], data_train[, 12])   #分别设置属性变量（除第12个变量nmkat外）与待判别变量（第12个变量nmkat）的取值，并记为fit_lda2
fit_lda2
plot(fit_lda1)
plot(fit_lda1, dimen = 1)   #对判别规则fit_lda1输出1个判别式的图形
pre_lda1 <- predict(fit_lda1, data_test)   #使用判别规则fit_lda1预测data_test中nmkat变量的类别
pre_lda1$class   #输出data_test中各样本的预测结果
pre_lda1$posterior   #输出个样本属于每一类别的后验概率
table(data_test$nmkat, pre_lda1$class)   #生成nmkat变量的预测值与实际值的混淆矩阵
error_lda1 <- sum(as.numeric(as.numeric(pre_lda1$class) != as.numeric(data_test$nmkat)))/nrow(data_test)   #计算错误率
error_lda1
library(klaR)
fit_bayes1 <- NaiveBayes(nmkat ~ ., data_train)   #以nmkat为待判别变量，以data_train来生成贝叶斯判别规则，记为fit_bayes
names(fit_bayes1)
fit_bayes1$apriori
fit_bayes1$tables   #tables项储存了用于建立判别规则的所有变量在各类别下的条件概率
plot(fit_bayes1, vars = "wfl", n = 50, col = c(1, "darkgrey", 1, "darkgrey", 1))   #对占地面积wfl绘制各类别下的密度图
plot(fit_bayes1, vars = "mvdauer", n = 50, col = c(1, "darkgrey", 1, "darkgrey", 1))   #对租赁期mvdauer绘制各类别下的密度图
plot(fit_bayes1, vars = "nmqm", n = 50, col = c(1, "darkgrey", 1, "darkgrey", 1))   #对每平方米净租金nmqm绘制各类别下的密度图
fit_bayes2 <- NaiveBayes(data_train[, -12], data_train[, 12])   #函数运行对象为数据框或数据矩阵时的贝叶斯判别格式，输出项同上
pre_bayes1 <- predict(fit_bayes1, data_test)   #根据fit_bayes1判别规则对测试集进行预测
pre_bayes1
table(data_test$nmkat, pre_bayes1$class)   #生成nmkat的真实值和预测值的混淆矩阵
error_bayes1 <- sum(as.numeric(as.numeric(pre_bayes1$class) != as.numeric(data_test$nmkat)))/nrow(data_test)   #计算贝叶斯判别预测错误率
error_bayes1
library(class)
fit_pre_knn <- knn(data_train[, -12], data_test[, -12], cl = data_train[, 12])   #建立K最近邻判别规则，并对测试集样本进行预测
fit_pre_knn
table(data_test$nmkat, fit_pre_knn)   #生成nmkat真实值与预测值的混淆矩阵
error_knn <- sum(as.numeric(as.numeric(fit_pre_knn) != as.numeric(data_test$nmkat)))/nrow(data_test)   #计算错误率
error_knn
error_knn <- rep(0,20)
for(i in 1:20){
  fit_pre_knn = knn(data_train[, -12], data_test[, -12], cl = data_train[, 12], k=i)   #构造K最近邻判别规则并预测
  error_knn[i] = sum(as.numeric(as.numeric(fit_pre_knn) != as.numeric(data_test$nmkat)))/nrow(data_test)
}
error_knn   #显示错误率向量error_knn的20个取值
plot(error_knn, type = "l", xlab = "K")
library(kknn)
fit_pre_kknn <- kknn(nmkat ~ ., data_train, data_test[, -12], k = 5)
summary(fit_pre_kknn)
fit <- fitted(fit_pre_kknn)   #输出有权重的K最近邻预测结果
fit
table(data_test$nmkat, fit)
error_kknn <- sum(as.numeric(as.numeric(fit) != as.numeric(data_test$nmkat)))/nrow(data_test)
error_kknn
