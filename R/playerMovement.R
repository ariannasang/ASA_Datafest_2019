# Player movement: graphing explosiveness
playerMovementUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("graph"))
  )
}

playerMovementTime <- function(input, output, session, data, title_stub){
  output$graph <- renderImage({
    w = 375
    h = 410
    
    # now make the animation
    p = best_game_performance(data(), title_stub) # returns static/animation
    if(sum(class(p) == "gganim") > 0) {
      # A temp file to save the output.
      outfile <- tempfile(fileext='.gif')
      gif_id <- paste0("outfile", sample(1:1E3, 1), ".gif")
      message(gif_id)
      anim_save(gif_id, animate(p))
      # Return a list containing the filename
      list(src = gif_id,
           contentType = 'image/gif',
           width = w,
           height = h,
           alt = "animated-graph-is-loading"
      )
      
    } else {
      # A temp file to save the output. It will be deleted after renderImage
      # sends it, because deleteFile=TRUE.
      message("didnt find gganim")
      outfile <- tempfile(fileext='.png')
      
      # Generate a png
      png(outfile, width=w, height=h)
      plot.new()
      title("Player didn't play this tournament")
      dev.off()
      # Return a list
      list(src = outfile,
           contentType = 'image/gif',
           width = w,
           height = h,
           alt = "static-graph-is-loading"
      ) 
    }
  }, deleteFile = TRUE)
  
}


player_movement <- function(.dataframe, .GameID, .title) {
  .dataframe %>% 
    select(GameID, FrameID, Speed, Longitude, Latitude) %>%
    filter(FrameID %% 10 == 0,
           GameID == .GameID) %>%
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
  }
  
  else {
    best_game <- filtered_df %>%
      group_by(GameID) %>%
      summarize(avg_speed = mean(Speed)) %>%
      top_n(1, avg_speed)
    
    player_movement(.filtered_df, best_game$GameID, .title)
  }
  
}
# best_game_performance(filter_df(gps,1,"Dubai"), "fred")
