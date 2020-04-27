trainingBarUI <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("graph"))
  )
}

trainingBar <- function(input, output, session, data, title_stub){
  output$graph <- renderPlot({
    plot_trainBar(data(), title_stub)
  })
  
  # output$graph <- renderImage({
  #   outfile <- tempfile(fileext='.gif')
  #   
  #   # now make the animation
  #   p = plot_time(data(), title_stub)
  #   anim_save("outfile.gif", animate(p)) # New
  #   
  #   # Return a list containing the filename
  #   list(src = "outfile.gif",
  #        contentType = 'image/gif',
  #        width = 400,
  #        height = 300,
  #        alt = "animated-graph-is-loading"
  #   )
  # }, 
  # deleteFile = TRUE)
}

# TODO: set y limits centered to 0
plot_trainBar <- function(.data, .title_stub){
  
  one_training <- .data %>% 
    filter(Training == "Yes") %>% 
    arrange(Date) %>% 
    select(Date, SessionType) 
  
  day_df <- one_training %>% 
    distinct(Date) %>% 
    mutate(day_idx = row_number())
  
  # Running counts of training sessions
  training_cum <- one_training %>%
    left_join(day_df, by = "Date") %>% 
    select(day_idx, SessionType) %>% 
    distinct(.keep_all = TRUE) %>% 
    mutate(n = 1) %>% 
    spread(SessionType, n) %>%
    mutate_all(replace_na, replace = 0) %>% 
    mutate_at(vars(-day_idx), cumsum)
  
  # Complete missing dates
  training_cum_complete <- training_cum %>%   
    left_join(day_df, by = "day_idx") %>% 
    complete(Date = seq.Date(min(Date), max(Date), by = "day")) %>% 
    gather("SessionType", "running_n", -Date) %>% 
    mutate(SessionType = factor(SessionType, 
                                levels = c("Mobility/Recovery", "Game", "Skills", "Conditioning", "Strength", 
                                           "Combat", "Speed"),
                                labels = c("Mobility/Recovery", "Game", "Skills", "Conditioning", "Strength", 
                                           "Combat", "Speed"))
    ) %>% 
    filter(!is.na(SessionType)) %>% 
    group_by(SessionType) %>% 
    fill(running_n) 

  training_cum_complete %>% 
    arrange(Date) %>% 
    ggplot(aes(Date, running_n, color = SessionType)) +
    geom_line() +
    theme(legend.position = "bottom",
          legend.title = element_blank()) + 
    labs(title = .title_stub,
         x = "",
         y = "")

}

# plot_trainBar(filter_df(rpe, 10, "World Cup"), "title")
