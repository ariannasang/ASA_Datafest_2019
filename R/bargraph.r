barGraphUI <- function(id){
  ns <- NS(id)
  tagList(
    radioButtons(ns("radiobutton"), "Select variable", colnames(df)[2:6], "cyl"),
    textOutput(ns("var")),
    plotOutput(ns("graph"))
  )
}

barGraph <- function(input, output, session){
  output$var <- renderText({
    input$radiobutton
  })
  
  output$graph <- renderPlot({
    colplot(input$radiobutton)
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
colplot("cyl")

