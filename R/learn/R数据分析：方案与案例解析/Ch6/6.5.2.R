s <- scan(file="6.5.2.txt")
library(psych)
describe(s)
fivenum(s)
EDA <- function(x){
  par(mfrow=c(2,2));
  hist(x);
  dotchart(x);
  boxplot(x, horizontal = T);
  qqnorm(x);
  qqline(x);
  par(mfrow=c(1,1))
}
B <- function(x){
  stem(x);
  boxplot(x)
}
EDA(s)
B(s)