# Training Before Tournament

trainingTimeUI <- function(id){
  ns <- NS(id)
  tagList(
    sliderInput(ns("daysBefore"), "No. of Training days",
                min = 1, max = 6, value = 1),
    textOutput(ns("dateRange")),
    dateInput(ns("inDate"), "Training Day"),
    plotOutput(ns("graph"))
  )
}

trainingTime <- function(input, output, session, data, title_stub){
  # Date bounds for this data
    
  observe({
    rez <- data() %>% 
      summarize(minD = min(Date),
                maxD = max(Date))
    
    
    updateDateInput(
      session, "inDate",
      value = rez$maxD[1],
      min = rez$minD[1],
      max = rez$maxD[1]
    )
    
  })
  
  output$dateRange <- renderText({
    rez <- data() %>% 
      summarize(minD = min(Date),
                maxD = max(Date))
    paste0("Training for this tournament: ",
           format(rez$minD[1], "%b %m %Y"),
           " - ",
           format(rez$maxD[1], "%b %m %Y"))
  })
  
  output$graph <- renderPlot({
    training_over_time(
      data(), title_stub, 
      input$inDate, input$daysBefore)
  })
  
  
  
}

training_over_time <- function(dataframe, title, date, days) {

  dataframe %>% 
    filter(Training == "Yes",
           !is.na(SessionType),
           SessionType != "Game") %>% 
    count(SessionType) %>%
    ggplot(aes(n, SessionType)) +
    geom_col() + 
    scale_x_continuous(labels = scales::number_format()) + 
    labs(title = title,
         x = "", 
         y = "")
}

# training_over_time(filter_df(rpe, 1, "Dubai"), 'Type of Sessions by Count')
# filter_df(rpe, 1, "Dubai", FALSE) %>% distinct(Date) %>% arrange(Date)
