# Training Before Tournament

trainingTimeUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("graph"))
  )
}

trainingTime <- function(input, output, session, data, title_stub){
  output$graph <- renderPlot({
    training_over_time(data(), title_stub)
  })
}

trainingExertion <- function(.dataframe, .Date, .n_days, .title) {

  days <- .dataframe %>%
    distinct(Date) %>%
    filter(Date <= .Date) %>%
    head(.n_days + 1) 
  

  .dataframe %>%
    filter(Training == "Yes",
           !is.na(SessionType),
           !is.na(SessionLoad),
           SessionType != "Game",
           Date %in% days$Date) %>%
    select(Date, SessionType, SessionLoad) %>%
    group_by(SessionType) %>%
    mutate(SessionType_avgLoad = mean(SessionLoad)) %>%
    ungroup() %>%
    mutate(overexerted = ifelse(SessionLoad > SessionType_avgLoad, 1, 0))  %>%
    ggplot(aes(x = SessionType, y = SessionLoad, fill= overexerted)) + 
    geom_bar(stat='identity') + 
    facet_wrap(~Date)+ 
    labs(title = .title)+ 
    theme(axis.text.x = element_text(angle= 45, hjust = 1))
}

# d <- as.Date("2017-11-26")
# trainingExertion(filter_df(rpe, 3, "Dubai"), d,4, "example")


