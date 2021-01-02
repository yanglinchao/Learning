# 聚类的有效性指标
# 外部指标ClusterExternalIndex()包括JC/FMI/RI
ClusterExternalIndexes <- function(x, y){
  # 聚类性能的外部度量指标JC/FMI/RI
  # 需要有聚类结果和参考结果
  # x和y分别为聚类结果和参考结果
  # x和y的长度应当相等
  
  # 将样本两两配对，根据其聚类结果是否相同和参考结果是否相同交叉分为4类
  # 若样本对聚类结果相同，参考结果相同，为A类，总数记为a
  # 若样本对聚类结果相同，参考结果不同，为B类，总数记为b
  # 若样本对聚类结果不同，参考结果相同，为C类，总数记为c
  # 若样本对聚类结果不同，参考结果不同，为D类，总数记为d
  
  m <- length(x)
  #生成a/b/c/d
  a <- 0; b <- 0; c <- 0; d <- 0
  for(i in 1:(m-1)){
    
    for(j in (i+1):m)
    
      if(x[i] == x[j]){
        if(y[i] == y[j]){
          a <- a+1
        }else{
          b <- b+1
        }
      }else{
        if(y[i] == y[j]){
          c <- c+1
        }else{
          d <- d+1
        }
      }
    
  }
  
  # JC:Jaccard Coefficient
  JC <- a/(a+b+c)
  
  # FMI:Fowlkes and Mallows Index
  FMI <- sqrt((a/(a+b))*(a/(a+c)))
  
  #RI:Rand Index
  RI <- (2*(a+d))/(m*(m-1))
  
  result <- list(JC=JC, FMI=FMI, RI=RI)
  return(result)
}


# 簇内样本间的平均距离
AvgDist <- function(data, clusters, disMethod = "euclidean"){
    # 簇内样本间的平均距离
    # data为参与聚类的数据(数据框或矩阵)，clusters为聚类的结果(向量)
    
    # 簇的个数
    cluster <- unique(clusters)
    n <- length(cluster)
    
    # 生成空向量储存各簇内样本间平均距离结果
    result <- rep(NA, n)
    
    # 对各簇内样本间平均距离进行计算
    for(i in 1:n){
      cdata <- data[which(clusters == cluster[i])]
      result[i] <- mean(dist(cdata, method = disMethod))
    }
    
    result <- data.frame(clusters = cluster, avgdist = result)
    return(result)
  }

# 簇内样本间的最大距离
MaxDist <- function(data, clusters, disMethod = "euclidean"){
    # 簇内样本间的平均距离
    # data为参与聚类的数据(数据框或矩阵)，clusters为聚类的结果(向量)
    
    # 簇的个数
    cluster <- unique(clusters)
    n <- length(cluster)
    
    # 生成空向量储存各簇内样本间平均距离结果
    result <- rep(NA, n)
    
    # 对各簇内样本间平均距离进行计算
    for(i in 1:n){
      cdata <- data[which(clusters == cluster[i])]
      result[i] <- max(dist(cdata, method = disMethod))
    }
    
    result <- data.frame(clusters = cluster, avgdist = result)
    return(result)
}


# 加权距离函数，欧式距离
MyWeightedDist <- function(data, weight = rep(1, ncol(data))){
  # data为计算样本间距离的数据，行为样本，列为变量
  # weight为根据变量重要程度设置的权重，默认权重相等
  
  n_col <- ncol(data)   # 变量数
  n_row <- nrow(data)   # 样本数
  
  # 生成矩阵储存结果
  # matrix_dist矩阵，列为1到(n_row-1)变量，行为2到n_row变量
  matrix_dist <- matrix(NA, nrow = (n_row-1), ncol = (n_row-1))
  
  # 从第1个样本开始循环，分别和第2、第3……个样本计算距离
  for(i in 1:(n_row-1)){
    
    for(j in (i+1):(n_row)){
      
      xi <- data[i, ]
      xj <- data[j, ]
      dist <- sqrt(sum(weight*((xi-xj)^2)))
      matrix_dist[j-1, i] <- dist
    }
    
  }
  
  result <- data.frame(matrix_dist)
  names(result) <- c(1:(n_row-1))
  rownames(result) <- c(2:(n_row))
  return(result)
  
}


# 计算中心点函数(均值)
CenterMean <- function(data, clusters){
  # 计算各簇中心点函数(均值)
  
  # 一共有n个簇
  cluster <- unique(clusters)
  n <- length(cluster)
  
  # 建立矩阵储存结果，行为类别，列为变量值
  result <- matrix(ncol = ncol(data), nrow = n)
  
  # 按簇分别计算中心点
  for(i in 1:n){
    cdata <- data[which(clusters == cluster[i]), ]
    result[i, ] <- apply(cdata, MARGIN = 2, mean)
  }
  
  result <- data.frame(cbind(cluster, result))
  names(result) <- c("clusters", names(data))
  
  return(result)
}

