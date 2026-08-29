# Missing Values and Data Cleaning in R
# ============================================================

cat("--- 1. NA, NaN, Inf, NULL ---\n")
print(NA); print(class(NA))
print(NA_integer_); print(NA_real_); print(NA_character_)
print(NaN); print(is.nan(NaN)); print(is.na(NaN)) # NaN is NA but not vice versa
print(Inf); print(-Inf); print(1/0); print(0/0) # Inf and NaN
print(NULL); print(is.null(NULL)); print(length(NULL))
# Difference: NA is missing value in vector, NULL is absence of object

cat("\n--- 2. is.na / is.nan / is.infinite / is.null ---\n")
x <- c(1, 2, NA, 4, NaN, Inf, 7)
print(is.na(x))
print(is.nan(x))
print(is.infinite(x))
print(is.finite(x))
print(complete.cases(x)) # FALSE where NA/NaN

cat("\n--- 3. Handling NA in computations ---\n")
vec <- c(1, 2, NA, 4, 5)
print(mean(vec))              # NA
print(mean(vec, na.rm = TRUE)) # 3
print(sum(vec, na.rm = TRUE))
print(sd(vec, na.rm = TRUE))
print(min(vec, na.rm = TRUE))
print(max(vec, na.rm = TRUE))

# na.omit / na.exclude / na.pass
print(na.omit(vec))
print(na.omit(data.frame(a = c(1, NA, 3), b = c(4, 5, NA))))

cat("\n--- 4. complete.cases / na.omit for data frames ---\n")
df <- data.frame(
  a = c(1, 2, NA, 4, 5),
  b = c(NA, 2, 3, 4, 5),
  c = c(1, 2, 3, NA, 5)
)
print(df)
print(complete.cases(df))
print(df[complete.cases(df), ])
print(na.omit(df))
print(nrow(na.omit(df)))

cat("\n--- 5. Replacing NA ---\n")
vec2 <- c(1, NA, 3, NA, 5)
vec2[is.na(vec2)] <- 0
print(vec2)

vec3 <- c(1, NA, 3, NA, 5)
vec3[is.na(vec3)] <- mean(vec3, na.rm = TRUE)
print(vec3)

# ifelse
vec4 <- c(1, NA, 3, NA, 5)
print(ifelse(is.na(vec4), 0, vec4))

cat("\n--- 6. duplicated / unique / duplicated with NA ---\n")
v <- c(1, 2, 2, 3, 1, NA, NA)
print(duplicated(v))
print(!duplicated(v))
print(unique(v))
print(anyDuplicated(v))
print(duplicated(v, fromLast = TRUE))

df_dup <- data.frame(id = c(1, 2, 2, 3), val = c("a", "b", "b", "c"))
print(duplicated(df_dup))
print(unique(df_dup))

cat("\n--- 7. Sorting with NA ---\n")
x <- c(3, NA, 1, 5, NA, 2)
print(sort(x)) # NA last by default
print(sort(x, na.last = TRUE))
print(sort(x, na.last = FALSE))
print(sort(x, na.last = NA)) # remove NA
print(order(x)) # indices
print(order(x, na.last = FALSE))
print(x[order(x, na.last = TRUE)])

cat("\n--- 8. Cleaning: scale, cut, outliers ---\n")
vals <- c(10, 12, 11, 13, 100, 12, 11) # 100 is outlier
print(scale(vals)) # z-score normalization
print(scale(vals, center = TRUE, scale = TRUE))
# IQR method for outliers
q1 <- quantile(vals, 0.25)
q3 <- quantile(vals, 0.75)
iqr <- q3 - q1
lower <- q1 - 1.5 * iqr
upper <- q3 + 1.5 * iqr
print(paste("Bounds:", lower, "-", upper))
print(vals[vals < lower | vals > upper]) # outliers
print(vals[vals >= lower & vals <= upper]) # without outliers

# cut - binning
print(cut(1:10, breaks = 3))
print(cut(1:10, breaks = c(0, 3, 7, 10), labels = c("Low", "Medium", "High")))
print(cut(iris$Sepal.Length, breaks = 3))

cat("\n--- 9. tidyr missing handling (if available) ---\n")
if (requireNamespace("tidyr", quietly = TRUE)) {
  library(tidyr)
  df_tidy <- data.frame(x = c(1, 2, NA), y = c(NA, 2, 3))
  print(drop_na(df_tidy))
  print(replace_na(df_tidy, list(x = 0, y = 0)))
  print(fill(data.frame(a = c(1, NA, NA, 4)), a, .direction = "down"))
} else {
  message("tidyr not installed")
}

cat("\n--- 10. Practical: data cleaning pipeline ---\n")
raw <- data.frame(
  name = c(" Alice ", "BOB", NA, "charlie", " Alice "),
  age = c(25, NA, 30, 22, 25),
  score = c(85, 92, NA, 78, 85),
  stringsAsFactors = FALSE
)
print("Raw:")
print(raw)
# Clean steps
raw$name <- trimws(tolower(raw$name)) # trim and lower
raw <- raw[!is.na(raw$name), ] # remove NA names
raw <- raw[!duplicated(raw), ] # remove duplicates
raw$age[is.na(raw$age)] <- median(raw$age, na.rm = TRUE)
raw$score[is.na(raw$score)] <- mean(raw$score, na.rm = TRUE)
print("Cleaned:")
print(raw)
print(summary(raw))

cat("\n--- Done: Missing Values & Cleaning ---\n")
