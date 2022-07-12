lengthOfLastWord <- function(s){

  s <- strsplit(s, split = " ")[[1]]
  last <- s[length(s)]
  last.length <- length(strsplit(last, split = "")[[1]])
  print(last.length)
}
s = "hiauhbga auiha aihgoa"
lengthOfLastWord(s = s)