library(spuRs)
data(ufc)
str(ufc)


opar1 <- par(no.readonly = TRUE)
plot(ufc$dbh.cm, ufc$height.m, axes = FALSE, xlab = "", ylab = "", type = "n")
points(ufc$dbh.cm, ufc$height.m,
       col = ifelse(ufc$height.m > 4.9, "darkseagreen4", "red"),
       pch = ifelse(ufc$height.m > 4.9, 1, 3))
axis(1)
axis(2)
opar2 <- par(las = 0)
mtext("Diameter (cm)", side = 1, line = 3)
mtext("Height (m)", side = 2, line = 3)
box()
legend(x = 60, y = 15,
       c("Normal trees", "A weird tree"),
       col = c("darkseagreen3", "red"),
       pch = c(1, 3),
       bty = "n")
par(opar1)