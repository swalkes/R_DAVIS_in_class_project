# week 5 

surveys <- read_csv("data/portal_data_joined.csv")

#mutate function 
# making new columns based on columns that already exist in the dataframe 

surveys_mut <- surveys %>%   
  mutate(weight_kg = weight/1000)  # adds new column "weight_kg" to the end of the surveys dataframe 

surveys_mut <- surveys %>%   
  mutate(weight_kg = weight/1000, weight_kg2 = weight_kg*2)  # adds 2 new columns to the surveys dataframe 

surveys_mut2 <- surveys %>% 
  filter(!is.na(weight)) %>%
  filter(species_id != "NL") %>%  # filters for all species that aren't NL
  mutate(weight_kg = weight/1000)

unique(surveys_mut2$species_id) # shows that NL has been removed

## challenge 
surveys_exercise <- surveys %>%
  mutate(hindfoot_half = hindfoot_length/2) %>%
  filter(!is.na(hindfoot_half)) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)
  
## split, apply, combine
# takes two different functions, group_by, and summarize 

surveys_group <- surveys %>%
  group_by(sex) %>% # groups data by weight
  summarise(mean_weight = mean(weight, na.rm = TRUE)) # calculates mean by using weight column, but need to remove NAs
  
surveys_summarized <- surveys %>%
  group_by(sex,species_id) %>% # groups data by weight
  summarise(mean_weight = mean(weight, na.rm = TRUE))

# calculate multiple things within a summarize function 
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE), min(weight, na.rm=TRUE))

# difference between summarize and mutate?  
sum_surveys <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

mut_surveys <- surveys %>%
  group_by(sex, species_id) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE))
  
# mutate appends new column to our original dataframe, summarize creates new, smaller dataframe

# you can summarize on multiple things 
multiple <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(min_weight = min(weight),
            max_weight = max(weight)) %>% 
            ungroup(mult)

# joins 
# jenny bryan super hero tutorial for joins is a useful resource 
tail <- read_csv("data/tail_length.csv")
tail
summary(surveys$record_id)
summary(tail$record_id)  # shows record_id is the same length and match up well 

# basic structure of a join
# join_function(first_data, second_data, by = column_to_join_by), columns must be named the same thing 
# left join returns all of the rows in the first table by all of the columns from both dataframes 

surveys_joined <- left_join(surveys, tail, by = "record_id")

NL_data <- surveys %>%
  filter(species_id == "NL")
NL_data

left_join(NL_data, tail, by = "record_id") # joins data from tail to NL_data dataframe and only pulls data that has "NL"

# joining by multiple columns 
# join_function(first_Data, second_data, by = c("year", "month", "day"))

# pivoting with tdyr
surveys_mz <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarise(mean_weight = mean(weight))

str(surveys_mz)

# goal is to have a column for every genus
unique(surveys_mz$genus) # prints each genus in the dataframe
n_distinct(surveys_mz$genus) # need to create 10 columns
n_distinct(surveys_mz$plot_id) # need to create 24 rows 

wide_survey <- surveys_mz %>%
  pivot_wider(names_from = "genus", values_from = "mean_weight") # what columns in surveys_mz do we get the names from?
                                                                # moves weight to each column for genus

# pivoting from wide (above format) to long (format that R likes it)
# which columns do we want to collapse into one column?

longer_surveys <- wide_survey %>% 
  pivot_longer(cols = -plot_id, names_to = "genus",
               values_to = "mean_weight") 
# "-plot_id" causes all plots except for plot_id should be collapsed into one column 
  






