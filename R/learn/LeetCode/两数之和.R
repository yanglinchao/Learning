TwoSum <- function(nums, target){
  
  nums.new <- nums[which(nums < target)]
  nums.new <- sort(nums.new)
  
  while(nums.new[1]+nums.new[length(nums.new)] > target) nums.new <- nums.new[-length(nums.new)]
  
  for(i in 1:length(nums.new)){
    
    a <- nums.new[i]
    b <- target-a
    
    if(b %in% nums.new == TRUE){
      aa <- a
      bb <- b
    }
  }
  
  a.s <- which(nums==aa)
  b.s <- which(nums==bb)
  result <- sort(c(a.s, b.s))
  print(result)
}

nums <- c(2, 7, 11, 15)
target <- 9
TwoSum(nums = nums, target = target)