x <- c(1, 2, 3, 4)
y <- c("a", "b", "c", "d")
z <- 5
a <- c("Jayan will be",25,"years old in",2028)

cat(x,":" ,class(x),"\n")
cat(y,":" ,class(y),"\n")
cat(z,":" ,class(z),"\n")
cat(a,":" ,class(a),"\n")

ls1  <- list(c(1, 2, 3, 4))
ls2 <- list("a", "b", "c")
ls3 <- c(ls1,ls2)

ls
class(ls)
print("------------------------------")
ls2
class(ls2)
print("------------------------------")
ls3
class(ls3)


x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

mat <- matrix(x, nrow = 3)

print(mat)
class(mat)


s <- c("spring", "autumn", "winter", "summer","spring", "autumn")

factor(s)

print(nlevels(factor(s)))

arr <- array(c(1, 2, 3), dim = c(3, 3, 3))

print(arr)

x <- 1:10
y <- LETTERS[1:10]
z <- c("Ansh", "Raj", "Sahil", "Vikram", "Ravi", "Kareena", "Anita", "Jayan", "Priya", "Sunil")

df <- data.frame(x, y, z)

df