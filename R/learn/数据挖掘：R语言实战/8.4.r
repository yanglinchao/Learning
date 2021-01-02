data <- read.table("u_data_ch8.txt")
data <- data[, -4]
names(data) <- c("userid", "itemid", "rating")
head(data)
dim(data)
MovieLens_KNN <- function(Userid, Itemid, n, K){
  sub <- which(data$userid == Userid)   #获取待预测用户U0在数据集中各条信息所在的行标签，存于sub
  if(length(sub)>=n) sub_n <- sample(sub, n)
  if(length(sub)<n) sub_n <- sample(sub, length(sub))   #获取随机抽出的n个U0已评分电影M1-Mn的行标签，存于sub_n
  known_itemid <- data$itemid[sub_n]   #获取U0已评分电影M1-Mn的电影ID
  unknown_itemid <- Itemid   #获取待预测电影M0的ID号
  known_itemid
  unknown_itemid
  
  unknown_sub <- which(data$itemid == unknown_itemid)
  user <- data$userid[unknown_sub[-1]]   #获取已评价电影M0的用户ID，存于user
  user
  
  data_all <- matrix(0, 1+length(user), 2+length(known_itemid))  #设置data.all的行数、列数，所有值暂取0
  data_all <- data.frame(data_all)
  names(data_all) <- c("userid", paste("unknown_itemid_", Itemid), paste("itemid_", known_itemid, sep = ""))   #对data.all的各变量进行命名
  item <- c(unknown_itemid, known_itemid)
  data_all$userid <- c(Userid, user)   #对data.all中的userid变量赋值
  data_all
  
  for(i in 1:nrow(data_all)){   #对data_all按行进行外层循环
    data_temp <- data[which(data$userid == data_all$userid[i]), ]
    for(j in 1:length(item)){   #对data_all按行进行内层循环
      if(sum(as.numeric(data_temp$itemid == item[j])) != 0){   #判断该位置是否有取值
        data_all[i, j+1] = data_temp$rating[which(data_temp$itemid == item[j])]
      }
    }
  }
    data_all
    data_test_x <- data_all[1, c(-1, -2)]   #获取测试集的已知部分
    data_test_y <- data_all[1, 2]   #获取测试集的待预测值
    data_train_x <- data_all[-1, c(-1, -2)]   #获取训练集的已知部分
    data_train_y <- data_all[-1, 2]   #获取训练集的待预测值
    dim(data_test_x); length(data_test_y)
    dim(data_train_x); length(data_train_y)
    fit <- knn(data_train_x, data_test_x, cl = data_train_y, k = K)   #进行knn判别
    list("data_all:" = data_all, "True Rating:" = data_test_y, "Predict Rating:" = fit, "User ID:" = Userid, "Item ID:" = Itemid)
}
user1 <- NULL
for(Item in 1:20)
  user1 = c(user1, MovieLens_KNN(Userid = 1, Itemid = Item, n = 50, K = 10)$'True Rating:')
user1