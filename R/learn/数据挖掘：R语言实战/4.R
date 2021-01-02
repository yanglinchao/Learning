library(MASS)
data(Insurance)   #获取Insurance数据集
nrow(Insurance); ncol(Insurance)   #显示Insurance数据集的行列数
dim(Insurance)   #显示Insurance数据集维度，效果同上
head(Insurance)   #输出Insurance数据集的前若干条
attributes(Insurance)   #获取Insurance数据集属性列表
str(Insurance)   #查看Insurance数据集内部数据
summary(Insurance)   #查看Insurance数据集的变量概况
library(Hmisc)
describe(Insurance[, 1:3])   #查看Insurance数据集前3列变量的描述结果
describe(Insurance[, 4:5])   #查看Insurance数据集后2列变量的描述结果
library(fBasics)
describe(Insurance[, 1:3])   #查看Insurance数据集前3列变量的描述结果
library(timeDate)
skewness(Insurance[, 4:5])   #计算Insurance数据集中后两列变量的偏度（和1比，左偏、右偏）
kurtosis(Insurance[, 4:5])   #计算Insurance数据集中后两列变量的峰度（和0[正态分布]比，小于0平坦，大于0陡峭）
library(Matrix)
i <- sample(1:10, 10, replace = TRUE)   #在1至10中有放回地随机选取10个数，作为数据集中非空元素的行号
j <- sample(1:10, 10, replace = TRUE)   #在1至10中有放回地随机选取10个数，作为数据集中非空元素的行号
(A <- sparseMatrix(i, j, x = 1))   #对第i行j列的元素取值为1，其他位置元素为空，生成稀疏矩阵A
loca <- which(A==1, arr.ind = TRUE)   #取loca变量记录个非空元素位置
plot(loca, pch = 22)   #对如上loca变量值绘制散点图
cor(Insurance$Holders, Insurance$Claims)   #计算Holders和Claims的相关系数
hist(Insurance$Claims, main = "Histogram of Freq of Insurance$Claims")   #对Claims变量绘制直方图
hist(Insurance$Claims, freq = FALSE, density = 20, main = "Histogram of Density of Insurance$Claims")   #绘制密度直方图
lines(density(Insurance$Claims))   #在直方图中添加概率密度曲线
str(hist(Insurance$Claims, breaks = 20, labels = TRUE,   #绘制20组直方图，并标出各组频率值
         col = "black", border = "white",   #设置直方图中矩形颜色
         mian = "Histogram of Insurance$Claims with 20 bars"))
library(Hmisc)
Ecdf(Insurance$Claims, xlab = "Claims", main = "Cumulative Distribution of Claims")   #绘制Claims变量的累计分布图
data.plot <- with(Insurance,   #形成Insurance数据集的环境
                  rbind(data.frame(var1 = Claims[Age=="<25"], var2="<25"),   #构造以年龄段为<25的Claims值为变量1，"<25"为变量2的新数据集
                        data.frame(var1 = Claims[Age=="25-29"], var2="25-29"),
                        data.frame(var1 = Claims[Age=="30-35"], var2="30-35"),
                        data.frame(var1 = Claims[Age==">35"], var2=">35")
                        ))   #将4个新数据集按行连接为新数据集data.plot
Ecdf(data.plot$var1, lty=2, group = data.plot$var2, label.curves = 1:4, xlab = "Claims", main = "Cumulative Distribution of Claims by Age")
Ecdf(Insurance$Claims, add = TRUE)
Claims.bp <- boxplot(Insurance$Claims, main = "Distribution of Claims")   #对Claims变量绘制箱形图
Claims.bp$stats   #获取箱形图的5个界限值
points(x = 1, y = mean(Insurance$Claims), pch = 8)   #用星号标记出均值的位置
Claims.points <- as.matrix(Insurance$Claims[which(Insurance$Claims>102)], 6, 1)   #获取超过上侧延展线的6个异常值的取值
Claims.text <- rbind(Claims.bp$stats,mean(Insurance$Claims), Claims.points)   #将待标注12个点的取值汇总于Claims.text,包括箱形图的5个主要点、均值、6个异常值
for(i in 1:length(Claims.text)) text(x=1.1, y=Claims.text[i, ], labels = Claims.text[i,])   #将12个点的取值标注于箱形图的相应位置
boxplot(var1 ~ var2, data = data.plot, horizontal = TRUE,   #以data.plot数据集中的var1对var2绘图，且横向输出图形
        main = "Distribution of Claims by Age", xlab = "Claims", ylab = "Age")   #设置图形的名称，以及横纵轴轴变量名
with(Insurance,   #形成Insurance数据集的环境
     {
     boxplot(Holders ~ Age, boxwex = 0.25, at = 1:4+0.2,subset = Age == ">35")   #绘制第一个箱子：>35年龄段下的Holders分布
     boxplot(Holders ~ Age, add=TRUE, boxwex = 0.25, at = 1:4+0.2, subset = Age =="30-35")   #加入第2个箱子：30-35年龄段下的Holders分布
     boxplot(Holders ~ Age, add = TRUE, boxwex = 0.25, at = 1:4+0.2, subset = Age == "25-29")   #加入第3个箱子
     boxplot(Holders ~ Age, add = TRUE, boxwex = 0.25, at = 1:4+0.2, subset = Age == "<25")   #加入第4个箱子
     })
boxplot(var1 ~ var2, data = data.plot, add = TRUE, boxwex = 0.25, at = 1:4-0.2,
        col = "lightgrey", main = "Distribution of Claims & Holders by Age", xlab = "Age", ylab = "Claims&holders")   #加入以Age划分的Claims变量箱形图，即加入另外四个箱子：各年龄段下的Claims分布；将Claims的四个箱子填充为浅灰色，并设定图形及坐标轴名称
legend(x = "topleft", c("Claims", "Holders"), fill = c("lightgrey", "white"))   #为Holders和”Claims各自的四个箱子加上图例
data.bp <- list(data.plot$var1[which(data.plot$var2=="<25")],
                data.plot$var1[which(data.plot$var2=="25-29")],
                data.plot$var1[which(data.plot$var2=="30-35")],
                data.plot$var1[which(data.plot$var2==">35")])   #以list形式生成用于绘图的数据集data.bp
bpplot(data.bp, name = c("<25", "25-29", "30-35", ">35"), xlab = "Age", ylab = "Claims")   #绘制以Age划分的Claims变量比例箱形图
Claims_Age <- with(Insurance,
                   c(sum(Claims[which(Age=="<25")]),   #计算<25年龄组的Claims之和
                     sum(Claims[which(Age=="25-29")]),
                     sum(Claims[which(Age=="30-35")]),
                     sum(Claims[which(Age==">35")]))
                   )   #分别计算各年龄组的Claims之和后，以c()函数生成向量Claims_Age
barplot(Claims_Age, names.arg = c("<25", "25-29", "30-35", ">35"), density = rep(20, 4), main = "Distribution of Age by Claims", xlab = "Age", ylab = "Claims")   #绘制条形图，并设置四个矩阵的名称依次为"<25", "25-29", "30-35", ">35"
Holders_Age <- with(Insurance,
                    c(sum(Holders[which(Age=="<25")]),
                      sum(Holders[which(Age=="25-29")]),
                      sum(Holders[which(Age=="30-35")]),
                      sum(Holders[which(Age==">35")]))
                    )   #分别计算各年龄组的Holders之和后，以c()函数生成向量Holders_Age
Holders_Age
data_bar <- rbind(Claims_Age, Holders_Age)   #将Claims_Age与Holders_Age合并为data_bar
data_bar   #查看data_bar
barplot(data_bar, names.arg = c("<25", "25-29", "30-35", ">35"), beside = TRUE, main = "Age Distribution by Claims and Holders", xlab = "Age", ylab = "Claims&Holders", col = c("black", "darkgrey"))
legend(x = "topleft", rownames(data_bar), fill = c("black", "darkgrey"))
barplot(data_bar, names.arg = c("<25", "25-29", "30-35", ">35"), main = "Age Distribution by Claims and Holders", xlab = "Age", ylab = "Claims&Holders", col = c("black", "darkgrey"))
legend(x = "topleft", rownames(data_bar), fill = c("black", "darkgrey"))
dotchart(data_bar, xlab = "Claims&Holders", pch = 1:2, main = "Age Distribution by Claims and Holders")   #绘制点阵图
legend(x = 14000, y = 15, "<25", bty = "n")
legend(x = 14000, y = 11, "25-29", bty = "n")
legend(x = 14000, y = 11, "30-35", bty = "n")
legend(x = 14000, y = 11, ">35", bty = "n")
pie(Claims_Age, labels = c("<25", "25-29", "30-35", ">35"), main = "Pie Chart of Age by Claims", col = c("white", "lightgray", "darkgrey", "black"))   #绘制Age变量Claims取值的饼图
percent <- round(Claims_Age/sum(Claims_Age)*100)   #计算各组的比例
label <- paste(paste(c("<25", "25-29", "30-35", ">35"), ":"), percent, "%", sep = "")   #设置图形各部分图里的文本内容
pie(Claims_Age, labels = label, main = "Pie Chart of Age by Claims", col = c("white", "lightgrey", "darkgrey", "black"))   #绘制Age变量Claims取值的百分比饼图
library(plotrix)
pie3D(Claims_Age, labels = c("<25", "25-29", "30-35", ">35"), explode = 0.05, main = "3D Pie Chart of Age by Claims", labelcex = 0.8)
