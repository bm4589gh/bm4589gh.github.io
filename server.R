library(shiny)
library(data.table)
library(UsingR)
data(galton)
shinyServer(
  function(input, output) {
    output$newHist <- renderPlot({
      hist(galton$child, xlab='Child Heights', col='lightblue',main='Histogram')
      ht <- input$parentHeight
      dt <- data.table(galton, key="parent")
      cht <- round(dt[parent == ht,mean(child)],1)
      if (ht == cht) cht <- cht + .05
      lines(c(ht, ht), c(0, 200),col="blue",lwd=2)
      lines(c(cht, cht), c(0, 200),col="red",lwd=2)
      text(63, 150, paste("Parent Height (blue) = ", ht))
      text(63, 140, paste("Avg Child Height (red) = ", cht))
    })
  }
)