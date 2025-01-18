library(shiny)
library(bslib)

library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("data/counties.rds")

# Define UI ----
ui <- page_sidebar(
  title = "censusVis",
  sidebar = sidebar(
    helpText(
      "Create ..."
    ), 
    selectInput(
      "var",
      label = "Choose ...",
      choices = 
        list(
          "White", 
          "Black", 
          "Hispanic", 
          "Asian"
        ),
      selected = "White"
    ),
    sliderInput("range",
                label = "Range of interest",
                min = 0,
                max = 100,
                value = c(0, 100)
    )    
  ),
  "textOutput wil be here",
  textOutput("selected_var"),
  card(plotOutput("map"))
)

# Define server logic ----
server <- function(input, output) {
  
  output$selected_var <- renderText({
    paste("You have selected", input$var, "from", input$range[1], "to", input$range[2])
  })
  output$map <- renderPlot({
    data <- switch(input$var,
                   "White" = counties$white,
                   "Black" = counties$black,
                   "Hispanic" = counties$hispanic,
                   "Asian" = counties$asian)
    
    color <- switch(input$var,
                    "White" = "darkgreen",
                    "Black" = "black",
                    "Hispanic" = "darkorange",
                    "Asian" = "darkviolet")
    
    legend <- switch(input$var,
                     "White" = "% White",
                     "Black" = "% Black",
                     "Hispanic" = "% Hispanic",
                     "Asian" = "% Asian")
    
    percent_map(var = data, color, legend, max = input$range[2], min = input$range[1])
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)

