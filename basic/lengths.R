# stringr example with fallback to base nchar
if (requireNamespace("stringr", quietly = TRUE)) {
  library(stringr)
  print(str_length("hello"))
} else {
  # fallback using base R
  print(nchar("hello"))
  message("stringr not installed - using nchar fallback")
}