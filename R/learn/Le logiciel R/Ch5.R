length(c(1, 3, 6, 2, 7))   #返回一个向量的长度
sort(c(1, 6, 6, 2, 8))   #以递增或递减的方式第一个向量的元素进行排序
sort(c(1, 6, 6, 2, 8), decreasing = TRUE)
rev(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #将一个向量的元素以倒序的方式重新排列
vec <- c(1, 3, 6, 2, 7, 4, 8, 5, 10)
names(vec) <- 1:9
vec
sort(vec)
order(vec)   #以向量形式返回按增序或减序排列后的各元素在原始向量中的位置索引
rank(vec)   #返回各元素的排名序号所构成的向量（若果遇到某些元素取值相同时[打结]）
unique(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #剔除向量中重复的元素
duplicated(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #判断想两种每个元素是否在它之前的元素中出现过
cbind(1:4, 5:8)   #合并列
rbind(1:4, 5:8)   #合并行
X <- data.frame(GENDER = c("F", "M", "M", "F"), Height = c(165, 182, 178, 160),
                 Weight = c(50, 65, 67, 55), Income = c(80, 90, 60, 50))
Y <- data.frame(GENDER = c("F", "M", "M", "F"), Height = c(165, 182, 178, 160),
                 Weight = c(55, 65, 67, 85), Salary = c(70, 90, 40, 40))
X
Y
merge(X, Y, by = c("GENDER", "Weight"))
merge(X, Y, by = c("GENDER", "Weight"), all = TRUE)
library(gtools)
df1 <- data.frame(A = 1:5, B = LETTERS[1:5])
df2 <- data.frame(A = 1:5, B = letters[1:5])
df1
df2
smartbind(df1, df2)
X <- matrix(c(1:4, 1, 6:8), nr = 2)
X
apply(X, MARGIN = 1, FUN = mean)
apply(X, MARGIN = 2, FUN = sum)
sweep(X, MARGIN = 1, STATS = c(3, 5), FUN = "-")   #从第一行减去3，第二行减去5
sweep(X, MARGIN = 2, STATS = c(2, 2, 3, 3), FUN = "/")
X <- data.frame(trt1 = c(1, 6, 3, 5), trt2 = c(8, 8, 3, 1))
Y <- stack(X)
Y
unstack(Y)
X <- data.frame(Weight = c(80, 75, 60, 52), Height = c(180, 170, 165, 150),
                Cholesterol = c(44, 12, 23, 34), Gender = c("Male", "Female", "Female", "Female"))
X
aggregate(X[, -4], by = list(Gender = X[, 4]), FUN = mean) #X[, -4]用来抽取除第4列的其他所有列
X <- transform(X, Height = Height/100, BMI = Weight/(Height/100)^2)
X
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
lapply(x, mean)   #此列表各个组成部分的均值
lapply(x, quantile, probs = (1:3)/4)   #列表各个组成部分的中位数和四分位数
sapply(x, quantile)   #列表各个组成部分的四分位数
i36 <- sapply(3:6, seq)   #创建一个由向量构成的列表
i36
sapply(i36, sum)   #对列表中的各个向量求和
A <- c(4, 6, 2, 7)   #第一个集合
B <- c(2, 1, 7, 3)   #第二个集合
vec <- c(2, 3, 7)   #一些元素
is.element(vec, A)   #vec中元素属于A?
all(A %in% B)   #集合A属于B？
all(B %in% A)
intersect(A, B)   #交集
union(A, B)   #并集
setdiff(A, B)   #补集
setdiff(union(A, B), intersect(A, B))   #对称差
vec <- c(2, 4, 6, 8, 3)
vec[2]
"["(vec, 2)   #"["是一个函数
vec[-2]   #提取除了第2个元素外的所有元素
vec[2:5]
vec[-c(1, 5)]
vec[c(T, F, F, T, F)]   #通过逻辑值来提取
vec[vec>4]
mask <- c(T, F, T, NA, F, F, T)
which(mask)   #输出对应于值TRUE的位置索引
x <- c(0:4, 0:5, 11)
which.min(x)   #输出最小值的位置索引
which.max(x)   #输出最大值的位置索引
z <- c(0, 0, 0, 2, 0)
z[c(1, 5)] <- 1
z
z[which.max(z)] <- 0
z
z[z==0] <- 8
z
(vecA <- c(1, 3, 6, 2, 7, 4, 8, 1, 0))
(vecB <- c(vecA, 4, 1))          
(vecC <- c(vecA[1:4], 8, 5, vecA[5:9]))
Mat <- matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
Mat
Mat[2, 3]
Mat[1, ]
Mat[, 1]
Mat[, 1, drop = FALSE]   #输出的结构为一列矩阵
Mat[c(1, 4), ]
Mat[3, -c(1, 3)]
MatLogical <- matrix(c(TRUE, FALSE), nrow = 4, ncol = 3)
MatLogical
Mat[MatLogical]
L <- list(12, c(34, 67, 8), Mat, 1:15, list(10, 11))
L[[2]]
"[["(L, 2)
L[[5]][[2]]
L <- list(cars = c("Ford", "Pegeot"), climate = c("Trop", "Temp"))
L$cars
string <- c("one", "two", "three")
string
noquote(string)   #可以抑制R的输出结果中双引号的显示，sQuote()和dQuote()用来显示不同的引号
zz <- data.frame("First Name" = c("Pierre", "Benoit", "Remy"), check.names = FALSE)
zz
format(zz, justify = "left")   #format()产生个性化的显示
string1 <- c("a", "ab", "B", "bba", "one", "@$", "brute")
nchar(string1)   #计算各字符串中的字符个数
letters   #letters和LETTERS可以分别返回26个小写和大写字母
string2 <- c("e","d")
paste(string1, string2)   #连接两个字符
paste(string1, string2, sep = "-")
paste(string1, string2, collapse = " ", sep = "-" )
substring("abcdefghi", first = 1:3, last = 4:6)   #从一个字符串中提取子字符串
strsplit(c("05 Jan", "06 Feb"), split = " ")   #分裂一个字符串
grep("i", c("Pierre", "Benoit", "Rems"))    #在字符串向量中搜索，返回对应位置
gsub("i", "L", c("Pierre", "Benoit", "Rems"))  #将字符串向量中所有元素中具有某一模式的部分进行替换
sub("r", "L", c("Pierre", "Benoit", "Rems"))   #仅替换第一个具有特定模式的字符串的那部分
Sys.time(); date()   #都能显示当前时间
as.numeric(substring(Sys.time(), c(1, 6, 9, 12, 15, 18), c(4, 7, 10, 13, 16, 19)))   #提取年、月、日、小时、分钟和秒数
##5.7
x <- rcauchy(10)   #生成10个来自于Cauchy分布的随机数
my.input <- "mean"
switch(my.input, mean = mean(x), median = median(x))
if(TRUE) 1+1
x <- 2
y <- -3
if(x <= y){
  print("x smaaler than y")
}else{
  print("x larger than y")
}
for(i in 1:3) print(i)
x <- c(1, 3, 7, 2)
for(var in x) print(2*var)
x <- 2
y <- 1
while(x+y < 7) x <- x+y
x
for(i in 1:4){
  if(i == 3) break
  for(j in 6:8){
    if(j == 7) next
    j <- i+j
  }
}
i
j
i <- 0
repeat{
  i <- i+1
  if(i == 4) break
}
i
##5.8
biroot <- function(a, b, c){
  delta <- b^2 - 4*a*c
  if(delta < 0){
    print("方程无实数根")
  }else{
    if(delta == 0){
      x <- (-b + sqrt(delta))/(2*a)
      answer <- list(Delta = delta, x = x)
      return(answer)
    }else{
      if(delta > 0){
        x1 <- (-b - sqrt(delta))/(2*a)
        x2 <- (-b + sqrt(delta))/(2*a)
        answer <- list(Delta = delta, x1 = x1, x2 = x2)
        return(answer)
      }
    }
  }
}
BMI <- function(weight, height){
  bmi <- weight/height^2
  res <- list(Weight = weight, Height = height, BMI = bmi)
  return(res)
}
weight.category <- function(bmi){
  interval.BMI <- c(15, 16.5, 18.5, 25, 30, 35, 40, 41)
  code <- as.character(rank(c(bmi, interval.BMI), ties.method = "max")[1])
  category <- switch(code,
                     "2" = "severely underweight",
                     "3" = "underweight",
                     "4" = "normal weight",
                     "5" = "overweight",
                     "6" = "moderate obesity",
                     "7" = "severe obesity",
                     "8" = "morbid obesity")
  cat(paste("Your BMI is: ", round(bmi, 3), ".\n
            This corresponds to weight category : " , category, ".\n", sep = ""))
}
weight.category(BMI(70, 1.82)$BMI)
##worksheet A Intima_Media_Thickness
imt <- read.csv("Intima_Media_Thickness.csv")
imt$bmi <- imt$weight/(imt$height/100)^2
head(imt)
imt_bmi30 <- imt[imt$bmi > 30, ]
imt_bmi30
imt_athleticwomen <- imt[imt$GENDER == "2" & imt$SPORT == "1", ]
imt_athleticwomen
imt_age50bmi30 <- imt[imt$AGE == 50 | imt$bmi >30, ]
imt_age50bmi30
##worksheet A bmichild
bmichild <- read.csv("bmichild.csv")
bmichild$bmi <- bmichild$weight/(bmichild$height/100)^2
bmi_2 <- bmichild[bmichild$bmi < 15 & bmichild$year <= 3.5, ]
bmi_2
str(bmi_2)
##worksheet A Bith_weight
bw <- read.csv("Birth_weight.csv")
bw$PTL1[bw$PTL == 0] <- 0
bw$PTL1[bw$PTL == 1] <- 1
bw$PTL1[bw$PTL > 1] <- 2
bw$FVT1[bw$FVT == 0] <- 0
bw$FVT1[bw$FVT == 1] <- 1
bw$FVT1[bw$FVT > 1] <- 2
bwbyBWT <- bw[order(bw$BWT), ]
bwbyBWT
##worksheet B 
infarction <- read.csv("Infarction.csv")
infarction[infarction == "."] <- NA
na1 <- which(apply(is.na(infarction), MARGIN = 1, FUN = any) == TRUE)
sum1 <- function(x){sum(x) > 1}
na2 <- which(apply(is.na(infarction), MARGIN = 1, FUN = sum1) == TRUE)
na2
na3 <- which(apply(is.na(infarction), MARGIN = 2, FUN = any) == TRUE)
infarction_new <- na.omit(infarction)
##worksheet C
dept <- read.csv("http://www.biostatisticien.eu/springeR/dept-pop.csv")
numdep <- substring(dept$Departement,1, 2)
numdep
place <- substring(dept$Departement, 4)
place
dept <- cbind(numdep, place, dept[, -1])
head(dept)
##worksheet D
flu <- read.csv("http://www.biostatisticien.eu/springeR/flu.csv")
head(flu)
names(flu)
##worksheet E
a <- matrix(1:6, 3, 2)
rownames(a) <- c(1, 2, 6)
b <- matrix(1:8, 4, 2)
rownames(b) <- c(3, 4, 5, 7)
ab <- rbind(a, b)
ab <- ab[order(rownames(ab)), ]
ab
list1 <- list()
list1[[1]] <- matrix(runif(25), nr = 5)
list1[[2]] <- matrix(runif(30), nr = 5)
list1[[3]] <- matrix(runif(15), nr = 5)
list1
matrix1 <- matrix(unlist(list1), nrow = 5)
matrix1
list2 <- list()
list2[[1]] <- matrix(runif(25),nc=5)
list2[[2]] <- matrix(runif(35),nc=5)
list2[[3]] <- matrix(runif(15),nc=5)
matrix2 <- t(matrix(unlist(list2), nrow = 5))
matrix2
