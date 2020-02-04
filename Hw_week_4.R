## Sam Walkes
## hw week 4



# problem 1
surveys <- read.csv("data/portal_data_joined.csv")

# problem 2
survey_base <- surveys[,c("species_id","weight","plot_type")]
survey_base$species_id  <- as.character(survey_base$species_id)
survey_base$plot_type <- as.character(survey_base$plot_type)
survey_base_complete <- survey_base[complete.cases(survey_base), ]
challenge_base <- survey_base_complete[(survey_base_complete[, 2]>150),]

head(challenge_base)


# problem 3
surveys2 <- read_csv("data/portal_data_joined.csv")
surveys_tidy<- select(surveys2, species_id, hindfoot_length, year)
surveys_tidy2 <- na.omit(surveys_tidy)
surveys_100 <- surveys_tidy2[-c(100:nrow(surveys_tidy2)),]
challenge_tidy <- surveys_tidy2 %>%
  filter(species_id == "RM") %>%
  filter(year == "1997")







