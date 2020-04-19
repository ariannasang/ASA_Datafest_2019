library(shiny)
library(datasets)

function(input, output) {
  callModule(barGraph, "one")
  callModule(barGraph, "two")
}
