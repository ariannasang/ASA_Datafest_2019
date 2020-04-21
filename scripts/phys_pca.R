readRDS("data/physical_fatigue.rda") %>% 
  select(PlayerID, Date, contains("PCA")) %>% 
  gather("PCA", "value", PCA1:PCA2) %>%  
  arrange(PlayerID, Date) %>% 
  mutate(Tournament = which_tournament_training_for(Date)) %>% 
  saveRDS("data/phys_pca.rda")
