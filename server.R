library(quantmod)
library(shiny)

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    
    output$text1 <- renderText({paste("", input$symb)})
    
    validate(
      need(input$symb != "", "Please enter Valid Stock Symbol")
    )
    
    # quantmod   
    
    tryCatch({
      data <- getSymbols(
        input$symb,
        src = "yahoo",
        to = Sys.Date(),
        auto.assign = FALSE
      )
    },
    error=function(e) {
      output$text1 <- renderText({paste(input$symb, " is not a valid symbol.")})
      return(NULL) 
    }
    )
    
    # Show the first "n" observations
    output$view <- renderTable({
      head(data, n = input$obs)
    }, include.rownames = TRUE)
    
    # Quantmod chart
    
    m <- paste0("last ",input$integer, " months")
    
    output$text2 <- renderText({paste("Current Ticker" , m)})
    tryCatch({
      chartSeries(data,
                  theme = chartTheme("white"),
                  type = "line",
                  subset = m ,
                  TA = NULL)
    },
    error=function(e) {
      output$text2 <- renderText({paste("")})
      return(NULL) 
    }
    )
  }
  ) 
})
