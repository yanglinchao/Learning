#数据选择

library(Quandl)
Quandl.auth("xy9nByxb8Q9izWx2gwPZ")
G <- Quandl("GOOG/NASDAQ_GOOG", start_date = "2009-06-01", end_date = "2013-06-01")
G <- G[order(G$Date), ]
SP500 <- Quandl("YAHOO/INDEX_GSPC", start_date = "2009-06-01", end_date = "2013-06-01")
SP500 <- SP500[order(SP500$Date), ]
LIBOR <- Quandl("FED/RILSPDEPM01_N_B", start_date = "2009-06-01", end_date = "2013-06-01")
LIBOR <- LIBOR[order(LIBOR$Date), ]


#过滤日期
#intersect函数仅能运用于两个向量,调用Reduce函数来识别3个时间序列中的共同日期
cdates <- Reduce(intersect, list(G$Date, SP500$Date, LIBOR$Date))

G <- G[G$Date %in% cdates, "Close"]
SP500 <- SP500[SP500$Date %in% cdates, "Adjusted Close"]
LIBOR <- LIBOR[LIBOR$Date %in% cdates, "Value"]

#计算对数收益率
logreturn <- function(x) log(tail(x, -1) / head(x, -1))

#因为LIBOR利率是基于货币市场基差而报价的,计算式遵循actual/360的传统,并且时间序列包含了用百分比表示的利率,所以要进行进一步处理
rft <- log(1 + head(LIBOR, -1) / 36000 * diff(cdates))


##简单beta估计

cov(logreturn(G) - rft, logreturn(SP500) - rft) / var(logreturn(SP500) - rft)

#写一个风险溢价的函数
riskpremium <- function(x, rft) logreturn(x) - rft


##基于线性回归估计beta


(fit <- lm(riskpremium(G, rft) ~ riskpremium(SP500, rft)))
#x轴表示MRP,y轴表示Google的风险溢价
plot(riskpremium(SP500, rft), riskpremium(G, rft))
abline(fit, col = "red")

#根据CAPM,E(r)-rf = beta(E(r_m)-rf),所以删除截距项
fit <- lm(riskpremium(G, rft) ~ -1 + riskpremium(SP500, rft))
summary(fit)

#检查残差
par(mfrow = c(2, 2))
plot(fit)