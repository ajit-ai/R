# Reverse a string in R
my_string <- "Hello, World!"
reversed <- paste(rev(strsplit(my_string, NULL)[[1]]), collapse = "")
print(reversed)