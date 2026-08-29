# Descriptive Statistics - Comprehensive
# ============================================================

cat("--- Using datasets: mtcars, iris, cars ---\n")
print(dim(mtcars)); print(names(mtcars))
print(summary(mtcars))
print(str(mtcars))

cat("\n--- 1. Central Tendency ---\n")
x <- c(10, 12, 15, 18, 20, 22, 25, 30, 100) # with outlier
print(paste("Mean:", mean(x)))
print(paste("Mean trimmed 10%:", mean(x, trim = 0.1)))
print(paste("Median:", median(x)))
# Mode (custom, R has no built-in mode for numeric)
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
print(paste("Mode:", get_mode(c(1, 2, 2, 3, 3, 3, 4))))
print(paste("Mode of mtcars$cyl:", get_mode(mtcars$cyl)))
print(paste("Weighted mean:", weighted.mean(x, w = 1:9)))

cat("\n--- 2. Dispersion ---\n")
print(paste("Range:", paste(range(x), collapse = " - ")))
print(paste("Diff Range:", diff(range(x))))
print(paste("Variance:", var(x)))
print(paste("SD:", sd(x)))
print(paste("IQR:", IQR(x)))
print(paste("MAD:", mad(x))) # median absolute deviation
print(paste("CV (sd/mean):", sd(x) / mean(x)))
print(quantile(x, probs = c(0, 0.25, 0.5, 0.75, 1)))
print(quantile(x, probs = seq(0, 1, 0.1))) # deciles

cat("\n--- 3. Summary by groups ---\n")
print(aggregate(mpg ~ cyl, data = mtcars, FUN = mean))
print(aggregate(cbind(mpg, hp) ~ cyl, data = mtcars, FUN = mean))
print(aggregate(Sepal.Length ~ Species, data = iris, FUN = summary))
# tapply version
print(tapply(mtcars$mpg, mtcars$cyl, mean))
print(tapply(mtcars$mpg, mtcars$cyl, sd))

cat("\n--- 4. Frequency tables ---\n")
print(table(mtcars$cyl))
print(table(mtcars$cyl, mtcars$gear))
print(prop.table(table(mtcars$cyl)))
print(prop.table(table(mtcars$cyl, mtcars$gear), margin = 1)) # row proportions
print(addmargins(table(mtcars$cyl, mtcars$gear)))

cat("\n--- 5. Correlation and Covariance ---\n")
print(cor(mtcars$mpg, mtcars$wt))
print(cor(mtcars[, c("mpg", "wt", "hp", "disp")]))
print(cor(mtcars$mpg, mtcars$wt, method = "spearman"))
print(cor(mtcars$mpg, mtcars$wt, method = "kendall"))
print(cov(mtcars$mpg, mtcars$wt))
print(cov(mtcars[, c("mpg", "wt", "hp")]))

# Correlation test
print(cor.test(mtcars$mpg, mtcars$wt))

cat("\n--- 6. Distributions ---\n")
# Normal
print(dnorm(0, mean = 0, sd = 1)) # density at 0
print(pnorm(1.96, mean = 0, sd = 1)) # CDF
print(qnorm(0.975, mean = 0, sd = 1)) # quantile
print(rnorm(5, mean = 10, sd = 2)) # random

# Binomial
print(dbinom(3, size = 10, prob = 0.5))
print(pbinom(3, size = 10, prob = 0.5))
print(qbinom(0.5, size = 10, prob = 0.5))
print(rbinom(5, size = 10, prob = 0.5))

# Poisson, Uniform, Exponential
print(dpois(3, lambda = 2))
print(punif(0.5, min = 0, max = 1))
print(rexp(3, rate = 1))

# Sampling
set.seed(123)
print(sample(1:10, 5)) # without replacement
print(sample(1:6, 10, replace = TRUE)) # with replacement
print(sample(c("H", "T"), 10, replace = TRUE, prob = c(0.5, 0.5)))

cat("\n--- 7. Sorting, Ranking, Ordering ---\n")
v <- c(5, 2, 8, 1, 9)
print(sort(v))
print(sort(v, decreasing = TRUE))
print(order(v)) # indices that would sort
print(rank(v))
print(rank(c(1, 2, 2, 3), ties.method = "average"))
print(rank(c(1, 2, 2, 3), ties.method = "min"))

cat("\n--- 8. Scale and Center ---\n")
print(scale(mtcars$mpg)) # z-scores
print(scale(mtcars[, 1:3])) # matrix scaled
# Manual
z <- (mtcars$mpg - mean(mtcars$mpg)) / sd(mtcars$mpg)
print(head(z))

cat("\n--- 9. mtcars full EDA ---\n")
print(paste("nrow:", nrow(mtcars), "ncol:", ncol(mtcars)))
print(sapply(mtcars, mean))
print(sapply(mtcars, sd))
print(sapply(mtcars, median))
print(cor(mtcars))
# Which car has max mpg?
print(mtcars[which.max(mtcars$mpg), ])
print(mtcars[which.min(mtcars$mpg), ])

cat("\n--- Done: Descriptive Stats ---\n")
