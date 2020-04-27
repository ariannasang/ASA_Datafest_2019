library(shiny)

function(input, output) {
  phys_pca1 <- eventReactive(input$go, {filter_df(phys_pca, input$psel, input$tsel1, input$limit21)}, ignoreNULL = FALSE)
  phys_pca2 <- eventReactive(input$go, {filter_df(phys_pca, input$psel, input$tsel2, input$limit21)}, ignoreNULL = FALSE)
  ment_pca1 <- eventReactive(input$go, {filter_df(ment_pca, input$psel, input$tsel1, input$limit21)}, ignoreNULL = FALSE)
  ment_pca2 <- eventReactive(input$go, {filter_df(ment_pca, input$psel, input$tsel2, input$limit21)}, ignoreNULL = FALSE)
  rpe1 <- eventReactive(input$go, {filter_df(rpe, input$psel, input$tsel1, input$limit21)}, ignoreNULL = FALSE)
  rpe2 <- eventReactive(input$go, {filter_df(rpe, input$psel, input$tsel2, input$limit21)}, ignoreNULL = FALSE)
  gps1 <- eventReactive(input$go, {filter_df(gps, input$psel, input$tsel1, input$limit21)}, ignoreNULL = FALSE)
  gps2 <- eventReactive(input$go, {filter_df(gps, input$psel, input$tsel2, input$limit21)}, ignoreNULL = FALSE)
  
  callModule(timeSeries, "physPCA1", phys_pca1, "Physical Fatigue")
  callModule(timeSeries, "mentPCA1", ment_pca1, "Mental Fatigue")
  callModule(timeSeries, "physPCA2", phys_pca2, "Physical Fatigue")
  callModule(timeSeries, "mentPCA2", ment_pca2, "Mental Fatigue")
  callModule(trainingTime, "t1", rpe1, "Training for Tournament")
  callModule(trainingTime, "t2", rpe2, "Training for Tournament")
  callModule(playerMovementTime, "mv1", gps1, "Movement simulation")
  callModule(playerMovementTime, "mv2", gps2, "Movement simulation")
  
}
