## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(vistime)

## ----gg_vistime_basic_ex, warning=FALSE, fig.width=5, fig.height=1.5----------
timeline_data <- data.frame(event = c("Event 1", "Event 2"), 
                            start = c("2020-06-06", "2020-10-01"), 
                            end = c("2020-10-01", "2020-12-31"), 
                            group = "My Events")

gg_vistime(timeline_data)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("vistime")

## ----eval = FALSE-------------------------------------------------------------
#  gg_vistime(data,
#             col.event = "event",
#             col.start = "start",
#             col.end = "end",
#             col.group = "group",
#             col.color = "color",
#             col.fontcolor = "fontcolor",
#             optimize_y = TRUE,
#             linewidth = NULL,
#             title = NULL,
#             show_labels = TRUE,
#             background_lines = NULL)
#  

## ----presidents example, fig.height = 2.5, fig.width=5------------------------
pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
                   Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
                   start = c("1789-03-29", "1797-02-03", "1801-02-03"),
                   end = c("1797-02-03", "1801-02-03", "1809-02-03"),
                   color = c('#cbb69d', '#603913', '#c69c6e'),
                   fontcolor = c("black", "white", "black"))
                  
gg_vistime(pres, col.event = "Position", col.group = "Name", title = "Presidents of the USA")

## ----project planning example, fig.height = 4.5, fig.width=10-----------------
data <- read.csv(text="event,group,start,end,color
                       Phase 1,Project,2016-12-22,2016-12-23,#c8e6c9
                       Phase 2,Project,2016-12-23,2016-12-29,#a5d6a7
                       Phase 3,Project,2016-12-29,2017-01-06,#fb8c00
                       Phase 4,Project,2017-01-06,2017-02-02,#DD4B39
                       Room 334,Team 1,2016-12-22,2016-12-28,#DEEBF7
                       Room 335,Team 1,2016-12-28,2017-01-05,#C6DBEF
                       Room 335,Team 1,2017-01-05,2017-01-23,#9ECAE1
                       Group 1,Team 2,2016-12-22,2016-12-28,#E5F5E0
                       Group 2,Team 2,2016-12-28,2017-01-23,#C7E9C0
                       3-200,category 1,2016-12-25,2016-12-25,#1565c0
                       3-330,category 1,2016-12-25,2016-12-25,#1565c0
                       3-223,category 1,2016-12-28,2016-12-28,#1565c0
                       3-225,category 1,2016-12-28,2016-12-28,#1565c0
                       3-226,category 1,2016-12-28,2016-12-28,#1565c0
                       3-226,category 1,2017-01-19,2017-01-19,#1565c0
                       3-330,category 1,2017-01-19,2017-01-19,#1565c0
                       1-217.0,category 2,2016-12-27,2016-12-27,#90caf9
                       4-399.7,moon rising,2017-01-13,2017-01-13,#f44336
                       8-831.0,sundowner drink,2017-01-17,2017-01-17,#8d6e63
                       9-984.1,birthday party,2016-12-22,2016-12-22,#90a4ae
                       F01.9,Meetings,2016-12-26,2016-12-26,#e8a735
                       Z71,Meetings,2017-01-12,2017-01-12,#e8a735
                       B95.7,Meetings,2017-01-15,2017-01-15,#e8a735
                       T82.7,Meetings,2017-01-15,2017-01-15,#e8a735")
                           
gg_vistime(data)

## ----gantt_true, fig.height = 2.3, fig.width=6--------------------------------
data <- read.csv(text="event,start,end
                       Phase 1,2020-12-15,2020-12-24
                       Phase 2,2020-12-23,2020-12-29
                       Phase 3,2020-12-28,2021-01-06
                       Phase 4,2021-01-06,2021-02-02")
        
gg_vistime(data, optimize_y = TRUE, linewidth = 25)

## ----gantt_false, fig.height = 3.7, fig.width=6-------------------------------
gg_vistime(data, optimize_y = FALSE, linewidth = 25)

## ----eval=FALSE---------------------------------------------------------------
#  chart <- vistime(pres, col.event = "Position")
#  ggplot2::ggsave("presidents.png", timeline)

## ----eval=FALSE---------------------------------------------------------------
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
#    ui = plotOutput("myVistime"),
#    server = function(input, output) {
#      output$myVistime <- renderPlot({
#        vistime(pres, col.event = "Position", col.group = "Name")
#      })
#    }
#  )

## ----gg_customization, fig.height=2.5, fig.width=5, message=FALSE-------------
library(vistime)
data <- read.csv(text="event,start,end
                       Phase 1,2020-12-15,2020-12-24
                       Phase 2,2020-12-23,2020-12-29
                       Phase 3,2020-12-28,2021-01-06
                       Phase 4,2021-01-06,2021-02-02")
        
p <- gg_vistime(data, optimize_y = T, col.group = "event", title = "ggplot customization example")

library(ggplot2)
p + ggplot2::theme(
      plot.title = element_text(hjust = 0, size=10),
      axis.text.x = element_text(size = 10, color = "violet"),
      axis.text.y = element_text(size = 10, color = "red", angle = 30),
      panel.border = element_rect(linetype = "dashed", fill=NA),
      panel.background = element_rect(fill = 'green')) +
    coord_cartesian(ylim = c(0.7, 3.5))


