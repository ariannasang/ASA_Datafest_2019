library(tidyverse)
library(gganimate)
library(gifski)
library(png)
theme_set(theme_bw())

gps <- readRDS("data/gps.rda")

one_game <- gps %>%
  select(GameID, PlayerID, FrameID, GameClock, Longitude, Latitude) %>% 
  filter(GameID == 20, PlayerID == 8, FrameID %% 10 == 0, !is.na(Longitude)) %>% 
  select(FrameID, contains("tude"))
  
p <- one_game %>% 
  ggplot() +
  geom_point(aes(x = Longitude, y = Latitude)) 
  
p
p_move <- p + transition_time(FrameID)
anim_save("www/move.gif", p_move)
