#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Chick Weight Dataset at a Glance"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("box1", "Enter Plot title:", value = 
                  "Weight versus age of chicks on different diets"),
      sliderInput("slTime", "Pick Start and End Time:",
                  0, 22, value = c(0, 22), step = 2), 
      checkboxGroupInput("gDiet", 
                         label = h4("Diet group to Show"), 
                         choices = list("Diet 1" = 1, 
                                        "Diet 2" = 2,
                                        "Diet 3" = 3,
                                        "Diet 4" = 4),
                         selected = c(1,2,3,4)),
      radioButtons("radio", label = h3("Draw lines on:"),
                 choices = list("Mean of Diet" = 1, "Mean of Chick" = 2)
                 ,selected = 1) 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3(textOutput("PlotTT")),
      plotOutput("scatPlot")
    )
  ),
  
  br(),
  
  fluidRow(
    column(4,
           numericInput("SelTime", "Show statistics value on Time:",
                        value = 21, min = 0, max = 21, step = 1),
           submitButton("Submit"),
           h5("Hint: Please click Summit to apply your choice.", style = "color:red")
    ),
    column(4,
           tabsetPanel(type = "tabs",
                       tabPanel("Group by Diet", br(), tableOutput("subTable")),
                       tabPanel("Overall", br(), tableOutput("allTable")))
    )
  ),
  
  br(),
  
  fluidRow(
    p("To see the code of this app, visit ",
      a("my github page.", 
        href = "https://github.com/rivei/DataProdProject/tree/master"))
  )
)
)

