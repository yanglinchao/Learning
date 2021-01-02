library(evir)
data(danish)   #载入evir包中的danish数据
help(danish)

#探索性数据分析
summary(danish)
hist(danish, breaks = 200, xlim = c(0, 20))

#理赔的尾部行为
emplot(danish)   #x轴使用对数尺度
emplot(danish, alog = "xy")   #xy轴都使用对数尺度
qplot(danish, trim = 100)   #创建QQ图，损失数据在100处截尾

#阈值的决定
meplot(danish, omit = 4)   #画出超过增加的阈值的样本平均超额

#对尾部拟合GPD超额
gpdfit <- gpd(danish, threshold = 10)   #拟合一个GPD分布
gpdfit$converged   #converged成分的零值说明使用极大似然估计时收敛到了最大值
gpdfit$par.ests
gpdfit$par.ses


#使用拟合的GPD模型估计分位数
tp <- tailplot(gpdfit)   #直接创建一个原始的丹麦火灾损失分布的尾部图形
gpd.q(tp, pp = 0.999, ci.p = 0.95)
quantile(danish, probs = 0.999, type = 1)

#使用拟合的GPD模型计算预期损失
tp <- tailplot(gpdfit)
gpd.q(tp, pp = 0.99)
gpd.sfall(tp, 0.99)
