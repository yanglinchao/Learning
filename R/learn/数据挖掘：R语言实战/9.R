library(rpart)
data(car.test.frame)
head(car.test.frame)
car.test.frame$Mileage = 100*4.546/(1.6*car.test.frame$Mileage)   #将“英里数(Mileage)”的取值转换为“油耗”指标
names(car.test.frame) = c("价格", "产地", "可靠性", "油耗", "类型", "车重", "发动机功率", "净马力")
head(car.test.frame)
str(car.test.frame)   #探寻数据集内部结构
summary(car.test.frame)
Group_Mileage <- matrix(0, 60, 1)   #设矩阵Group_Mileage用于存放新变量
Group_Mileage[which(car.test.frame$"油耗" >= 11.6)] = "A"
Group_Mileage[which(car.test.frame$"油耗" <= 9)] = "C"
Group_Mileage[which(Group_Mileage == 0)] = "B"   #将不在组A、C中的样本Group_Mileage值取为B
car.test.frame$"分组油耗" = Group_Mileage   #在数据集中添加新变量分组油耗，取名为Group_Mileage
car.test.frame[1:10, c(4, 9)]
a <- round(1/4*sum(car.test.frame$"分组油耗" == "A"))
b <- round(1/4*sum(car.test.frame$"分组油耗" == "B"))
c <- round(1/4*sum(car.test.frame$"分组油耗" == "C"))
a; b; c
library(sampling)
sub <- strata(car.test.frame, stratanames = "分组油耗", size = c(c, b, a), method = "srswor")   #使用strata函数对car.test.frame中的“分组油耗”变量进行分层抽样
sub
Train_Car <- car.test.frame[-sub$ID_unit, ]   #生成训练集Train_Car
Test_Car <- car.test.frame[sub$ID_unit, ]   #生成测试集Test_Car
nrow(Train_Car); nrow(Test_Car)  #显示训练集、测试集行数，检查其比例是否为3:1
library(rpart)
formula_Car_Reg <- 油耗 ~ 价格 + 产地 + 可靠性 + 类型 + 车重 + 发动机功率 + 净马力   #设定模型公式
rp_Car_Reg <- rpart(formula_Car_Reg, Train_Car, method = "anova")   #构建回归树
print(rp_Car_Reg)
printcp(rp_Car_Reg)   #导出回归树的cp表格
summary(rp_Car_Reg)
rp_Car_Reg1 <- rpart(formula_Car_Reg, Train_Car, method = "anova", minsplit = 10)  #将分支包含最小样本数minsplit从默认值20更改为10，新的回归树记为rep_Car_Reg1
print(rp_Car_Reg1)
rp_Car_Reg2 <- rpart(formula_Car_Reg, Train_Car, method = "anova", cp = 0.1)
print(rp_Car_Reg2)
printcp(rp_Car_Reg2)
rp_Car_Reg3 <- prune.rpart(rp_Car_Reg, cp = 0.1)   #对决策树rp_Car_Reg按照cp值为0.1进行剪枝
print(rp_Car_Reg3)
printcp(rp_Car_Reg3)
rp_Car_Reg4 <- rpart(formula_Car_Reg, Train_Car, method = "anova", maxdepth = 1)   #将树的深度设为1
print(rp_Car_Reg4)
printcp(rp_Car_Reg4)
rp_Car_Plot <- rpart(formula_Car_Reg, Train_Car, method = "anova", minsplit = 10)
rpart.plot(rp_Car_Plot)
library(rpart.plot)
rpart.plot(rp_Car_Plot)
rpart.plot(rp_Car_Plot, type = 4)
rpart.plot(rp_Car_Plot, type = 4, branch = 1)
rpart.plot(rp_Car_Plot, type = 4, fallen.leaves = TRUE)
library(maptree)
draw.tree(rp_Car_Plot, col = rep(1,7), nodeinfo = TRUE)
plot(rp_Car_Plot, uniform = TRUE, main = "plot:Regression Tree")
text(rp_Car_Plot, use.n = TRUE, all = TRUE)

formula_Car_Cla <- 分组油耗 ~ 价格 + 产地 +　可靠性　+ 类型 + 车重 + 发动机功率 + 净马力
rp_Car_Cla <- rpart(formula_Car_Cla, Train_Car, method = "class", minsplit = 5)   #对训练集构建分类树
print(rp_Car_Cla)
rpart.plot(rp_Car_Cla, type = 4, fallen.leaves = TRUE)

pre_Car_Cla <- predict(rp_Car_Cla, Test_Car, type = "class")
pre_Car_Cla
(p = sum(as.numeric(pre_Car_Cla != Test_Car$分组油耗))/nrow(Test_Car))   #计算错误率
table(Test_Car$分组油耗, pre_Car_Cla)   #获取混淆矩阵


library(RWeka)
names(Train_Car) <- c("Price", "Country", "Reliability", "Mileage", "Type", "Weight", "Disp.", "HP", "Oil_Consumption")   #更改为英文变量名
Train_Car$Oil_Consumption <- as.factor(Train_Car$Oil_Consumption)   #将分组油耗Oil_Consumption的变量类型改为因子型，使J48()可识别
formula <- Oil_Consumption ~ Price + Country + Reliability + Type + Weight + Disp. + HP
c45_0 <- J48(formula, Train_Car)   #在默认参数取值下，构建分类树模型
c45_0
summary(c45_0)
c45_1 <- J48(formula, Train_Car, control = Weka_control(M=3))
c45_1
plot(c45_1)
