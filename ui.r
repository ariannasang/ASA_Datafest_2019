library(shiny)
library(shinydashboard)

single_column <- function(pnum, collapsed = FALSE){
  column(
    width = 6, 
    box(
      title = "Best Game Movement",
      width = NULL, solidHeader = TRUE, status = "primary",
      collapsible = TRUE, collapsed = collapsed,
      playerMovementUI(paste0("mv", pnum))
    ),
    box(
      title = "Player Status",
      width = NULL, solidHeader = TRUE, status = "primary",
      collapsible = TRUE, collapsed = collapsed,
      timeSeriesUI(paste0("physPCA", pnum)), 
      timeSeriesUI(paste0("mentPCA", pnum))
    ),
    box(
      title = "Training Status",
      width = NULL, solidHeader = TRUE, status = "warning",
      collapsible = TRUE, collapsed = collapsed,
      trainingTimeUI(paste0("t", pnum))
    ),
  )
  
}

header <- dashboardHeader(
  title = "Rugby7",
  titleWidth = 150
)

sidebar <-   dashboardSidebar(
  width = 150,
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Source code", icon = icon("file-code-o"), 
             href = "https://github.com/ariannasang/ASA_Datafest_2019")
  )
)

sels <- box(
  width = 8, 
  title = "Selections",
  solidHeader = TRUE, status = "success", 
  box(
    width = 6,
    selectInput(
      "psel", "Player", unique(phys_pca$PlayerID), 
      # selected = sample(unique(phys_pca$PlayerID), 1)
      selected = 1
    ),
    checkboxInput("limit21", "Only 3 weeks before matches?", value = FALSE)
  ),
  box(
    selectInput("tsel1", "Tournament 1:", tdates$Tournament, 
      # selected = sample(tdates$Tournament, 1)
      selected = "Dubai"
    ),
    selectInput("tsel2", "Tournament 2:", tdates$Tournament, 
                # selected = sample(tdates$Tournament, 1)
                selected = "Dubai"
                
    ),
    actionButton("go", "Submit!")
  )
)

col1 <- single_column(1)
col2 <- single_column(2)
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
      fluidRow(sels),
      fluidRow(col1, col2)
    ),
    tabItem(tabName = "widgets",
      h2("Widgets tab content")
    )
  )
)

dashboardPage(skin = "blue", header, sidebar, body)
