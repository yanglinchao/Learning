isValid <- function(self){
  
  self <- strsplit(self, split = "")[[1]]
  

  
  if(length(self) %% 2 ==0){
    
    a <- c()
    b <- c()
    for(i in 1:length(self)){
      if(self[i]=="("){
        a <- rbind(a, ")")
      }else if(self[i]=="["){
        a <- rbind(a, "]")
      }else if(self[i]=="{"){
        a <- rbind(a, "}")
      }else if(self[i]==")"){
        b <- rbind(b, self[i])
      }else if(self[i]=="]"){
        b <- rbind(b, self[i])
      }else if(self[i]=="}"){
        b <- rbind(b, self[i])
      }
    }
    
    if(length(a)==length(b)){
      
      if(all(a == b)){
        print("true")
      }else if(all(a[sort(1:length(a), decreasing = TRUE)] == b)){
        print("true")
      }else{
        print("false")
      }
      
    }else{
      print("fasle")
    }
    
    
  }else{
    print("false")
  }
  
}

self <- "((()])"
isValid(self)
