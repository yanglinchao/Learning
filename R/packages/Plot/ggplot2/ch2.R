require(ggplot2)
str(diamonds)
qplot(carat, price, data = diamonds)   #钻石价格和重量之间的关系
qplot(log(carat), log(price), data = diamonds)   #钻石价格的指数和重量的指数之间的关系
qplot(carat, x*y*z, data = diamonds)   #钻石体积(x*y*z)与重量的关系
set.seed(1410)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
qplot(carat, price, data = dsmall, colour = color)   #根据变量color进行分类，每类有不同的颜色
qplot(carat, price, data = dsmall, shape = cut)   #根据变量cut进行分类，每类有不同的点的形状
qplot(carat, price, data = dsmall, colour = color, shape = cut)
qplot(carat, price, data = diamonds, alpha = I(1/10))  #透明度为1/10
qplot(carat, price, data = diamonds, alpha = I(1/100))   #透明度为1/100
qplot(carat, price, data = dsmall, geom = c("point", "smooth"))
qplot(carat, price, data = dsmall, geom = c("point", "smooth"), se = FALSE)
ggplot(dsmall, aes(x = carat, y = price)) + geom_point() + geom_smooth(se = FALSE)
qplot(color, price / carat, data = diamonds, geom = "jitter", alpha = I(1/5))
