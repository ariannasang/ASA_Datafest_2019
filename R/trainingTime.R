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
    trainingExertion(
      data(), 
      input$inDate, input$daysBefore,
      title_stub)
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

d <- as.Date("2017-11-26")
trainingExertion(filter_df(rpe, 3, "Dubai"), d,4, "example")

