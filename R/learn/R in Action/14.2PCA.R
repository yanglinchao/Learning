library(psych)
##判断主成分的个数
fa.parallel(USJudgeRatings[, -1], fa = "pc", n.iter = 100, show.legend = FALSE, main = "Scree plot with parallel analysis")   #从图中可以看出应当只保留一个特征根
##提取主成分
pc <- principal(USJudgeRatings[, -1], nfactors = 1)
pc   #pc1表示成分载荷，用来解释主成分含义；h2栏指公因子方差，主成分能解释每个变量方差的多少；SS loading指与特定主成分相关联的标准化后的方差值；Proportion Var表示每个主成分对整个数据集的解释程度
fa.parallel(Harman23.cor$cov, n.obs = 302, fa = "pc", n.iter = 100, show.legend = FALSE, main = "Scree plot with parallel analysis")
pc2 <- principal(Harman23.cor$cov, nfactors = 2, rotate = "none")
pc2
##主成分旋转
rc2 <- principal(Harman23.cor$cov, nfactors = 2, rotate = "varimax")
rc2
##从原始数据中获取成分得分
head(pc$scores)
##获取主成分得分的系数
round(unclass(rc2$weights), 2)
##利用如下公式可以得到主成分得分：
PC1 <- 0.28*height + 0.30*arm.span + 0.30*forearm + 0.28*lower.leg - 0.06*weight - 0.08*bitro.diameter - 0.10*chest.girth - 0.04*chest.width
PC2 <- -0.05*height - 0.08*arm.span - 0.09*forearm - 0.06*lower.leg + 0.33*weight + 0.32*bitro.diameter + 0.34*chest.girth + 0.27*chest.width