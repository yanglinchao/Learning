opar <- par(no.readonly = TRUE)
par(mfrow=c(1, 2))
t1 <- subset(Orange, Tree==1)
plot(t1$age, t1$circumference, xlab = "Age (days)", ylab = "Circumference (mm)", main = "Orange Tree 1 Growth")
plot(t1$age, t1$circumference, xlab = "Age (days)", ylab = "Circumference (mm)", main = "Orange Tree 1 Growth", type = "b")
par(opar)
par(mfrow=c(1, 1))
###为了方便起见，将因子转化为数值型###
Orange$Tree <- as.numeric(Orange$Tree)
ntrees <- max(Orange$Tree)
###创建图形###
xrange <- range(Orange$age)
yrange <- range(Orange$circumference)
plot(xrange, yrange, type = "n", xlab = "Age (days)", ylab = "Circumference (mm)")   #type="n"不生成任何点和线，通常用来为后面的命令创建坐标轴
colors <- rainbow(ntrees)
linetype <- c(1:ntrees)
plotchar <- seq(18, 18+ntrees, 1)
###添加线条###
for(i in 1:ntrees){
  tree <- subset(Orange, Tree==i)
  lines(tree$age, tree$circumference,
        type = "b",
        lwd = 2,
        lty = linetype[i],
        col = colors[i],
        pch = plotchar[i])
}
title("Tree Growth", "example of line plot")
###添加图例###
legend(xrange[1], yrange[2],
       1:ntrees,
       cex=0.8,
       col=colors,
       pch=plotchar,
       lty=linetype,
       title="Tree")
