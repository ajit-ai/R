# Algorithms: Searching in R
# ============================================================

cat("--- 1. Linear Search ---\n")
linear_search <- function(vec, target) {
  for (i in seq_along(vec)) {
    if (vec[i] == target) return(i) # return first index
  }
  return(NA) # not found
}
vec <- c(10, 20, 30, 40, 50)
print(linear_search(vec, 30)) # 3
print(linear_search(vec, 99)) # NA
print(linear_search(c(5, 2, 8, 2, 9), 2)) # first occurrence

# Find all occurrences
linear_search_all <- function(vec, target) {
  which(vec == target)
}
print(linear_search_all(c(5, 2, 8, 2, 9), 2))

cat("\n--- 2. Binary Search (requires sorted vector) ---\n")
binary_search <- function(vec, target) {
  # Assumes vec is sorted ascending
  low <- 1
  high <- length(vec)
  while (low <= high) {
    mid <- floor((low + high) / 2)
    if (vec[mid] == target) return(mid)
    else if (vec[mid] < target) low <- mid + 1
    else high <- mid - 1
  }
  return(NA)
}
sorted <- sort(c(64, 34, 25, 12, 22, 11, 90))
print(sorted)
print(binary_search(sorted, 25))
print(binary_search(sorted, 100))
print(binary_search(sorted, 11)) # first element
print(binary_search(sorted, 90)) # last element

# Recursive binary search
binary_search_rec <- function(vec, target, low = 1, high = length(vec)) {
  if (low > high) return(NA)
  mid <- floor((low + high) / 2)
  if (vec[mid] == target) return(mid)
  else if (vec[mid] < target) return(binary_search_rec(vec, target, mid + 1, high))
  else return(binary_search_rec(vec, target, low, mid - 1))
}
print(binary_search_rec(sorted, 25))
print(binary_search_rec(sorted, 99))

cat("\n--- 3. Base R searching: which, match, %in% ---\n")
v <- c(10, 20, 30, 20, 40)
print(which(v == 20)) # all indices
print(which.max(v))
print(which.min(v))
print(match(20, v)) # first match index
print(match(c(20, 99), v)) # vectorized
print(20 %in% v)
print(99 %in% v)
print(c(20, 30) %in% v)

# pmatch partial matching
print(pmatch("med", c("mean", "median", "mode")))

cat("\n--- 4. String searching ---\n")
texts <- c("apple", "banana", "apricot", "cherry")
print(grep("ap", texts)) # indices
print(grep("ap", texts, value = TRUE))
print(grepl("an", texts))
# Fixed vs regex
print(grep("a.p", c("apple", "acp", "a p"), value = TRUE)) # regex . = any char
print(grep("a.p", c("apple", "acp", "a p"), value = TRUE, fixed = TRUE)) # literal

cat("\n--- 5. Interpolation Search (for uniformly distributed sorted data) ---\n")
interpolation_search <- function(vec, target) {
  low <- 1
  high <- length(vec)
  while (low <= high && target >= vec[low] && target <= vec[high]) {
    if (low == high) {
      if (vec[low] == target) return(low)
      return(NA)
    }
    # Estimate position
    pos <- low + floor(((target - vec[low]) / (vec[high] - vec[low])) * (high - low))
    if (pos < low || pos > high) return(NA)
    if (vec[pos] == target) return(pos)
    if (vec[pos] < target) low <- pos + 1
    else high <- pos - 1
  }
  return(NA)
}
uniform_vec <- seq(10, 100, by = 10) # 10,20,...,100
print(uniform_vec)
print(interpolation_search(uniform_vec, 50))
print(interpolation_search(uniform_vec, 55))

cat("\n--- 6. Searching in data frames ---\n")
df <- data.frame(id = 1:5, name = c("Alice", "Bob", "Charlie", "David", "Eve"),
                 age = c(25, 30, 22, 35, 28), stringsAsFactors = FALSE)
print(df)
# Find row where name == "Charlie"
print(df[df$name == "Charlie", ])
print(which(df$name == "Charlie"))
print(df[which(df$age > 28), ])
# subset
print(subset(df, age > 28))
print(subset(df, name %in% c("Alice", "Eve")))

cat("\n--- 7. Hash-like search with environments (O(1) concept) ---\n")
# Environment as hash map
hash <- new.env(hash = TRUE)
hash[["apple"]] <- 5
hash[["banana"]] <- 3
print(hash[["apple"]])
print(exists("banana", envir = hash))
print(exists("cherry", envir = hash))
print(ls(hash))
# vs named vector
named_vec <- c(apple = 5, banana = 3, cherry = 7)
print(named_vec["apple"])
print(named_vec[["banana"]])

cat("\n--- 8. Performance: linear vs binary ---\n")
set.seed(42)
large_sorted <- sort(sample(1:100000, 10000))
target <- sample(large_sorted, 1)
cat("Target:", target, "\n")
# Linear: O(n)
print(system.time(for (i in 1:1000) linear_search(large_sorted, target)))
# Binary: O(log n)
print(system.time(for (i in 1:1000) binary_search(large_sorted, target)))
# Base which: O(n) but C-optimized
print(system.time(for (i in 1:1000) which(large_sorted == target)))

cat("\n--- Done: Searching ---\n")
