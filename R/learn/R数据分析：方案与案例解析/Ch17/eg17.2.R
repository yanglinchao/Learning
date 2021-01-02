library(ggplot2)
#####散点图#####
qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, colour=color)   #对不同颜色进行区分
qplot(carat, price, data = diamonds, shape=cut)   #对不同形状切工的信息进行区分
qplot(carat, price, data = diamonds, alpha=I(1/50))  
##设置alpha=I(1/n),n代表该点经过多少次重合不会再透明，可以看出大部分点在哪里重合。
##或者可以使用ggplot()函数中的二维直方图来表现，如下。
p <- ggplot(diamonds, aes(carat, price))
p + stat_bin2d(bins = 100)
##如果还需要对颜色和切工在散点图上进行区分，需要用ggplot()函数
p <- ggplot(diamonds, aes(carat, price))
p + geom_point(aes(colour=cut, shape=cut, size=depth), alpha=0.6, position = 'jitter')
qplot(carat, price, data=diamonds, geom=c("point","smooth"))   #添加平滑曲线
#####条形图和箱线图#####
library(ggplot2)
qplot(color, data = diamonds, geom = "bar")
qplot(color, data = diamonds, geom = "bar", weight=carat) + scale_y_continuous("carat")
p <- ggplot(data = diamonds, aes(x=color, fill=factor(cut)))
p + geom_bar(position = 'stack')
p + geom_bar(position = 'dodge')
p + geom_bar(position = 'fill')
p + geom_bar(position = 'identity', alpha=0.3)
qplot(color, price/carat, data = diamonds, geom = "boxplot")
p <- ggplot(diamonds, aes(color, price/carat, fill=color))
p + geom_boxplot()
p + geom_violin(alpha=0.8, width=0.9) + geom_jitter(shape=21, alpha=0.03)
#####直方图和密度图#####
qplot(carat, data = diamonds, geom = "histogram", binwidth=1)
qplot(carat, data = diamonds, geom = "histogram", binwidth=0.1)
qplot(carat, data = diamonds, geom = "histogram", binwidth=0.01)
qplot(carat, data = diamonds, geom = "histogram", fill=cut)
qplot(carat, data = diamonds, geom = "histogram", colour=cut)
p <- ggplot(diamonds, aes(carat))
p + geom_histogram(position = 'identity', alpha=0.3, aes(y = ..density.., fill=cut), color="white") + stat_density(geom = 'line', position = 'identity', aes(colour=cut))
#####时间序列图#####
qplot(date, uempmed, data=economics, geom = 'line')