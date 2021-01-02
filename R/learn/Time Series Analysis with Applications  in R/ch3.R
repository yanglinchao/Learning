data(rwalk)
model1 <- lm(rwalk~time(rwalk))
summary(model1)
rwalk_df <- data.frame(time = c(time(rwalk)), rwalk = c(rwalk))
ggplot(data = rwalk_df, aes(x = time, y = rwalk)) + geom_point() + geom_line() + geom_abline(intercept = model1$coefficients[1], slope = model1$coefficients[2], col = 'blue')

data("tempdub")
month. <- season(tempdub)
model2 <- lm(tempdub ~ month. - 1)    #去掉截距项
summary(model2)
model3 <- lm(tempdub ~ month.)   #一月将被移除
summary(model3)
model2$coefficients
library(ggplot2)
a <- data.frame(model2$coefficients)
a$month <- month.[1:12]
ggplot(data = a, aes(x = month, y = model2.coefficients)) + geom_point()

har. = harmonic(tempdub, 1)   #求cos(2*pi*t)&sin(2*pi*t)
model4 <- lm(tempdub ~ har.)
summary(model4)

temp <- c(tempdub); fitted <- fitted(model4)
tempdub_df <- data.frame(temp = temp, fitted = fitted, time = c(1:144))
ggplot(data = tempdub_df, aes(x = time)) + geom_point(aes(y = temp), col = 'darkorchid1') + geom_line(aes(y = fitted), col = 'darkorange1') + scale_x_continuous(breaks = seq(from = 1, to = 145, by = 12), labels = c(1964:1976))
