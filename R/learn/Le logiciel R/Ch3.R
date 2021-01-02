##3.2.1.2
z <- 1 + 2i
typeof(z)   #类型
Re(z)   #实部
Im(z)   #虚部
Mod(z)   #模
Arg(z)   #幅角
##3.2.2.1
vec <- c(1, 3, 6, 2, 7, 4, 8, 1, 0)
names(vec) <- letters[1:9]   #前九个拉丁字母
vec
is.vector(vec)
X <- matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
X
Y <- matrix(1:12, nrow = 4, ncol = 3, byrow = FALSE)   #默认是是byrow = FALSE
Y
class(Y)
X <- array(1:12, dim = c(2, 3, 2))
X
BMI <- data.frame(Gender = c("M", "F", "M", "F", "M", "F"),
                  Height = c(1.83, 1.76, 1.82, 1.60, 1.90, 1.66),
                  Weight = c(67, 58, 66, 48, 75, 55),
                  row.names = c("Jack", "Julia", "Henry", "Emma", " William", "Elsa"))
BMI
is.data.frame(BMI)
str(BMI)   #显示一个数据框中每一列的结构
A <- list(TRUE, -1:3, matrix(1:4, nrow = 2), c(1+2i, 3), "一个字符串")
A
class(A)
x <- factor(c("blue", "green", "blue", "red", "blue", "green", "green"))
x
levels(x)
class(x)
poids <- c(55, 63, 83, 57, 75, 90, 73, 67, 58, 84, 87, 79, 48, 52)
Poids <- cut(poids, 3)   #cut()可以对一个连续变量重新编码并使之成为一个因子
class(Poids)
z <- ordered(c("Small", "Tall", "Average", "Tall", "Average", "Small", "Tall"),
             levels = c("Small", "Average", "Tall"))
class(z)
ts(1:10, frequency = 4, start = c(1959, 2))   #从1959年的第二个季度开始
##worksheet
bmichild <- read.csv("bmichild.csv")
head(bmichild)
summary(bmichild)
bmichild$BMI <- bmichild$weight/((bmichild$height/100)^2)
head(bmichild)
plot(weight ~ height, data = bmichild, xlab = "Height (cm)", ylab = "Weight (kg)", head = "the Plot of Weight and Height")
library(car)
scatterplot(weight ~ height | zep, data = bmichild, lwd = 2, boxplot = "xy")