library(shiny)

function(input, output) {
  # callModule(barGraph, "one")
  # callModule(barGraph, "two")
  callModule(timeSeries, "onetime")
  callModule(timeSeries, "twotime")
}
