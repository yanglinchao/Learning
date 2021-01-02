u.test <- function(a, mu ,thegama, alternative="twoside"){
  Se=thegama/sqrt(length(a))
  u=(mean(a)-mu)/Se
  if(alternative=="twoside")
    p=2*(1-pnorm(abs(u)))
  else if(alternative=="less")
    p=pnorm(u)
  else 
    p=1-pnorm(u)
  return(list(u=u, p=p))
}
bore <- c(100.36, 100.31, 99.99, 100.11, 100.64, 100.85, 99.42, 99.91, 99.35, 100.10)
u.test(bore, 100, 0.5)
t.test(bore, mu=100)
