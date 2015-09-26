
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Examine Correlation among Sales Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
          selectInput("y", "X Axis",
                      c("Sales", "Revenue", "Price_Index", "Income_Level",
                        "Market_Potential"
                      ),
                      selected = "Sales"
          ),
          selectInput("x", "Y Axis",
                      c("Sales", "Revenue", "Price_Index", "Income_Level",
                        "Market_Potential"
                      ),
                      selected = "Revenue"
          ),
          submitButton("Update View", icon("refresh"))
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
          h4('Plot'),
    plotOutput("distPlot"),
    
    h4('Correlation Test'),    
    uiOutput("Corr")
  )
))
