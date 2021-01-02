nutrielderly <- read.csv("nutrition_elderly.csv")
attach(nutrielderly)
##构造定性变量
situation <- as.factor(situation)
levels(situation) <- c("single", "couple", "family", "other")
gender <- as.factor(gender)
class(gender)
fat <- as.factor(fat)
levels(fat)  <- c("butter", "margarine", "peanut", "sunflower",
                  "olive", "Isio4", "rapeseed", "duck")
smoker <- c(1, 0, 0, 1, 0, 1, 0, 1, 0, 0)
smoker <- as.logical(smoker)
smoker
##如果处理的是一个已经组织成因子类型的变量，可以运用下面方法将它变成逻辑值
smoker   #smoker为因子类型的变量
smoker <- c(smoke = as.logical(2-as.integer(smoker)))   #转为逻辑值
smoker
##构造有序变量
meat <- as.ordered(meat)
fish <- as.ordered(fish)
raw_fruit <- as.ordered(raw_fruit)
cooked_fruit_veg <- as.ordered(cooked_fruit_veg)
mylevels <- c("never", "<1/week", "1/week", "2-3/week", "4-6/week", "1/day")
levels(chocol) <- levels(cooked_fruit_veg) <- levels(raw_fruit) <- mylevels
levels(fish) <- levels(meat) <- mylevels
##构造离散的定性数据
tea <- as.integer(tea)
coffee <- as.integer(coffee)
##构造连续的定性变量
height <- as.double(height)
weight <- as.double(weight)
age <- as.double(age)
write.csv(nutrielderly, file = "nutrition_elderly_new.csv")
require(vcd)
attach(Arthritis)
res <- hist(Age, plot = FALSE)
nn <- as.character(res$breaks)
x <- as.table(res$counts)
dimnames(x) <- list(paste(nn[-length(nn)], nn[-1], sep = "-"))
x
table(cut(Age, res$breaks, include.lowest = TRUE))
tabage <- table(Age)
names(which.max(tabage))   #得到唯一的众数
names(tabage)[max(tabage) == tabage]   #得到全部众数
detach(Arthritis)
mean(Age)
quantile(Age, probs = c(0.1, 0.9))
quantile(Age, probs = c(0.25, 0.5, 0.75))
quantile(Age, probs = 1:10/10)
median(Age)
my.median <- function(x){
  if(is.numeric(x)) return(median(x))
  if(is.ordered(x)) {
    N <- length(x)
    if(N%%2) return(sort(x)[(N+1)/2])else{
      inf <- sort(x)[N/2]
      sup <- sort(x)[N/2+1]
      if(inf==sup) return(inf) else return(c(inf, sup))
    }
  }
  stop("无法计算该类数据的中位数")
}
my.median(Improved)
median.for.freq <- function(x){
  #x为频率表
  if(all(is.numeric(names(x)))){
    tab.freq.cum <- cumsum(x)
    index <- order(tab.freq.cum <- 0.5)[1]
    fc1 <- tab.freq.cum[index]
    fc2 <- tab.freq.cum[index-1]
    x1 <- as.numeric(names(fc1))
    x3 <- as.numeric(names(fc2))
    mex <- as.numeric(x1 + (x2-x1)*(0.5-fc1)/(fc2-fc1))
  }else{mex <- NA}
  return(mex)
}
require(vcd)
attach(Arthritis)
res <- hist(Age, plot = FALSE, breaks = c(20, 30, 40, 50, 60, 70, 80))
tab.x <- table(rep(res$breaks[-1], res$counts))
tab.x
median.for.freq(tab.x/sum(tab.x))
mydata <- read.csv("nutrition_elderly.csv")
attach(mydata)
genderfat <- table(gender, fat)
chi2 <- chisq.test(genderfat)$statistic
chi2
chi2 <- summary(table(gender, fat))$statistic
chi2
N <- sum(genderfat)
p <- nrow(genderfat)
q <- ncol(genderfat)
Phi2 <- chi2/N
Phi2/(min(p, q)-1)
sqrt(chi2/(N+chi2))
Phi2
cor(as.numeric(meat), as.numeric(fish), method = "kendall")
cor(rank(fat), rank(situation))
cor(as.numeric(fat), as.numeric(situation), method = "spearman")
cor(height, weight)   #相关系数
cov(height, weight)   #协方差
eta2 <- function(x, gpe){
  means <- tapply(x, gpe, mean)
  counts <- tapply(x, gpe, length)
  varwithin <- (sum(counts * (means - mean(x))^2))
  vartot <- (var(x) * (length(x) - 1))
  res <- varwithin/vartot
return(res)
}
eta2(weight, gender)
detach(mydata)
mydata <- read.csv("nutrition_elderly.csv")
attach(mydata)
col <- c("yellow", "yellow2", "sandybrown", "orange", "darkolivegreen", "green", "olivedrab2", "green4")
barplot(sort(table(fat), T), col = col)
detach(mydata)
require(RColorBrewer)
col <- brewer.pal(8, "Pastel2")
pie(table(mydata$fat), col = col)
col <- c("yellow", "yellow2", "sandybrown", "orange", "darkolivegreen")
tx <- table(mydata$fish)
tx <- tx/sum(tx)
r <- barplot(tx, ylim = c(0, 1), col = col)
points(r, cumsum(tx), type = "l")
plot(ecdf(na.omit(mydata$coffee)), 
     main = paste("Empirical distribution function", "for varialbe coffee", sep = "\n"),
     verticals = TRUE, ylab = expression(F(n)(x)), col.01line = "#89413A", col.points = "#6D1EFF",
     col.hor = '#3971FF', col.vert = '#3971FF')
plot(ecdf(na.omit(mydata$age)),
     main = paste("empirical distribution function", "of variable age", sep = "\n"),
     col.hor = '#3971FF', col.points = '#3971FF')
##worksheet A
snee <- read.table("http://biostatisticien.eu/springeR/snee74en.txt", header = T)
head(snee)
tail(snee)
attributes(snee)
str(snee)
attach(snee)
levels(hair)
table(hair)
table(hair, eyes)
table(snee)
barplot(sort(table(hair)))
barplot(sort(table(eyes)))
barplot(sort(table(gender)))
eyeshair <- table(eyes, hair)
eyeshair
table(hair)/sum(table(hair))
fhair <- margin.table(eyeshair, 2)/592
fhair
nblue <- margin.table(eyeshair, 1)[1]
nblue
nblue*margin.table(eyeshair, 2)/592
round(fhair*nblue)
marginX <- margin.table(eyeshair, 1)
marginX
tab.ind1 <- marginX %*% t(fhair)
round((tab.ind1))
table(eyes, hair)
feyes <- margin.table(eyeshair, 1)/592
feyes
nblond <- margin.table(eyeshair, 2)[2]
nblond
marginY <- margin.table(eyeshair, 2)
marginY
tab.ind2 <- marginY %*% t(feyes)
tab.ind2
round(tab.ind2)
all.equal(tab.ind1, tab.ind2)
(tab.ind1 - eyeshair)^2
tab.ind1
eyeshair
chisq.test(eyeshair)
tab.contr <- (eyeshair-tab.ind1)^2/tab.ind1
tab.contr
genhair <- table(gender, hair)
genhair
barplot(genhair, beside = TRUE, main = "hair by gender", legend.text = c("female", "male"))
chisq.test(hair, gender)
##worksheet B
ne <- read.csv("nutrition_elderly.csv")
attach(ne)
names(which.max(table(situation)))
table(height)
res <- hist(height,breaks=seq(140,190,by=5),right=TRUE, plot=FALSE)
res
ind <- which.max(res$count)
modal.class <- paste(res$breaks[ind],res$breaks[ind+1], sep="-")
modal.class
summary(chocol)
str(chocol)
median(chocol)
table(chocol)
table(raw_fruit)
median.for.freq(table(chocol))
med <- function(tabx) names(which.max(cumsum(tabx)/sum(tabx)>0.5))
med(table(chocol))
cumsum(table(chocol))
which.max(cumsum(table(chocol))/sum(table(chocol)) > 0.5)
hist(height, freq = FALSE)
hist(height, ecdf(height)(breaks), breaks = seq(140, 190, by = 5), freq = FALSE)
require(Hmisc)
Ecdf(height)
mean(height)
mean(weight)
mean(age)
hist(age)
summary(age)
table(tea)
sum(c(0:6, 9, 10)*as.numeric(table(tea)))/sum(table(tea))
boxplot(weight)

