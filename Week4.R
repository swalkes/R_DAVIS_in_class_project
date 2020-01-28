# week 4 

# factors as data
# factors: integers with a character name assigned to them 

sex <- as.factor(c("male", "female", "male", "male"))
sex
class(sex)
typeof(sex)

# reordering factors 
sex <- factor(sex,levels = c("male", "female"))
sex

# converting factors to characters 
as.character(sex)

year_fct <- as.factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct) #doesn't work for years; convert to characters first 
year_fct <- as.numeric(as.character(year_fct))


# renaming factors and levels within factors
levels(sex)
levels(sex)[1] # pulls out "males" from sex object
levels(sex)[1] <- "MALE" # capitalizes "male"

#rename to M and F
levels(sex)[1] <- "M"
levels(sex)[2] <- "F"
sex

# in one step 
levels(sex) <- c("M","F")
sex

# reorder levels so females come first
sex <- factor(sex,levels = c("F", "M"))
sex
levels(sex)


# starting with data 
surveys <- read.csv("data/portal_data_joined.csv") # this is a dataframe
class(surveys) # shows that "surveys" is a dataframe 
nrow(surveys) # shows how many rows are in the dataframe 
head(surveys) # show first 6 rows
colnames(surveys) # shows column names
summary(surveys) # gives summary of every column in the dataframe 
str(surveys)
surveys$species_id <- as.character(surveys$species_id)
str(surveys)

# pulling out unqiue identifiers in a column 
unique(surveys$species_id)
unique(surveys$species)

#indexing and subsetting dataframes 

# brackets have two dimensions for dataframes 
# [row, column]
surveys[1,1]


# first element in the sixth column 
surveys[1,6]

# pulls out third column 
surveys[,3]

#first three elements of the seventh column 
surveys[1:3, 7]

# all columns rows 1-6
surveys[1:6,]

# exclude the first column 
surveys[ ,-1] # - sign excludes the first row 
surveys[-c(7:34786),] # just the first 6 rows 

# can also call columns by names 
surveys[1:6,"species_id"]


surveys_200 <- surveys[200,] # subsets to just get the 20th row of the dataframe
nrow(surveys)
n_rows <-surveys[34786,]

tail(surveys)  # shows the last 6 rows of the dataframe
surveys_last <- surveys[n_rows,]

surveys_middle <-  surveys[nrow(surveys)/2,] 
surveys_middle

surveys[-c(7:nrow(surveys)),] # negative sign comes before the c()



# tidyverse
library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")
# character columns come in as characters instead of factors 
surveys 
# tibble = a dataframe that prints nicely 
# dbl = integer
# chr = character 
class(surveys)

# dplyer
# dplyer comes with tidyverse package and is useful for subsetting 
# dplyer introduced 'pipe' --> allows us to do multiple functions on the same dataframe at once

# select and filter 

#select is for columns; filter is for rows

surveys_new <- select(surveys, plot_id, species_id, weight)

filter(surveys, plot_id == 3)

# pipes 

# I want all weights greater than 5 and only the columns species_id, sex, and weight








