isPalindrome <- function(self){
  
  self <- as.character(self)
  self <- strsplit(self, split = "")[[1]]
  
  self.length <- length(self)
  center.length <- trunc(length(self)/2)+1
  
  a <- self[1:(center.length-1)]
  b <- self[(center.length+1):length(self)]
  b <- b[sort(c(1:length(b)), decreasing = TRUE)]
  
  if(sum(a==b)==length(a)){
    print("TRUE")
  }else{
    print("FALSE")
  }
}

self <- 123456787654321
isPalindrome(self = self)
