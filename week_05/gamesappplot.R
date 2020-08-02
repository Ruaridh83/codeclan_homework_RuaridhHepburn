library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)
library(CodeClanData)

#This is an app that helps people choose a game they would enjoy based on what machine they want to play it on
#what genre of games they currently enjoy and how good they want the game to be. 

ui <- fluidPage(
  
  theme = shinytheme("yeti"),
  
  titlePanel("Visualisation of Game quality"),
  
  br(),
  #button to select what console they want to play on
  fluidRow(
    column(4,
           radioButtons('developer',
                        'Who made the game',
                        choices = unique(game_sales$developer), inline = TRUE)
    ),
    #narrowing down what kind of games they like
    column(4,
           selectInput("year",
                       "When was the game made?",
                       choices = unique(game_sales$year_of_release))
    ),
    #letting user select how many titles are recommended based on critic reviews, min and max values
    #defined by min and max values on the DF. 
    column(4,
           selectInput("platform", 
                       "What console was the game made for?",
                       choices = unique(game_sales$platform))
    ),
  ),
  br(),
  br(),
  plotOutput("game_plot")
  
)

server <- function(input, output) {
  output$game_plot <- renderPlot({
    game_sales %>%
      filter(developer == input$developer) %>%
      filter(year_of_release == input$year_of_release) %>%
      filter(platform == input$platform) %>%
      ggplot() +
      aes(x = medal, y = count, fill = medal) +
      geom_histogram()
  })
} 
shinyApp(ui = ui, server = server)