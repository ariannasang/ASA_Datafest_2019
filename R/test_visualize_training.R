library(tidyverse)
library(lubridate)
theme_set(theme_light())

rpe <- readRDS("data/rpe.rda")
games <- readRDS("data/games.rda")

tdates <- games %>% 
  select(Date, Tournament) %>% 
  arrange(Date) %>% 
  group_by(Tournament) %>% 
  summarize(startDate = first(Date),
            endDate = last(Date)) %>% 
  ungroup() %>% 
  arrange(endDate)

what_tournament_training_for <- function(date){
  case_when(
    date < tdates$endDate[1] ~ tdates$Tournament[1],
    date < tdates$endDate[2] ~ tdates$Tournament[2],
    date < tdates$endDate[3] ~ tdates$Tournament[3],
    date < tdates$endDate[4] ~ tdates$Tournament[4],
    date < tdates$endDate[5] ~ tdates$Tournament[5],
    date < tdates$endDate[6] ~ tdates$Tournament[6],
    date < tdates$endDate[7] ~ tdates$Tournament[7],
    TRUE ~ as.character(NA)
    
  )
}

what_tournament_training_for(as_date("2018-01-29"))

rpe %>% 
  select(Date, PlayerID, SessionType, SessionLoad) %>% 
  filter(PlayerID == 1, !is.na(SessionType)) %>% 
  arrange(Date) %>% 
  
  count(SessionType) %>% 
  mutate(SessionType = fct_rev(SessionType)) %>% 
  ggplot() +
  geom_col(aes(SessionType, n)) +
  coord_flip() +
  labs(title = "Training Sessions",
       x = "",
       y = "")

