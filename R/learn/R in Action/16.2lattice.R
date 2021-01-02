##生成栅栏图
library(lattice)
histogram(~ height | voice.part, data = singer,
          main = "Distribution of Height by Voice Pitch",
          xlab = "Height (inches)")
library(lattice)
attach(mtcars)
gear <- factor(gear, levels = c(3, 4, 5), labels = c("3 gears", "4 gears", "5 gears"))
cyl <- factor(cyl, levels = c(4, 6, 8), labels = c("4 cylinders", "6 cylinders", "8 cylinders"))
densityplot(~ mpg, main = "Density Plot", xlab = "Miles per Gallon")   #图2
bwplot(cyl ~ mpg | gear, main = "Box Plots by Cylinders and Gears", xlab = "Miles per Gallon", ylab = "Cylinders")   #图3
xyplot(mpg ~ wt | cyl * gear, main = "Scatter Plots by Cylinders and Gears", xlab = "Car Weight", ylab = "Miles per Gallon")   #图4
cloud(mpg ~ wt * qsec | cyl, main = "3D Scatter Plots by Cylinders")   #图5
dotplot(cyl ~ mpg | gear, main = "Dot Plots by Number of Gears and Cylinders", xlab = "Miles Per Gallon")   #图6
splom(mtcars[c(1, 3, 4, 5, 6)], main = "Scatter Plot Matrix for mtcars Data")   #图7
##储存与修改
library(lattice)
mygraph <- densityplot(~ height | voice.part, data = singer)
update(mygraph, col = "red", pch = 16, cex = .8, jitter = .05, lwd = 2)
##以连续型变量为条件变量，利用equal.count()函数将连续型变量转化为瓦块数据结构的函数
displacement <- equal.count(mtcars$disp, number = 3, overlap = 0)   #将数据分割到3个区间中，重叠度为0，每个数值范围内的观测数相等
xyplot(mpg ~ wt | displacement, data = mtcars, main = "Miles per Gallon vs. Weight by Engine Displacement", xlab = "Weight", ylab = "Miles per Gallon", layout = c(3,1), aspect = 1.5)
##自定义面板函数(图9)
library(lattice)
displacement <- equal.count(mtcars$disp, number = 3, overlap = 0)
mypanel <- function(x, y){
  panel.xyplot(x, y, pch = 19)
  panel.rug(x, y)
  panel.grid(h = -1, v = -1)
  panel.lmline(x, y, col = "red", lwd = 1, lty = 2)
}
xyplot(mpg ~ wt | displacement, data = mtcars, layout = c(3, 1), aspect = 1.5, main = "Miles per Gallon vs. Weight by Engine Displacement", xlab = "Weight", ylab = "Miles per Gallon", panel = mypanel)
##分组变量:将结果叠加显示在一张图中（图10）
library(lattice)
mtcars$transmission <- factor(mtcars$am, levels = c(0,1), labels = c("Automatic", "Manual"))
colors = c("red", "blue")   #设定颜色
lines = c(1, 2)   #设定线的类型
points = c(16, 17)   #设定点的类型
key.trans <- list(title = "Trasmission", space = "bottom", columns = 2, text = list(levels(mtcars$transmission)), points = list(pch = points, col = colors), lines = list(col = colors, lty = lines), cex.title = 1, cex = .9)   #自定义图例
densityplot(~ mpg, data = mtcars, group = transmission, main = "MPG Distribution by Transmission Type", xlab = "Miles per Gallon", pch = points, lty = lines, col = colors, lwd = 2, jitter = .05, key = key.trans)
##包含分组变量和条件变量以及自定义图例的xyplot（图11）
library(lattice)
colors <- "darkgreen"
symbols <- c(1:12)
linetype <- c(1:3)
key.species <- list(title = "Plant", space = "right", text = list(levels(CO2$Plant)), points = list(pch = symbols, col = colors))
xyplot(uptake ~ conc | Type*Treatment, data = CO2,
       group = Plant,
       type = "o",
       pch = symbols, col = colors, lty = linetype,
       main = "Carbon Dioxide Uptake\nin Grass Plants",
       ylab = expression(paste("Uptake ", bgroup("(", italic(frac("umol", "m"^2)),")"))),
       xlab = expression(paste("Concentration ", bgroup("(", italic(frac(mL, L)), ")"))),
       sub = "Grass Species: Echinochloa crus-galli",
       key = key.species)
       