strStr <- function(haystack, needle){
  
  if(length(needle)==0){
    
    print("0")
    
  }else{
    
    haystack <- strsplit(haystack, split = "")[[1]]
    needle <- strsplit(needle, split = "")[[1]]
    needle.contact <- paste(needle, collapse = "")
    
    haystack.contact <- c()
    for(i in 1:(length(haystack)-length(needle)+1)){
      haystack.contact <- rbind(haystack.contact, paste(haystack[i:(i+length(needle)-1)], collapse = ""))
    }
    
    for(i in 1:length(haystack.contact)){
      if(haystack.contact[i]==needle.contact){
        print((i-1))
      }
      if(sum(haystack.contact==needle.contact)==0){
        print(-1)
      }
      
    }
    
  }
}

haystack = "hello"
needle = "ll"
strStr(haystack = haystack, needle = needle)