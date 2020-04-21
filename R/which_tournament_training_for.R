library(dplyr)
library(lubridate)

tdates <- readRDS("data/tournamentDates.rda")
which_tournament_training_for <- function(date){
  case_when(
    date <= tdates$endDate[1] ~ tdates$Tournament[1],
    date <= tdates$endDate[2] ~ tdates$Tournament[2],
    date <= tdates$endDate[3] ~ tdates$Tournament[3],
    date <= tdates$endDate[4] ~ tdates$Tournament[4],
    date <= tdates$endDate[5] ~ tdates$Tournament[5],
    date <= tdates$endDate[6] ~ tdates$Tournament[6],
    date <= tdates$endDate[7] ~ tdates$Tournament[7],
    TRUE ~ as.character(NA)
    
  )
}

which_tournament_training_for(as_date("2018-01-29"))
