# example data frame
dat <- data.frame(event = 1:2, start = c("2019-01-05", "2019-01-06"), stringsAsFactors = FALSE)

# shortcut that fills standard arguments
fix_columns2 <- function(data,
                         col.event = "event",
                         col.start = "start",
                         col.end = "end",
                         col.group = "group",
                         col.color = "color",
                         col.fontcolor = "fontcolor",
                         col.tooltip = "tooltip"){
  fix_columns(data, col.event, col.start, col.end, col.group, col.color,
              col.fontcolor, col.tooltip)
}

test_that("new columns", {
  result <- fix_columns2(dat)
  cols_expected <- c("event", "start", "end", "group", "tooltip", "label", "col", "fontcol")

  expect_equal(names(result), cols_expected)
  expect_equal(result$start, result$end)

  expect_equal(unique(result$group), "")

  expect_setequal(
    names(fix_columns2(
      data.frame(DASEVENT = 1:2, DERSTART = c("2019-01-01", "2019-01-02"), DASENDE = "2019-01-10", DIEGRUPPE = 1, col = "", fontcol = ""),
      "DASEVENT", "DERSTART", "DASENDE", "DIEGRUPPE")),
    cols_expected
  )

  groups_equal_events <- fix_columns2(
    data.frame(DASEVENT = 1:2, DERSTART = c("2019-01-01", "2019-01-02"), DASENDE = "2019-01-10", col = "", fontcol = ""),
    "DASEVENT", "DERSTART", "DASENDE", "DASEVENT")
  expect_setequal(
    names(groups_equal_events),
    cols_expected
  )

  expect_equal(groups_equal_events$event, as.character(groups_equal_events$group))
})


test_that("POSIXct conversion", {
  dat$start <- "2014-01-01"
  expect_s3_class(fix_columns2(dat)$start, "POSIXct")

  dat$start <- "2014/01/01"
  expect_s3_class(fix_columns2(dat)$start, "POSIXct")

  dat$start <-"2014/01/01 15:50"
  expect_s3_class(fix_columns2(dat)$start, "POSIXct")

  dat$start <-"2014-01:01"
  expect_error(fix_columns(dat))
})

test_that("factor conversion", {
  dat$event <- "1"
  expect_type(fix_columns2(dat)$event, "character")
})

test_that("missing end dates", {
  dat$end <- c("2014-01-02", NA)
  expect_equal(fix_columns2(dat)$end, as.POSIXct(c("2014-01-02", dat$start[2])))
})

test_that("color columns are untouched", {
  expect_length(names(fix_columns2(dat)), 8)

  dat[, c("color", "fontcolor", "unabhaengigeSpalte", "Spalte5")] <- "irgendwas"
  expect_length(names(fix_columns2(dat)), 8)
})

test_that("tooltips", {
  dat$tooltip <- 1:2
  expect_equal(fix_columns2(dat)$tooltip, as.character(1:2))

  dat$MYTOOLTIPS <- 1:2
  expect_equal(fix_columns2(dat, col.tooltip = "MYTOOLTIPS")$tooltip, as.character(1:2))
})

test_that("whitespace is trimmed", {
  dat <- data.frame(event = c("a", "  b"),
                    start = c("2019-01-05", "2019-01-06"),
                    groups = c("a", "  a"), 
                    stringsAsFactors = TRUE)
  expect_equal(fix_columns2(dat, col.group = "groups")$group, factor(c("a", "a"), levels = "a"))
  expect_equal(fix_columns2(dat, col.group = "groups")$event, c("a", "b"))
})

test_that('Group column remains unchanged', {
    dat <- data.frame(
        event = c("Event B", "Event A", "Event C"),
        start = c("1789-03-29", "1797-02-03", "1801-02-03"),
        end = c("1797-02-03", "1801-02-03", "1809-02-03"),
        group = factor(c('b', 'a', 'c'), levels = c('a', 'b', 'c'))
        )
    expect_equal(fix_columns2(dat)$group,
                 factor(c('b', 'a', 'c'), levels = c('a', 'b', 'c')))
    dat <- data.frame(
        event = c("Event B", "Event A", "Event C"),
        start = c("1789-03-29", "1797-02-03", "1801-02-03"),
        end = c("1797-02-03", "1801-02-03", "1809-02-03"),
        group = c('b', 'a', 'c')
        )
    expect_equal(fix_columns2(dat)$group,
                 c('b', 'a', 'c'))
    dat <- data.frame(
        event = c("Event B", "Event A", "Event C"),
        start = c("1789-03-29", "1797-02-03", "1801-02-03"),
        end = c("1797-02-03", "1801-02-03", "1809-02-03"),
        group = 1:3
        )
    expect_equal(fix_columns2(dat)$group,
                 as.character(1:3))
})

