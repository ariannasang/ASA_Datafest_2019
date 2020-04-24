timeSeriesUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("graph"))
  )
}

timeSeries <- function(input, output, session, data, title_stub){
  output$graph <- renderPlot({
    plot_time(data(), title_stub)
  })
}

# TODO: set y limits centered to 0
plot_time <- function(.data, .title_stub){
  tname <- .data$Tournament[1]
  .data %>% 
    ggplot() +
    geom_line(aes(x = Date, y = value, color = PCA)) +
    theme(legend.position = "bottom", 
          legend.title = element_blank()) +
    labs(title = paste0(.title_stub), 
         x = "",
         y = "")
}
  
plot_time(filter_df(phys_pca, 1, "Dubai"), "title")
