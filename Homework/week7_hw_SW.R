library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
years <- c("2002", "2003", "2004", "2005", "2006", "2007")
gapminder_years <- gapminder %>%
  filter(complete.cases(.)) %>%
  group_by(country, continent, year, pop)


## creates dataframe with years as columns
gapminder_wide <- gapminder %>%
  filter(!is.na(pop)) %>% 
  group_by(country, continent, year) %>% 
  summarise(pop) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  arrange(country)

# creates object subtracting 2002 pop from 2007
difference <- (gapminder_wide$"2007" - gapminder_wide$"2002")

# creates new column of the vector oject 
gapminder_wide$pop_diff <- c(difference)  

# Africa plot
Africa <-  gapminder_wide %>% 
  filter(continent == "Africa") %>%
  ggplot(mapping = aes(x = reorder(country, pop_diff), y = pop_diff)) +
  geom_bar(stat = "identity", fill = "darkorchid4") +
    xlab("") +
    ylab("") + 
    facet_wrap(~ continent) +
    theme_bw() + 
    theme(axis.text.x = element_text(angle = 70, vjust = 0.5))
    
# Americas plot
America <- gapminder_wide %>%
  filter(continent == "Americas") %>%
  ggplot(mapping = aes(x = reorder(country, pop_diff), y = pop_diff)) +
  geom_bar(stat = "identity", fill = "dodgerblue4") +
  xlab("") +
  ylab("") + 
  facet_wrap(~ continent) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

# Asia plot
Asia <- gapminder_wide %>%
  filter(continent == "Asia") %>%
  ggplot(mapping = aes(x = reorder(country, pop_diff), y = pop_diff)) +
  geom_bar(stat = "identity", fill = "green4") +
  xlab("") +
  ylab("") + 
  facet_wrap(~ continent) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

# Europe plot
Europe <- gapminder_wide %>%
  filter(continent == "Europe") %>%
  ggplot(mapping = aes(x = reorder(country, pop_diff), y = pop_diff)) +
  geom_bar(stat = "identity", fill = "yellow2") +
  xlab("") +
  ylab("") + 
  facet_wrap(~ continent) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

library(cowplot)
cowplot <- plot_grid(Africa, America, Asia, Europe) +
  draw_label("Country", x=0.5, y=  0, vjust=-0.5, angle= 0) +
  draw_label("Change in Population Between 2002 and 2007", x=  0, y=0.5, vjust= 1.5, angle=90)
cowplot



## could also be done in fewer lines of code:

gapminder <- read_csv("data/gapminder.csv")

pg <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(pop_change_0207 = `2007` - `2002`)

pg %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x = reorder(country, pop_change_0207), y = pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") + 
  theme_bw() +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") +
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007")
