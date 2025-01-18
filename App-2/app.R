library(shiny)
library(bslib)

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
  )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)

