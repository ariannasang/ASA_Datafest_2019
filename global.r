library(tidyverse)

df <- mtcars
df$car_name <- rownames(df)
rownames(df) <- NULL
df <- df %>% 
  select(car_name, cyl, vs, am, gear, carb) %>% 
  mutate_at(2:6, as.factor)



source("R/slider.r")
source("R/bargraph.r")