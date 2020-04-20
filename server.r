library(shiny)

function(input, output) {
  player_select <- reactive({input$playerSelect})
  tour_select1 <- reactive({input$tourSelect1})
  tour_select2 <- reactive({input$tourSelect2})

  callModule(barGraph, "one", player_select, tour_select1)
  callModule(barGraph, "two", player_select, tour_select1)
  callModule(barGraph, "three", player_select, tour_select2)
  callModule(barGraph, "four", player_select, tour_select2)
  callModule(barGraph, "five", player_select, tour_select1)
}
