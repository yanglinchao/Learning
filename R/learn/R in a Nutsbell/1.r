##ch3
teams <- c("PHI", "NYM", "FLA", "ATL", "WSM")
w <- c(92, 89, 94, 72, 59)
l <- c(70, 73, 77, 90, 102)
nleast <- data.frame(teams, w, l)
nleast
nleast$teams == "FLA"
nleast$w[nleast$teams == "FLA"]
data("cars")
head(cars)
cars.lm <- lm(dist ~ speed, data = cars)
summary(cars.lm)
library(nutshell)
data("field.goals")
head(field.goals)
str(field.goals)
summary(field.goals)
hist(field.goals$yards, breaks = 35)
table(field.goals$play.type)
stripchart(field.goals[field.goals$play.type == "FG blocked", ]$yards, pch = 19, method = "jitter")
data("cars")
str(cars)
plot(cars, xlab = "Speed(mph)", ylab = "Stopping distance(ft)", las = 1, xlim = c(0, 25))
plot(speed ~ dist, data = cars, las = 1)
abline(lm(speed ~ dist, data = cars), col = "red")
library(lattice)
data("consumption")
head(consumption)
str(consumption)
dotplot(Amount ~ Year | Food, consumption)
dotplot(Amount ~ Year | Food, data = consumption, aspect = "xy", scales = list(relation = "sliced", cex = .4))
##ch4
getOption("defaultPackages")   #得到默认加载的R包的清单
(.packages())   #查看当前已加载的所有R包
(.packages(all.available = TRUE))   #查看所有已安装的R包的清单（同library()）
