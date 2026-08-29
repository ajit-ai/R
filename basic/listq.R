empId = c(1, 2, 3, 4)
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4

empList = list(
  "ID" = empId,
  "Names" = empName,
  "Total Staff" = numberOfEmp
)
print(empList)

cat("Accessing name components using indices\n")
print(empList[[2]])

cat("Accessing Sandeep from name using indices\n")
print(empList[[2]][2])

cat("Accessing 4 from ID using indices\n")
print(empList[[1]][4])


empId = c(1, 2, 3, 4)
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4

empList = list(
  "ID" = empId,
  "Names" = empName,
  "Total Staff" = numberOfEmp
)
cat("Before modifying the list\n")
print(empList)

empList$`Total Staff` = 5
empList[[1]][5] = 5
empList[[2]][5] = "Kamala"

cat("After modified the list\n")
print(empList)

my_numbers = c(1,5,6,3)

append(my_numbers, 45)

my_numbers = append(my_numbers, 45, after=2)
print(my_numbers)