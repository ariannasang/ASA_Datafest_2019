library(shiny)
library(datasets)

fluidPage(
  # theme = "bootstrap_darkly.css",
  titlePanel("Rugby7 Player Analysis"),
  selectInput("psel", "Player", unique(phys_pca$PlayerID), selected = 1),
  splitLayout(
    verticalLayout(
      selectInput("tsel1", "Tournament", tdates$Tournament, selected = tdates$Tournament[1]),
      splitLayout(
        timeSeriesUI("physPCA1"),
        timeSeriesUI("mentPCA1")
      ),
      trainingTimeUI("t1")
      
    ),
    verticalLayout(
      selectInput("tsel2", "Tournament", tdates$Tournament, selected = tdates$Tournament[2]),
      splitLayout(
        timeSeriesUI("physPCA2"),
        timeSeriesUI("mentPCA2")
      ),
      trainingTimeUI("t2")
    )
  )
)
