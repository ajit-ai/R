library(testthat)

test_that("sorting algorithms correctness", {
  bubble_sort <- function(vec) {
    n <- length(vec); v <- vec
    for (i in 1:(n - 1)) for (j in 1:(n - i)) if (v[j] > v[j + 1]) { tmp <- v[j]; v[j] <- v[j + 1]; v[j + 1] <- tmp }
    v
  }
  insertion_sort <- function(vec) {
    v <- vec; n <- length(v)
    for (i in 2:n) { key <- v[i]; j <- i - 1; while (j >= 1 && v[j] > key) { v[j + 1] <- v[j]; j <- j - 1 }; v[j + 1] <- key }
    v
  }
  merge_sort <- function(vec) {
    if (length(vec) <= 1) return(vec)
    mid <- floor(length(vec) / 2)
    left <- merge_sort(vec[1:mid]); right <- merge_sort(vec[(mid + 1):length(vec)])
    result <- numeric(0); i <- 1; j <- 1
    while (i <= length(left) && j <= length(right)) {
      if (left[i] <= right[j]) { result <- c(result, left[i]); i <- i + 1 } else { result <- c(result, right[j]); j <- j + 1 }
    }
    if (i <= length(left)) result <- c(result, left[i:length(left)])
    if (j <= length(right)) result <- c(result, right[j:length(right)])
    result
  }
  quick_sort <- function(vec) {
    if (length(vec) <= 1) return(vec)
    pivot <- vec[1]; rest <- vec[-1]
    c(quick_sort(rest[rest <= pivot]), pivot, quick_sort(rest[rest > pivot]))
  }
  v <- c(64, 34, 25, 12, 22, 11, 90)
  expect_equal(bubble_sort(v), sort(v))
  expect_equal(insertion_sort(v), sort(v))
  expect_equal(merge_sort(v), sort(v))
  expect_equal(quick_sort(v), sort(v))
  expect_equal(sort(v, method = "radix")[1:3], c(11, 12, 22))
})

test_that("searching algorithms", {
  linear_search <- function(vec, target) { for (i in seq_along(vec)) if (vec[i] == target) return(i); return(NA) }
  binary_search <- function(vec, target) {
    low <- 1; high <- length(vec)
    while (low <= high) { mid <- floor((low + high) / 2); if (vec[mid] == target) return(mid) else if (vec[mid] < target) low <- mid + 1 else high <- mid - 1 }
    return(NA)
  }
  expect_equal(linear_search(c(10, 20, 30), 20), 2)
  expect_true(is.na(linear_search(c(10, 20, 30), 99)))
  sorted <- c(11, 12, 22, 25, 34, 64, 90)
  expect_equal(binary_search(sorted, 25), 4)
  expect_true(is.na(binary_search(sorted, 99)))
  expect_equal(which(c(1, 2, 2, 3) == 2), c(2, 3))
  expect_true(2 %in% c(1, 2, 3))
})

test_that("recursion and DP", {
  fib_dp <- function(n) {
    if (n <= 1) return(n)
    dp <- numeric(n + 1); dp[1] <- 0; dp[2] <- 1
    for (i in 3:(n + 1)) dp[i] <- dp[i - 1] + dp[i - 2]
    dp[n + 1]
  }
  expect_equal(fib_dp(10), 55)
  expect_equal(fib_dp(0), 0)
  gcd_rec <- function(a, b) if (b == 0) a else gcd_rec(b, a %% b)
  expect_equal(gcd_rec(48, 18), 6)
  knapsack <- function(weights, values, capacity) {
    n <- length(weights); dp <- matrix(0, n + 1, capacity + 1)
    for (i in 1:n) for (w in 0:capacity) {
      if (weights[i] <= w) dp[i + 1, w + 1] <- max(dp[i, w + 1], dp[i, w - weights[i] + 1] + values[i]) else dp[i + 1, w + 1] <- dp[i, w + 1]
    }
    dp[n + 1, capacity + 1]
  }
  expect_equal(knapsack(c(10, 20, 30), c(60, 100, 120), 50), 220)
})

test_that("algorithm files exist", {
  # check via both possible roots
  files <- c("algorithms/01_sorting.R", "algorithms/02_searching.R", "algorithms/03_recursion_dynamic.R")
  for (f in files) {
    # testthat runs from tests/testthat, so need ../../ prefix
    expect_true(file.exists(file.path("../../", f)) || file.exists(f), info = f)
  }
})
