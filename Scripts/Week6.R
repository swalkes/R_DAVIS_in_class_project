## R Davis week 6

## Starting with ggplot 

library(tidyverse)
surveys_complete <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.))  # "." tells the pipe to send its content there if there's nothing between the ()

## ggplot 
# pivot longer important for ggplot 

#basic ggplot building

# map shows ggplot how to visualize your data
# aes = what type of visualization you want 
# geom = geometry to express the data 

# ggplot(data = DATA, mapping = aes(MAPPINGS)) + geom_function()

ggplot(data = surveys_complete) # comes up blank 

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) # just axes

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()
  
# assigning part of a plot to an object 
surveys_plot <- ggplot(data = surveys_complete,   # press enter after commas to make code look more organized
                       mapping = aes(x = weight, 
                                     y = hindfoot_length))
surveys_plot + geom_point()  # having the object allows us to make changes and save typing

#anything inside the ggplot() function is universal to the whole plot. For example, geom_point() will
# pull data and information from ggplot()
# putting data and mapping inside geom_point() will only be applied to that particular geometry 

# modify a specific geom by itself 
ggplot(data = surveys_complete,
       mapping = aes (x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1) # changes the transparency of the points

ggplot(data = surveys_complete,
       mapping = aes (x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1, color = "blue") ## google for color names 

# separate color by species 
ggplot(data = surveys_complete,
       mapping = aes (x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1, aes(color = species_id)) # need to make new aesthetic call to separate color in geom shape

# can also include color within the ggplot call; that way ALL elements of the graph are colored by species
# for example, if we added trend lines, all of them could be colored by species too
ggplot(data = surveys_complete,
       mapping = aes (x = weight, y = hindfoot_length, color = species_id)) + 
  geom_point(alpha = 0.1)




## challenge problem: species id on x-axis, and weight on the y-axis


# scatter plot of weight and species id
ggplot(data = surveys_complete,
       mapping = aes (x = species_id, y = weight)) + 
  geom_point(aes(color = species_id))

# boxplot of weight and species id
ggplot(data = surveys_complete,
       mapping = aes (x = species_id, y = weight, color = plot_type)) + 
  geom_boxplot()

# alternatively.... 
surveys_complete %>% # tells ggplot that the dataframe is surveys_complete
  ggplot(mapping = aes(x = species_id, y = weight)) + 
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "brown") # takes each of the points and adds a bit of noise to each point so points don't overlap

# flip jitter and boxplot lines to change which one is in front 
surveys_complete %>% # tells ggplot that the dataframe is surveys_complete
  ggplot(mapping = aes(x = species_id, y = weight)) + 
  geom_jitter(alpha = 0.3, aes(color = plot_type)) +
  geom_boxplot() 

# challenge 
# 1) replace boxplot with violin plot 
surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) + 
  geom_jitter(alpha = 0.3, aes(color = plot_type)) +
  geom_violin()


# 2) represent weight on log scale

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id, y = weight)) + 
  geom_jitter(alpha = 0.3, aes(color = plot_type)) +
  geom_violin() +
  scale_y_log10()

# takes distribution of PF and NL hindfoot length
surveys_complete %>% 
  filter(species_id == c("NL","PF")) %>%  # or (species_id == "NL" | species_id == "PF")
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(mapping = aes(color = as.factor(plot_id), alpha = 0.3)) + # can set plot_id as a factor within ggplot
  geom_boxplot(fill = NA) # "fill" makes the middle of the boxplot transparent; "alpha =" also works 















