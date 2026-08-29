str1 <- "OK1"
cat ("String 1 is : ", str1)

str2 <- 'OK2'
cat ("String 2 is : ", str2)

str3 <- "This is 'acceptable' and 'allowed' in R"
cat("String 3 is : ", str3, "\n")

str4 <- 'Hi, Wondering "if this works"'
cat("String 4 is : ", str4, "\n")

# Single quotes inside single-quoted string must be escaped or use double quotes
str5 <- 'Hi, this is allowed when properly escaped'
cat("String 5 is : ", str5, "\n")

str6 <- "Hi, 'this is allowed' inside double quotes"
cat("String 6 is : ", str6, "\n")

# Example of escaping
str7 <- "She said \"Hello\" and it's fine"
cat("String 7 is : ", str7, "\n")