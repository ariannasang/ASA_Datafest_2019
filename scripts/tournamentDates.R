library(tidyverse)
games <- readRDS("data/games.rda")

tdates <- games %>% 
  select(Date, Tournament) %>% 
  arrange(Date) %>% 
  group_by(Tournament) %>% 
  summarize(startDate = first(Date),
            endDate = last(Date)) %>% 
  ungroup() %>% 
  arrange(endDate)

saveRDS(tdates, "data/tournamentDates.rda")
