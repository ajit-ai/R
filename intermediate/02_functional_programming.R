# Functional Programming in R
# ============================================================

# 1. Anonymous functions
cat("--- Anonymous Functions ---\n")
print(sapply(1:5, function(x) x^2))
print((function(x, y) x + y)(10, 20))

# 2. Closures - function returning function
cat("\n--- Closures ---\n")
make_power <- function(n) {
  function(x) x^n
}
square <- make_power(2)
cube <- make_power(3)
print(square(5))  # 25
print(cube(3))    # 27

make_counter <- function() {
  count <- 0
  function() {
    count <<- count + 1
    return(count)
  }
}
counter <- make_counter()
print(counter()) # 1
print(counter()) # 2
print(counter()) # 3

# 3. Recursion
cat("\n--- Recursion ---\n")
factorial_rec <- function(n) {
  if (n <= 1) return(1)
  return(n * factorial_rec(n - 1))
}
print(factorial_rec(5)) # 120
print(factorial_rec(0)) # 1

fibonacci <- function(n) {
  if (n <= 1) return(n)
  return(fibonacci(n - 1) + fibonacci(n - 2))
}
print(sapply(0:10, fibonacci))

gcd <- function(a, b) {
  if (b == 0) return(a)
  return(gcd(b, a %% b))
}
print(gcd(48, 18)) # 6

# 4. Higher-order functions
cat("\n--- Higher-order functions ---\n")
apply_twice <- function(f, x) f(f(x))
print(apply_twice(function(x) x * 2, 5)) # 20

compose <- function(f, g) {
  function(x) f(g(x))
}
add1 <- function(x) x + 1
double <- function(x) x * 2
add1_then_double <- compose(double, add1)
print(add1_then_double(5)) # 12

# 5. Reduce, Filter, Map, Find, Position, Negate
cat("\n--- Reduce / Filter / Map ---\n")
print(Reduce("+", 1:5))           # sum 1:5 = 15
print(Reduce("*", 1:5))           # factorial 5 = 120
print(Reduce(function(a, b) paste(a, b, sep = " "), c("Hello", "World", "R")))

print(Filter(function(x) x %% 2 == 0, 1:10)) # even numbers
print(Map(function(x) x^2, 1:5))
print(Map(sum, 1:5, 6:10)) # parallel map

print(Find(function(x) x > 5, 1:10))      # first >5
print(Position(function(x) x > 5, 1:10))  # position of first >5
is_even <- function(x) x %% 2 == 0
is_odd <- Negate(is_even)
print(Filter(is_odd, 1:10))

# 6. Environments
cat("\n--- Environments ---\n")
e <- new.env()
e$x <- 100
print(e$x)
print(ls(e))
print(environment(square))
print(parent.env(environment()))

# 7. Lexical scoping
cat("\n--- Lexical Scoping ---\n")
y <- 10
f <- function() {
  y <- 20
  g <- function() print(y)
  return(g)
}
h <- f()
h() # prints 20 (lexical scope, not 10)

# 8. ... (dots) variadic functions
cat("\n--- Dots (...) ---\n")
my_paste <- function(..., sep = "-") {
  paste(..., sep = sep)
}
print(my_paste("A", "B", "C"))
print(my_paste("A", "B", "C", sep = "|"))

# 9. do.call
cat("\n--- do.call ---\n")
args_list <- list(1:5, na.rm = TRUE)
print(do.call(mean, args_list))
print(do.call(rbind, list(data.frame(a = 1), data.frame(a = 2))))

# 10. Vectorization & ifelse
cat("\n--- Vectorization ---\n")
x <- 1:10
print(ifelse(x %% 2 == 0, "even", "odd"))
print(pmax(c(1, 5, 3), c(2, 4, 6))) # parallel max
print(pmin(c(1, 5, 3), c(2, 4, 6)))

# 11. Switch & match
cat("\n--- switch / match ---\n")
type <- "mean"
result <- switch(type,
  mean = mean(1:10),
  median = median(1:10),
  sum = sum(1:10),
  stop("Unknown type")
)
print(result)
print(match(c("b", "a"), c("a", "b", "c")))
print(match.call())

cat("\n--- Done: Functional Programming ---\n")
