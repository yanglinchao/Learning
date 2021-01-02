#primesieve
primesieve <- function(sieved, unsieved){
  #finds primes using the Sieve of Eratosthenes
  #sieved: sorted vector of sieved numbers
  #unsieved: sorted vector of unsieved numbers
  
  #cat("sieved", unsieved, "\n")
  #cat("unsieved", unsieved, "\n")
  
  p <- unsieved[1]
  n <- length(unsieved)
  
  if(p^2 > n){
    return(c(sieved, unsieved))
  }else{
    unsieved <- unsieved[unsieved %% p != 0]
    sieved <- c(sieved, p)
    return(primesieve(sieved, unsieved))
  }
  
}

primesieve(c(), 2:200)
