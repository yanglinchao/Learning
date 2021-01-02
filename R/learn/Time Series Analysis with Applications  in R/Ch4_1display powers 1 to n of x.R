library(TSA)
data("ma1.2.s")
plot(ma1.2.s, ylab = expression(Y[t]), type = 'o')

plot(y = ma1.2.s, x = zlag(ma1.2.s), ylab = expression(Y[t]), xlab = expression(Y[t-1]), type = 'p')
plot(y = ma1.2.s, x = zlag(ma1.2.s, 2), ylab = expression(Y[t]), xlab = expression(Y[t-2]), type = 'p')

data(ma2.s);plot(ma2.s, ylab = expression(Y[t]), type = 'o')
plot(y = ma2.s, x = zlag(ma2.s), ylab = expression(Y[t]), xlab = expression(Y[t-1]), type = 'p')
plot(y = ma2.s, x = zlag(ma2.s, 2), ylab = expression(Y[t]), xlab = expression(Y[t-2]), type = 'p')
plot(y = ma2.s, x = zlag(ma2.s, 3), ylab = expression(Y[t]), xlab = expression(Y[t-3]), type = 'p')
