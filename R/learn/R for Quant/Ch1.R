#Ch 1.1

library(zoo)

#导入数据并转换成zoo格式
aapl <- read.zoo("aapl.csv", sep = ",", header = TRUE, format = "%Y-%m-%d")
str(aapl)
plot(aapl, main = "APPLE Closing Prices on NASDAQ", ylab = "Price (USD)", xlab = "Date")

head(aapl)
tail(aapl)
aapl[which.max(aapl)]

#简单收益率
ret_simple <-  diff(aapl) / lag(aapl, k = -1) * 100   #(Close_t-Close_t-1)/Close_t

#连续复合收益率
ret_cont <- diff(log(aapl)) * 100   #ln(Close_t)-ln(Close_t-1)=ln(Close_t/Close_t-1)

summary(ret_simple)
#使用coredata函数来表明仅仅关注收益率情况(结果不包含日期)
summary(coredata(ret_simple))

ret_simple[which.min(ret_simple)]

#作直方图
hist(ret_simple, breaks = 100, main = "Histogram of Simple Returns", xlab = "%")

#确定一天中置信水平为99%的VaR
quantile(ret_simple, probs = 0.01)


#Ch1.2 ARIMA模型对英国房屋价格建模并预测

library(forecast)
library(zoo)
#导入数据并转换为zoo格式
#参数FUN对日期列调用给定的函数(as.yearmon表示月度数据点)
hp <- read.zoo("UKHP.csv", sep = ",", header = TRUE, format = "%Y-%m", FUN = as.yearmon)
str(hp)

#查看时间序列数据的频率
frequency(hp)

#计算收益率
hp_ret <- diff(hp) / lag(hp, k = -1) * 100

#模型识别和估计

#使用forecast包的auto.arima函数识别最优模型并估计参数
mod <- auto.arima(hp_ret, stationary = TRUE, seasonal = FALSE, ic = 'aic')
mod

#偏自相关图
pacf(mod$x)

#系数和截距项的置信区间(alpha = 0.05)
confint(mod)

#模型诊断

#时间序列诊断图
tsdiag(mod)

#真实值(黑色)和拟合值(红色)的对比图
plot(mod$x, lty = 1, main = "UK house prices: raw data vs. fitted + values", ylab = "Return in percent", xlab = "Date")
lines(fitted(mod), lty = 2, lwd = 2, col = "red")

#计算预测的精确性
#平均误差、均方误差、平均绝对误差、平均百分比误差、平均绝对值百分比误差、平均绝对比例误差
accuracy(mod)


#预测

#预测接下来3个月的月收益率
predict(mod, n.ahead = 3)
#画出带有标准误的预测
plot(forecast(mod))


#Ch1.3 协整

library(urca)
library(zoo)

prices <- read.zoo("JetFuelHedging.csv", sep = ",", FUN = as.yearmon, format = "%Y-%m", header = TRUE)
summary(prices)

#通过拟合一个用取暖油价格变化来解释航空燃油价格的线性模型，可以推导出两种商品的最小方差对冲比率。线性模型中的beta系数就是最优对冲比。
simple_mod <- lm(diff(prices$JetFuel) ~ diff(prices$HeatingOil) + 0) #+0将截距项设为0,表示航空公司不持有现金
summary(simple_mod)

#两个价格序列的长期关系(取暖油价格用红色)
plot(prices$JetFuel, main = "Jet Fuel and Heating Oil Prices", xlab = "Date", ylab = "USD")
lines(prices$HeatingOil, col = "red")

jf_adf <- ur.df(prices$JetFuel, type = "drift")
summary(jf_adf)
ho_adf <- ur.df(prices$HeatingOil, type = "drift")
summary(ho_adf)

#继续估计静态均衡模型，并使用ADF方法检验时间序列的残差是否平稳
mod_static <- summary(lm(prices$JetFuel ~ prices$HeatingOil))
error <- residuals(mod_static)
error_cadf <- ur.df(error, type = "none")
summary(error_cadf)

#误差修正模型(ECM)
djf <- diff(prices$JetFuel)
dho <- diff(prices$HeatingOil)
error_lag <- lag(error, k = -1)
mod_ecm <- lm(djf ~ dho + error_lag)
summary(mod_ecm)


#Ch1.4 GARCH

library(zoo)
intc <- read.zoo("intc.csv", header = TRUE, sep = ",", format = "%Y-%m", FUN = as.yearmon)

#检验ARCH效应
plot(intc, main = "Monthly returns of Intel Corporation", xlab = "Date", ylab = "Return in percent")
#Ljung-Box检验
Box.test(coredata(intc^2), type = "Ljung-Box", lag = 12)
#LM检验
library(FinTS)
ArchTest(coredata(intc))

#GARCH模型设定
library(rugarch)
#使用ugarchspec()设定模型
intc_garch11_spec <- ugarchspec(variance.model = list(garchOrder = c(1, 1)), mean.model = list(armaOrder = c(0, 0)))

#GARCH模型估计
intc_garch11_fit <- ugarchfit(spec = intc_garch11_spec, data = intc)
intc_garch11_fit

#回测风险模型
#使用ugarchroll()设定模型
intc_garch11_roll <- ugarchroll(intc_garch11_spec, intc, n.start = 120, refit.every = 1, refit.window = "moving", solver = "hybrid", calculate.VaR = TRUE, VaR.alpha = 0.01, keep.coef = TRUE)
#使用report()函数检查回测报告
report(intc_garch11_roll, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)

#图形
#使用ugarchroll对象的精确预测VaR创建一个zoo对象
intc_VaR <- zoo(intc_garch11_roll@forecast$VaR[, 1])
#通过rownames(年和月)重写这个对象的index属性
index(intc_VaR) <- as.yearmon(rownames(intc_garch11_roll@forecast$VaR))
#对真实收益率进行同样的处理
intc_actual <- zoo(intc_garch11_roll@forecast$VaR[, 2])
index(intc_actual) <- as.yearmon(rownames(intc_garch11_roll@forecast$VaR))
#画出图形
plot(intc_actual, type = "b", main = "99% 1 Month VaR Backtesting", xlab = "Date", ylab = "Return/VaR in percent")
lines(intc_VaR, col = "red")
legend("topright", inset = .05, c("Intel return", "VaR"), col = c("black", "red"), lty = c(1, 1))

#预测
intc_garch11_fcst <- ugarchforecast(intc_garch11_fit, n.ahead = 12)
intc_garch11_fcst
