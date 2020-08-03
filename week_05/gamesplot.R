library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)
library(CodeClanData)

#This is an app to show the user ratings of a game when filtered down by develepor, year of release
#and gaming platform, so the user can see what the best games are in each genre for their year and machine. 

ui <- fluidPage(
    
    theme = shinytheme("yeti"),
    
    titlePanel("Visualisation of Game quality"),
    
    br(),
    #dropdown for selecting who made the game
    fluidRow(
        column(6,
               selectInput('developer',
                            'Who made the game',
                            choices = unique(game_sales$developer))
        ),
        
        #What platform the game is played on. 
        column(6,
               selectInput("platform", 
                           "What console was the game made for?",
                           choices = unique(game_sales$platform))
        ),
    ),
    br(),
    br(),
    plotOutput("game_plot"),
    
    br(),
    br(),
    #cool web links for the console manufacturers
    tags$a("Nintendo",
           href = "https://www.nintendo.com"),
    br(),
    tags$a("Xbox",
           href = "https://www.xbox.com"),
    br(),
    tags$a("Playstation",
           href = "https://www.playstation.com"),
    br(),
    tags$a("There's still a website for the Gameboy??!?",
           href = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
    
)

server <- function(input, output) {
    output$game_plot <- renderPlot({
        
        game_sales %>%
            filter(developer == input$developer) %>%
            
            filter(platform == input$platform) %>%
            
            ggplot() +
            aes(x = user_score, y = genre, fill = name) +
            geom_col(position = "dodge")
    })
} 
shinyApp(ui = ui, server = server)
