x <- c(1, 2, 3, 4)
x
class(x)   #显示向量x的数据类型
x <- c(1, 2, 3, 4)
x1 <- as.integer(x)
class(x1)
x <- c(1, 2, 3, 4)
x == 2
!(x<2)   #判断向量x中大于等于2的元素
which(x<2)   #选择向量x中小于2的元素
is.logical(x)   #判断向量x是否为逻辑型数据
y <- c("I", "love", "R")
y
class(y)
length(y)    #x显示向量y的维度，即数据个数
nchar(y)   #显示向量y中每个元素的字符个数
y == "R"
sex <- factor(c(1, 1, 0, 0, 1), levels = c(0, 1), labels = c("male", "female"))
sex
library(MASS)
data("Insurance")
dim(Insurance)   #获取数据集维度
dim(Insurance[1:10, ])   #获取数据集前10条数据的维度
dim(Insurance[, 2:4])   #获取数据集第2、3、4个变量的维度
dim(Insurance)[1]   #获取数据集维度向量第一个元素，即行数
vars <- c("District", "Age")
Insurance[20:25, vars]   #筛选出District及Age变量的第20~25行数据
names(Insurance)   #输出Insurance数据集变量名
head(names(Insurance), n=2)   #仅输出前两个变量名
tail(names[Insurance], n=2)   #仅输出后两个变量名
head(Insurance$Age)   #仅输出Age变量前若干条数据
levels(Insurance$Age)   #显示Age变量的4个水平值
sub1 <- sample(nrow(Insurance), 10, replace = T)   #从Insurance的总观测数中有放回随机收取10个行序号
Insurance[sub1, ]   #输出抽到的10条观测样本
sub2 <- sample(nrow(Insurance), 10, replace = T, prob = c(rep(0, nrow(Insurance)-1), 1))   #设置除最后一条样本的抽样概率为1外，其他样本被抽到的概率都为0
sub2
Insurance[sub2, ]
library(sampling)
sub4 <- strata(Insurance, stratanames = "District", size = c(1, 2, 3, 4))   #按街区District进行分层，且1-4街区分别无放回抽取1-4个样本
sub4
getdata(Insurance, sub4)   #获取分层抽样所得的数据集
sub6 <- strata(Insurance, stratanames = "District", size = c(1, 2, 3, 4), method = "systematic", pik = Insurance$Claims)   #选择系统抽样方法，并以Insurance中Claims变量控制各层内抽样概率
sub6
getdata(Insurance, sub6)
library(sampling)
sub7 <- cluster(Insurance, clustername = "District", size = 2, method = "srswor", description = TRUE)   #按照District变量的不同取值划分群，并无放回地抽取其中两个群的所有样本
train.sub <- sample(nrow(Insurance), 3/4*nrow(Insurance))   #随机无放回抽取3/4样本行序号
train.data <- Insurance[train.sub, ]   #将相应3/4行序号对应样本构造出训练集
test.data <- Insurance[-train.sub, ]   #将另外1/4行序号对应样本构造出测试集
dim(train.data); dim(test.data)   #显示训练集与测试集的维度