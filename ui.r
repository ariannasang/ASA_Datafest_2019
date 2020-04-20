library(shiny)
library(datasets)

fluidPage(
  # theme = "bootstrap_darkly.css",
  titlePanel("Rugby7 Player Analysis"),
  selectInput("playerSelect", "Player", unique(phys_pca$PlayerID), selected = 1),
  splitLayout(
    verticalLayout(
      selectInput("tourSelect1", "Tournament", 1:4, selected = 1),
      splitLayout(
        barGraphUI("one"),
        barGraphUI("two")
      ),
      barGraphUI("five")
      
      
    ),
    verticalLayout(
      selectInput("tourSelect2", "Tournament", 1:4, selected = 1),
      splitLayout(
        barGraphUI("three"),
        barGraphUI("four")
      )
      
    )
  )
)
