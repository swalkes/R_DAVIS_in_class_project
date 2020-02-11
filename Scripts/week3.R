## week 2 hw review ## 

![File Path Image](images/file_path.png)

# this will not run in R and causes an error message

# need to add images to github for it to recognize this image path

# pull every time you start a new project

## week 3 - how r thinks about data ##

# vectors: 

x <- 5 

# x is a vector of one value, build longer vectors with the "c" function 

weight_g <- c(50, 60, 65, 82)

animals <- c("mouse","rat","dog") # separate characters by commas and enclose in quotation marks 

# every element in a vector must be the same type of data 
class(weight_g) # numeric
class(animals) # character 
str(weight_g) # structure function; gives us basic information about how the vector is structured
str(animals)

# we can modify vectors with the c() function
weight_g <- c(weight_g,90) # adds the value 90 to the weight_g vector 
# or 
weight_g <- c(30, weight_g)

# atomic vectors: simplest datastructure R has, linear vector with just one type of data
# atomic vector includes, numeric, character, logical (T/F), integer (only whole numbers, denoted w/ "L")
class(1:10) # colon a shortcut to create a sequence 
x <- (1:10)
class(x)
# TRUE is 1, FALSE is 0
num_logical <- c(1, 2, 3, TRUE)
class(num_logical)

# coersion challenge; R will change values so that all values in the vector are the same datatype 
# a single character will change the whole vector characters
# characters are the least picky data type; logical is the most picky data type

# subsetting vectors 
animals <- c("mouse", "rat", "dog", "cat")
animals[2] # returns "rat" --> when you subset a vector, you get smaller vectors back 
animals[c(3,2)] # gives multiple index values to subset 
animals[c(3, 2, 3, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)] # possible to give more index values than initial vector
#entires start at 1, not 0 

#conditional subsetting 
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)] # returns only the entries in weight that have "TRUE" with them 
weight_g > 50 # returns which values in weight_g are greater than 50 
weight_g[weight_g > 50]

#multiple operations at once 
weight_g[weight_g < 30 | weight_g > 50] # | = "or"... "i want the values of weight_g that are < 30 OR > 50
animals 
animals[animals == "cat" | animals == "rat"]
animals %in% c("mouse", "rat") # show which values from animals are found in "mouse and rats"
animals[animals %in% c("mouse", "rat")]

# characters are ranked in alphabetical order

# vector math
x <- (1:10)
x + 3 # adds 3 to each element 
x*10 # multiples each element by 10
y <- (100:109)
x + y
z <- (1:2)
x + z # "vector recycling" --> recycles the shorter vector until it reaches the length of the longer vector
z <- (1:3) 
x + z # gives warning when the longer object length is not a multiple of the shorter object length
a <- (x+z)
a # partially recycles the shorter vector
length(z) # gives the length of the vector

#recycling with conditional subsetting 
x[c(TRUE, FALSE, TRUE)] 



# working with missing data 
# represented as NAs 
heights <- c(2, 4, 4, NA, 6)

mean(heights) # can't calcuate mean bc of the NAs 
#na.rm = NA Remove 
mean(heights, na.rm = TRUE) 
max(heights, na.rm = TRUE)

#is.na = Is it an NA?
is.na(heights)

#! = is not
!is.na(heights) # is it not an NA? 
heights[!is.na(heights)] # returns elements that aren't NAs

#complete.cases = extracts all the elements that are complete cases (values that are not NAs in our case)
heights[complete.cases(heights)]

anaconda_length <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
complete_lengths <- anaconda_length[complete.cases(anaconda_length)]
median(complete_lengths)
long_bois <- complete_lengths[complete_lengths > 67]
length(long_bois) 
# or 
length(long_bois[long_bois > 67])


## other data structures

# lists are a bunch of vectors put together, and each one can be a different length 
# dataframes 
# matrices = length x width 
# array = 3 dimensional 
# factors used to represent categorical data; integer vectors with variables attached to them 
sex <- factor(c("male", "female", "female", "female", "male"))
class(sex)
typeof(sex)
levels(sex)
nlevels(sex)

#specify the order of the levels 
sex <- factor(sex, levels = c("male", "female"))

#making factors into characters 
sex_ch <- as.character(sex)