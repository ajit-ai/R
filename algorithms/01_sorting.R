# Algorithms: Sorting in R
# Implement classic sorting algorithms from scratch + compare with base
# ============================================================

cat("--- 1. Bubble Sort ---\n")
bubble_sort <- function(vec) {
  n <- length(vec)
  v <- vec # copy
  for (i in 1:(n - 1)) {
    swapped <- FALSE
    for (j in 1:(n - i)) {
      if (v[j] > v[j + 1]) {
        tmp <- v[j]; v[j] <- v[j + 1]; v[j + 1] <- tmp
        swapped <- TRUE
      }
    }
    if (!swapped) break
  }
  return(v)
}
test_vec <- c(64, 34, 25, 12, 22, 11, 90)
print(paste("Original:", paste(test_vec, collapse = ", ")))
print(paste("Bubble sorted:", paste(bubble_sort(test_vec), collapse = ", ")))
print(paste("Base sort:   ", paste(sort(test_vec), collapse = ", ")))
cat("Correct:", identical(bubble_sort(test_vec), sort(test_vec)), "\n")

cat("\n--- 2. Selection Sort ---\n")
selection_sort <- function(vec) {
  n <- length(vec)
  v <- vec
  for (i in 1:(n - 1)) {
    min_idx <- i
    for (j in (i + 1):n) {
      if (v[j] < v[min_idx]) min_idx <- j
    }
    tmp <- v[i]; v[i] <- v[min_idx]; v[min_idx] <- tmp
  }
  return(v)
}
print(selection_sort(test_vec))
cat("Correct:", identical(selection_sort(test_vec), sort(test_vec)), "\n")

cat("\n--- 3. Insertion Sort ---\n")
insertion_sort <- function(vec) {
  v <- vec
  n <- length(v)
  for (i in 2:n) {
    key <- v[i]
    j <- i - 1
    while (j >= 1 && v[j] > key) {
      v[j + 1] <- v[j]
      j <- j - 1
    }
    v[j + 1] <- key
  }
  return(v)
}
print(insertion_sort(test_vec))
cat("Correct:", identical(insertion_sort(test_vec), sort(test_vec)), "\n")

cat("\n--- 4. Merge Sort (recursive) ---\n")
merge_sort <- function(vec) {
  if (length(vec) <= 1) return(vec)
  mid <- floor(length(vec) / 2)
  left <- merge_sort(vec[1:mid])
  right <- merge_sort(vec[(mid + 1):length(vec)])
  # merge
  result <- numeric(0)
  i <- 1; j <- 1
  while (i <= length(left) && j <= length(right)) {
    if (left[i] <= right[j]) {
      result <- c(result, left[i]); i <- i + 1
    } else {
      result <- c(result, right[j]); j <- j + 1
    }
  }
  if (i <= length(left)) result <- c(result, left[i:length(left)])
  if (j <= length(right)) result <- c(result, right[j:length(right)])
  return(result)
}
print(merge_sort(test_vec))
cat("Correct:", identical(merge_sort(test_vec), sort(test_vec)), "\n")
large_vec <- sample(1:1000, 100)
cat("Large test correct:", identical(merge_sort(large_vec), sort(large_vec)), "\n")

cat("\n--- 5. Quick Sort (recursive) ---\n")
quick_sort <- function(vec) {
  if (length(vec) <= 1) return(vec)
  pivot <- vec[1]
  rest <- vec[-1]
  left <- rest[rest <= pivot]
  right <- rest[rest > pivot]
  c(quick_sort(left), pivot, quick_sort(right))
}
print(quick_sort(test_vec))
cat("Correct:", identical(quick_sort(test_vec), sort(test_vec)), "\n")

cat("\n--- 6. Counting Sort (for integers, O(n+k)) ---\n")
counting_sort <- function(vec) {
  # Assumes non-negative integers
  max_val <- max(vec)
  counts <- integer(max_val + 1)
  for (v in vec) counts[v + 1] <- counts[v + 1] + 1
  result <- numeric(0)
  for (i in 0:max_val) {
    if (counts[i + 1] > 0) result <- c(result, rep(i, counts[i + 1]))
  }
  return(result)
}
count_vec <- c(4, 2, 2, 8, 3, 3, 1)
print(counting_sort(count_vec))
cat("Correct:", identical(counting_sort(count_vec), sort(count_vec)), "\n")

cat("\n--- 7. Base R sorting utilities ---\n")
v <- c(5, 2, 8, 1, 9, 2, 5)
print(sort(v))
print(sort(v, decreasing = TRUE))
print(order(v)) # indices
print(v[order(v)])
print(rank(v))
print(rank(v, ties.method = "min"))
print(order(v, decreasing = TRUE))

# Sorting data frame
df <- data.frame(name = c("Bob", "Alice", "Charlie"), age = c(30, 25, 35), score = c(88, 92, 85))
print(df)
print(df[order(df$age), ])
print(df[order(df$score, decreasing = TRUE), ])
print(df[order(df$age, df$score), ]) # multi-col

# sort.int (faster for vectors), is.unsorted
print(is.unsorted(v))
print(is.unsorted(sort(v)))

cat("\n--- 8. Benchmark comparison ---\n")
set.seed(42)
bench_vec <- sample(1:10000, 1000)
# Time each (small benchmark, not precise)
cat("Base sort time:\n")
print(system.time(for (i in 1:100) sort(bench_vec)))
cat("Quick sort time (10 runs, recursive is slower in R):\n")
print(system.time(for (i in 1:10) quick_sort(bench_vec)))
cat("Note: Custom R sorts are educational; base sort uses highly optimized C code (radix sort)\n")

# Check radix sort option
print(sort(bench_vec, method = "radix")[1:5])

cat("\n--- Done: Sorting ---\n")
