library(ggplot2)
hgram <- qplot(uempmed, data = economics, binwidth = 1)
hgram
previous_theme <- theme_set(theme_bw())
hgram
hgram + previous_theme
theme_set(previous_theme)

hgramt11 <- hgram + labs(title = "This is a histogram")
hgramt12 <- hgramt11 + theme(plot.title = element_text(size = 20))
hgramt13 <- hgramt11 + theme(plot.title = element_text(size = 20, colour = "red"))
hgramt14 <- hgramt11 + theme(plot.title = element_text(size = 20, hjust = 0))
hgramt15 <- hgramt11 + theme(plot.title = element_text(size = 20, face = "bold"))
hgramt16 <- hgramt11 + theme(plot.title = element_text(size = 20, angle = 180))
library(grid)   #建立网格将图一起输出
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3)))
print(hgramt11, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(hgramt12, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(hgramt13, vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(hgramt14, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(hgramt15, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(hgramt16, vp = viewport(layout.pos.row = 2, layout.pos.col = 3))

library(ggplot2)
hgram <- qplot(uempmed, data = economics, binwidth = 1)
hgram21 <- hgram + theme(panel.grid.major = element_line(colour = "red"))
hgram22 <- hgram + theme(panel.grid.major = element_line(size = 2))
hgram23 <- hgram + theme(panel.grid.major = element_line(linetype = "dotted"))
hgram24 <- hgram + theme(axis.line = element_line())
hgram25 <- hgram + theme(axis.line = element_line(colour = "red"))
hgram26 <- hgram + theme(axis.line = element_line(size = 0.5, linetype = "dashed"))
library(grid)   #建立网格将图一起输出
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3)))
print(hgram21, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(hgram22, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(hgram23, vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(hgram24, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(hgram25, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(hgram26, vp = viewport(layout.pos.row = 2, layout.pos.col = 3))

library(ggplot2)
hgram <- qplot(uempmed, data = economics, binwidth = 1)
hgram31 <- hgram + theme(plot.background = element_rect(fill = "grey80", colour = NA))
hgram32 <- hgram + theme(plot.background = element_rect(size = 20))
hgram33 <- hgram + theme(plot.background = element_rect(colour = "red"))
hgram34 <- hgram + theme(plot.background = element_rect())
hgram35 <- hgram + theme(plot.background = element_rect(colour = NA))
hgram36 <- hgram + theme(plot.background = element_rect(linetype = "dotted"))
library(grid)   #建立网格将图一起输出
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3)))
print(hgram31, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(hgram32, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(hgram33, vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(hgram34, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(hgram35, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(hgram36, vp = viewport(layout.pos.row = 2, layout.pos.col = 3))

library(ggplot2)
hgramt <- qplot(uempmed, data = economics, binwidth = 1) + labs(title = "This is a histogram")
hgramt21 <- hgramt + theme(panel.grid.minor = element_blank())
hgramt22 <- hgramt + theme(panel.grid.major = element_blank())
hgramt23 <- hgramt + theme(panel.background = element_blank())
hgramt24 <- hgramt + theme(axis.title.x = element_blank(), axis.title.y = element_blank())
hgramt25 <- hgramt + theme(axis.line = element_blank())
library(grid)   #建立网格将图一起输出
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 3)))
print(hgramt, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(hgramt21, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(hgramt22, vp = viewport(layout.pos.row = 1, layout.pos.col = 3))
print(hgramt23, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(hgramt24, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(hgramt25, vp = viewport(layout.pos.row = 2, layout.pos.col = 3))

old_theme <- theme_update(
  plot.background = element_rect(fill = "#3366FF"),
  panel.background = element_rect(fill = "#003DF5"),
  axis.text.x = element_text(colour = "#CCFF33"),
  axis.text.y = element_text(colour = "#CCFF33", hjust = 1),
  axis.title.x = element_text(colour = "#CCFF33", face = "bold"),
  axis.title.y = element_text(colour = "#CCFF33", face = "bold", angle = 90)
)
p1 <- qplot(cut, data = diamonds, geom = "bar")
p2 <- qplot(cty, hwy, data = mpg)
theme_set(old_theme)
library(grid)   #建立网格将图一起输出
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 2)))
print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))

library(ggplot2)
update_geom_defaults("point", aes(colour = "darkblue"))
qplot(mpg, wt, data = mtcars)
update_stat_defaults("bin", aes(y = ..density..))
qplot(wt, data = mtcars, geom = "histogram", binwidth = 1)

(a <- qplot(date, unemploy, data = economics, geom = "line"))
(b <- qplot(uempmed, unemploy, data = economics) + geom_smooth(se = F))
(c <- qplot(uempmed, unemploy, data = economics, geom = "path"))
library(grid)
#新建一个图形设备窗口,占据整个图形设备窗口
vp1 <- viewport(width = 1, height = 1, x = 0.5, y = 0.5)
vp1 <- viewport()
##只占了图形设备一半的宽和高的视图窗口,定位在图形的中间位置
vp2 <- viewport(width = 0.5, height = 0.5, x = 0.5, y = 0.5)
vp2 <- viewport(width = 0.5, height = 0.5)
##一个2cm*3cm的视图窗口，定位在图形设备中心
vp3 <- viewport(width = unit(2, "cm"), height = unit(3, "cm"))
##在右上角的视图窗口
vp4 <- viewport(x = 1, y = 1, just = c("right", "top"))
##处在左下角
vp5 <- viewport(x = 0, y = 0, just = c("left", "bottom"))
pdf("polishing-subplot-1.pdf", width = 4, height = 4)
subvp <- viewport(width = 0.4, height = 0.4, x = 0.75, y = 0.35)
b
print(c, vp = subvp)
dev.off()
