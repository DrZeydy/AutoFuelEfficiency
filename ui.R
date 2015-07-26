shinyUI(fluidPage(
  
  titlePanel("Estimate Fuel Efficiency"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("In 1974 Motor Trend US magazine published the fuel consumption and features of the 1973-74 car models. What would be the fuel efficiency of a new car based on this data?  Select the features of the car to provide an estimate:"),
      radioButtons("ncyl", label = h4("Number of cylinders"),
                   choices = list("4 cylinders" = 4, "6 cylinders" = 6, "8 cylinders" = 8), 
                   selected = 4),
      br(),
      sliderInput('cwt', h4("Car weight"), value = 3000, min = 1000, max = 6000, step = 100,)
    ),
    
    mainPanel(
      plotOutput("plot"),
      h3('Results of prediction'),
      textOutput("prediction")
    )
  )
))