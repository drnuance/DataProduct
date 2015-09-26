
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(datasets)
library(ggplot2)
library(dplyr)
library(splines)
data(freeny)

shinyServer(function(input, output) {
        # Time Series data type also gets limited support. So convert it to numeric first and rebuild a correct data frame.          
        freey <- data.frame(cbind(as.numeric(freeny.y), freeny.x))
        # seems that aes_string's power is limited in processing space " ".        
        colnames(freey) <- c("Sales", "Revenue", "Price_Index", "Income_Level", "Market_Potential")
        # Axis is wrong, so changed it accordingly.
        
  output$distPlot <- renderPlot({
        g <- ggplot(data=freey, aes_string(x=input$y, y=input$x)) 
        g <- g + geom_line() + stat_smooth(method = "lm")
        g <- g + xlab(input$y) + ylab(input$x)
        print(g)
  })

  output$Corr <- renderText({
          result <- cor.test(as.vector(freey[[input$x]]), as.vector(freey[[input$y]]), conf.level = 0.01)
          line1 <- paste("P Value:", round(result$p.value, digits=3))
          if (result$p.value < 0.01) {
                line2 <- paste("We accept the assumption that", input$x, "correlates to", input$y)
                line3 <- paste("Estimated coefficiency is", round(result$estimate, digits=3))
                line4 <- paste("Confidential interval at 1% level is (", round(result$conf.int[1], digits=3), ", ", round(result$conf.int[2], digits=3), ")", sep="")
                HTML(paste(line1, line2, line3, line4, sep = '<br/>'))
          } else {
                line2 <- paste("We reject the assumption that", input$x, "correlates to", input$y)    
                HTML(paste(line1, line2, sep = '<br/>'))
          }
  })
})
