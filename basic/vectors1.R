X = c(1, 3, 5, 7, 8)

print(X)

X<- c(61, 4, 21, 67, 89, 2)
cat('using c function', X, '\n')

Y<- seq(1, 10, length.out = 5) 
cat('using seq() function', Y, '\n') 

Z<- 2:7
cat('using colon', Z)

v1 <- c(4, 5, 6, 7)
typeof(v1)

v2 <- c(1L, 4L, 2L, 5L)
typeof(v2)

v1 <- c('geeks', '2', 'hello', 57)
typeof(v1)

v1 <- c(TRUE, FALSE, TRUE, NA)
typeof(v1)

x <- c(1, 2, 3, 4, 5)
length(x)

y <- c("apple", "banana", "cherry")
length(y)

z <- c(TRUE, FALSE, TRUE, TRUE)
length(z)

X <- c(2, 5, 18, 1, 12)
cat('Using Subscript operator', X[2], '\n')

Y <- c(4, 8, 2, 1, 17)
cat('Using combine() function', Y[c(4, 1)], '\n')

X <- c(2, 7, 9, 7, 8, 2)

X[3] <- 1
X[2] <- 9
cat('subscript operator', X, '\n')

X[1:5] <- 0
cat('Logical indexing', X, '\n')

X <- X[c(3, 2, 1)]
cat('combine() function', X)

M <- c(8, 10, 2, 5)

M <- NULL

print(cat('Output vector', M, "\f"))

X <- c(8, 2, 7, 1, 11, 2)

A <- sort(X)
cat('ascending order', A, '\n')

B <- sort(X, decreasing = TRUE)
cat('descending order', B)