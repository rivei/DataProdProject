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

  fluidRow(column(10,
    h3("Introduction"),
    h4("- The ChickenWeight dataset is one of the easiest accessible dataset in R datasets
       library. Personally speaking, it is a data set that can be easily analysis and be 
       plot in a colorful way."),
    h4("- In the dataset, the body weights of the chicks were measured at birth and every
      second day thereafter until day 20. They were also measured on day 21. There were 
      four groups on chicks on different protein diets."))
  ),
  br(),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("box1", "Enter Plot title:", value = 
                  "Weight versus age of chicks on different diets"),
      br(),
      sliderInput("slTime", "Pick Start and End Time:",
                  0, 22, value = c(0, 22), step = 2), 
      br(),
      checkboxGroupInput("gDiet", 
                         label = "Diet group to Show", 
                         choices = list("Diet 1" = 1, 
                                        "Diet 2" = 2,
                                        "Diet 3" = 3,
                                        "Diet 4" = 4),
                         selected = c(1,2,3,4)),
      br(),
      radioButtons("radio", label = "Draw lines on:",
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
           h3("Statistic summary"),
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

