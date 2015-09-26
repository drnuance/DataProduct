
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
    p("This simple app uses the Freeny's Revenue Data in library(datasets) to help managers to do simple business anlaysis on factors affecting revenue. Managers can plot any two variables in the dataset to get some idea on the correlation."),
    p("In addition, a Correlation test will be run on the assumption that these two variables are correlated. The rejection level is set to 1%. System will display appropriate output based on calculated P Value, helping managers to make decision based on data, rather than intuition."),
    h4('Plot'),
    plotOutput("distPlot"),
    
    h4('Correlation Test'),    
    uiOutput("Corr")
  )
))
