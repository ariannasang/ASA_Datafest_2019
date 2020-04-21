barGraphUI <- function(id){
  ns <- NS(id)
  tagList(
    textOutput(ns("p_t_sel")),
    plotOutput(ns("graph"))
  )
}

barGraph <- function(input, output, session, p_sel, t_sel){
  output$graph <- renderPlot({
      filler()
  })

  output$p_t_sel <- renderText({
    paste("Player: ", p_sel(), "; Tournament: ", t_sel())
  })
}


colplot <- function(var){
  var <- sym(var)
  df %>%
    count(!!var) %>%
    ggplot() +
    geom_col(aes(x = !!var, y = n)) +
    labs(title = as_label(var),
         x = "",
         y = "")
}
# colplot("cyl")

filler <- function(){
  colplot("cyl")
}


