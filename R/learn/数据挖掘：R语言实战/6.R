library(arules)
data("Groceries")
summary(Groceries)
inspect(Groceries[1:10])   #观测Groceries数据集中前10行数据items
rules0 <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.5))   #生成关联规则rules0
rules0   #显示rules0中生成关联规则条数
inspect(rules0[1:10])
rules1 <- apriori(Groceries, parameter = list(support = 0.005, confidence = 0.5))   #将支持度调整到0.005，记为rules1
rules1
rules2 <- apriori(Groceries, parameter = list(support = 0.005, confidence = 0.6))
rules2
rules3 <- apriori(Groceries, parameter = list(support = 0.005, confidence = 0.64))
rules3
inspect(rules3)
rules.sorted_sup <- sort(rules0, by = "support")   #给定置信度阈值为0.5，按支持度排序，记为rules.sorted_sup
inspect(rules.sorted_sup[1:5])
rules4 <- apriori(Groceries, parameter = list(maxlen = 2, supp = 0.001, conf = 0.1), appearance = list(rhs = "mustard", default = "lhs"))
inspect(rules4)
itemsets_apr <- apriori(Groceries, parameter = list(supp = 0.001, target = "frequent itemsets"), control = list(sort = -1))   #将apriori()中目标参数取值设为“频繁项集”
itemsets_apr
inspect(itemsets_apr[1:5])
itemsets_ecl <- eclat(Groceries, parameter = list(minlen = 1, maxlen = 3, supp = 0.001, target = "frequent itemsets"), control = list(sort = -1))   #按出现的频繁程度排序，输出项数为2的项集
itemsets_ecl
inspect(itemsets_ecl[1:5])
library(arulesViz)
rules5 <- apriori(Groceries, parameter = list(support = 0.002, confidence = 0.5))
rules5
plot(rules5)
plot(rules5, interactive = TRUE)   #绘制互动散点图
plot(rules5, shading = "order", control = list(main = "Two - key plot"))   #绘制Two-key图
plot(rules5, method = "grouped")   #对rules5作分组图
plot(rules5, method = "matrix", measure = "lift")
plot(rules5, method = "matrix3D", measure = "lift")
plot(rules5, method = "paracoord")
