# File I/O in R - Comprehensive Examples
# ============================================================

# Working directory helpers
cat("--- Working Directory ---\n")
print(getwd())
# setwd("path/to/dir") # change working directory
print(list.files(".", pattern = "\\.R$"))
# dir.create("test_dir") # create directory
# file.exists("basic/csv_file.csv")

# Sample data frame
df <- data.frame(
  id = 1:5,
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  score = c(85, 92, 78, 88, 95),
  dept = c("CS", "Math", "CS", "Physics", "Math"),
  stringsAsFactors = FALSE
)
print(df)

# 1. CSV read/write
cat("\n--- CSV I/O ---\n")
write.csv(df, "test_output.csv", row.names = FALSE)
print("Wrote test_output.csv")
df_read <- read.csv("test_output.csv", stringsAsFactors = FALSE)
print(df_read)
print(str(df_read))

# Read with options
# read.csv params: header, sep, na.strings, colClasses, nrows, skip
# Example reading basic/csv_file.csv if exists
if (file.exists("basic/csv_file.csv")) {
  print(read.csv("basic/csv_file.csv"))
}

# 2. read.table / write.table
cat("\n--- read.table / write.table ---\n")
write.table(df, "test_table.txt", sep = "\t", row.names = FALSE, quote = FALSE)
print(read.table("test_table.txt", header = TRUE, sep = "\t"))

# 3. read.csv vs read.csv2 (different decimal separators)
# write.csv2 uses ; and comma for decimal

# 4. saveRDS / readRDS - single R object
cat("\n--- RDS (single object) ---\n")
saveRDS(df, "test_data.rds")
df_rds <- readRDS("test_data.rds")
print(identical(df, df_rds))

# 5. save / load - multiple objects
cat("\n--- save / load (multiple objects) ---\n")
x <- 1:10
y <- letters[1:5]
save(x, y, df, file = "test_workspace.RData")
# Clear and reload
rm(x, y)
load("test_workspace.RData")
print(x)
print(y)

# 6. scan() - read vector
cat("\n--- scan() ---\n")
cat("1 2 3 4 5\n6 7 8 9 10\n", file = "scan_test.txt")
print(scan("scan_test.txt", quiet = TRUE))
print(scan("scan_test.txt", what = character(), quiet = TRUE))

# 7. readLines / writeLines
cat("\n--- readLines / writeLines ---\n")
writeLines(c("Hello World", "R is great", "File I/O demo"), "lines_test.txt")
print(readLines("lines_test.txt"))
# n param, warn param
print(readLines("lines_test.txt", n = 2))

# 8. file() connection - low level
cat("\n--- file connections ---\n")
con <- file("connection_test.txt", "w")
writeLines(c("Line 1", "Line 2", "Line 3"), con)
close(con)
con <- file("connection_test.txt", "r")
print(readLines(con))
close(con)

# 9. csv with na.strings, colClasses
cat("\n--- CSV with NA handling ---\n")
df_na <- data.frame(a = c(1, 2, NA, 4), b = c("x", NA, "z", "w"))
write.csv(df_na, "na_test.csv", row.names = FALSE)
print(read.csv("na_test.csv", na.strings = c("NA", "")))
print(read.csv("na_test.csv", colClasses = c("numeric", "character")))

# 10. Handling large files (nrows, skip)
cat("\n--- Large file handling ---\n")
# read.csv("large.csv", nrows=100) # read first 100 rows
# read.csv("large.csv", skip=1000, nrows=100) # chunked reading
# Use data.table::fread for fast reading if available
if (requireNamespace("data.table", quietly = TRUE)) {
  # library(data.table)
  # dt <- data.table::fread("test_output.csv")
  # print(dt)
  message("data.table available - fread can be used")
} else {
  message("data.table not installed - install.packages('data.table') for faster I/O")
}

# 11. JSON (if jsonlite available)
cat("\n--- JSON ---\n")
if (requireNamespace("jsonlite", quietly = TRUE)) {
  json_str <- jsonlite::toJSON(df, pretty = TRUE)
  print(json_str)
  write(json_str, "test.json")
  print(jsonlite::fromJSON("test.json"))
} else {
  message("jsonlite not installed - install.packages('jsonlite') for JSON support")
}

# 12. file operations
cat("\n--- File operations ---\n")
print(file.exists("test_output.csv"))
print(file.info("test_output.csv")[, c("size", "isdir", "mtime")])
# file.copy("test_output.csv", "copy.csv")
# file.rename("copy.csv", "renamed.csv")
# unlink("renamed.csv") # delete file

# Cleanup temp files
cat("\n--- Cleanup ---\n")
files_to_remove <- c("test_output.csv", "test_table.txt", "test_data.rds",
                     "test_workspace.RData", "scan_test.txt", "lines_test.txt",
                     "connection_test.txt", "na_test.csv", "test.json")
for (f in files_to_remove) {
  if (file.exists(f)) {
    unlink(f)
    cat("Removed:", f, "\n")
  }
}

cat("\n--- Done: File I/O ---\n")
