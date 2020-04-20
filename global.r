library(tidyverse)

df <- mtcars
df$car_name <- rownames(df)
rownames(df) <- NULL
df <- df %>% 
  select(car_name, cyl, vs, am, gear, carb) %>% 
  mutate_at(2:6, as.factor)

phys_pca <- readRDS("data/physical_fatigue.rda") %>% 
  select(PlayerID, Date, contains("PCA")) %>% 
  gather("PCA", "value", PCA1:PCA2) 

ment_pca <- readRDS("data/mental_fatigue.rda") %>%
  select(PlayerID, Date, contains("PCA")) %>% 
  gather("PCA", "value", PCA1:PCA2) 
  
source("R/slider.r")
source("R/bargraph.r")
source("R/timeseries.r")