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
    group_by(Date) %>%
    count(SessionType) %>%
    ungroup() %>%
    group_by(SessionType) %>%
    mutate(n = cumsum(n)) %>%
    ggplot(aes(x = Date, y = n, color= SessionType))+
    geom_line(size = 0.8) +
    theme(legend.position = "bottom", 
          legend.title = element_blank()) +
    scale_y_continuous(labels = scales::number_format()) + 
    labs(title = title,
         x = "", 
         y = "")
}

# training_over_time(filter_df(rpe, 1, "Dubai"), 'Type of Sessions by Count')
# filter_df(rpe, 1, "Dubai", FALSE) %>% distinct(Date) %>% arrange(Date)
