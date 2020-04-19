sliderTextUI <- function(id){
  ns <- NS(id)
  tagList(
    sliderInput(ns("slider"), "Slide me", 0, 100, 1),
    textOutput(ns("number"))
  )
}

sliderText <- function(input, output, session){
  output$number <- renderText({
    input$slider
  })
}