# Week 7

# hw review
library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
gapminder %>% rename(Continent = continent) # renames continent column 

# ggplot continued 
# load survey data 

surveys_complete <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.)) # period means all columns 

yearly_counts <- surveys_complete %>%
  count(year, species_id)



ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() # connects all the points, bad!!

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) + geom_line(aes(color = species_id)) 
  # separates lines and colors them 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) + geom_line() 
  # group = groups species id without coloring them differently 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, linetype = species_id)) + geom_line()
  # changes line type for species_id



ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = species_id)) + geom_line()
  # still difficult to read
  # use Faceting 
  # faceting groups by a categorical variable and creates a single graph for each variable 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() + 
  facet_wrap(~ species_id)

# creating a graph with different colors for males and females within in each facet graphs
sexy_counts <- surveys_complete %>%
  count(year, species_id, sex) # count = group by and tally in one step and ungroups  

ggplot(data = sexy_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() + 
  facet_wrap(~ species_id) + 
  theme_few()

# https://ggplot2.tidyverse.org/reference/ggtheme.html


ggplot(data = sexy_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() + 
  facet_wrap(~ species_id) +
  theme_bw()


# visualization dos and don'ts
# lollipop plot instead of barchart
# pie charts suck 
# difficult to intepret area --> less is more 
# scale_color_colorblind()  --> colorblind friendly color scales (categorical) 
# viridis --> continuous colorblind friendly color schemes 
# consider what each element of your plot is adding to its story

# do 
#Label appropriately and legibly, including axes, and use text to highlight important bits
#Use one color to represent each category, consider colorblind/BW friendly palettes
#Order datasets using logical heirarchy (Make it easy for reader to compare values)
#Use icons when possible to reduce unnecessary labeling
#Pay attention to scale (e.g., start axis at zero not 2.4 to 3.5)
#Include your data/outliers where possible 

# don't 
#Don’t try to add too much into one plot…keep it simple
#Don’t add color uncessarily unless it provides a specific function
#Avoid high contrast colors (red/green or blue/yellow)
#Don’t use 3D charts. They can make it hard to discern or perceive the actual information.
#Avoid ornamentation (shadowing, extra illustration, etc)
#Avoid more than 6 categorical colors in a layout unless you looking at continuous data.
#Keep fonts simple (avoid uncessary bold or italicization)
#Don’t try to compare too many categories or data types in one chart

# intro to publishing plots with cowplot
#install.packages("cowplot")
library(cowplot)
# combines existing ggplot to publish 

plot.diamonds <- diamonds %>% # saves plot as an object for combining them
  ggplot(aes(x = clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5)) # angle, slants the text; vjust = verticle adjustment of text

plot.cars <- mtcars %>%
  ggplot(aes(x = wt, y = mpg, color = factor(cyl))) +
           geom_point(size =2) +
           theme_minimal()
  
plot.cars2 <- mpg %>%
  ggplot(aes(x = cty, y = hwy, color = factor(manufacturer))) +
  geom_point() + 
  theme_minimal()

# new using cowplots to sticth them together 
cowplot <- plot_grid(plot.cars, plot.diamonds, plot.cars2, labels = c("A","B","C"))

#patchwork is another package that allows for plots to be stitched together

#plotly for interactive plots 
#install.packages("plotly")
library(plotly)

# any object saved in ggplot can be sent into "ggplotly"
# end product is an interactive plot of the data 
plotly::ggplotly(plot.diamonds) #useful for analyzing your own figures!



#trendlines 
ggplot(mtcars, aes(x =wt, y = mpg)) + 
  geom_point() +
  geom_smooth(method = "lm") + # adds trendline 
  theme(axis.title.x = element_text(size = 16)) # changes x axis text size

