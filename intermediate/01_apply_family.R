# Apply Family in R - Comprehensive Examples
# ============================================================

# Sample data
mat <- matrix(1:12, nrow = 3, ncol = 4)
print("Matrix:")
print(mat)

lst <- list(a = 1:5, b = 6:10, c = 11:15)
vec <- c(2, 4, 6, 8, 10)

# 1. apply() - Apply over margins of array/matrix
cat("\n--- apply() ---\n")
# Row sums (MARGIN=1) and column sums (MARGIN=2)
print(apply(mat, 1, sum))   # row-wise
print(apply(mat, 2, sum))   # column-wise
print(apply(mat, 2, mean))
print(apply(mat, 1, max))

# 2. lapply() - Always returns list
cat("\n--- lapply() ---\n")
print(lapply(lst, mean))
print(lapply(lst, sum))
print(lapply(1:3, function(x) x^2))
# With anonymous function
print(lapply(lst, function(x) x * 2))

# 3. sapply() - Simplified lapply (vector/matrix if possible)
cat("\n--- sapply() ---\n")
print(sapply(lst, mean))
print(sapply(lst, length))
print(sapply(1:5, function(x) x^2))

# 4. vapply() - Safer sapply with explicit return type
cat("\n--- vapply() ---\n")
print(vapply(lst, mean, numeric(1)))
print(vapply(lst, sum, numeric(1)))
# vapply enforces type; this would error if type mismatched:
# vapply(lst, function(x) paste(x), character(1)) # would need correct length

# 5. mapply() - Multivariate sapply
cat("\n--- mapply() ---\n")
print(mapply(sum, 1:5, 6:10)) # sum of pairs
print(mapply(function(x, y) x^y, c(2, 3, 4), c(3, 2, 2)))
print(mapply(rep, 1:4, 4:1)) # rep 1 four times, 2 three times, etc.
print(mapply(paste, c("A", "B"), c("1", "2"), MoreArgs = list(sep = "-")))

# 6. tapply() - Apply over ragged array (grouped)
cat("\n--- tapply() ---\n")
ages <- c(25, 30, 25, 30, 25, 30)
groups <- factor(c("A", "A", "B", "B", "A", "B"))
values <- c(10, 20, 30, 40, 50, 60)
print(tapply(values, groups, mean))
print(tapply(values, list(groups, ages), sum))

# iris example
print(tapply(iris$Sepal.Length, iris$Species, mean))
print(tapply(iris$Sepal.Length, iris$Species, summary))

# 7. rapply() - Recursive apply over lists
cat("\n--- rapply() ---\n")
nested <- list(a = list(x = 1:3, y = 4:6), b = list(z = 7:9))
print(rapply(nested, mean))
print(rapply(nested, sum, how = "list"))

# 8. eapply() - Apply over environment (advanced)
cat("\n--- eapply() ---\n")
env <- new.env()
env$a <- 10
env$b <- 20
env$c <- 30
print(eapply(env, function(x) x * 2))

# 9. Vectorization vs loops benchmark concept
cat("\n--- Vectorization vs apply ---\n")
x <- 1:100000
# Vectorized (fast)
system.time(vec_result <- x * 2)
# Using sapply (slower, but more flexible)
system.time(sapply_result <- sapply(x, function(v) v * 2))

# 10. Practical examples
cat("\n--- Practical: data.frame apply ---\n")
df <- data.frame(a = 1:5, b = 6:10, c = 11:15)
print(lapply(df, mean))   # mean of each column
print(sapply(df, sd))
print(sapply(df, function(col) sum(col > 7)))

# Custom function with apply
normalize <- function(x) (x - min(x)) / (max(x) - min(x))
print(apply(mat, 2, normalize))

cat("\n--- Done: Apply Family ---\n")
