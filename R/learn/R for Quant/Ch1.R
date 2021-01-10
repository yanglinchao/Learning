#Ch 1.1

library(zoo)

#�������ݲ�ת����zoo��ʽ
aapl <- read.zoo("aapl.csv", sep = ",", header = TRUE, format = "%Y-%m-%d")
str(aapl)
plot(aapl, main = "APPLE Closing Prices on NASDAQ", ylab = "Price (USD)", xlab = "Date")

head(aapl)
tail(aapl)
aapl[which.max(aapl)]

#��������
ret_simple <-  diff(aapl) / lag(aapl, k = -1) * 100   #(Close_t-Close_t-1)/Close_t

#��������������
ret_cont <- diff(log(aapl)) * 100   #ln(Close_t)-ln(Close_t-1)=ln(Close_t/Close_t-1)

summary(ret_simple)
#ʹ��coredata����������������ע���������(�������������)
summary(coredata(ret_simple))

ret_simple[which.min(ret_simple)]

#��ֱ��ͼ
hist(ret_simple, breaks = 100, main = "Histogram of Simple Returns", xlab = "%")

#ȷ��һ��������ˮƽΪ99%��VaR
quantile(ret_simple, probs = 0.01)


#Ch1.2 ARIMAģ�Ͷ�Ӣ�����ݼ۸�ģ��Ԥ��

library(forecast)
library(zoo)
#�������ݲ�ת��Ϊzoo��ʽ
#����FUN�������е��ø����ĺ���(as.yearmon��ʾ�¶����ݵ�)
hp <- read.zoo("UKHP.csv", sep = ",", header = TRUE, format = "%Y-%m", FUN = as.yearmon)
str(hp)

#�鿴ʱ���������ݵ�Ƶ��
frequency(hp)

#����������
hp_ret <- diff(hp) / lag(hp, k = -1) * 100

#ģ��ʶ��͹���

#ʹ��forecast����auto.arima����ʶ������ģ�Ͳ����Ʋ���
mod <- auto.arima(hp_ret, stationary = TRUE, seasonal = FALSE, ic = 'aic')
mod

#ƫ�����ͼ
pacf(mod$x)

#ϵ���ͽؾ������������(alpha = 0.05)
confint(mod)

#ģ�����

#ʱ���������ͼ
tsdiag(mod)

#��ʵֵ(��ɫ)�����ֵ(��ɫ)�ĶԱ�ͼ
plot(mod$x, lty = 1, main = "UK house prices: raw data vs. fitted + values", ylab = "Return in percent", xlab = "Date")
lines(fitted(mod), lty = 2, lwd = 2, col = "red")

#����Ԥ��ľ�ȷ��
#ƽ����������ƽ��������ƽ���ٷֱ���ƽ������ֵ�ٷֱ���ƽ�����Ա������
accuracy(mod)


#Ԥ��

#Ԥ�������3���µ���������
predict(mod, n.ahead = 3)
#�������б�׼���Ԥ��
plot(forecast(mod))


#Ch1.3 Э��

library(urca)
library(zoo)

prices <- read.zoo("JetFuelHedging.csv", sep = ",", FUN = as.yearmon, format = "%Y-%m", header = TRUE)
summary(prices)

#ͨ�����һ����ȡů�ͼ۸�仯�����ͺ���ȼ�ͼ۸������ģ�ͣ������Ƶ���������Ʒ����С����Գ���ʡ�����ģ���е�betaϵ���������ŶԳ�ȡ�
simple_mod <- lm(diff(prices$JetFuel) ~ diff(prices$HeatingOil) + 0) #+0���ؾ�����Ϊ0,��ʾ���չ�˾�������ֽ�
summary(simple_mod)

#�����۸����еĳ��ڹ�ϵ(ȡů�ͼ۸��ú�ɫ)
plot(prices$JetFuel, main = "Jet Fuel and Heating Oil Prices", xlab = "Date", ylab = "USD")
lines(prices$HeatingOil, col = "red")

jf_adf <- ur.df(prices$JetFuel, type = "drift")
summary(jf_adf)
ho_adf <- ur.df(prices$HeatingOil, type = "drift")
summary(ho_adf)

#�������ƾ�̬����ģ�ͣ���ʹ��ADF��������ʱ�����еĲв��Ƿ�ƽ��
mod_static <- summary(lm(prices$JetFuel ~ prices$HeatingOil))
error <- residuals(mod_static)
error_cadf <- ur.df(error, type = "none")
summary(error_cadf)

#�������ģ��(ECM)
djf <- diff(prices$JetFuel)
dho <- diff(prices$HeatingOil)
error_lag <- lag(error, k = -1)
mod_ecm <- lm(djf ~ dho + error_lag)
summary(mod_ecm)


#Ch1.4 GARCH

library(zoo)
intc <- read.zoo("intc.csv", header = TRUE, sep = ",", format = "%Y-%m", FUN = as.yearmon)

#����ARCHЧӦ
plot(intc, main = "Monthly returns of Intel Corporation", xlab = "Date", ylab = "Return in percent")
#Ljung-Box����
Box.test(coredata(intc^2), type = "Ljung-Box", lag = 12)
#LM����
library(FinTS)
ArchTest(coredata(intc))

#GARCHģ���趨
library(rugarch)
#ʹ��ugarchspec()�趨ģ��
intc_garch11_spec <- ugarchspec(variance.model = list(garchOrder = c(1, 1)), mean.model = list(armaOrder = c(0, 0)))

#GARCHģ�͹���
intc_garch11_fit <- ugarchfit(spec = intc_garch11_spec, data = intc)
intc_garch11_fit

#�ز����ģ��
#ʹ��ugarchroll()�趨ģ��
intc_garch11_roll <- ugarchroll(intc_garch11_spec, intc, n.start = 120, refit.every = 1, refit.window = "moving", solver = "hybrid", calculate.VaR = TRUE, VaR.alpha = 0.01, keep.coef = TRUE)
#ʹ��report()�������زⱨ��
report(intc_garch11_roll, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)

#ͼ��
#ʹ��ugarchroll����ľ�ȷԤ��VaR����һ��zoo����
intc_VaR <- zoo(intc_garch11_roll@forecast$VaR[, 1])
#ͨ��rownames(�����)��д��������index����
index(intc_VaR) <- as.yearmon(rownames(intc_garch11_roll@forecast$VaR))
#����ʵ�����ʽ���ͬ���Ĵ���
intc_actual <- zoo(intc_garch11_roll@forecast$VaR[, 2])
index(intc_actual) <- as.yearmon(rownames(intc_garch11_roll@forecast$VaR))
#����ͼ��
plot(intc_actual, type = "b", main = "99% 1 Month VaR Backtesting", xlab = "Date", ylab = "Return/VaR in percent")
lines(intc_VaR, col = "red")
legend("topright", inset = .05, c("Intel return", "VaR"), col = c("black", "red"), lty = c(1, 1))

#Ԥ��
intc_garch11_fcst <- ugarchforecast(intc_garch11_fit, n.ahead = 12)
intc_garch11_fcst