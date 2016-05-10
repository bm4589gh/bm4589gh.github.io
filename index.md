---
title       : Guess your Child Height
subtitle    : galton data set
author      : bm4589gw
job         : Developing Data Products Part2 - Reproducible Pitch Presentation
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []   # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Locations for the deployed App

### Shiny Application - Part 1
- Shiny App that allows you to Guess your Childs height.
- URL: *https://bm4589gh.shinyapps.io/developingdataproducts/*
- ui.R, server.R, README.md

### Reproducible Pitch Presentation - Part 2
- URL: *https://github.com/bm4589gh/DevelopingDataProducts/tree/master/slidify/index.html*
- index.Rmd, index.md, index.html

### Source code located on the @Github repository.

```
git clone https://github.com/bm4589gh/developingdataproducts.git

```

---  .class #id

## The galton dataset

- The table above gives data based on the famous 1885 study of Francis Galton exploring the relationship between the heights of adult children and the heights of their parents.

### Source http://www.math.uah.edu/stat/data/Galton.html



```r
# install.packages("HistData")
library(HistData)
```

```
## Warning: package 'HistData' was built under R version 3.2.5
```

```r
data(Galton)
head(Galton,3)
```

```
##   parent child
## 1   70.5  61.7
## 2   68.5  61.7
## 3   65.5  61.7
```

---  .class #id

## Layout - galton Child-Parent Height dataset

** data frame with 928 observations of 2 variables.**

```
     child           parent     
 Min.   :61.70   Min.   :64.00  
 1st Qu.:66.20   1st Qu.:67.50  
 Median :68.20   Median :68.50  
 Mean   :68.09   Mean   :68.31  
 3rd Qu.:70.20   3rd Qu.:69.50  
 Max.   :73.70   Max.   :73.00  
 
```

## Using the App
Select a Parent Height from the drop down and you can see the associated average of Child Heights for that Parent Height.  The Parent and Child Heights will show as lines on the histogram of Child Heights.

--- &twocol 

## Code - ui.R and server.R

*** =left

``` 
ui.R - Core parts

parentHeights <- as.list(sort(unique(galton$parent)))
shinyUI(fluidPage(titlePanel
 ("Guess your Child Height based on your own height"),
 sidebarLayout(sidebarPanel(selectInput(
 "parentHeight", label = h4("Parent Height:"),
 choices = parentHeights, selected = 66.5) ),
 mainPanel(tabsetPanel(type = "tabs",
 tabPanel("Histogram", br(), plotOutput("newHist") ),
 tabPanel("Help", br(), h3("What's your guess?"),
 rest of help text) ) ) ) ) )
              
Note: Left box is centered align 
      due to known slidify bug.
```
*** =right
```
server.R
library(shiny)
library(data.table)
library(UsingR)
data(galton)
shinyServer(
function(input, output) {
 output$newHist <- renderPlot({
 hist(galton$child, xlab='Child Heights', 
 col='lightblue',main='Histogram')
 ht <- input$parentHeight
 dt <- data.table(galton, key="parent")
 cht <- round(dt[parent == ht,mean(child)],1)
 lines(c(ht, ht), c(0, 200),col="blue",lwd=2)
 lines(c(cht, cht), c(0, 200),col="red",lwd=2)
 text(63, 150, paste("Parent Height (blue) = ", ht))
 text(63, 140, paste("Avg Child Height (red) = ", cht))
}) } )

```
*** =fullwidth
