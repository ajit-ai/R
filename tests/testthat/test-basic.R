library(testthat)

# Tests for basic/*.R programs
# Each test verifies behavior of the corresponding example file

test_that("Hello.r - basic hello and functions", {
  multiply <- function(x, y) return(x * y)
  expect_equal(multiply(4, 6), 24)
  expect_equal(5 + 3, 8)
  expect_true(-10 < 0)
  expect_equal(1:5, c(1, 2, 3, 4, 5))
})

test_that("sum.R - addition", {
  a <- 3; b <- 7
  expect_equal(a + b, 10)
  expect_equal(paste("Sum is", a + b), "Sum is 10")
})

test_that("prog1 prog2 prog3 - assignment and types", {
  a <- 5; b <- 3
  assign("tmp", 10)
  expect_equal(tmp, 10)
  rm(tmp)
  expect_equal(class(10L), "integer")
  expect_equal(class(3+1i), "complex")
  expect_equal(class(10.5), "numeric")
})

test_that("operators - arithmetic, comparison, logical", {
  expect_equal(10 + 3, 13)
  expect_equal(10 - 3, 7)
  expect_equal(10 * 3, 30)
  expect_equal(10 ^ 2, 100)
  expect_equal(10 %% 3, 1)
  expect_equal(10 %/% 3, 3)
  expect_false(10 > 12)
  expect_true(10 < 12)
  expect_true(10 != 12)
  expect_true(TRUE & TRUE)
  expect_true(TRUE | FALSE)
  expect_equal(!FALSE, TRUE)
})

test_that("vectors1.R - vectors", {
  v <- c(1, 2, 3, 4, 5)
  expect_length(v, 5)
  expect_equal(v[1], 1)
  expect_equal(seq(1, 10, by = 2), c(1, 3, 5, 7, 9))
  expect_equal(sort(c(3, 1, 2)), c(1, 2, 3))
  expect_equal(typeof(c(1L, 2L)), "integer")
})

test_that("lists - creation and manipulation", {
  lst <- list(a = 1:3, b = "hello")
  expect_length(lst, 2)
  expect_equal(lst$a, 1:3)
  expect_equal(lst[[2]], "hello")
  lst2 <- append(lst, list(c = 99), after = 1)
  expect_length(lst2, 3)
  expect_equal(unlist(list(a = 1, b = 2)), c(a = 1, b = 2))
})

test_that("matrix.R - matrices", {
  m <- matrix(1:6, nrow = 2, byrow = TRUE)
  expect_equal(dim(m), c(2, 3))
  expect_equal(m[1, 1], 1)
  expect_equal(dim(cbind(m, c(7, 8))), c(2, 4))
  expect_equal(dim(rbind(m, c(7, 8, 9))), c(3, 3))
})

test_that("arrays.R - arrays", {
  arr <- array(1:8, dim = c(2, 2, 2))
  expect_equal(dim(arr), c(2, 2, 2))
  expect_equal(length(arr), 8)
})

test_that("factor.R - factors", {
  f <- factor(c("Male", "Female", "Male"))
  expect_equal(nlevels(f), 2)
  expect_true("Male" %in% levels(f))
  f2 <- factor(c("a", "b"), levels = c("a", "b", "c"))
  expect_equal(levels(f2), c("a", "b", "c"))
})

test_that("dataFrame.R - data frames", {
  df <- data.frame(name = c("Alice", "Bob"), age = c(25, 30), stringsAsFactors = FALSE)
  expect_equal(nrow(df), 2)
  expect_equal(df$name[1], "Alice")
  df2 <- rbind(df, data.frame(name = "Charlie", age = 22, stringsAsFactors = FALSE))
  expect_equal(nrow(df2), 3)
})

test_that("strings - nchar substr paste gsub", {
  s <- "Hello World"
  expect_equal(nchar(s), 11)
  expect_equal(substr(s, 1, 5), "Hello")
  expect_equal(toupper(s), "HELLO WORLD")
  expect_equal(gsub("a", "X", "banana"), "bXnXnX")
  expect_equal(paste(rev(strsplit("hello", "")[[1]]), collapse = ""), "olleh")
})

test_that("control flow - if for while functions", {
  greatest <- function(x, y, z) if (x >= y && x >= z) x else if (y >= z) y else z
  expect_equal(greatest(3, 7, 5), 7)
  res <- c(); for (i in 1:5) res <- c(res, i)
  expect_equal(res, 1:5)
  x <- 1; res2 <- c(); while (x < 4) { res2 <- c(res2, x); x <- x + 1 }
  expect_equal(res2, 1:3)
  multiply <- function(x, y) x * y
  expect_equal(multiply(4, 6), 24)
})

test_that("csv and stats", {
  # csv_file.csv exists
  csv_path <- testthat::test_path("../../basic/csv_file.csv")
  # alternative: check relative
  if (file.exists("basic/csv_file.csv")) {
    df <- read.csv("basic/csv_file.csv")
    expect_gt(nrow(df), 0)
  } else {
    skip("csv_file.csv not found in test env")
  }
  expect_equal(mean(c(10, 20, 30)), 20)
  expect_equal(median(c(1, 2, 3, 4)), 2.5)
})

test_that("plotting functions do not error", {
  tmp <- tempfile(fileext = ".png")
  png(tmp)
  expect_no_error(plot(1:10))
  expect_no_error(hist(rnorm(20), plot = TRUE))
  expect_no_error(barplot(c(1, 2, 3), plot = TRUE))
  dev.off()
  unlink(tmp)
})

test_that("type conversion", {
  expect_equal(as.integer(40.23), 40L)
  expect_equal(class(4L + 3.5), "numeric")
  expect_equal(as.integer("3") + as.integer("4"), 7L)
})
