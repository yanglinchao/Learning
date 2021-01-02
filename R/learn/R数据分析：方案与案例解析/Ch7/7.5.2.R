height <- c(136, 144, 143, 157, 137, 159, 135, 158, 147, 165, 158, 142, 159, 150, 156, 152, 140, 149,
            148, 155)
t.test(height, mu=149)
var.test1 <- function(x, sigma2){
  n <- length(x)
  S2=var(x)
  df=n-1
  chi2 <- df*S2/sigma2;
  P <- pchisq(chi2, df)
  data.frame(var=S2, df=df, chisq2=chi2, P_value=P)
}
var.test1(height, 75)