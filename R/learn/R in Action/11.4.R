ftable(Titanic)
library(vcd)
mosaic(Titanic, shade = TRUE, legeng = TRUE)
mosaic(~ Class + Sex + Age + Survived, data = Titanic, shade = TRUE, legeng = TRUE)
###两行代码都将生成图1，但是表达式版本的代码可是对图形中变量的选择和摆放拥有更多的控制权