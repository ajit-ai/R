# Tidyverse: dplyr, tidyr, tibble - Comprehensive
# Requires dplyr, tidyr, tibble (install if missing)
# Uses base fallback where possible
# ============================================================

cat("--- Tibble vs Data Frame ---\n")
if (requireNamespace("tibble", quietly = TRUE)) {
  library(tibble)
  tb <- tibble(name = c("Alice", "Bob", "Charlie"), age = c(25, 30, 22), score = c(85, 92, 78))
  print(tb)
  print(class(tb))
  # tibble never converts strings to factors, prints nicely, subsetting stays tibble
  print(tb[1, ])
  print(tb[, "name"])
  # as_tibble
  print(as_tibble(mtcars[1:3, 1:3]))
} else {
  cat("tibble not installed - using data.frame fallback\n")
  tb <- data.frame(name = c("Alice", "Bob", "Charlie"), age = c(25, 30, 22), score = c(85, 92, 78))
  print(tb)
}

# Sample data for dplyr
df <- data.frame(
  id = 1:6,
  name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank"),
  dept = c("CS", "CS", "Math", "Math", "Physics", "CS"),
  score = c(85, 92, 78, 88, 95, 80),
  age = c(25, 30, 22, 35, 28, 26),
  stringsAsFactors = FALSE
)
print(df)

has_dplyr <- requireNamespace("dplyr", quietly = TRUE)
has_tidyr <- requireNamespace("tidyr", quietly = TRUE)

if (has_dplyr) {
  library(dplyr)
  cat("\n--- dplyr: filter, select, mutate, arrange, summarise ---\n")
  print(filter(df, score > 85))
  print(filter(df, dept == "CS" & age > 25))
  print(select(df, name, score))
  print(select(df, -id))
  print(select(df, starts_with("s"))) # helper
  print(mutate(df, grade = ifelse(score >= 90, "A", ifelse(score >= 80, "B", "C"))))
  print(mutate(df, score_scaled = scale(score)))
  print(arrange(df, score))
  print(arrange(df, desc(score)))
  print(summarise(df, mean_score = mean(score), max_score = max(score), n = n()))

  cat("\n--- group_by + summarise ---\n")
  print(df %>% group_by(dept) %>% summarise(mean_score = mean(score), count = n(), .groups = "drop"))
  print(df %>% group_by(dept) %>% summarise(mean_age = mean(age), sd_score = sd(score)))

  cat("\n--- pipe %>% ---\n")
  result <- df %>%
    filter(score > 80) %>%
    mutate(passed = TRUE) %>%
    arrange(desc(score)) %>%
    select(name, dept, score, passed)
  print(result)

  # New native pipe |> (R 4.1+)
  result2 <- df |> filter(score > 80) |> arrange(desc(score))
  print(head(result2))

  cat("\n--- Joins ---\n")
  dept_info <- data.frame(dept = c("CS", "Math", "Physics"), building = c("A", "B", "C"), stringsAsFactors = FALSE)
  print(inner_join(df, dept_info, by = "dept"))
  print(left_join(df, dept_info, by = "dept"))
  print(right_join(dept_info, df, by = "dept"))
  # anti_join, semi_join
  print(semi_join(df, dept_info, by = "dept"))
  print(anti_join(df, data.frame(dept = "CS", stringsAsFactors = FALSE), by = "dept"))

  cat("\n--- distinct, rename, count ---\n")
  print(distinct(df, dept))
  print(rename(df, department = dept))
  print(count(df, dept))
  print(count(df, dept, sort = TRUE))

  cat("\n--- slice, pull ---\n")
  print(slice(df, 1:3))
  print(slice_max(df, order_by = score, n = 2))
  print(slice_min(df, order_by = score, n = 2))
  print(pull(df, score))

  cat("\n--- across, case_when, coalesce ---\n")
  print(mutate(df, across(c(score, age), scale)))
  print(mutate(df, grade = case_when(
    score >= 90 ~ "A",
    score >= 80 ~ "B",
    TRUE ~ "C"
  )))
  df_na <- data.frame(a = c(1, NA, 3), b = c(NA, 2, 3))
  print(mutate(df_na, a = coalesce(a, 0)))
} else {
  cat("\ndplyr not installed - showing base R equivalents\n")
  cat("Base filter:", paste(df[df$score > 85, "name"], collapse = ", "), "\n")
  cat("Base select: df[,c('name','score')]\n")
  print(df[, c("name", "score")])
  cat("Base arrange (order):\n")
  print(df[order(df$score, decreasing = TRUE), ])
  cat("Base aggregate:\n")
  print(aggregate(score ~ dept, data = df, FUN = mean))
}

if (has_tidyr) {
  library(tidyr)
  cat("\n--- tidyr: pivot_longer / pivot_wider ---\n")
  wide <- data.frame(id = 1:3, math = c(80, 85, 90), science = c(88, 92, 85), english = c(75, 80, 95))
  print(wide)
  long <- pivot_longer(wide, cols = c(math, science, english), names_to = "subject", values_to = "score")
  print(long)
  print(pivot_wider(long, names_from = subject, values_from = score))

  cat("\n--- separate / unite ---\n")
  df_sep <- data.frame(full = c("Alice-25", "Bob-30", "Charlie-22"), stringsAsFactors = FALSE)
  print(separate(df_sep, col = full, into = c("name", "age"), sep = "-"))
  df_unite <- data.frame(first = c("Alice", "Bob"), last = c("Smith", "Jones"), stringsAsFactors = FALSE)
  print(unite(df_unite, col = "full_name", first, last, sep = " "))

  cat("\n--- drop_na / fill / complete ---\n")
  df_na2 <- data.frame(a = c(1, NA, 3, NA), b = c(NA, 2, NA, 4))
  print(drop_na(df_na2))
  print(fill(data.frame(x = c(1, NA, NA, 4)), x, .direction = "down"))
  print(complete(data.frame(a = c(1, 1, 2), b = c(1, 2, 1)), a, b))

  cat("\n--- nest / unnest (if tidyr version supports) ---\n")
  if (exists("nest")) {
    nested <- df %>% group_by(dept) %>% nest()
    print(nested)
    print(unnest(nested, cols = data))
  }
} else {
  cat("\ntidyr not installed - base reshape fallback\n")
  # Base reshape
  wide <- data.frame(id = 1:3, math = c(80, 85, 90), science = c(88, 92, 85))
  print(wide)
  print(stack(wide[, c("math", "science")]))
  print(reshape(wide, varying = c("math", "science"), v.names = "score",
                timevar = "subject", times = c("math", "science"), direction = "long"))
}

cat("\n--- Done: Tidyverse ---\n")
