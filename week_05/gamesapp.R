library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)
library(CodeClanData)

#This is an app that helps people choose a game they would enjoy based on what machine they want to play it on
#what genre of games they currently enjoy and how good they want the game to be. 

ui <- fluidPage(
  
  theme = shinytheme("superhero"),
  
  titlePanel("Roo's Game Recommendation Machine"),
  
  br(),
  
  strong("An app that helps choose a game to play", style = "color:pink;"),
  
  br(),
  br(),
  
  em("ps remember to give your wee brother a shot", style = "color:red;"),
  
  br(),
  br(),
  #button to select what console they want to play on
  fluidRow(
    column(4,
           radioButtons('platform',
                        'What do you want to play on?',
                        choices = unique(game_sales$platform), inline = TRUE)
    ),
    #narrowing down what kind of games they like
    column(4,
           selectInput("genre",
                       "What kinda games do you like?",
                       choices = unique(game_sales$genre))
    ),
    #letting user select how many titles are recommended based on critic reviews, min and max values
    #defined by min and max values on the DF. 
    column(4,
           sliderInput("critic_score", 
                       "How rad do you want this game to be?",
                       min = 21, 
                       max = 98,
                       21 )
    ),
    
    
    
  ),
  
  br(),
  br(),
  
  actionButton("update", "Recommend me a Game!!"),
  
  tableOutput("table_output")
  
)

server <- function(input, output) {
  
  game_data <- eventReactive(input$update,{
    
    game_sales %>%
      filter(platform == input$platform)  %>%
      filter(genre == input$genre) %>%
      filter(critic_score == input$critic_score) 
      
    
  })
  #output is a table to show what game is best suited for them. 
  output$table_output <- renderTable({
    game_data()
  })
}

shinyApp(ui = ui, server = server)