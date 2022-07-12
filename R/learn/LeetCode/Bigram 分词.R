
findOcurrences <- function(text, first, second){
  
  text <- strsplit(text, split = " ")
  text <- text[[1]]
  
  first.num <- which(text == first)
  second.num <- first.num+1
  third <- rep(NA, length(first.num))
  for(i in 1:length(first.num)){
    if(text[second.num[i]] == second){
      third[i] <- text[second.num[i]+1]
    }
  }
  third <- na.omit(third)
  print(third)
}


text <- "alice is a good girl she is a good student"
first <- "a"
second <- "good"

findOcurrences(text = text, first = first, second = second)