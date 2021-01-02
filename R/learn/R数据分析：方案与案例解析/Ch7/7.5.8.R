proptest <- function(x, n, p, alternative){
  Se <- sqrt(p*(1-p)/n)
  u <- (x/n-p)/Se
  if(alternative=="twoside")
    p <- 2*(1-pnorm(abs(u)))
  else if(alternative=="less")
    p <- pnorm(p)
  else
    p <- 1-pnorm(p)
  return(list(u=u, p=p))
}
proptest(1, 400, 0.01, alternative = "less")