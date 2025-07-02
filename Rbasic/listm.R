empId = c(1, 2, 3, 4) 
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4
 
empList = list(empId, empName, numberOfEmp)
 
print(empList)

my_named_list <- list(name = "Sudheer", age = 25, city = "Delhi")

print(my_named_list)


empId = c(1, 2, 3, 4)
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4

empList = list(
  "ID" = empId,
  "Names" = empName,
  "Total Staff" = numberOfEmp
  )
print(empList)

cat("Accessing name components using $ command\n")
print(empList$Names)