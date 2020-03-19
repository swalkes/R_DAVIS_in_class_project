## week 8 data import and export

library(tidyverse)

species.dot <- read.csv("data/species.csv")
species.dot # not a tibble from tidyverse 
species_underscore <- read_csv("data/species.csv")
species_underscore

str(species.dot)
species.dot2 <- read.csv("data/species.csv", stringsAsFactors = FALSE)
str(species.dot2) # changes factors to characters 

# reading in a semicolon separated file 
# read.csv(sep = ";") or read.csv2()
# read_csv and read.csv are specialized functions of the command "read.table" 

read_csv("data/wide_eg.csv") #file read in weirdly 
read_csv("data/wide_eg.csv", skip = 2) # skips first two lines of the csv and makes the third line the column headers
# read_cvs command can read in files directly from a website if the links ends in ".csv" 

#exporting a csv
write_csv(x = species.dot, path = "data/data_output/species_dot_written.csv") # include file extension in file name

#.rda and .rds files 

#.rda can store multiple objects in it; eg. multiple dataframes 
save(species.dot2, species_underscore, file = "data/data_output/species_dataframes.rda")
load(file = "data/data_output/species_dataframes.rda") # re-loads .rda file; loads objects as they were before

#rds stores only a single object
saveRDS(species_underscore, file = "data/data_output/species_underscore.rds")
new_species_underscore <- readRDS(file = "data/data_output/species_underscore.rds") #reads file back in, assign a new object 

# saving plots 
surveys <- read_csv("data/portal_data_joined.csv")
library(ggplot2)
surveys %>%
  ggplot(aes(x = year, y = hindfoot_length, color = genus)) +
  geom_jitter()
ggsave(filename = "images/surveys_hindfoot_year_species.jpeg", width = 6, height = 6) # make sure to specify filetype


# some cool packages: 
#readxl:: # reads in excel files 
#googlesheets4:: # allows you to access google drive and pull data in from googlesheets 
#foregin:: # allows R to read in "weird" datasets like SPSS
#rio:: # import and export diferent file types, don't need to specify extensions   

  
# Datetimes in R

#Three basic time classes in R
#1. Date: just for dates (eg 2/25/2020)
#2. Datetime: POSIXxt best for dates with times 
#3. POSIXlt

# when you enter your data, enter it in separate columns for year, month, day, and time 

sample_dates_1 <- c("2019-02-01", "2019-03-21", "2020-02-25", "2019-04-04")
sample_dates_1 <- as.Date(sample_dates_1) # only works nicely bc the formant in sample_dates_1 is the format R looks for

#Format R looks for yyyy mm dd
sample_dates_2 <- c("02-25-2020", "04-04-1988", "12-13-1989","01-2-1993")
sample_dates_2 <- as.Date(sample_dates_2) #error!!! 
  
sample_dates_2 <- as.Date(sample_dates_2, format = "%m-%d-%Y") # gives R the correct format, and allows it to find dates

#see less for cheatsheet
murica <- c("Jul 04, 2019")
as.Date(murica, format = "%b %d, %Y") #b = "Jul"; from cheatsheet

time <- c("2016-07-24 22:55:01", "2013-04-12 18:50:11")
#Nice format, YYYY MM DD, HH:MM:SS this is what R is looking for

time <- as.POSIXct(time)

# R is set to to local timezone "tz" sets timezome 
time <- as.POSIXct(time, tz ="GMT")
