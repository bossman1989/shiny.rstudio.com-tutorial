library(shiny)
library(tidyverse)

# Data
data <- faithful[,2][order(faithful[,2])];
rv <- reactiveValues(data = rnorm(100));

server <- function(input, output) {

  # Observations
  observeEvent(input$go, {});
  observeEvent(input$norm, { rv$data <- rnorm(100) });
  observeEvent(input$unif, { rv$data <- runif(100) });

  # Reactives
  bins <- eventReactive(input$go,
                        {seq(min(data), max(data), length.out = input$bins + 1)},
                        ignoreNULL = FALSE
  )

  histdata <- reactive({
    hist(x = data, breaks = bins(), col = 'darkgray', border = 'white', main = isolate(input$title))
  })

  # Plotting
  output$clicks <- renderPrint({
    input$go[1];
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

  output$toggledist <- renderPlot({
    hist(rv$data)
  })
}
