# PCA1: sleep (SleepQuality + Fatigue + Soreness + SleepHours)
# PCA2: health (Pain + Illness + Menstration + Illness)


readRDS("data/physical_fatigue.rda") %>% 
  select(PlayerID, Date,
         sleep = PCA1, 
         health = PCA2) %>% 
  gather("PCA", "value", sleep:health) %>% 
  arrange(PlayerID, Date) %>% 
  mutate(Tournament = which_tournament_training_for(Date))
  # saveRDS("data/phys_pca.rda")
