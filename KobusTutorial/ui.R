# ui.r
library(shiny)

ui <- fluidPage(
  
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      actionButton(inputId = "norm", label = "Normal"),
      actionButton(inputId = "unif", label = "Uniform"),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      textInput(inputId = "title",
                label = "Write a title",
                value = "Histogram of Random Normal Values"),
      actionButton(inputId = "go",
                   label = "Update")
    ),
    
    mainPanel(
      plotOutput("toggledist"),
      verbatimTextOutput("clicks"),
      plotOutput("distPlot"),
      plotOutput("ggplothist"),
      verbatimTextOutput("stats")
    )
  )
)
