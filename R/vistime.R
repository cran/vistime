#' Create a Timeline rendered by Plotly
#'
#' Provide a data frame with event data to create a visual and interactive timeline plot rendered by Plotly.
#' Simplest drawable dataframe can have columns `event` and `start`.
#'
#' @param data \code{data.frame} that contains the data to be visualized
#' @param col.event (optional, character) the column name in \code{data} that contains event
#'   names. Default: \emph{event}.
#' @param col.start (optional, character) the column name in \code{data} that contains start
#'   dates. Default: \emph{start}.
#' @param col.end (optional, character) the column name in \code{data} that contains end dates.
#'   Default: \emph{end}.
#' @param col.group (optional, character) the column name in \code{data} to be used for
#'   grouping. Default: \emph{group}.
#' @param col.color (optional, character) the column name in \code{data} that contains colors
#'   for events. Default: \emph{color}, if not present, colors are chosen via
#'   \code{RColorBrewer}.
#' @param col.fontcolor (optional, character) the column name in \code{data} that contains the
#'   font color for event labels. Default: \emph{fontcolor}, if not present,
#'   color will be black.
#' @param col.tooltip (optional, character) the column name in \code{data} that contains the
#'   mouseover tooltips for the events. Default: \emph{tooltip}, if not present,
#'   then tooltips are built from event name and date.
#' @param optimize_y (optional, logical) distribute events on y-axis by smart heuristic
#'   (default), otherwise use order of input data.
#' @param linewidth (optional, numeric) the linewidth (in pixel) for the events
#'   (typically used for large amount of parallel events). Default: heuristic value.
#' @param title (optional, character) the title to be shown on top of the timeline.
#'   Default: \code{NULL}.
#' @param show_labels (optional, boolean) choose whether or not event labels shall be
#'   visible. Default: \code{TRUE}.
#' @param background_lines (optional, integer) the number of vertical lines to draw in the
#'   background to demonstrate structure (default: 10). Less means more memory-efficient plot.
#' @param ... for deprecated arguments up to vistime 1.1.0 (like events, colors, ...)
#' @seealso Functions \code{?hc_vistime} and \code{?gg_vistime} for different charting engines (Highcharts and ggplot2).
#' @export
#' @return \code{vistime} returns an object of class \code{plotly} and \code{htmlwidget}.
#' @examples
#' # presidents and vice presidents
#' pres <- data.frame(
#'   Position = rep(c("President", "Vice"), each = 3),
#'   Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
#'   start = c("1789-03-29", "1797-02-03", "1801-02-03"),
#'   end = c("1797-02-03", "1801-02-03", "1809-02-03"),
#'   color = c("#cbb69d", "#603913", "#c69c6e"),
#'   fontcolor = c("black", "white", "black")
#' )
#'
#' vistime(pres, col.event = "Position", col.group = "Name", title = "Presidents of the USA")
#'
#'
#' \dontrun{
#' # Argument`optimize_y` can be used to change the look of the timeline. `TRUE` (the default)
#' # will find a nice heuristic to save `y`-space, distributing the events:
#' data <- read.csv(text="event,start,end
#'                        Phase 1,2020-12-15,2020-12-24
#'                        Phase 2,2020-12-23,2020-12-29
#'                        Phase 3,2020-12-28,2021-01-06
#'                        Phase 4,2021-01-06,2021-02-02")
#'
#' vistime(data, optimize_y = TRUE)
#'
#' # `FALSE` will plot events as-is, not saving any space:
#' vistime(data, optimize_y = FALSE)
#'
#'
#' # more complex and colorful example
#' data <- read.csv(text = "event,group,start,end,color
#' Phase 1,Project,2018-12-22,2018-12-23,#c8e6c9
#' Phase 2,Project,2018-12-23,2018-12-29,#a5d6a7
#' Phase 3,Project,2018-12-29,2019-01-06,#fb8c00
#' Phase 4,Project,2019-01-06,2019-02-02,#DD4B39
#' Room 334,Team 1,2018-12-22,2018-12-28,#DEEBF7
#' Room 335,Team 1,2018-12-28,2019-01-05,#C6DBEF
#' Room 335,Team 1,2019-01-05,2019-01-23,#9ECAE1
#' Group 1,Team 2,2018-12-22,2018-12-28,#E5F5E0
#' Group 2,Team 2,2018-12-28,2019-01-23,#C7E9C0
#' 3-200,category 1,2018-12-25,2018-12-25,#1565c0
#' 3-330,category 1,2018-12-25,2018-12-25,#1565c0
#' 3-223,category 1,2018-12-28,2018-12-28,#1565c0
#' 3-225,category 1,2018-12-28,2018-12-28,#1565c0
#' 3-226,category 1,2018-12-28,2018-12-28,#1565c0
#' 3-226,category 1,2019-01-19,2019-01-19,#1565c0
#' 3-330,category 1,2019-01-19,2019-01-19,#1565c0
#' 1-217.0,category 2,2018-12-27,2018-12-27,#90caf9
#' 3-399.7,moon rising,2019-01-13,2019-01-13,#f44336
#' 8-831.0,sundowner drink,2019-01-17,2019-01-17,#8d6e63
#' 9-984.1,birthday party,2018-12-22,2018-12-22,#90a4ae
#' F01.9,Meetings,2018-12-26,2018-12-26,#e8a735
#' Z71,Meetings,2019-01-12,2019-01-12,#e8a735
#' B95.7,Meetings,2019-01-15,2019-01-15,#e8a735
#' T82.7,Meetings,2019-01-15,2019-01-15,#e8a735")
#'
#' vistime(data)
#'
#' # ------ It is possible to change all attributes of the timeline using plotly_build(),
#' # ------ which generates a list which can be inspected using str
#' p <- vistime(data.frame(event = 1:4, start = c("2019-01-01", "2019-01-10")))
#' pp <- plotly_build(p) # transform into a list
#'
#' # Example 1: change x axis font size:
#' pp$x$layout$xaxis$tickfont <- list(size = 28)
#' pp
#'
#' # Example 2: change y axis font size:
#' pp$x$layout[["yaxis"]]$tickfont <- list(size = 28)
#' pp
#'
#' # Example 3: Changing events font size
#' for (i in 1:length(pp$x$data)) {
#'   if (pp$x$data[[i]]$mode == "text") pp$x$data[[i]]$textfont$size <- 28
#' }
#' pp
#'
#' # or, using purrr:
#' text_idx <- which(purrr::map_chr(pp$x$data, "mode") == "text")
#' for(i in text_idx) pp$x$data[[i]]$textfont$size <- 28
#' pp
#'
#' # Example 4: change marker size
#' # loop over pp$x$data, and change the marker size of all text elements to 50px
#' for (i in 1:length(pp$x$data)) {
#'   if (pp$x$data[[i]]$mode == "markers") pp$x$data[[i]]$marker$size <- 40
#' }
#' pp
#'
#' # or, using purrr:
#' marker_idx <- which(purrr::map_chr(pp$x$data, "mode") == "markers")
#' for(i in marker_idx) pp$x$data[[i]]$marker$size <- 40
#' pp
#' }
#'
vistime <- function(data,
                    col.event = "event",
                    col.start = "start",
                    col.end = "end",
                    col.group = "group",
                    col.color = "color",
                    col.fontcolor = "fontcolor",
                    col.tooltip = "tooltip",
                    optimize_y = TRUE, linewidth = NULL, title = NULL,
                    show_labels = TRUE, background_lines = NULL, ...) {

  checked_dat <- validate_input(data, col.event, col.start, col.end, col.group, col.color,
                                col.fontcolor, col.tooltip, optimize_y, linewidth, title,
                                show_labels, background_lines, list(...))

  cleaned_dat <- vistime_data(checked_dat$data, checked_dat$col.event, checked_dat$col.start,
                              checked_dat$col.end, checked_dat$col.group, checked_dat$col.color,
                              checked_dat$col.fontcolor, checked_dat$col.tooltip, optimize_y)

  total <- plot_plotly(cleaned_dat, linewidth, title, show_labels, background_lines)

  return(total)
}
