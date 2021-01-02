# install.packages("devtools")
# 安装patchwork包
devtools::install_github("thomasp85/patchwork")


library(ggplot2)
library(patchwork)
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_point(aes(gear, disp))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Combine these two plots together
p1+p2
p1+p2+plot_layout(ncol = 1, height = c(3, 1))
p1+plot_spacer()+p2
p4+{p1+{p2+p3+plot_layout(ncol=1)}}+plot_layout(ncol=1)


# more function
# "/"可以将不同plots置于同一个nesting水平
# first we use "+" to add plots and layout
(p1+p2)+p3+plot_layout(ncol=1)
# then we use "/"
(p1+p2)/p3+plot_layout(ncol=1)

# "*"只改变处于当前nesting水平的所有plots
# "^"修改所有的plots
(p1+(p2+p3)+p4+plot_layout(ncol=1))*theme_bw()
(p1+(p2+p3)+p4+plot_layout(ncol=1))^theme_bw()
