# PCA1: playerConfidence (trainingReadiness + FocusRating + ObjectiveRating)
# PCA2: playerMood (Irritability + Desire)


readRDS("data/mental_fatigue.rda") %>% 
  select(PlayerID, Date,
         confidence = PCA1, 
         mood = PCA2) %>% 
  gather("PCA", "value", confidence:mood) %>% 
  arrange(PlayerID, Date) %>% 
  mutate(Tournament = which_tournament_training_for(Date)) %>% 
  saveRDS("data/ment_pca.rda")
