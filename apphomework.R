library(shiny)
library(tidyverse)
library(CodeClanData)
install.packages(shinytheme)
library(shinythemes)



ui <- fluidPage(
  theme = shinytheme("cyborg"),
  titlePanel("Five Country Medal Comparison"),
  
  fluidRow(
    
    column(6, 
           
           radioButtons("season",
                        "Summer or Winter Olympics?",
                        choices = c("Summer", "Winter")
           )
           
    ),
    
    
    column(6, 
      radioButtons("medal",
                   "Medal Type",
                   choices = c("Gold", "Silver", "Bronze"))),
    
    
    mainPanel(
      plotOutput("medal_plot"))))


server <- function(input, output){
  output$medal_plot <- renderPlot({
    
    
    olympics_overall_medals %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$medal) %>%
      filter(season == input$season) %>%
      ggplot() +
      aes(x = team, y = count, fill = team) +
      geom_col()
  })
}

shinyApp(ui = ui, server = server)