par(mfrow = c(3, 2))   #将窗口平均分割为3行2列
plot(1:4, c(2, 3, 4, 1), type = "b", main = "Main title",
     sub = "Subtitle", xlab = "Labe 11 for x", ylab = "Label for y")
points(1:4, c(4, 2, 1, 3), type = "l")
plot(0, 0, "n")
segments(x0 = 0, y0 = 0, x1 = 1, y1 = 1)
lines(x = c(1, 0), y = c(0, 1))
plot(0, 0, "n"); abline(h = 0, v = 0); abline(a = 1, b = 1)
curve(x^3-3*x, from = -2, to = 2)
plot(runif(7), type = "h", axes = FALSE)
box(lty = "1373")
x <- runif(12); y <- runif(12)
i <- order(x, y); x <- x[i]; y <- y[i]
plot(x, y); s <- seq(length(x)-1)
arrows(x[s], y[s], x[s+1], y[s+1], length = 0.1)
colors()
colors()[grep("orange", colors())]   #获得不同色调的橙色的名称
x <- matrix(1:12, nrow = 3)
colours <- c("orange", "orangered", "red", "lightblue", "blue", "white",
             "lightgrey","grey", "darkgrey", "yellow", "green", "purple")
image(x, col = colours)
text(rep(c(0, 0.5, 1), 4), rep(c(0, 0.3, 0.7, 1), each = 3), 1:12, cex = 2)
image(as.matrix(rev(as.data.frame(t(x)))), col = colours)
text(rep(c(0, 0.33, 0.67, 1), each = 3), rep(c(1, 0.5, 0), 4), 1:12,cex = 2)
rgb(red = 26, green = 204, blue = 76, maxColorValue = 255)
rgb(red = 0.1, green = 0.8, blue = 0.3)
col2rgb("#1ACC4C")
curve(sin(x), lwd = 30, col = rgb(0.8, 0.5, 0.2), xlim = c(-10, 10))
curve(cos(x), lwd = 30, col = rgb(0.1, 0.8, 0.3, alpha = 0.2), add = T)
pie(rep(1, 200), labels = "", col = rainbow(200), border = NA)
require("RColorBrewer")
display.brewer.all()
plot(1:10, 1:10, xlab = bquote(x[i]), ylab = bquote(y[i]))
text(3, 6, "some text")
text(4, 9, expression(widehate(beta) == (X^T * X)^{1} * X^T * y))
p <- 4; text(8, 4, bquote(beta[.(p)]))   #融合了数学符号和数值变量
plot(1:10, 1:10)
mtext("bottom", side = 1)
mtext(expression(x^2 + 3*y + hat(beta)), side = 4)
plot.new()
box()
title(main = "Main Title", sub = "Subtitle", xlab = "x label", ylab = "y label")
plot.new()
lines(x = c(0, 1), y = c(0, 1), col = "red")
axis(side = 1, at = c(0, 0.5, 1), labels = c("a", "b", c), col = "blue")
plot(1:4, 1:4, col = 1:4)
legend(x = 3, y = 2.5, legend = c("a", "b", "c", "d"), fill = 1:4)
plot(1:4, 1:4, col = 1:4, type = "b")
legend(x = 3, y = 2.5, legend = c("a", "b", "c", "d"), col = 1:4, lty = 1)
save.par <- par(no.readonly = TRUE)   #保存par()默认值
par(bg = "red")   #现在可以改变若干参变量的值
par(save.par)   #最后恢复它的旧值
save_par <- par(no.readonly = TRUE)
par(bg = "lightgray", col.axis = "darkgreen", col.lab = "darkred",
    col.main = "purple", col.sub = "black", fg = "blue")
curve(cos(x), xlab = "xlab in darkred", main = "Title in purple", xlim = c(-10, 10), sub = "sub in black")
curve(sin(x), col = "blue", add = T)
par(save_par)
save_par <- par(no.readonly = TRUE)
par(mfrow = c(1, 3))
vals <- c(0, 0.5, 1)
for(adj in vals){
  par(adj = adj)
  plot(0, main = paste("adj =", adj), col.lab = "red",
       col.main = "red", type = "n")
  text(1, 0, "abc", col = "red", cex = 2)
  abline(h = 0, lty = 2)
  abline(v = 1, lty = 2)
}
abline(v = 0.8, h = -0.5, lty = 2)
text(0.8, -0.5, "abc", col = "red", cex = 2, adj = c(0, 1))
abline(h = 0.5, v = 0.5, lty = 2)
text(0.8, 0.5, "ABC", col = "red", cex = 2, adj = c(0.5, 0.5), srt = 120)
par(save_par)
save_par <- par(no.readonly = TRUE)
par(cex.axis = 1.5)
plot(1:5, y = rep(1, 5), type = "n", font.axis = 2, font.lab = 3, xlab = "xlab in italics",
     ylab = "", font.main = 4, main = "Title in bold italics", font.sub = 5, sub = "Susbtitle in symbol font")
text(2, 1.2, "Ordinary text")
par(ps = 30)
text(3, 1, "A Hershey font", family = "HersheyScript")
par(ps = 14)
text(3, 0.8, "Another Hershey font", family = "HersheyGothicEnglish")
par(save_par)
save_par <- par(no.readonly = TRUE)
par(mar = c(7, 4, 4, 2) + 0.1)   #扩大底部边界为x轴标签留出空间
par(bty = "7", col = "blue", lab = c(10, 10, 1), las = 1, tck = 1)
#定义边框盒子的样式，在x轴和y轴上各有10个十字记号
#水平标签，刻度长度为1，将给出一个坐标网格
plot(1:8, xaxt = "n", xlab = "")   #创建一个没有x轴和x标签的图形
axis(1, labels = FALSE)   #添加仅具有十字记号的x轴
labels <- paste("Label", 1:8, sep = " ")   #创建标签向量
text(1:8, par("usr")[3] - 0.25, srt = 45, adj = 1, labels = labels, xpd = TRUE)   #将x标签添加到默认的十字记号上去
mtext(1, text = "Labels for the X axis", line = 6)
par(save_par)
plot(1, 1, type = "n")
for(i in 0:6) abline(v = 0.6+i*0.1, lty = i, lwd = i)
abline(v = 1.3, lty = "92", lwd = 10)
##worksheet A
z <- 1 + 2i
plot(1,3, xlab = "Re(z)", ylab = "Im(z)", xlim = c(0, 2.5), ylim = c(0, 2.5), main = "Complex numbers")
segments(0, 0, Re(z), Im(z))
points(Re(z), Im(z),pch = 19)
abline(h = 0, v = 0)
lines(x = c(Re(z), Re(z)), y = c(Im(z), 0), lty = 2)
lines(x = c(Re(z), 0), y = c(Im(z), Im(z)), lty = 2)
text(Re(z), Im(z), "z", pos = 4)
text(0.5, 1.2, "Mod(z)", srt = atan(z)*180/pi)
r <- 0.5
x<-seq(from=Re(r*exp(1i*Arg(z))), to=r, length=100)
y<-sqrt(0.5^2-x^2)
points(x, y, type="l")
text(0.55, 0.35, "Arg(z)", srt=-45, cex=0.8)
