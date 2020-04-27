library(tidyverse)
library(gganimate)
library(gifski)
library(png)

theme_set(theme_light())
options(gganimate.dev_args = list(width = 375, height = 410))

filter_df <- function(.df, .playerid, .tour, .limit21 = FALSE){
  rez <- .df %>% 
    filter(PlayerID == .playerid, Tournament == .tour)
  
  last21_days <- rez %>% 
    distinct(Date) %>% 
    arrange(Date) %>% 
    tail(21)
  
  if(.limit21){
    return(rez %>% right_join(last21_days, by = "Date"))
  } else {
    return(rez)
  }
}


phys_pca <- readRDS("data/phys_pca.rda") 
ment_pca <- readRDS("data/ment_pca.rda")
rpe <- readRDS("data/rpe2.rda")
gps <- readRDS("data/gps2.rda")
games <- readRDS("data/games.rda")

source("R/timeSeries.R")
source("R/trainingTime.R")
source("R/playerMovement.R")
source("R/which_tournament_training_for.R")