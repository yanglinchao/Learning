smallestRepunitBivByK <- function(k){
  
  if(k %% 2 == 0){
    print(-1)
  }else if(k %% 5 ==0){
    print(-1)
  }else{
    
    num <- 1
    while(num %% k != 0){
      num <- num*10+1
    }
    
    print(length(strsplit(as.character(num), split = "")[[1]]))
    
  }
  
}

k = 9
smallestRepunitBivByK(k=k)
