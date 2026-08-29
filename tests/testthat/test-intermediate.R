library(testthat)

test_that("apply family works", {
  mat <- matrix(1:12, nrow = 3)
  expect_equal(apply(mat, 1, sum), c(22, 26, 30))
  expect_equal(apply(mat, 2, sum), c(6, 15, 24, 33))
  lst <- list(a = 1:3, b = 4:6)
  expect_equal(sapply(lst, mean), c(a = 2, b = 5))
  expect_equal(vapply(lst, mean, numeric(1)), c(a = 2, b = 5))
  expect_equal(mapply(sum, 1:3, 4:6), c(5, 7, 9))
})

test_that("functional programming closures", {
  make_power <- function(n) function(x) x^n
  expect_equal(make_power(2)(5), 25)
  expect_equal(make_power(3)(2), 8)
  expect_equal(Reduce("+", 1:5), 15)
  expect_equal(Filter(function(x) x %% 2 == 0, 1:6), c(2, 4, 6))
})

test_that("error handling", {
  safe <- function(x) tryCatch(stop("err"), error = function(e) "caught")
  expect_equal(safe(1), "caught")
  expect_error(stop("test error"))
  expect_true(inherits(try(log("a"), silent = TRUE), "try-error"))
})

test_that("file I/O", {
  df <- data.frame(a = 1:3, b = letters[1:3], stringsAsFactors = FALSE)
  tmp_csv <- tempfile(fileext = ".csv")
  tmp_rds <- tempfile(fileext = ".rds")
  write.csv(df, tmp_csv, row.names = FALSE)
  expect_true(file.exists(tmp_csv))
  df2 <- read.csv(tmp_csv, stringsAsFactors = FALSE)
  expect_equal(nrow(df2), 3)
  saveRDS(df, tmp_rds)
  expect_equal(readRDS(tmp_rds), df)
  unlink(c(tmp_csv, tmp_rds))
  tmp_txt <- tempfile(fileext = ".txt")
  writeLines(c("hello", "world"), tmp_txt)
  expect_equal(readLines(tmp_txt), c("hello", "world"))
  unlink(tmp_txt)
})

test_that("dates and times", {
  d1 <- as.Date("2024-01-01")
  d2 <- as.Date("2024-01-10")
  expect_equal(as.numeric(d2 - d1), 10)
  expect_equal(class(d1), "Date")
  expect_equal(format(as.Date("2024-01-15"), "%Y-%m-%d"), "2024-01-15")
  start <- as.POSIXct("2024-01-01 09:00:00")
  end <- as.POSIXct("2024-01-01 10:30:00")
  expect_equal(as.numeric(difftime(end, start, units = "hours")), 1.5)
})

test_that("regex strings", {
  expect_equal(gsub("a", "X", "banana"), "bXnXnX")
  expect_equal(sub("a", "X", "banana"), "bXnana")
  expect_true(grepl("^a", "apple"))
  expect_equal(grep("an", c("apple", "banana", "cherry")), 2)
  expect_equal(strsplit("a,b,c", ",")[[1]], c("a", "b", "c"))
})

test_that("missing values", {
  v <- c(1, 2, NA, 4)
  expect_true(is.na(v[3]))
  expect_equal(mean(v, na.rm = TRUE), mean(c(1, 2, 4)))
  df <- data.frame(a = c(1, NA, 3), b = c(4, 5, NA))
  expect_equal(sum(complete.cases(df)), 0)
  expect_equal(nrow(na.omit(df)), 0)
})

test_that("OOP S3 S4", {
  person_new <- function(name, age) { obj <- list(name = name, age = age); class(obj) <- "person"; obj }
  p <- person_new("Alice", 30)
  expect_equal(class(p), "person")
  greet <- function(x) UseMethod("greet")
  greet.person <- function(x) paste("Hi", x$name)
  greet.default <- function(x) "unknown"
  expect_equal(greet(p), "Hi Alice")
  setClass("TestStudent2", slots = list(name = "character", gpa = "numeric"))
  s <- new("TestStudent2", name = "Bob", gpa = 3.5)
  expect_equal(s@name, "Bob")
})
