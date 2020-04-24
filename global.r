library(tidyverse)

theme_set(theme_light())

filter_df <- function(.df, .playerid, .tour){
  .df %>% 
    filter(PlayerID == .playerid, Tournament == .tour)
}


phys_pca <- readRDS("data/phys_pca.rda") 
ment_pca <- readRDS("data/ment_pca.rda")
rpe <- readRDS("data/rpe2.rda")
  
source("R/slider.R")
source("R/bargraph.R")
source("R/timeseries.R")
source("R/trainingTime.R")
source("R/which_tournament_training_for.R")