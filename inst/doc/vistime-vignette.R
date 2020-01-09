## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE----------------------------------------------------------
#  install.packages("vistime")

## ----eval = FALSE, echo = FALSE------------------------------------------
#  if(!require("devtools")) install.packages("devtools")
#  devtools::install_github("shosaco/vistime")

## ----eval=FALSE----------------------------------------------------------
#  library(vistime)

## ----eval=FALSE----------------------------------------------------------
#  vistime(data, start = "start", end = "end", groups = "group", events = "event", colors = "color",
#                fontcolors = "fontcolor", tooltips = "tooltip", optimize_y = TRUE, linewidth = NULL,
#                title = NULL, show_labels = TRUE, background_lines = 10)

## ----eval=FALSE----------------------------------------------------------
#  pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
#                     Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
#                     start = c("1789-03-29", "1797-02-03", "1801-02-03"),
#                     end = c("1797-02-03", "1801-02-03", "1809-02-03"),
#                     color = c('#cbb69d', '#603913', '#c69c6e'),
#                     fontcolor = c("black", "white", "black"))
#  
#  vistime(pres, events="Position", groups="Name", title="Presidents of the USA")

## ---- echo=FALSE, out.width = "100%"-------------------------------------
knitr::include_graphics("../inst/img/ex2.png")

## ----eval=FALSE----------------------------------------------------------
#  data <- read.csv(text="event,group,start,end,color
#                         Phase 1,Project,2016-12-22,2016-12-23,#c8e6c9
#                         Phase 2,Project,2016-12-23,2016-12-29,#a5d6a7
#                         Phase 3,Project,2016-12-29,2017-01-06,#fb8c00
#                         Phase 4,Project,2017-01-06,2017-02-02,#DD4B39
#                         Room 334,Team 1,2016-12-22,2016-12-28,#DEEBF7
#                         Room 335,Team 1,2016-12-28,2017-01-05,#C6DBEF
#                         Room 335,Team 1,2017-01-05,2017-01-23,#9ECAE1
#                         Group 1,Team 2,2016-12-22,2016-12-28,#E5F5E0
#                         Group 2,Team 2,2016-12-28,2017-01-23,#C7E9C0
#                         1-217.0,category 2,2016-12-27,2016-12-27,#90caf9
#                         3-200,category 1,2016-12-25,2016-12-25,#1565c0
#                         3-330,category 1,2016-12-25,2016-12-25,#1565c0
#                         3-223,category 1,2016-12-28,2016-12-28,#1565c0
#                         3-225,category 1,2016-12-28,2016-12-28,#1565c0
#                         3-226,category 1,2016-12-28,2016-12-28,#1565c0
#                         3-226,category 1,2017-01-19,2017-01-19,#1565c0
#                         3-330,category 1,2017-01-19,2017-01-19,#1565c0
#                         4-399.7,moon rising,2017-01-13,2017-01-13,#f44336
#                         8-831.0,sundowner drink,2017-01-17,2017-01-17,#8d6e63
#                         9-984.1,birthday party,2016-12-22,2016-12-22,#90a4ae
#                         F01.9,Meetings,2016-12-26,2016-12-26,#e8a735
#                         Z71,Meetings,2017-01-12,2017-01-12,#e8a735
#                         B95.7,Meetings,2017-01-15,2017-01-15,#e8a735
#                         T82.7,Meetings,2017-01-15,2017-01-15,#e8a735")
#  
#  vistime(data)

## ----echo=FALSE, out.width = "100%"--------------------------------------
knitr::include_graphics("../inst/img/ex3.png")

## ----eval=FALSE----------------------------------------------------------
#  chart <- vistime(pres, events="Position")
#  export(chart, file = "presidents.pdf")

## ----eval=FALSE----------------------------------------------------------
#  library(shiny)
#  library(plotly)
#  library(vistime)
#  
#  pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
#                     Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
#                     start = c("1789-03-29", "1797-02-03", "1801-02-03"),
#                     end = c("1797-02-03", "1801-02-03", "1809-02-03"),
#                     color = c('#cbb69d', '#603913', '#c69c6e'),
#                     fontcolor = c("black", "white", "black"))
#  
#  shinyApp(
#    ui = plotlyOutput("myVistime"),
#    server = function(input, output) {
#      output$myVistime <- renderPlotly({
#        vistime(pres, events="Position", groups="Name")
#      })
#    }
#  )

## ----eval=FALSE----------------------------------------------------------
#  pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
#                     Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
#                     start = c("1789-03-29", "1797-02-03", "1801-02-03"),
#                     end = c("1797-02-03", "1801-02-03", "1809-02-03"),
#                     color = c('#cbb69d', '#603913', '#c69c6e'),
#                     fontcolor = c("black", "white", "black"))
#  
#  p <- vistime(pres, events="Position", groups="Name", title="Presidents of the USA")
#  
#  # step 1: transform into a list
#  pp <- plotly_build(p)
#  
#  # step 2: change the font size
#  pp$x$layout$xaxis$tickfont <- list(size = 28)
#  
#  pp

## ----echo=FALSE, out.width = "50%"---------------------------------------
knitr::include_graphics("../inst//img/ex2-tickfontsize.png")

## ----eval=FALSE----------------------------------------------------------
#  # loop through the yaxes and change the font size for each element:
#  for(i in grep("yaxis*", names(pp$x$layout))){
#       pp$x$layout[[i]]$tickfont <- list(size = 28)
#  }
#  
#  pp

## ----echo=FALSE, out.width = "50%"---------------------------------------
knitr::include_graphics("../inst//img/ex2-yfontsize.png")

## ----eval=FALSE----------------------------------------------------------
#  pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
#                      Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
#                      start = c("1789-03-29", "1797-02-03", "1801-02-03"),
#                      end = c("1797-02-03", "1801-02-03", "1809-02-03"),
#                      color = c('#cbb69d', '#603913', '#c69c6e'),
#                      fontcolor = c("black", "white", "black"))
#  
#  p <- vistime(pres, events="Position", groups="Name", title="Presidents of the USA")
#  
#  # step 1: transform into a list
#  pp <- plotly_build(p)
#  
#  # step 2: loop over pp$x$data, and change the font size of all text elements to 28
#  for(i in 1:length(pp$x$data)){
#      if(pp$x$data[[i]]$mode == "text") pp$x$data[[i]]$textfont$size <- 28
#  }
#  
#  #' # or, using purrr:
#  #' text_idx <- which(purrr::map_chr(pp$x$data, "mode") == "text")
#  #' for(i in text_idx) pp$x$data[[i]]$textfont$size <- 28
#  #' pp
#  
#  pp

## ----echo=FALSE, out.width = "50%"---------------------------------------
knitr::include_graphics("../inst//img/ex2-eventfontsize.png")

## ----eval=FALSE----------------------------------------------------------
#  dat <- data.frame(event = 1:4, start = c("2019-01-01", "2019-01-10"))
#  
#  p <- vistime(dat)
#  
#  # step 1: transform into a list
#  pp <- plotly_build(p)
#  
#  # step 2: loop over pp$x$data, and change the marker size of all text elements to 50px
#  for(i in 1:length(pp$x$data)){
#      if(pp$x$data[[i]]$mode == "markers") pp$x$data[[i]]$marker$size <- 10
#  }
#  
#  pp
#  
#  # or, using purrr:
#  # marker_idx <- which(purrr::map_chr(pp$x$data, "mode") == "markers")
#  # for(i in marker_idx) pp$x$data[[i]]$marker$size <- 10
#  # pp

## ----echo=FALSE, out.width = "50%"---------------------------------------
knitr::include_graphics("../inst//img/ex3-markersize.png")

