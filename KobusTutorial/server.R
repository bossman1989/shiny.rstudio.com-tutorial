library(shiny)
library(tidyverse)

server <- function(input, output) {

  # Observations
  observeEvent(input$clicks, {});

  # Data
  data <- faithful[,2][order(faithful[,2])];

  # Reactives
  bins <- reactive({
    seq(min(data), max(data), length.out = input$bins + 1)
  });
  histdata <- reactive({
    hist(x = data, breaks = bins(), col = 'darkgray', border = 'white', main = isolate(input$title))
  })

  # Plotting
  output$clicks <- renderPrint({
    input$clicks[1];
  })

  output$ggplothist <- renderPlot({
    ggplot(tibble(data), aes(data)) +
      geom_histogram(breaks=bins()) +
      ggtitle(isolate(input$title));
  })

  output$distPlot <- renderPlot({
    histdata()
  })

  output$stats <- renderPrint({
    histdata()$counts;
  })
}