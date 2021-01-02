#金融网络的表示、模拟和可视化
library(igraph)

set.seed(7)
e <- erdos.renyi.game(100, 0.1)   #仿真一个erdos-renyi图，设置节点数以及在两个任意节点之间划出一条边的概率
plot(e)

graph.density(e)   #计算密度
transitivity(e)   #计算聚类（传递性）
average.path.length(e)   #计算平均路径长度

set.seed(592)
w <- watts.strogatz.game(1, 100, 5, 0.05)   #创建一个随机的无标度网络
plot(w)
graph.density(w)   #计算密度
transitivity(w)   #计算聚类（传递性）
average.path.length(w)   #计算平均路径长度


#网络结构的分析和拓扑改变的检查
data <- read.csv("networktable.csv")
size <- read.csv2("vertices.csv")

bignetwork <- graph.data.frame(data, vertices = size)
is.connected(bignetwork)   #请求网络的基本性质
table(is.multiple(bignetwork))   #检查这个网络的边是否是多重的
str(is.loop(bignetwork))   #检查这个网络是否存在环
snetwork <- simplify(bignetwork, edge.attr.comb = "sum")
plot(snetwork, edge.arrow.size = 0.4)

walktrap.community(bignetwork)

monthlynetwork <- subset(data, (Year == 2008) & (Month == 9))

mAmount <- with(data, aggregate(Amount, by = list(Month = Month, Year = Year), FUN = mean))
plot(ts(mAmount$x, start = c(2007, 1), frequency = 12), ylab = "Amount")
ds <- sapply(2007:2010, function(year){
  sapply(1:12, function(mount){
    mdata <- subset(data, (Year == Year)&(Month == Month))
    graph.density(graph.data.frame(mdata))
  })
})
plot(ts(as.vector(ds), start = c(2007, 1), frequency = 12))
abline(v = 2008 + 259/366, col = "red")


#对系统风险的贡献——系统重要性金融机构的识别
g <- graph.data.frame(data)
degree <- degree(g, normalized = TRUE)
between <- betweenness(g, normalized = TRUE)
closeness <- closeness(g, normalized = TRUE)
eigenv <- evcent(g, directed = TRUE)$vector

norm <- function(x) x/mean(x)

index <- (norm(degree) + norm(between) + norm(closeness) + norm(eigenv)) / 4
hist(index)
