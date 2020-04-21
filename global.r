library(tidyverse)


filter_df <- function(.df, .playerid, .tour){
  .df %>% 
    filter(PlayerID == .playerid, Tournament == .tour)
}

df <- mtcars
df$car_name <- rownames(df)
rownames(df) <- NULL
df <- df %>% 
  select(car_name, cyl, vs, am, gear, carb) %>% 
  mutate_at(2:6, as.factor)

phys_pca <- readRDS("data/phys_pca.rda") 
ment_pca <- readRDS("data/ment_pca.rda")
  
source("R/slider.R")
source("R/bargraph.R")
source("R/timeseries.R")
source("R/which_tournament_training_for.R")