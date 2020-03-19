# Functions

# Any code used 3 or more times should be used as a function 
# prevents copy-pasting errors
# intro to writing functions

my_sum <- function(a, b){ # code goes between curly brackets and argument goes inside the parentheses
  the_sum <- a + b
  return(the_sum)
}

my_sum(a = 5, b = 10) # runs the function 

# function creates its own environment, separate from the global environment; need to given directly to the function
# for example, defining a and b outside of the funciton with assignment arrows won't work
a <- 20
b <- 2
# a and be need to be given as arguments "my_sum" can't find it from the global environment

my_sum2 <- function(a = 2, b = 5){  # sets default values for a and b
  the_sum <- a + b
  return(the_sum)
}
my_sum2()
my_sum2(12) # sets a as 12, b remains as the default
# default can reduce the amount of code you have to write with more complicated functions 

# functions to convert temperatures 
F_to_K <- function(temp){
  K <- (((temp - 32)* (5/9)) + 273.15)
  return(K)
}
F_to_K(32)


# source()-ing functions
source("functions.r") # source("file_path"); calls functions from other scripts, and then functions can be run


library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")


# making a function that returns a line plot of population over time for a single country in a country

# how to plot a single country
gapminder %>% 
  filter(country == "Afghanistan") %>%
  ggplot(aes(x = year, y = pop)) +
  geom_line()

# what in this function isn't generic?

pop_growth <- function(dataframe, plot_country){
    plot <- dataframe %>%
      filter(country == plot_country) %>%
    ggplot(dataframe, mapping = aes(x = year, y = pop)) +
    geom_line()
    return(plot)
}
pop_growth(dataframe = gapminder, plot_country = "Bulgaria")


# intro to iteration: 
x <- 1:10 
log(x)

#for loop; for each value of i, R does print()
for(i in 1:10) {
  print(i)
}

#multiple lines of code in one loop; for each value in i, R does print(i), followed by print(i^2)
for(i in 1:10){
  print(i)
  print(i^2)
}

# using i as an index to subset
for(i in 1:10){
  print(letters[i])
  print(mtcars$mpg[i])
}


# storing the results 
# create a vector that is the same size, and fill it in 
results <- rep(NA,nrow(mtcars)) # rep generates repeated values; nrow shows how many rows are in mtcars dataframe
# this generates a vector that is the same length as mtcars 
for(i in seq_along(results)){
  results[i] <- mtcars$wt[i] * 1000 #takes each weight value, multiples by 1000 and then addres to the results vector
  #no need for "return()" function because for loops don't create their own env.
}

# conditional statements
# for running code ONLY if certain conditions are met 

for(i in 1:10){
  if(i < 5) {
    print(paste(i, "Shrek")) # will paste "Shrek" if i is less than 5
  } else {
    print(paste(i, "Shrek2"))
  }
}

# case_when is a nested conditional
mtcars %>%
  mutate(car_size = case_when(
    wt > 3.5 ~"big", #"if wt is grater than 3.5, then I want cars to be big"
    wt > 2.5 ~ "medium", #statements do not overwrite each other and read from the top down
    TRUE ~ "small" # if they don't fit either category, then they're small
  ))

# can use multiple columns in the conditions 
mtcars %>%
  mutate(car_size = case_when(
    wt > 3.5 | cyl == 8 ~ "big",
    wt > 2.5 ~ "medium",
    TRUE ~ "small"
  ))

