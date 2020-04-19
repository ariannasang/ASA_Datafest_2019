setwd("C:\Users\asang\Desktop\Datafest2019")


library(readr)
games <- read.csv("games.csv")
gps <- read.csv("gps.csv")
rpe <- read.csv("rpe.csv")
wellness <- read.csv("wellness.csv")

library(dplyr)
sub_games <- games %>% head(100)
sub_gps <- gps %>% head(100)
sub_rpe <- rpe %>% head(100)
sub_wellness <- wellness %>% head(100)

# Missing Data
colSums(is.na(games))
colSums(is.na(gps)) # Longitude: 1,515,243 NA
colSums(is.na(rpe)) # 11/14 variables w NA
colSums(is.na(wellness)) # 5/19 variables w NA

library(VIM)

# rpe
colSums(is.na(rpe)) # 11/14 variables w NA
matrixplot(rpe) 

## If Training is No(white), then SessionType until AcuteLoad is missing and 
## ObjectiveRating and FocusRating is missing. 
rpe_train <- rpe %>% filter(Training=="Yes")
rpe_not_train <- rpe %>% filter(Training=="No")

rpe %>% count(PlayerID, Training) %>% View()
matrixplot(rpe_train)
matrixplot(rpe_not_train)

View(rpe_train)

## rpe_train: Variables to keep Date, PlayerID, SessionType, Duration,
## RPE, 


# Longitude is complete every 100 values
str(gps)
gps %>% 
  as_tibble %>% 
  filter(GameID == 14, PlayerID == 1, FrameID %% 100 ==0) %>% 
  filter(is.na(Latitude))
count(GameID, PlayerID, sort = TRUE)
  
# Scaling data for rpe and wellness
  
## How many player are there?

  
  
  
  
