# 载入arules包
library(arules)
# 加载Groceries数据集
data("Groceries")
summary(Groceries)
length(Groceries)
# "Groceries"作为arules自带数据集不需要做转换处理,当用arules包处理实际数据的时候,要把数据转换为arules包识别的交易数据
# 查看前20条购买记录
inspect(Groceries[1:5])

# 进一步查看数据信息
class(Groceries)
Groceries
dim(Groceries)
colnames(Groceries)[1:5]
# basketSize表示每个transaction包含item数目，是row level；而ItemFrequency是这个item的支持度，是column level
basketSize <- size(Groceries)
summary(basketSize)
sum(basketSize) # count of all 1s in the sparse matrix
itemFreq <- itemFrequency(Groceries)
itemFreq[1:5]
sum(itemFreq) # 本质上代表“平均一个transaction购买的item个数
itemCount <- (itemFreq/sum(itemFreq))*sum(basketSize)
itemCount # itemCount表示每个item出现的次数
summary(itemCount)
orderedItem <- sort(itemCount, decreasing = T)
orderedItem[1:10]
# 也可以把支持度itemFrequency排序，查看支持度的最大值
orderedItemFreq <- sort(itemFrequency(Groceries), decreasing = T)
orderedItemFreq[1:10]
# 通过图形更直观观测
itemFrequencyPlot(Groceries, support=0.1)
# 按照排序查看
itemFrequencyPlot(Groceries, topN=10, horiz=T)


# apriori算法
rul <- apriori(Groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
# 注：minlen,maxlen这里是规则的LHS+RHS的并集的元素个数
# 查看频繁项集
inspect(rul)

# 规则评估
# 规则排序
# 按照lift顺序查看，也可以按照support或confidence进行查看
ordered_groceryrules <- sort(rul, by = "lift")
inspect(ordered_groceryrules)
# 搜索规则
yogurtrules <- subset(rul, items %in% c("yogurt"))
# 注：%in%是精确匹配；%pin%是部分匹配；%ain%是完全匹配
inspect(yogurtrules)

# 应用：假如商场经理想要促销chocolate,该如何做
rul1 <- apriori(Groceries, parameter = list(support = 0.002, confidence = 0.2, maxlen = 3), appearance = list(rhs = "chocolate", default = "lhs"))
rul1
inspect(rul1)

# 可视化：使用arulesViz包自带的plot函数绘制scatter,groupd或graph等图形
library(arulesViz)
plot(rul, method = "grouped", shading = "lift")
plot(rul, method = "scatterplot")
plot(rul, method = "two-key plot")
plot(rul, method = "matrix")
plot(rul, method = "matrix3D")
plot(rul, method = "graph")
plot(rul, method = "paracoord")
