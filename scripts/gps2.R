library(tidyverse)

games <- readRDS("data/games.rda")
x <- games %>% 
  select(GameID, Date, Tournament)

gps <- readRDS("data/gps.rda") 
  
gps %>% 
  inner_join(gps, x, by = "GameID") 
  # saveRDS("data/gps.rda")

  