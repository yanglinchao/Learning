require(ggplot2)
p <- qplot(sleep_total, sleep_cycle, data = msleep, colour = vore)
p
p + scale_color_hue()
p + scale_colour_hue("What does\nit eat?",
                     breaks = c("herbi", "carni", "omni", NA),
                     labels = c("plants", "meat", "both", "don't know"))
p + scale_colour_brewer(palette = "Set1")
p <- qplot(cty, hwy, data = mpg, colour = displ)
p
p + scale_x_continuous("City mpg")
p + xlab("City mpg")
p + ylab("Highway mpg")
p + labs(x = "City mpg", y = "Highway", colour = "Displacement")
p + xlab(expression(frac(miles, gallon)))
require(ggplot2)
p <- qplot(cyl, wt, data = mtcars)
p
p + scale_x_continuous(breaks = c(5.5, 6.5))
p + scale_x_continuous(limits = c(5.5, 6.5))
p <- qplot(wt, cyl, data = mtcars, colour = cyl)
p
p + scale_colour_gradient(breaks = c(5.5, 6.5))
p + scale_colour_gradient(limits = c(5.5, 6.5))
qplot(log10(carat), log10(price), data = diamonds)
qplot(carat, price, data = diamonds) + scale_x_log10() + scale_y_log10()
f2d <- with(faithful, MASS::kde2d(eruptions, waiting, h = c(1, 10), n = 50))   #利用MASS包kde2d()对eruptions和waiting进行二维核密度估计,参数h设置矢量方向的带宽,参数n设置每个方向的网格点的数量
df <- with(f2d, cbind(expand.grid(x, y), as.vector(z)))
names(df) <- c("eruptions", "waiting", "density")
erupt <- ggplot(df, aes(waiting, eruptions, fill = density)) + geom_tile() + scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
erupt + scale_fill_gradient(limits = c(0, 0.04))
erupt + scale_fill_gradient(limits = c(0, 0.04), low = "white", high = "black")
erupt + scale_fill_gradient2(limits = c(-0.04, 0.04), midpoint = mean(df$density))
point <- qplot(brainwt, bodywt, data = msleep, log = "xy", colour = vore)
area <- qplot(log10(brainwt), data = msleep, fill = vore, binwidth = 1)
point + scale_colour_brewer(palette = "Set1")
point + scale_colour_brewer(palette = "Set2")
point + scale_colour_brewer(palette = "Pastel1")
area + scale_fill_brewer(palette = "Set1")
area + scale_fill_brewer(palette = "Set2")
area + scale_fill_brewer(palette = "Pastel2")
plot <- qplot(brainwt, bodywt, data = msleep, log = "xy")
plot + aes(colour = vore) + scale_colour_manual(values = c("red", "orange", "yellow", "green", "blue"))
colours <- c(carni = "red", "NA" = "orange", insecti = "yellow", herbi = "green", omni = "blue")
plot + aes(colour = vore) + scale_colour_manual(values = colours)
plot + aes(shape = vore) + scale_shape_manual(values = c(1, 2, 6, 0, 23))
huron <- data.frame(year = 1875:1972, level = LakeHuron)
ggplot(huron, aes(year)) + 
  geom_line(aes(y = level - 5, colour = "below")) + 
  geom_line(aes(y = level + 5, colour = "above")) +
  scale_colour_manual("Direction", values = c("below" = "blue", "above" = "red"))