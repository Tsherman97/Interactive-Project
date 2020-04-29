library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Stock Price Lookup"),
  
  sidebarLayout(
    sidebarPanel(
      
      helpText("Let's get rich!"),
      
      textInput("symb", "Enter Ticker", value = "", width = NULL, placeholder = NULL),
      
      sliderInput("integer", "Last Months Data:", 
                  min=1, max=120, value=1),
      numericInput("obs", "Trading Days Since 1/1/2007", 31)
    ),
    
    mainPanel(textOutput("text1"),textOutput("text2"),plotOutput("plot"), tableOutput("view")))
)
)
