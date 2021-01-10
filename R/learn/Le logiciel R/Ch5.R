length(c(1, 3, 6, 2, 7))   #����һ�������ĳ���
sort(c(1, 6, 6, 2, 8))   #�Ե�����ݼ��ķ�ʽ��һ��������Ԫ�ؽ�������
sort(c(1, 6, 6, 2, 8), decreasing = TRUE)
rev(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #��һ��������Ԫ���Ե���ķ�ʽ��������
vec <- c(1, 3, 6, 2, 7, 4, 8, 5, 10)
names(vec) <- 1:9
vec
sort(vec)
order(vec)   #��������ʽ���ذ������������к�ĸ�Ԫ����ԭʼ�����е�λ������
rank(vec)   #���ظ�Ԫ�ص�������������ɵ���������������ĳЩԪ��ȡֵ��ͬʱ[���]��
unique(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #�޳��������ظ���Ԫ��
duplicated(c(1, 3, 6, 2, 7, 4, 8, 1, 0))   #�ж�������ÿ��Ԫ���Ƿ�����֮ǰ��Ԫ���г��ֹ�
cbind(1:4, 5:8)   #�ϲ���
rbind(1:4, 5:8)   #�ϲ���
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
sweep(X, MARGIN = 1, STATS = c(3, 5), FUN = "-")   #�ӵ�һ�м�ȥ3���ڶ��м�ȥ5
sweep(X, MARGIN = 2, STATS = c(2, 2, 3, 3), FUN = "/")
X <- data.frame(trt1 = c(1, 6, 3, 5), trt2 = c(8, 8, 3, 1))
Y <- stack(X)
Y
unstack(Y)
X <- data.frame(Weight = c(80, 75, 60, 52), Height = c(180, 170, 165, 150),
                Cholesterol = c(44, 12, 23, 34), Gender = c("Male", "Female", "Female", "Female"))
X
aggregate(X[, -4], by = list(Gender = X[, 4]), FUN = mean) #X[, -4]������ȡ����4�е�����������
X <- transform(X, Height = Height/100, BMI = Weight/(Height/100)^2)
X
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
lapply(x, mean)   #���б�������ɲ��ֵľ�ֵ
lapply(x, quantile, probs = (1:3)/4)   #�б�������ɲ��ֵ���λ�����ķ�λ��
sapply(x, quantile)   #�б�������ɲ��ֵ��ķ�λ��
i36 <- sapply(3:6, seq)   #����һ�����������ɵ��б�
i36
sapply(i36, sum)   #���б��еĸ����������
A <- c(4, 6, 2, 7)   #��һ������
B <- c(2, 1, 7, 3)   #�ڶ�������
vec <- c(2, 3, 7)   #һЩԪ��
is.element(vec, A)   #vec��Ԫ������A?
all(A %in% B)   #����A����B��
all(B %in% A)
intersect(A, B)   #����
union(A, B)   #����
setdiff(A, B)   #����
setdiff(union(A, B), intersect(A, B))   #�ԳƲ�
vec <- c(2, 4, 6, 8, 3)
vec[2]
"["(vec, 2)   #"["��һ������
vec[-2]   #��ȡ���˵�2��Ԫ���������Ԫ��
vec[2:5]
vec[-c(1, 5)]
vec[c(T, F, F, T, F)]   #ͨ���߼�ֵ����ȡ
vec[vec>4]
mask <- c(T, F, T, NA, F, F, T)
which(mask)   #�����Ӧ��ֵTRUE��λ������
x <- c(0:4, 0:5, 11)
which.min(x)   #�����Сֵ��λ������
which.max(x)   #������ֵ��λ������
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
Mat[, 1, drop = FALSE]   #����ĽṹΪһ�о���
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
noquote(string)   #��������R����������˫���ŵ���ʾ��sQuote()��dQuote()������ʾ��ͬ������
zz <- data.frame("First Name" = c("Pierre", "Benoit", "Remy"), check.names = FALSE)
zz
format(zz, justify = "left")   #format()�������Ի�����ʾ
string1 <- c("a", "ab", "B", "bba", "one", "@$", "brute")
nchar(string1)   #������ַ����е��ַ�����
letters   #letters��LETTERS���Էֱ𷵻�26��Сд�ʹ�д��ĸ
string2 <- c("e","d")
paste(string1, string2)   #���������ַ�
paste(string1, string2, sep = "-")
paste(string1, string2, collapse = " ", sep = "-" )
substring("abcdefghi", first = 1:3, last = 4:6)   #��һ���ַ�������ȡ���ַ���
strsplit(c("05 Jan", "06 Feb"), split = " ")   #����һ���ַ���
grep("i", c("Pierre", "Benoit", "Rems"))    #���ַ������������������ض�Ӧλ��
gsub("i", "L", c("Pierre", "Benoit", "Rems"))  #���ַ�������������Ԫ���о���ĳһģʽ�Ĳ��ֽ����滻
sub("r", "L", c("Pierre", "Benoit", "Rems"))   #���滻��һ�������ض�ģʽ���ַ������ǲ���
Sys.time(); date()   #������ʾ��ǰʱ��
as.numeric(substring(Sys.time(), c(1, 6, 9, 12, 15, 18), c(4, 7, 10, 13, 16, 19)))   #��ȡ�ꡢ�¡��ա�Сʱ�����Ӻ�����
##5.7
x <- rcauchy(10)   #����10��������Cauchy�ֲ��������
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
    print("������ʵ����")
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