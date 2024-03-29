% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vistime_data.R
\name{vistime_data}
\alias{vistime_data}
\title{Standardize data to plot on a timeline plot}
\usage{
vistime_data(
  data,
  col.event = "event",
  col.start = "start",
  col.end = "end",
  col.group = "group",
  col.color = "color",
  col.fontcolor = "fontcolor",
  col.tooltip = "tooltip",
  optimize_y = TRUE,
  ...
)
}
\arguments{
\item{data}{\code{data.frame} that contains the data to be normalized}

\item{col.event}{(optional, character) the column name in \code{data} that contains event
names. Default: \emph{event}.}

\item{col.start}{(optional, character) the column name in \code{data} that contains start
dates. Default: \emph{start}.}

\item{col.end}{(optional, character) the column name in \code{data} that contains end dates.
Default: \emph{end}.}

\item{col.group}{(optional, character) the column name in \code{data} to be used for
grouping. Default: \emph{group}.}

\item{col.color}{(optional, character) the column name in \code{data} that contains colors
for events. Default: \emph{color}, if not present, colors are chosen via
\code{RColorBrewer}.}

\item{col.fontcolor}{(optional, character) the column name in \code{data} that contains the
font color for event labels. Default: \emph{fontcolor}, if not present,
color will be black.}

\item{col.tooltip}{(optional, character) the column name in \code{data} that contains the
mouseover tooltips for the events. Default: \emph{tooltip}, if not present,
then tooltips are built from event name and date.}

\item{optimize_y}{(optional, logical) distribute events on y-axis by smart heuristic (default), otherwise use order of input data.}

\item{...}{for deprecated arguments up to vistime 1.1.0 (like events, colors, ...)}
}
\value{
\code{vistime_data} returns a data.frame with the following columns: event, start, end, group, tooltip, label, col, fontcol, subplot, y
}
\description{
Standardize data to plot on a timeline plot
}
\examples{
# presidents and vice presidents
pres <- data.frame(
  Position = rep(c("President", "Vice"), each = 3),
  Name = c("Washington", rep(c("Adams", "Jefferson"), 2), "Burr"),
  start = c("1789-03-29", "1797-02-03", "1801-02-03"),
  end = c("1797-02-03", "1801-02-03", "1809-02-03"),
  color = c("#cbb69d", "#603913", "#c69c6e"),
  fontcolor = c("black", "white", "black")
)

vistime_data(pres, col.event = "Position", col.group = "Name")
}
