# Regex and Advanced String Manipulation in R
# ============================================================

# Base string functions + regex + stringr (if available)

cat("--- 1. grep / grepl / regexpr / gregexpr ---\n")
texts <- c("apple", "banana", "Apricot", "cherry", "avocado", "Blueberry")
print(grep("^a", texts, value = TRUE))           # starts with a
print(grep("^a", texts, value = TRUE, ignore.case = TRUE))
print(grepl("an", texts))                        # contains "an"
print(grep("berry$", texts, value = TRUE))       # ends with berry

# regexpr - first match position
print(regexpr("an", texts))
print(gregexpr("an", texts)) # all matches
print(regmatches(texts, regexpr("an", texts)))

cat("\n--- 2. sub / gsub ---\n")
print(sub("a", "X", "banana"))    # first occurrence only
print(gsub("a", "X", "banana"))   # all occurrences
print(gsub("[0-9]", "", "a1b2c3d4"))
print(gsub("\\s+", " ", "too   many    spaces")) # collapse spaces

# With regex groups
print(sub("(\\w+) (\\w+)", "\\2 \\1", "John Doe")) # swap words
phone <- "123-456-7890"
print(sub("(\\d{3})-(\\d{3})-(\\d{4})", "(\\1) \\2-\\3", phone))

cat("\n--- 3. strsplit / paste / sprintf ---\n")
print(strsplit("a,b,c,d", ","))
print(strsplit("hello world R programming", " "))
words <- strsplit("apple,banana;cherry|date", "[,;|]")[[1]]
print(words)
print(paste(c("Hello", "World"), collapse = " "))
print(paste("A", 1:3, sep = "-"))
print(sprintf("Name: %s, Age: %d, Score: %.2f", "Alice", 25, 95.678))
print(sprintf("Hex: %x, Scientific: %e", 255, 12345.678))

cat("\n--- 4. nchar / substr / substring ---\n")
s <- "Hello World"
print(nchar(s))
print(substr(s, 1, 5))  # Hello
print(substr(s, 7, 11)) # World
print(substring(s, 7))  # from 7 to end
print(toupper(s)); print(tolower(s))
print(trimws("  hello world  "))
print(trimws("  hello world  ", which = "left"))

cat("\n--- 5. Regex metacharacters ---\n")
# . any char, ^ start, $ end, * 0+, + 1+, ? 0/1, [] char class, () group, | or, \\ escape
test_strings <- c("cat", "bat", "hat", "chat", "caat", "cut", "ct")
print(grep("^c.*t$", test_strings, value = TRUE)) # starts c ends t
print(grep("c.t", test_strings, value = TRUE))    # c any char t
print(grep("ca+", test_strings, value = TRUE))    # c followed by one or more a
print(grep("ca?t", test_strings, value = TRUE))   # c optional a then t
print(grep("c[au]t", test_strings, value = TRUE)) # c followed by a or u then t
print(grep("[0-9]+", c("abc123", "def", "456ghi"), value = TRUE))

cat("\n--- 6. Character classes ---\n")
print(grep("[A-Z]", c("hello", "Hello", "HELLO"), value = TRUE))
print(grep("[a-z]+", "Hello123World", value = TRUE))
print(gsub("[^a-zA-Z]", "", "Hello 123 World! @#")) # keep only letters
print(gsub("[aeiou]", "*", "hello world"))           # replace vowels
print(grep("\\d", c("abc", "a1b", "123"), value = TRUE))  # digit
print(grep("\\s", c("hello world", "helloworld"), value = TRUE)) # whitespace

cat("\n--- 7. Quantifiers ---\n")
print(grep("a{2}", c("a", "aa", "aaa", "b"), value = TRUE))      # exactly 2 a's
print(grep("a{2,3}", c("a", "aa", "aaa", "aaaa"), value = TRUE)) # 2 to 3
print(grep("a{2,}", c("a", "aa", "aaa", "aaaa"), value = TRUE))  # 2 or more

cat("\n--- 8. stringr package (if available) ---\n")
if (requireNamespace("stringr", quietly = TRUE)) {
  library(stringr)
  print(str_length("hello"))
  print(str_detect(c("apple", "banana"), "an"))
  print(str_count("banana", "a"))
  print(str_replace("banana", "a", "X"))    # first
  print(str_replace_all("banana", "a", "X")) # all
  print(str_split("a,b,c", ","))
  print(str_subset(c("apple", "banana", "cherry"), "^a"))
  print(str_extract("My phone is 123-456-7890", "\\d{3}-\\d{3}-\\d{4}"))
  print(str_extract_all("a1 b22 c333", "\\d+"))
  print(str_match("John Doe 25", "(\\w+) (\\w+) (\\d+)"))
  print(str_trim("  hello  "))
  print(str_pad("5", width = 3, pad = "0")) # "005"
  print(str_to_upper("hello")); print(str_to_lower("HELLO"))
  print(str_starts("hello world", "hello"))
  print(str_ends("hello world", "world"))
} else {
  message("stringr not installed - install.packages('stringr')")
}

cat("\n--- 9. Practical examples ---\n")
# Email validation
emails <- c("test@example.com", "invalid.email", "user@domain.co.uk", "bad@.com")
email_pattern <- "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
print(grepl(email_pattern, emails))
print(emails[grepl(email_pattern, emails)])

# Extract numbers from text
text <- "Prices: $19.99, $25.50, $100"
print(regmatches(text, gregexpr("\\$[0-9]+\\.[0-9]{2}", text)))

# Word count
sentence <- "R is a powerful language for data analysis"
print(length(strsplit(sentence, "\\s+")[[1]]))
print(lengths(strsplit(sentence, "\\s+")))

# CamelCase to snake_case
camel <- "camelCaseStringExample"
print(gsub("([a-z])([A-Z])", "\\1_\\L\\2", camel, perl = TRUE))

cat("\n--- 10. Case conversion with regex ---\n")
print(chartr("aeiou", "AEIOU", "hello world"))
print(casefold("Hello World", upper = TRUE))
print(casefold("Hello World", upper = FALSE))

cat("\n--- Done: Regex & Strings ---\n")
