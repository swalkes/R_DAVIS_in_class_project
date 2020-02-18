# R Davis week 3 hw
# Sam Walkes



## generating the data
set.seed(15)
hw3 <- runif(50, 4, 50)
hw3 <- replace(hw3, c(4,12,22,27), NA)
hw3


##Problem 1
hw3_rm <- hw3[complete.cases(hw3)]
prob1 <- hw3_rm[hw3_rm < 38 & hw3_rm > 14]
prob1

##Problem 2
times3 <- prob1*3
plus10 <- times3 + 10
plus10


##Problem3 
Final  <- plus10[c(TRUE, FALSE)]
