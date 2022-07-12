longestCommonPrefix <- function(self){
  
  self.list <- strsplit(self, split = "")
  
  self.length <- c()
  for(i in 1:length(self.list)){
    self.length[i] <- length(self.list[[i]])
  }
  
  short <- self.list[which(self.length==min(self.length))[1]][[1]]
  
  for(i in 1:length(short)){
    
    a <- rep(NA, length(self.list))
    for(j in 1:length(self.list)){

      a[j] <- self.list[[j]][i]==short[i]
    }
    a <- sum(a)
    if(a!=length(self.list)) break
    
  }
  answer <- paste(short[1:(i-1)], collapse = "")
  print(answer)
  
}
self <- c("flower","flow","flight")
longestCommonPrefix(self = self)
