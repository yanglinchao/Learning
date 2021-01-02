#Black-Scholes定价模型
library(fOptions)
GBSOption(TypeFlag = "c", S = 900, X = 950, Time = 1/4, r = 0.02, sigma = 0.22, b = 0.02)


#Cox-Ross-Rubinstein二叉树模型
library(fOptions)
CRRBinomialTreeOption(TypeFlag = "ce", S = 900, X = 950, Time = 1/4, r = 0.02, b = 0.02, sigma = 0.22, n = 3)
#画出整个期权树
CRRTree <- BinomialTreeOption(TypeFlag = "ce", S = 900, X = 950, Time = 1/4, r = 0.02, b = 0.02, sigma = 0.22, n = 3)
BinomialTreePlot(CRRTree, dy = 1, xlab = "Time steps", ylab = "Number of up steps", xlim = c(0, 4))
title(main = "Call Option Tree")

#Greeks
library(fOptions)
sapply(c("delta", "gamma", "vega", "theta", "rho"), function(greek){
  GBSGreeks(Selection = greek, TypeFlag = "c", S = 900, X = 950, Time = 1/4, r = 0.02, b = 0.02, sigma = 0.22)
})
#观察delta的变化
deltas <- sapply(c(1/4, 1/20, 1/50), function(t){
  sapply(500:1500, function(S){
    GBSGreeks(Selection = "delta", TypeFlag = "c", S = S, X = 950, Time = t, r = 0.02, b = 0.02, sigma = 0.22)
  })
})
plot(500:1500, deltas[ , 1], ylab = "Delta of call option", xlab = "Price of the underlying (S)", type = "l")
lines(500:1500, deltas[, 2], col = "blue")
lines(500:1500, deltas[, 3], col = "red")
legend("bottomright", legend = c("t=1/4", "t=1/20", "t=1/50"), col = c("black", "blue", "red"), pch = 19)
#跨式期权的delta
straddles <- sapply(c("c", "p"), function(type){
  sapply(500:1500, function(S){
    GBSGreeks(Selection = "delta", TypeFlag = type, S = S, X = 950, Time = 1/4, r = 0.02, b = 0.02, sigma = 0.22)
  })
})
plot(500:1500, rowSums(straddles), type = "l", xlab = "Price of the underlying (S)", ylab = "Delta of Straddle")


#隐含波动率
goog <- read.table("goog_calls.csv", sep = ";", header = TRUE)
goog$Strike <- as.numeric(goog$Strike)
volatilites <- sapply(seq_along(goog$Strike), function(i){
  GBSVolatility(price = goog$Ask.Price[i], TypeFlag = "c", S = 866.2, X = goog$Strike[i], Time = 88/360, r = 0.02, b = 0.02)
})
str(volatilites)
plot(x = goog$Strike, volatilites, type = "p", ylab = "Implied volatiltiy", xlab = "Strike price (X)")
