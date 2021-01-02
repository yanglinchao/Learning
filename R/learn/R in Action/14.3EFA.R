options(digits = 2)
covariances <- ability.cov$cov
correlations <- cov2cor(covariances)   #协方差矩阵转化为相关系数矩阵
correlations
##判别需提供的公共因子数
library(psych)
fa.parallel(correlations, n.obs = 112, fa = "both", n.iter = 100, main = "Scree plots with parallel analysis")
###注意：对于EFA，Kaiser-Harris准则的特征值数大于0，而不是1，对于PCA则为1
##未旋转的主轴迭代因子法
fa <- fa(correlations, nfactors = 2, rotate = "none", fm = "pa")
fa
##用正交旋转提取因子
fa.varimax <- fa(correlations, nfactors = 2, rotate = "varimax", fm = "pa")
fa.varimax
###使用正交旋转将人为地强制两个因子不相关。若想允许两个因子相关，可以使用斜交转轴法。
##用斜交旋转提取因子
fa.promax <- fa(correlations, nfactors = 2, rotate = "promax", fm = "pa")
fa.promax
factor.plot(fa.promax, labels = rownames(fa.promax$loadings))