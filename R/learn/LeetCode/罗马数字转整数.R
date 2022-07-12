romanToInt <- function(self){
  
  romanTable <- data.frame(roman = c("I", "V", "X", "L", "C", "D", "M"),
                           int = c(1, 5, 10, 50, 100, 500, 1000))
  
  self <- strsplit(self, split = "")[[1]]
  
  self.int <- c()
  for(i in 1:length(self)){
    self.int[i] <- romanTable$int[which(romanTable$roman == self[i])]
  }
  
  max.site <- which(self.int==max(self.int))
  
  if(max.site!=1){
    self.int.first <- self.int[1:(max.site-1)] * (-1)
    self.int.second <- self.int[max.site:length(self.int)]
    answer <- sum(self.int.first) + sum(self.int.second)
  }else{
    answer <- sum(self.int)
  }
  
  print(answer)
  
}

self <- "IX"
romanToInt(self = self)
