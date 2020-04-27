# Principal Components Analysis on physical fatigue
wellness <- readRDS("data/wellness.rda")

physical_data <- wellness %>%
  select(Date, PlayerID, Fatigue, Soreness, SleepHours, SleepQuality, 
         Pain, Illness, Menstruation, Nutrition) %>%
  mutate(Pain = ifelse(Pain == "Yes", 1, 0),
         Illness = ifelse(Illness =="Yes",1,0),
         Menstruation = ifelse(Menstruation == "Yes",1 ,0),
         Nutrition = ifelse(Nutrition == "Okay" | Nutrition == "Excellent", 1, 0))

## Impute missing values for menstruation and nutrition
library(mice)
md.pattern(physical_data)
imputed_Data <- mice(physical_data, m=5, maxit = 50, method = 'pmm', seed = 500)
str(imputed_Data)


imp.physical_fatigue<- complete(imputed_Data, 1)


## Center and scale 
scaled.physical_fatigue <- imp.physical_fatigue %>%
  group_by(PlayerID) %>%
  mutate(mean_Fatigue = mean(Fatigue),
         mean_Soreness = mean(Soreness),
         mean_SleepHours = mean(SleepHours),
         mean_SleepQuality = mean(SleepQuality)) %>%
  mutate(sd_Fatigue = sd(Fatigue),
         sd_Soreness = sd(Soreness),
         sd_SleepHours = sd(SleepHours),
         sd_SleepQuality = sd(SleepQuality)) %>% 
  mutate(Fatigue = (Fatigue - mean_Fatigue)/sd_Fatigue,
         Soreness = (Soreness - mean_Soreness)/sd_Soreness,
         SleepHours = (SleepHours - mean_SleepHours)/sd_SleepHours,
         SleepQuality = (SleepQuality - mean_SleepQuality)/sd_SleepQuality) %>%
  mutate(Pain = ifelse(Pain==1, 0, 1),
         Illness = ifelse(Illness==1, 0,1),
         Menstruation = ifelse(Menstruation==1, 0, 1)) %>%
  select(1:10)

## Run PCA 
physical.pca <-  prcomp(scaled.physical_fatigue[3:10], center = TRUE,scale. = TRUE)
biplot(physical.pca)

# PCA1: sleep (SleepQuality + Fatigue + Soreness + SleepHours)
# PCA2: health (Pain + Illness + Menstration + Illness)

scaled.physical_fatigue$PCA1 <- physical.pca$x[, 1]
scaled.physical_fatigue$PCA2 <- physical.pca$x[, 2]

scaled.physical_fatigue %>%
  select(1:9) %>% 
  ungroup 
  # saveRDS("physical_fatigue.rda")


