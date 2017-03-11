#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$PlotTT <- renderText(input$box1)

    output$scatPlot <- renderPlot({
      ckwT <- subset(ChickWeight, (Time >= as.integer(input$slTime[1])) & 
                              (Time <=as.integer(input$slTime[2])))
      ckw <- subset(ckwT, Diet == 0 )
      if(!is.null(input$gDiet)){
        for(i in 1:length(input$gDiet)){
          ckw <- rbind(ckw, subset(ckwT, Diet==input$gDiet[i]))
        }
      }
      ckw$Diet <- factor(ckw$Diet)

      
      if(input$radio == 1){
        p <- ggplot(ckw, aes(x = Time, y = weight, colour = Diet)) + 
          geom_point(alpha = 0.3) + 
          stat_summary(fun.y = 'mean',geom = 'line', 
                       aes(group = Diet, colour = Diet))
      }
      if(input$radio == 2){
        p <- ggplot(ckw, aes(x = Time, y = weight, colour = Diet, group = Chick))
        p <- p + geom_line()+ geom_point()
      }
      
      print(p)
  })
  
  output$subTable <- renderTable({
    ckw <- group_by(ChickWeight,Diet = factor(Diet))
    summarise(subset(ckw, Time == input$SelTime), Mean = mean(weight), 
              SD = sd(weight), Median = median(weight))
  })

  output$allTable <- renderTable({
    summarise(subset(ChickWeight, Time == input$SelTime), 
              Mean = mean(weight), SD = sd(weight), Median = median(weight))
  })

})
