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

training_over_time <- function(dataframe, title) {
  dataframe %>% 
    filter(Training == "Yes",
           !is.na(SessionType),
           SessionType != "Game") %>% 
    arrange(Date) %>%
    tail(21) %>% # 21 days before
    group_by(Date) %>%
    count(SessionType) %>%
    ungroup() %>%
    group_by(SessionType) %>%
    mutate(n = cumsum(n)) %>%
    ggplot(aes(x = Date, y = n, color= SessionType))+
    geom_line(alpha = .5) #+
  labs(title = title )
}