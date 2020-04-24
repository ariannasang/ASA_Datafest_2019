rpe %>% 
  mutate(Tournament = which_tournament_training_for(Date)) %>% 
  saveRDS("data/rpe2.rda")
