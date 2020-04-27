# Player movement: graphing explosiveness

playerMovementUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("graph"))
  )
}

playerMovementTime <- function(input, output, session, data, title_stub){
  output$graph <- renderPlot({
    best_game_performance(data(), title_stub)
  })
}

library(gganimate)

player_movement <- function(.dataframe, .GameID, .title) {
  .dataframe %>% 
    select(GameID, FrameID, Speed, Longitude, Latitude) %>%
    filter(FrameID %% 10 == 0,
           GameID == .GameID,
           !is.na(Speed),
           !is.na(contains("tude"))) %>%
    mutate(FrameID = row_number()) %>%
    ggplot() + 
    geom_point(aes(x = Longitude, y = Latitude, color = Speed)) +
    scale_color_continuous()+
    transition_time(FrameID)  + 
    labs(title = .title)
  
}

# player_movement(gps, 1, "Explosiveness of Player 2 during Game 1")


best_game_performance <- function(.filtered_df, .title) {

  filtered_df <- .filtered_df %>% 
    select(PlayerID, Tournament, GameID, Speed)
    
  if (nrow(filtered_df) == 0) {
    message("Did not play during this tournament")
    ggplot() +
      labs("Player did not play this tournament.")
  }
  
  if (nrow(filtered_df)!=0){
    best_game <- filtered_df %>%
      group_by(GameID) %>%
      summarize(avg_speed = mean(Speed)) %>%
      top_n(1, avg_speed)
    
    player_movement(.filtered_df, best_game$GameID, .title)
  }
  
}
# best_game_performance(filter_df(gps,2,"Dubai"), "fred")
