maxSubArray <- function(nums){
  
  n <- length(nums)
  
  for(i in 2:n){
    if(nums[i-1]>0) nums[i] <- nums[i-1] + nums[i]
  }
  print(max(nums))
}

nums <- c(-2, 1, -3, 4, -1, 2, 1, -5, 4)
maxSubArray(nums = nums)