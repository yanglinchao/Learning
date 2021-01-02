data <- read.table("u_data_ch8.txt")
data <- data[, -4]
names(data) <- c("userid", "itemid", "rating")
head(data)
dim(data)
MovieLens_KNN <- function(Userid, Itemid, n, K){
  sub <- which(data$userid == Userid)   #��ȡ��Ԥ���û�U0�����ݼ��и�����Ϣ���ڵ��б�ǩ������sub
  if(length(sub)>=n) sub_n <- sample(sub, n)
  if(length(sub)<n) sub_n <- sample(sub, length(sub))   #��ȡ��������n��U0�����ֵ�ӰM1-Mn���б�ǩ������sub_n
  known_itemid <- data$itemid[sub_n]   #��ȡU0�����ֵ�ӰM1-Mn�ĵ�ӰID
  unknown_itemid <- Itemid   #��ȡ��Ԥ���ӰM0��ID��
  known_itemid
  unknown_itemid
  
  unknown_sub <- which(data$itemid == unknown_itemid)
  user <- data$userid[unknown_sub[-1]]   #��ȡ�����۵�ӰM0���û�ID������user
  user
  
  data_all <- matrix(0, 1+length(user), 2+length(known_itemid))  #����data.all������������������ֵ��ȡ0
  data_all <- data.frame(data_all)
  names(data_all) <- c("userid", paste("unknown_itemid_", Itemid), paste("itemid_", known_itemid, sep = ""))   #��data.all�ĸ�������������
  item <- c(unknown_itemid, known_itemid)
  data_all$userid <- c(Userid, user)   #��data.all�е�userid������ֵ
  data_all
  
  for(i in 1:nrow(data_all)){   #��data_all���н������ѭ��
    data_temp <- data[which(data$userid == data_all$userid[i]), ]
    for(j in 1:length(item)){   #��data_all���н����ڲ�ѭ��
      if(sum(as.numeric(data_temp$itemid == item[j])) != 0){   #�жϸ�λ���Ƿ���ȡֵ
        data_all[i, j+1] = data_temp$rating[which(data_temp$itemid == item[j])]
      }
    }
  }
    data_all
    data_test_x <- data_all[1, c(-1, -2)]   #��ȡ���Լ�����֪����
    data_test_y <- data_all[1, 2]   #��ȡ���Լ��Ĵ�Ԥ��ֵ
    data_train_x <- data_all[-1, c(-1, -2)]   #��ȡѵ��������֪����
    data_train_y <- data_all[-1, 2]   #��ȡѵ�����Ĵ�Ԥ��ֵ
    dim(data_test_x); length(data_test_y)
    dim(data_train_x); length(data_train_y)
    fit <- knn(data_train_x, data_test_x, cl = data_train_y, k = K)   #����knn�б�
    list("data_all:" = data_all, "True Rating:" = data_test_y, "Predict Rating:" = fit, "User ID:" = Userid, "Item ID:" = Itemid)
}
user1 <- NULL
for(Item in 1:20)
  user1 = c(user1, MovieLens_KNN(Userid = 1, Itemid = Item, n = 50, K = 10)$'True Rating:')
user1