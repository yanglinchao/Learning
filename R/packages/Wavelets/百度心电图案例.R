#https://wenku.baidu.com/view/cd757ded6294dd88d0d26ba8.html

#extracting DWT coefficients(with Haar filter)

library(wavelets)

feature <- NULL
mydata <- read.table("https://archive.ics.uci.edu/ml/databases/synthetic_control/synthetic_control.data", header = FALSE, sep = "")
for(i in 1:nrow(mydata)){
  a <- t(mydata[i, ])
  wt <- dwt(a, filter = "haar", boundary = "periodic")
  feature <- rbind(feature, unlist(c(wt@W, wt@V[[wt@level]])))
}
feature <- as.data.frame(feature)

#set class labels into categorical values

classld <- c(rep("1", 100), rep("2", 100), rep("3", 100), rep("4", 100), rep("5", 100), rep("6", 100))
wtSc <- data.frame(cbind(classld, feature))

#build a decision tree with ctree() in package party

library(party)
ct <- ctree(classld ~ ., data = wtSc, controls = ctree_control(minsplit = 30, minbucket = 10, maxdepth = 5))
pClassld <- predict(ct)

#check predicted classes against original class labels

table(classld, pClassld)

#accuracy
(sum(classld == pClassld))/nrow(wtSc)

plot(ct, ip_args = list(pval = FALSE), ep_args = list(digits = 0))


#make predictions

f <- NULL
ap <- t(mydata[1, ])
wtp <- dwt(ap, filter = "haar", boundary = "periodic")
f <- rbind(f, unlist(c(wtp@W, wtp@V[[wt@level]])))
f <- as.data.frame(f)
predict(ct, f)
