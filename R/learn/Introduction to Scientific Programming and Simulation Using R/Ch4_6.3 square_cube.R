n <- readline("Please enter an integer: n = ")
number <- c(1:n)
square <- number^2
cube <- number^3
result <- data.frame(number = number, square = square, cube = cube)
print(result)