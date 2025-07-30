empId = c(1, 2, 3, 4)
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4

empList = list(
  "ID" = empId,
  "Names" = empName,
  "Total Staff" = numberOfEmp
)
cat("Before deletion the list is\n")
print(empList)

cat("After Deleting Total staff components\n")
print(empList[-3])

cat("After Deleting sandeep from name\n")
print(empList[[2]][-2])


lst1 <- list(1,2,3)
lst2 <- list("Sun","Mon","Tue")

new_list <- c(lst1, lst2)

print(new_list)


lst <- list(1:5)
print(lst)

vec <- unlist(lst)

print(vec)

lst1 <- list(list(1, 2, 3),
            list(4, 5, 6))

cat("The list is:\n")
print(lst1)
cat("Class:", class(lst1), "\n")

mat <- matrix(unlist(lst1), nrow = 2, byrow = TRUE)

cat("\nAfter conversion to matrix:\n")
print(mat)
cat("Class:", class(mat), "\n")