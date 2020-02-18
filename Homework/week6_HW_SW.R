

# Problem 1
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

gapminder_means <- gapminder %>%
  group_by(continent, year) %>% 
  summarise(meanlifeExp = mean(lifeExp, na.rm = TRUE))

ggplot(data = gapminder_means,
       mapping = aes (x = year, y = meanlifeExp)) + 
  geom_point(aes(color = continent))


# Problem 2
# scale_x_log10() sets the x axis on a log scale
# geom_smooth creates the trend line

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = log(lifeExp))) +
  geom_point(aes(color = continent)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# Problem 3
countries <- c("Brazil", "China", "El Salvador", "Niger", "United States")
gapminder_filtered <- gapminder %>% 
  filter(country %in% countries)

gapminder_filtered %>% 
  ggplot(mapping = aes(x = country, y = lifeExp)) + 
  geom_jitter(alpha = 0.3, aes()) +
  geom_boxplot() 