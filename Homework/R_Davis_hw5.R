
# question 1
surveys <- read_csv("data/portal_data_joined.csv")
head(surveys)

# question 2
surveys_2 <- surveys %>%
  filter(weight >= 30) %>%
  filter(weight <= 60)


# question 3
big_critters <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(max_weight = max(weight))

# question 4
surveys %>%
  group_by(species) %>%
  tally() %>%
  arrange(desc(n))

# question 5







