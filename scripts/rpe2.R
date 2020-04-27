readRDS("data/rpe.rda") %>% 
  mutate(Tournament = which_tournament_training_for(Date)) %>% 
  mutate(SessionType = factor(SessionType, 
                              levels = c("Mobility/Recovery", "Game", "Skills", "Conditioning", "Strength", 
                                         "Combat", "Speed"),
                              labels = c("Mobility/Recovery", "Game", "Skills", "Conditioning", "Strength", 
                                         "Combat", "Speed"))
  ) %>% 
  saveRDS("data/rpe2.rda")
