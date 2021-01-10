require(ggplot2)
str(diamonds)
qplot(carat, price, data = diamonds)   #��ʯ�۸������֮��Ĺ�ϵ
qplot(log(carat), log(price), data = diamonds)   #��ʯ�۸��ָ����������ָ��֮��Ĺ�ϵ
qplot(carat, x*y*z, data = diamonds)   #��ʯ���(x*y*z)�������Ĺ�ϵ
set.seed(1410)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
qplot(carat, price, data = dsmall, colour = color)   #���ݱ���color���з��࣬ÿ���в�ͬ����ɫ
qplot(carat, price, data = dsmall, shape = cut)   #���ݱ���cut���з��࣬ÿ���в�ͬ�ĵ����״
qplot(carat, price, data = dsmall, colour = color, shape = cut)
qplot(carat, price, data = diamonds, alpha = I(1/10))  #͸����Ϊ1/10
qplot(carat, price, data = diamonds, alpha = I(1/100))   #͸����Ϊ1/100
qplot(carat, price, data = dsmall, geom = c("point", "smooth"))
qplot(carat, price, data = dsmall, geom = c("point", "smooth"), se = FALSE)
ggplot(dsmall, aes(x = carat, y = price)) + geom_point() + geom_smooth(se = FALSE)
qplot(color, price / carat, data = diamonds, geom = "jitter", alpha = I(1/5))