x <- c(15.04, 15.36, 14.57, 15.57, 14.69, 15.37, 14.66, 14.52, 15.41, 15.34, 14.28, 15.01, 14.76, 14.38, 15.87, 13.66, 14.97, 15.29, 15.95)
describe.test <- function(x){
  hist(x, prob=T)
  stem(x)
  qqnorm(x)
  qqline(x)
}
describe.test(x)
install.packages("tseries")
library(tseries)
jarque.bera.test(x)
shapiro.test(x)