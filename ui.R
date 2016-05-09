library(shiny)
library(data.table)
library(UsingR)
data(galton)

parentHeights <- as.list(sort(unique(galton$parent)))

shinyUI(fluidPage(

  titlePanel("Guess your Child Height based on your own height"),
  
  sidebarLayout(sidebarPanel(

  selectInput(
    "parentHeight",
    label = h4("Parent Height:"),
    choices = parentHeights,
    #selected = 1,
    selected = 66.5
  )
  ),
  
  mainPanel(

    tabsetPanel(type = "tabs",
                
                tabPanel("Histogram",
                         br(),
                         plotOutput("newHist")
                        ),
                
                tabPanel("Help",
                         br(),
                         h3("What's your guess?"),
                         h3("Pick a Parent Height from the drop down and see the average of Child Heights for that Parent height"),
                         p("The Histogram is the Child Heights from the Galton data source "),
                         p("When you select a Parent Height from the down, the entries in the Galton table"),
                         p("with matching Parent Height will be found and the average will show as a value."),
                         br(),
                         p("The Parent Height will show on the Histogram as a ", strong("blue line"), "for reference."),
                         p("The Average Child Height will show on the Histogram as a ", strong("red line"), "for reference.")
                        )
              )
          )
  )
))

