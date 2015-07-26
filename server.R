library(UsingR)
data(mtcars)
mLm <- lm(mpg ~ wt * cyl, mtcars)

shinyServer(
  function(input, output) {
    
    data = reactive({
      ncyl=as.numeric(input$ncyl)
      cwt=input$cwt
      newdata = data.frame(cyl=as.numeric(input$ncyl), wt=input$cwt/1000)
      est=predict(mLm, newdata, interval="prediction")
      list(ncyl=ncyl, cwt=cwt, est=est)})

    output$plot <- renderPlot({
      plot(x=mtcars$wt*1000, y=mtcars$mpg, col=mtcars$cyl/2, pch=4, 
           xlab="Car Weight (lbs)", ylab="Fuel Efficiency (mpg)", xlim=c(1000,6000),
           main="Fuel Efficiency of 1973-74 model cars")
      legend("topright", legend = c("4","6","8","Estimate"), title="Cylinders", 
             col=c(2,3,4,data()$ncyl/2), pch=c(4,4,4,16) )
      abline(v=data()$cwt, h=data()$est[1], col="lightgray")
      points(x=data()$cwt, y=data()$est[1], col=data()$ncyl/2, pch=16)
    })
    
    output$prediction <- renderText({
      paste("For a car with ",data()$ncyl, "cylinders and ", data()$cwt, 
            "lbs, the estimated fuel efficiency is ", round(data()$est[1],1), "miles per gallon")})
  }
)