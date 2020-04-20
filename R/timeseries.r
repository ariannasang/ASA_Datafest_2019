timeSeriesUI <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(ns("select"), "Player", unique(phys_pca$PlayerID), selected = 1),
    plotOutput(ns("graph"))
  )
  
}

timeSeries <- function(input, output, session){
  output$var <- renderText({
    input$select
  })
  
  output$graph <- renderPlot({
    plot_time(input$select)
  })
}


plot_time <- function(player_id){
  phys_pca %>% 
    filter(PlayerID == player_id) %>% 
    ggplot() +
    geom_line(aes(x = Date, y = value, color = PCA)) +
    labs(x = "",
         y = "")
}

# plot_time(1)
