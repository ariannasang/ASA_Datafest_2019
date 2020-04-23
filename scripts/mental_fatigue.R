# Principal Components analysis on mental fatigue

wellness <- readRDS("data/wellness.rda")
rpe <- readRDS("data/rpe.rda")
colSums(is.na(wellness))
colSums(is.na(rpe))

library(lubridate)

wellness_mental_fatigue <- wellness %>%
  select(Date, PlayerID, Desire, Irritability, TrainingReadiness) %>% 
  mutate(Date = as.Date(Date))

rpe_mental_fatique <- rpe %>%
  select(Date, PlayerID, ObjectiveRating, FocusRating) %>% 
  mutate(Date = as.Date(Date))

mental_fatigue <- full_join(wellness_mental_fatigue, rpe_mental_fatique, by = c("Date", "PlayerID"))
mental_fatigue <- distinct(mental_fatigue, Date, PlayerID, .keep_all = T)

# Data Management
mental_fatigue$TrainingReadiness <- as.character(mental_fatigue$TrainingReadiness)

library(stringr)
mental_fatigue$TrainingReadiness <- sapply(mental_fatigue$TrainingReadiness, str_extract_all, "[[:digit:]]+") %>%
  unlist() %>% 
  as.numeric()

# Impute missing values
library(mice)
md.pattern(mental_fatigue)
imputed_Data <- mice(mental_fatigue, m=5, maxit = 50, method = 'pmm', seed = 500)
str(imputed_Data)

imp.mental_fatigue<- complete(imputed_Data, 1)

# Center and scale
scaled.mental_fatigue <- imp.mental_fatigue %>%
  group_by(PlayerID) %>%
  mutate(mean_Desire = mean(Desire),
         mean_Irritability = mean(Irritability),
         mean_TR = mean(TrainingReadiness),
         mean_OR = mean(ObjectiveRating),
         mean_FR = mean(FocusRating)) %>% 
  mutate(sd_Desire = sd(Desire),
         sd_Irritability = sd(Irritability),
         sd_TR = sd(TrainingReadiness),
         sd_OR = sd(ObjectiveRating),
         sd_FR = sd(FocusRating)) %>%
  mutate(Desire = (Desire - mean_Desire)/sd_Desire,
         Irritability = (Irritability - mean_Irritability)/sd_Irritability,
         TrainingReadiness = (TrainingReadiness - mean_TR)/sd_TR,
         ObjectiveRating = (ObjectiveRating - mean_OR)/sd_OR,
         FocusRating = (FocusRating - mean_FR)/sd_FR) %>%
  select(1:7)

# Run PCA
physical.pca <-  prcomp(scaled.mental_fatigue[3:7], center = TRUE,scale. = TRUE)
biplot(physical.pca)

# PCA1: playerConfidence (trainingReadiness + FocusRating + ObjectiveRating)
# PCA2: playerMood (Irritability + Desire)

scaled.mental_fatigue$PCA1 <- physical.pca$x[, 1]
scaled.mental_fatigue$PCA2 <- physical.pca$x[, 2]

scaled.mental_fatigue %>%
  select(1:9) 
  # saveRDS("mental_fatigue.rda")
