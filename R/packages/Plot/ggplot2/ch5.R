require(ggplot2)
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist + geom_histogram(aes(y = ..density..), binwidth = 0.1) + facet_grid(cut ~ .)   #用cut变量分面
depth_dist + geom_histogram(aes(fill = cut), binwidth = 0.1, position = "fill")
depth_dist + geom_freqpoly(aes(y = ..density.., colour = cut), binwidth = 0.1)   #binwit指组距
library(plyr)
qplot(cut, depth, data = diamonds, geom = "boxplot")
ggplot(diamonds, aes(cut, depth)) + geom_boxplot()
ggplot(diamonds, aes(carat, depth, group = round_any(carat, 0.1, floor))) + geom_boxplot() + xlim(c(0, 3))
require(ggplot2)
df <- data.frame(x = rnorm(2000), y = rnorm(2000))
norm <- ggplot(df, aes(x, y))
norm + geom_point()
norm + geom_point(shape = 1)
norm + geom_point(shape = ".")  #点的大小为像素级
norm + geom_point(colour = "black", alpha = 1/5)
norm + geom_point(colour = "black", alpha = 1/20)
td <- ggplot(diamonds, aes(table, depth)) + xlim(50, 70) + ylim(50, 70)
td + geom_point()
td + geom_jitter()
jit <- position_jitter(width = 0.5)
td + geom_jitter(position = jit)
td + geom_jitter(position = jit, colour = "black", alpha = 1/10)
td + geom_jitter(position = jit, colour = "black", alpha = 1/50)
td + geom_jitter(position = jit, colour = "black", alpha = 1/200)
d <- ggplot(diamonds, aes(carat, price)) + xlim(1, 3) + theme(legend.position = "none")
d + stat_bin2d()
d + stat_bin2d(bins = 10)
d + stat_bin2d(binwidth = c(0.02, 200))
require(hexbin)
d + stat_binhex()
d + stat_binhex(bins = 10)
d + stat_binhex(binwidth = c(0.02, 200))
d <- ggplot(diamonds, aes(carat, price)) + xlim(1, 3) + theme(legend.position = "none")
d + geom_point() + geom_density2d()
d + stat_density2d(geom = "point", aes(size = ..density..), contour = F) + scale_size_area()
d + stat_density2d(geom = "point", aes(size = ..density..), contour = F)
last_plot() + scale_fill_gradient(limits = c(1e-5, 8e-4))
require(ggplot2)
d <- subset(diamonds, carat < 2.5 & rbinom(nrow(diamonds), 1, 0.2) == 1)
d$lcarat <- log10(d$carat)
d$lprice <- log10(d$price)
##剔除整体的线性趋势
detrend <- lm(lprice ~ lcarat, data = d)
d$lprice2 <- resid(detrend)
mod <- lm(lprice2 ~ lcarat * color, data = d)
require(effects)
effectdf <- function(...){
  suppressWarnings(as.data.frame(effect(...)))
}
color <- effectdf("color", mod)
both1 <- effectdf("lcarat:color", mod)
carat <- effectdf("lcarat", mod, default.levels = 50)
both2 <- effectdf("lcarat:color", mod, default.levels = 3)
qplot(lcarat, lprice, data = d, colour = color)
qplot(lcarat, lprice2, data = d, colour = color)
fplot <- ggplot(mapping = aes(y = fit, ymin = lower, ymax = upper)) + ylim(range(both2$lower, both2$upper))
fplot %+% color + aes(x = color) + geom_point() + geom_errorbar()
fplot %+% both2 +
  aes(x = color, colour = lcarat, group = interaction(color, lcarat)) +
  geom_errorbar() + geom_line(aes(group = lcarat)) +
  scale_colour_gradient()
fplot %+% carat + aes(x = lcarat) + geom_smooth(stat = "identity")
ends <- subset(both1, lcarat == max(lcarat))
fplot %+% both1 + aes(x = lcarat, colour = color) +
  geom_smooth(stat = "identity") +
  scale_colour_hue() + theme(legend.position = "home") +
  geom_text(aes(label = color, x = lcarat +0.02), ends)
require(ggplot2)
(unemp <- qplot(date, unemploy, data = economics, geom = "line",
                xlab = "", ylab = "No.unemployed(1000s)"))
presidential <- presidential[-(1:3), ]
yrng <- range(economics$unemploy)
xrng <- range(economics$date)
unemp + geom_vline(aes(xintercept = as.numeric(start)), data = presidential)
require(scales)
unemp + geom_rect(aes(NULL, NULL, xmin = start, xmax = end,
                      fill = party), ymin = yrng[1], ymax = yrng[2],
                  data = presidential, alpha = 0.2) +
  scale_fill_manual(values = c("blue", "red"))
last_plot() + geom_text(aes(x = start, y = yrng[1], label = name),
                        data = presidential, size = 3, hjust = 0, vjust = 0)
caption <- paste(strwrap("Unemployment rates in the US have varied a lot over the years", 40), collapse = "\n")
unemp + geom_text(aes(x, y, label = caption),
                  data = data.frame(x = xrng[2], y = yrng[2]),
                  hjust = 1, vjust = 1, size = 4)
highest <- subset(economics, unemploy == max(unemploy))
unemp + geom_point(data = highest, size = 3, colour = "red", alpha = 0.5)
qplot(percwhite, percbelowpoverty, data = midwest)
qplot(percwhite, percbelowpoverty, data = midwest, size = poptotal / 1e6) +
  scale_size_area("Population\n(millions)",
                  breaks = c(0.5, 1, 2, 4))
qplot(percwhite, percbelowpoverty, data = midwest, size = area) +
  scale_size_area()
lm_smooth <- geom_smooth(method = lm, size = 1)
qplot(percwhite, percbelowpoverty, data = midwest) + lm_smooth
qplot(percwhite, percbelowpoverty, data = midwest, weight = popdensity, size = popdensity) + lm_smooth
qplot(percbelowpoverty, data = midwest, binwidth = 1)
qplot(percbelowpoverty, data = midwest, weight = poptotal, binwidth = 1) + ylab("population")