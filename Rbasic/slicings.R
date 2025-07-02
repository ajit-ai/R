str <- "Learn Code"

len <- nchar(str)
print(substr(str, 1, 4))
print(substr(str, len-2, len))

str <- "Hi LeArn CodiNG"
print(toupper(str))
print(tolower(str))
print(casefold(str, upper = TRUE))

string1 <- "Hello"
string2 <- "World"

result <- paste(string1, string2)

print(result)

result <- paste("Hello", "to", "the World")

print(result)