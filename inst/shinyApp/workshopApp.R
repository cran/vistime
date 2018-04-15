library(shiny)
library(plotly)
library(shinydashboard)

ui <- dashboardPage(header = dashboardHeader(title = "Meine App"),
                    sidebar = dashboardSidebar(img(src = "d-fine.jpg", width = "100%", align = "right")),
                    body = dashboardBody(
  
  # insert an image, shiny will look for it in the www-folder
  
  
  plotlyOutput(outputId = "histogram", width= "50%"),
  
  sliderInput(inputId = "slider", label = "Anzahl Zufallszahlen", min = 1, max = 10000, value = 1000),
  
  radioButtons(inputId = "change", label = "Verteilung auswählen", choices = c("Gleichverteilung", "Normalverteilung"))
  
 )
)

server <- function(input, output){
  output$histogram <- renderPlotly({
    if(input$change == "Gleichverteilung") numbers <- runif(input$slider)
    if(input$change == "Normalverteilung") numbers <- rnorm(input$slider)
    
    
    # create a histogram
    plot_ly(x = numbers, type = "histogram", hoverinfo = "text", text = paste("Dies ist die Zahl", numbers), width = "50%")
  })
  
  observeEvent(input$slider, {
    
    print(paste("Slider value has changed. Now generating", input$slider, "numbers drawn from distribution", input$change))
    
  })
    
  }

shinyApp(ui = ui, server = server)