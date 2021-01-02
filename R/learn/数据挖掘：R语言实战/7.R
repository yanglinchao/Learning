countries <- read.table("countries_ch7.txt", sep = ",")
dim(countries)
names(countries) <- c("country", "birth", "death")
var <- countries$country
var <- as.character(var)   #将var转换为字符型
for(i in 1:68) row.names(countries)[i] <- var[i]   #将数据集countries的行命名为相应国家名
head(countries)
plot(countries$birth, countries$death)
C <- which(countries$country == "CHINA")   #获取“中国”在数据集中的位置
T <- which(countries$country == "TAIWAN")
H <- which(countries$country == "HONG KONG")
I <- which(countries$country == "INDIA")
U <- which(countries$country == "UNITED STATES")
J <- which(countries$country == "JAPAN")
M <- which.max(countries$birth)   #获取出生率最高的国家或地区在数据集中的位置
points(countries[c(C, T, H, I, U, J, M), -1], pch = 16)   #以实心圆点标出如上国家和地区的样本点
legend(countries$birth[C], countries$death[C], "CHINA", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)   #标出“中国”样本点的图例"CHINA"
legend(countries$birth[T], countries$death[T], "TAIWAN", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)
legend(countries$birth[H], countries$death[H], "HONG KONG", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)
legend(countries$birth[I], countries$death[I], "INDIA", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)
legend(countries$birth[U], countries$death[U], "UNITED STATES", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)
legend(countries$birth[J], countries$death[J], "JAPAN", bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)
legend(countries$birth[M], countries$death[M], countries$country[M], bty = "n", xjust = 0.4, yjust = 0.3, cex = 0.8)   #标出出生率最高国家样本点的图例
fit_km1 <- kmeans(countries[, -1], centers = 3)   #利用kmeans算法对countries数据集进行聚类
print(fit_km1)   #输出聚类结果
fit_km1$centers   #获取各类中心点坐标
fit_km1$totss; fit_km1$tot.withinss; fit_km1$betweenss   #分别输出本次聚类的总平方和、组内平方和的总和、组间平方和
fit_km1$tot.withinss+fit_km1$betweenss
plot(countries[, -1], pch = (fit_km1$cluster-1))   #将countries数据集中聚为3类的样本点以3种不同形状表示
points(fit_km1$centers, pch=8)   #将三类的中心点以星号标记
legend(fit_km1$centers[1, 1], fit_km1$centers[1, 2], "Center_1", bty = "n", xjust = 1, yjust = 0, cex = 0.8)   #对类别1的中心点添加标注“Center_1”
legend(fit_km1$centers[2, 1]-2, fit_km1$centers[2, 2], "Center_2", bty = "n", xjust = 0, yjust = 0, cex = 0.8)   #对类别1的中心点添加标注“Center_1”
legend(fit_km1$centers[3, 1], fit_km1$centers[3, 2], "Center_3", bty = "n", xjust = 0.5, cex = 0.8)   #对类别1的中心点添加标注“Center_1”
result <- rep(0, 67)   #设置result变量用于存放67个聚类优度值
for(k in 1:67){   #对类别数k取1至67进行循环
  fit_km2 <- kmeans(countries[, -1], center = k)   #取类别数k，进行K均值聚类
  result[k] <- fit_km2$betweenss/fit_km2$totss   #计算类别数为k时的聚类优度，存入result中
}
round(result, 2)   #输出计算所得result，取小数位后两位的结果
plot(1:67, result, type = "b", main = "Choosing the Optimal Number of Cluster", xlab = "number of cluster:1 to 67", ylab = "betweenss/totss")
points(10, result[10], pch=16)
legend(10, result[10], paste("(10,", sprintf("%.1f%%", result[10]*100), ")", sep=""), bty="n", xjust=0.3, cex=0.8)   #对类别数为10的点给出其坐标标注(x, y), x为其类别数10， y为其聚类优度(%)
fit_km3 <- kmeans(countries[, -1], centers = 10)
cluster_CHINA <- fit_km3$cluster[which(countries$country == "CHINA")]   #获取中国大陆所属类别，记入cluster_CHINA
which(fit_km3$cluster==cluster_CHINA)   #选择出与中国大陆同类别的国家和地区
library(cluster)
fit_pam <- pam(countries[, -1], 3)   #用k-Medoids算法对countries数据集作聚类
print(fit_pam)
head(fit_pam$data)   #回看产生该聚类结果的相应数据集
fit_pam$call   #回看产生该聚类结果的函数设置
fit_pam1 <- pam(countries[, -1], 3, keep.data = FALSE)   #keep.data设置为FALSE时，数据集不再保留
fit_pam1$data
fit_pam2 <- pam(countries[, -1], 3, cluster.only = TRUE)   #更改cluster.only为FALSE时，除了各样本归属类别不再产生其他聚类相关信息
print(fit_pam2)
which(fit_km1$cluster != fit_pam$cluster)   #比较K-Means和K-Medoids
fit_hc <- hclust(dist(countries[, -1]))   #对countries数据集进行系谱聚类
print(fit_hc)
plot(fit_hc)
group_k3 <- cutree(fit_hc, k=3)   #利用剪枝函数cutree()中的参数k控制输出3类别的系谱聚类结果
group_k3
table(group_k3)   #将如上结果以表格形式总结
group_h18 <- cutree(fit_hc, h=18)   #利用剪枝函数cutree()中的参数h控制输出Height=18时的系谱聚类结果
group_h18
table(group_h18)
sapply(unique(group_k3), function(g)countries$country[group_k3 == g])   #查看如上k=3的聚类结果中各类别样本
plot(fit_hc)
rect.hclust(fit_hc, k=4, border = "light grey")   #用浅灰色矩形框出4分类的聚类结果
rect.hclust(fit_hc, k=7, which=c(2,6), border = "dark grey")   #用深灰色矩形框出7分类的第2类和第6类的聚类结果
library(fpc)
ds1 <- dbscan(countries[, -1], eps = 1, MinPts = 5)   #取半径参数eps为1，密度阈值MinPts为5
ds2 <- dbscan(countries[, -1], eps = 4, MinPts = 5)
ds3 <- dbscan(countries[, -1], eps = 4, MinPts = 2)
ds4 <- dbscan(countries[, -1], eps = 8, MinPts = 2)
ds1; ds2; ds3; ds4
par(mfcol=c(2, 2))
plot(ds1, countries[, -1], main = "1:MinPts=5 eps=1")
plot(ds3, countries[, -1], main = "3:MinPts=2 eps=4")
plot(ds2, countries[, -1], main = "2:MinPts=5 eps=4")
plot(ds4, countries[, -1], main = "4:MinPts=2 eps=8")
par(mfcol=c(1, 1))
d <- dist(countries[, -1])   #计算数据集的距离矩阵d
max(d); min(d)
library(ggplot2)
interval <- cut_interval(d, 30)   #对各样本间的距离进行分段处理，结合最大值最小值相差50左右，取居中段数为30
table(interval)   #展示数据分段结果
which.max(table(interval))   #找出所含样本点最多的区间
for(i in 4:6){
  for(j in 1:10){
    ds <- dbscan(countries[, -1], eps = i, MinPts = j)
    print(ds)
  }
}
library(mclust)
fit_em <- Mclust(countries[, -1])   #对countries进行EM聚类
summary(fit_em)
summary(fit_em, parameters = TRUE)    #获取EM聚类结果的细节信息
plot(fit_em)    #对EM聚类结果制图
countries_BIC <- mclustBIC(countries[, -1])   #获取countries在各模型和类别数下的BIC值
countries_BICsum <- summary(countries_BIC, data = countries[, -1])
countries_BICsum
countries_BIC   #输出BIC矩阵
plot(countries_BIC, G=1:7, col="black")   #对countries在类别数为1至7的条件下的BIC值作图
names(countries_BICsum)   #查看countries_BICsum中可获得的结果
mclust2Dplot(countries[, -1], classification = countries_BICsum$classification, parameters = countries_BICsum$parameters, col = "black")   #绘制分类图
countries_Dens <- densityMclust(countries[, -1])   #对每一个样本进行密度估计
plot(countries_Dens, countries[, -1], col = "grey", nlevels = 55)   #作2维密度图
plot(countries_Dens, type = "persp", col = grey(0.8))   #作3维密度图
