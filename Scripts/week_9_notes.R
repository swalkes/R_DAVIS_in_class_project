## working with Date Times in R using lubridate package


library(tidyverse)
library(lubridate)

nfy1 <- read_csv("data/2015_NFY_solinst.csv", skip = 12)
sample_dates <- c("07-15-2019", "12-24-2018", "03-30-1997", "03-30-1996")

sample_dates <- as.Date(sample_dates, format = "%m-%d-%Y")

dt <- c("07-15-2019 14:32:09", "12-24-2018 12:40:01")

# use as.POSIXct with time data
dt <- as.POSIXct(dt, format = "%m-%d-%Y %H:%M:%S")

# use tz to set a timezone  ??????
dt <- as.POSIXct(dt, format = "%m-%d-%Y %H:%M:%S", tz = "GMT")


#Lubridate
sample_dates <- c("07-15-2019", "12-24-2018", "03-30-1997", "03-30-1996")
dates_lubridate <- lubridate::mdy(sample_dates)

sample_dates2 <- c("5A06A17 14:22", "8A17A13 6:33")

# Can tell lubridate what the format of your dates are; mdy_hm = "month day year hour minute
sample_dates2_lub <- mdy_hm(sample_dates2)

head(nfy1)
# Generally, you do not want tidyverse to try and read in dates automatically. Can lead to mistakes 
# read in as character
# can specify what columns are what when you read in the csv
nfy1 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd")

head(nfy1)

# merges date and time column into one column with a space between them
nfy1$Datetime <- paste(nfy1$Date, nfy1$Time, sep = " ")
head(nfy1)

#use lubridate to convert datetime column into POSIXct
nfy1$Datetime2 <- mdy_hms(nfy1$Datetime, tz = "GMT")

#shows the timzeone
tz(nfy1$Datetime2)

#downloding Mana Loa Data
summary(mloa_2001)

names(mloa_2001)
# put 2 columns into one column; "-" inserts a dash between the 2 original columns
mloa_2001$Datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day,"",
                             mloa_2001$hour24, ":", mloa_2001$min)
# tell R that this is a date-time column 
mloa_2001$Datetime <- ymd_hms(mloa_2001$Datetime, tz = "Pacific/Honolulu")
tz(mloa_2001$Datetime)
