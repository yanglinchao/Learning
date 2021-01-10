#����ѡ��

library(Quandl)
Quandl.auth("xy9nByxb8Q9izWx2gwPZ")
G <- Quandl("GOOG/NASDAQ_GOOG", start_date = "2009-06-01", end_date = "2013-06-01")
G <- G[order(G$Date), ]
SP500 <- Quandl("YAHOO/INDEX_GSPC", start_date = "2009-06-01", end_date = "2013-06-01")
SP500 <- SP500[order(SP500$Date), ]
LIBOR <- Quandl("FED/RILSPDEPM01_N_B", start_date = "2009-06-01", end_date = "2013-06-01")
LIBOR <- LIBOR[order(LIBOR$Date), ]


#��������
#intersect����������������������,����Reduce������ʶ��3��ʱ�������еĹ�ͬ����
cdates <- Reduce(intersect, list(G$Date, SP500$Date, LIBOR$Date))

G <- G[G$Date %in% cdates, "Close"]
SP500 <- SP500[SP500$Date %in% cdates, "Adjusted Close"]
LIBOR <- LIBOR[LIBOR$Date %in% cdates, "Value"]

#�������������
logreturn <- function(x) log(tail(x, -1) / head(x, -1))

#��ΪLIBOR�����ǻ��ڻ����г���������۵�,����ʽ��ѭactual/360�Ĵ�ͳ,����ʱ�����а������ðٷֱȱ�ʾ������,����Ҫ���н�һ������
rft <- log(1 + head(LIBOR, -1) / 36000 * diff(cdates))


##��beta����

cov(logreturn(G) - rft, logreturn(SP500) - rft) / var(logreturn(SP500) - rft)

#дһ��������۵ĺ���
riskpremium <- function(x, rft) logreturn(x) - rft


##�������Իع����beta


(fit <- lm(riskpremium(G, rft) ~ riskpremium(SP500, rft)))
#x���ʾMRP,y���ʾGoogle�ķ������
plot(riskpremium(SP500, rft), riskpremium(G, rft))
abline(fit, col = "red")

#����CAPM,E(r)-rf = beta(E(r_m)-rf),����ɾ���ؾ���
fit <- lm(riskpremium(G, rft) ~ -1 + riskpremium(SP500, rft))
summary(fit)

#���в�
par(mfrow = c(2, 2))
plot(fit)