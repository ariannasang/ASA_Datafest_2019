library(shiny)
library(datasets)

fluidPage(
  # theme = "bootstrap_darkly.css",
  titlePanel("Rugby7 Player Analysis"),
  splitLayout(
    verticalLayout(
      h3("Player A"),
      # barGraphUI("one"),
      timeSeriesUI("onetime")
    ),
    verticalLayout(
      h3("Player B"),
      # barGraphUI("two"),
      timeSeriesUI("twotime")
    )
  )
)
