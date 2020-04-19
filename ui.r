library(shiny)
library(datasets)

fluidPage(
  titlePanel("Miles Per Gallon"),
  splitLayout(
    verticalLayout(
      h3("Tournament 1"),
      barGraphUI("one")
    ),
    verticalLayout(
      h3("Tournament 2"),
      barGraphUI("two")
    )
  )
)

