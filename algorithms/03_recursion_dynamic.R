# Algorithms: Recursion and Dynamic Programming in R
# ============================================================

cat("--- 1. Factorial ---\n")
factorial_rec <- function(n) {
  if (n <= 1) return(1)
  return(n * factorial_rec(n - 1))
}
factorial_iter <- function(n) {
  result <- 1
  for (i in 2:n) result <- result * i
  return(result)
}
print(factorial_rec(5)) # 120
print(factorial_rec(0)) # 1
print(factorial_iter(5))
# Base R
print(factorial(5))
print(gamma(6)) # gamma(n+1) = factorial(n)

cat("\n--- 2. Fibonacci ---\n")
# Naive recursion (exponential - slow for large n)
fib_rec <- function(n) {
  if (n <= 1) return(n)
  return(fib_rec(n - 1) + fib_rec(n - 2))
}
print(sapply(0:10, fib_rec))

# Memoized (dynamic programming) - fast
fib_memo <- local({
  memo <- c(0, 1) # fib(0)=0, fib(1)=1; R index offset
  f <- function(n) {
    if (n < length(memo)) return(memo[n + 1])
    # Compute iteratively up to n
    for (i in length(memo):n) {
      memo[i + 1] <<- memo[i] + memo[i - 1]
    }
    return(memo[n + 1])
  }
  f
})
print(sapply(0:10, fib_memo))
print(fib_memo(30)) # 832040
print(fib_memo(50)) # large

# Iterative DP
fib_dp <- function(n) {
  if (n <= 1) return(n)
  dp <- numeric(n + 1)
  dp[1] <- 0; dp[2] <- 1
  for (i in 3:(n + 1)) dp[i] <- dp[i - 1] + dp[i - 2]
  return(dp[n + 1])
}
print(fib_dp(10))
print(fib_dp(30))

cat("\n--- 3. GCD and LCM ---\n")
gcd_rec <- function(a, b) {
  if (b == 0) return(a)
  return(gcd_rec(b, a %% b))
}
gcd_iter <- function(a, b) {
  while (b != 0) {
    tmp <- b
    b <- a %% b
    a <- tmp
  }
  return(a)
}
print(gcd_rec(48, 18)) # 6
print(gcd_rec(101, 103)) # 1 (primes)
print(gcd_iter(48, 18))

lcm <- function(a, b) {
  abs(a * b) / gcd_rec(a, b)
}
print(lcm(12, 18)) # 36
print(lcm(7, 5))   # 35

cat("\n--- 4. Tower of Hanoi ---\n")
hanoi <- function(n, from = "A", to = "C", aux = "B") {
  if (n == 1) {
    cat("Move disk 1 from", from, "to", to, "\n")
    return(invisible())
  }
  hanoi(n - 1, from, aux, to)
  cat("Move disk", n, "from", from, "to", to, "\n")
  hanoi(n - 1, aux, to, from)
}
cat("Solution for 3 disks:\n")
hanoi(3)

cat("\n--- 5. Dynamic Programming: Coin Change ---\n")
coin_change <- function(coins, amount) {
  # Minimum coins needed
  dp <- rep(Inf, amount + 1)
  dp[1] <- 0 # 0 amount needs 0 coins; R index offset by 1
  for (i in 1:amount) {
    for (coin in coins) {
      if (coin <= i && dp[i - coin + 1] + 1 < dp[i + 1]) {
        dp[i + 1] <- dp[i - coin + 1] + 1
      }
    }
  }
  if (dp[amount + 1] == Inf) return(-1)
  return(dp[amount + 1])
}
print(coin_change(c(1, 3, 4), 6)) # 2 (3+3)
print(coin_change(c(1, 5, 10, 25), 30)) # 2 (25+5)
print(coin_change(c(2), 3)) # -1 impossible

cat("\n--- 6. DP: Longest Common Subsequence (LCS) ---\n")
lcs_length <- function(s1, s2) {
  a <- strsplit(s1, "")[[1]]
  b <- strsplit(s2, "")[[1]]
  m <- length(a); n <- length(b)
  dp <- matrix(0, nrow = m + 1, ncol = n + 1)
  for (i in 1:m) {
    for (j in 1:n) {
      if (a[i] == b[j]) dp[i + 1, j + 1] <- dp[i, j] + 1
      else dp[i + 1, j + 1] <- max(dp[i, j + 1], dp[i + 1, j])
    }
  }
  return(dp[m + 1, n + 1])
}
print(lcs_length("ABCBDAB", "BDCABA")) # 4 (e.g., BDAB)
print(lcs_length("AGGTAB", "GXTXAYB")) # 4 (GTAB)

cat("\n--- 7. DP: Knapsack 0/1 ---\n")
knapsack <- function(weights, values, capacity) {
  n <- length(weights)
  dp <- matrix(0, nrow = n + 1, ncol = capacity + 1)
  for (i in 1:n) {
    for (w in 0:capacity) {
      if (weights[i] <= w) {
        dp[i + 1, w + 1] <- max(dp[i, w + 1], dp[i, w - weights[i] + 1] + values[i])
      } else {
        dp[i + 1, w + 1] <- dp[i, w + 1]
      }
    }
  }
  return(dp[n + 1, capacity + 1])
}
print(knapsack(c(10, 20, 30), c(60, 100, 120), 50)) # 220 (20+30)
print(knapsack(c(1, 2, 3), c(10, 15, 40), 6)) # 65 (1+2+3? actually 1+3=50? check: 3+3? no dup; 1+2+3=6 =>65)

cat("\n--- 8. Permutations and Combinations ---\n")
# Recursive permutations
permute <- function(vec) {
  if (length(vec) == 1) return(list(vec))
  result <- list()
  for (i in seq_along(vec)) {
    rest <- vec[-i]
    for (p in permute(rest)) {
      result <- append(result, list(c(vec[i], p)))
    }
  }
  return(result)
}
print(permute(1:3))

# Combinations via base R
print(combn(1:4, 2))
print(combn(letters[1:4], 2))
print(choose(5, 2)) # 10

cat("\n--- 9. Binary Search Tree concept (list-based) ---\n")
# Simple BST insert/search using nested lists
bst_insert <- function(node, value) {
  if (is.null(node)) return(list(value = value, left = NULL, right = NULL))
  if (value < node$value) node$left <- bst_insert(node$left, value)
  else if (value > node$value) node$right <- bst_insert(node$right, value)
  return(node)
}
bst_search <- function(node, value) {
  if (is.null(node)) return(FALSE)
  if (value == node$value) return(TRUE)
  if (value < node$value) return(bst_search(node$left, value))
  return(bst_search(node$right, value))
}
bst_inorder <- function(node) {
  if (is.null(node)) return(numeric(0))
  c(bst_inorder(node$left), node$value, bst_inorder(node$right))
}
root <- NULL
for (v in c(50, 30, 70, 20, 40, 60, 80)) root <- bst_insert(root, v)
print(bst_inorder(root)) # should be sorted
print(bst_search(root, 40)) # TRUE
print(bst_search(root, 90)) # FALSE

cat("\n--- Done: Recursion & DP ---\n")
