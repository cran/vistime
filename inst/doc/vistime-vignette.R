## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(vistime)

## ----vistime_basic_ex, warning=FALSE, fig.height=1, out.width="100%"----------
library(vistime)

timeline_data <- data.frame(event = c("Event 1", "Event 2"), 
                            start = c("2020-06-06", "2020-10-01"), 
                            end = c("2020-10-01", "2020-12-31"), 
                            group = "My Events")

vistime(timeline_data)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("vistime")

## ----eval = FALSE-------------------------------------------------------------
#  vistime(data,
#          col.event = "event",
#          col.start = "start",
#          col.end = "end",
#          col.group = "group",
#          col.color = "color",
#          col.fontcolor = "fontcolor",
#          col.tooltip = "tooltip",
#          optimize_y = TRUE,
#          linewidth = NULL,
#          title = NULL,
#          show_labels = TRUE,
#          background_lines = NULL)

## ----presidents example, fig.height=3, out.width="100%"-----------------------
pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
                   Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
                   start = c("1789-03-29", "1797-02-03", "1801-02-03"),
                   end = c("1797-02-03", "1801-02-03", "1809-02-03"),
                   color = c('#cbb69d', '#603913', '#c69c6e'),
                   fontcolor = c("black", "white", "black"))
                  
vistime(pres, 
        col.event = "Position", 
        col.group = "Name", 
        title = "Presidents of the USA")

## ----project planning example, fig.height=5, out.width="100%"-----------------
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
                           
vistime(data)

## ----gantt_true, fig.height=1.8, out.width="100%"-----------------------------
data <- read.csv(text="event,start,end
                       Phase 1,2020-12-15,2020-12-24
                       Phase 2,2020-12-23,2020-12-29
                       Phase 3,2020-12-28,2021-01-06
                       Phase 4,2021-01-06,2021-02-02")
        
vistime(data, optimize_y = TRUE, linewidth = 25)

## ----gantt_false, fig.height=2.5, out.width="100%"----------------------------
vistime(data, optimize_y = FALSE, linewidth = 25)

## ----eval=FALSE---------------------------------------------------------------
#  # webshot::install_phantomjs()
#  chart <- vistime(pres, col.event = "Position")
#  plotly::export(chart, file = "presidents.pdf")

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
#    ui = plotly::plotlyOutput("myVistime"),
#    server = function(input, output) {
#      output$myVistime <- plotly::renderPlotly({
#        vistime(pres, col.event = "Position", col.group = "Name")
#      })
#    }
#  )

## ----plotly_customization, fig.height=2.5, out.width="100%", message=FALSE----
library(plotly)

p2 <- vistime(data,
              optimize_y = T, 
              col.group = "event",
              title = "Plotly customization example")

p2 %>% layout(xaxis=list(fixedrange=TRUE, tickfont=list(size=30, color="violet")), 
              yaxis=list(fixedrange=TRUE, tickfont=list(size=30, color="red"), tickangle=30,
                         mirror = FALSE, range = c(0.7, 3.5), showgrid = T),
              plot_bgcolor = "lightgreen") 

## ----plotly_build1, fig.height=3, out.width="100%"----------------------------
pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
                   Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
                   start = c("1789-03-29", "1797-02-03", "1801-02-03"),
                   end = c("1797-02-03", "1801-02-03", "1809-02-03"),
                   color = c('#cbb69d', '#603913', '#c69c6e'),
                   fontcolor = c("black", "white", "black"))
 
p <- vistime(pres, 
             col.event = "Position",
             col.group = "Name", 
             title = "Presidents of the USA")

# step 1: transform into a list
pp <- plotly::plotly_build(p)

# step 2: change the font size
pp$x$layout$xaxis$tickfont <- list(size = 28)

pp

## ----plotly_build2, fig.height=3, out.width="100%"----------------------------
pp$x$layout[["yaxis"]]$tickfont <- list(size = 28)
pp

## ----plotly_build3, fig.height=3, out.width="100%"----------------------------
pres <- data.frame(Position = rep(c("President", "Vice"), each = 3),
                    Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
                    start = c("1789-03-29", "1797-02-03", "1801-02-03"),
                    end = c("1797-02-03", "1801-02-03", "1809-02-03"),
                    color = c('#cbb69d', '#603913', '#c69c6e'),
                    fontcolor = c("black", "white", "black"))
 
p <- vistime(pres, 
             col.event = "Position",
             col.group = "Name", 
             title = "Presidents of the USA",
             linewidth=30)

# step 1: transform into a list
pp <- plotly::plotly_build(p)

# step 2: loop over pp$x$data, and change the font size of all text elements to 28
for(i in seq_along(pp$x$data)){
    if(pp$x$data[[i]]$mode == "text") pp$x$data[[i]]$textfont$size <- 28
}

#' # or, using purrr:
#' text_idx <- which(purrr::map_chr(pp$x$data, "mode") == "text")
#' for(i in text_idx) pp$x$data[[i]]$textfont$size <- 28
#' pp

pp

## ----plotly_build4, fig.height=2, out.width="100%"----------------------------
dat <- data.frame(event = 1:4, start = c("2019-01-01", "2019-01-10"))
 
p <- vistime(dat)

# step 1: transform into a list
pp <- plotly::plotly_build(p)

# step 2: loop over pp$x$data, and change the marker size of all text elements to 50px
for(i in seq_along(pp$x$data)){
    if(pp$x$data[[i]]$mode == "markers") pp$x$data[[i]]$marker$size <- 20
}

# or, using purrr:
# marker_idx <- which(purrr::map_chr(pp$x$data, "mode") == "markers")
# for(i in marker_idx) pp$x$data[[i]]$marker$size <- 20
# pp

pp


