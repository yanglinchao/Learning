searchInsert <- function(nums, target){
  
  n <- length(nums)
  
  left <- 1
  right <- n
  
  if(target>max(nums)){
    print(length(nums)+1)
  }else if(target<min(nums)){
    print(1)
  }else{
    while(left <= right){
      middle <- left + trunc((right-left)/2)
      if(nums[middle] > target){
        right <- middle-1
      }else if(nums[middle] < target){
        left <- middle+1
      }else{
        print(middle)
        break
      }
      
    }
    print(trunc(middle))
  }
}

nums = c(1, 3, 5, 6)
target = 9
searchInsert(nums = nums, target = target)