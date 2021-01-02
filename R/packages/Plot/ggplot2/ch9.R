##选取各个颜色里最小的钻石
ddply(diamonds, .(color), subset, carat == min(carat))
##选取各个颜色里最小的两颗钻石
ddply(diamonds, .(color), subset, order(carat) <= 2)
##选取每组里大小为前1%左右的钻石
ddply(diamonds, .(color), subset, carat > quantile(carat, 0.99))
##选取所有比组平均值大的钻石
ddply(diamonds, .(color), subset, price > mean(price))
##把每个颜色组里钻石的价格标准化,使其均值为0,方差为1
ddply(diamonds, .(color), transform, price = scale(price))
##减去组均值
ddply(diamonds, .(color), transform, price = price - mean(price))
nmissing <- function(x) sum(is.na(x))
nmissing(msleep$name)
nmissing(msleep$brainwt)
nmissing_df <- colwise(nmissing)
nmissing_df(msleep)
colwise(nmissing)(msleep)   #更便捷的方法
msleep2 <- msleep[, -6]   #移除第六列
numcolwise(median)(msleep2, na.rm = T)
ddply(msleep2, .(vore), numcolwise(median), na.rm = T)
