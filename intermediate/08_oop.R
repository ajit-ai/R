# OOP in R - S3, S4, and R6 / Reference Classes
# ============================================================

cat("--- 1. S3 System ---\n")
# S3 is simple: object is list with class attribute, generic uses UseMethod

# Create S3 class (use my_person to avoid collision with utils::person)
person <- list(name = "Alice", age = 30)
class(person) <- "my_person"
print(person)
print(class(person))

# Generic function
print.my_person <- function(x, ...) {
  cat("Person:", x$name, ", Age:", x$age, "\n")
}
print(person) # now uses custom print

# Constructor function
person_new <- function(name, age) {
  obj <- list(name = name, age = age)
  class(obj) <- "my_person"
  return(obj)
}
p1 <- person_new("Bob", 25)
p2 <- person_new("Charlie", 35)
print(p1); print(p2)

# S3 generic with UseMethod
greet <- function(x, ...) UseMethod("greet")
greet.my_person <- function(x, ...) {
  paste("Hello, I am", x$name)
}
greet.default <- function(x, ...) {
  paste("Hello, unknown object")
}
print(greet(p1))
print(greet("not a person"))

# Inheritance
employee <- list(name = "David", age = 28, dept = "CS")
class(employee) <- c("employee", "my_person")
print(class(employee))
greet.employee <- function(x, ...) {
  paste("Hello, I am", x$name, "from", x$dept)
}
print(greet(employee))
# Check inheritance
print(inherits(employee, "my_person"))
print(inherits(employee, "employee"))

cat("\n--- 2. S3 Methods inspection ---\n")
print(methods("print"))
print(methods("greet"))
print(s3_dispatch <- function(generic, object) {
  class_obj <- class(object)[1]
  paste0(generic, ".", class_obj)
})
print(s3_dispatch("greet", p1))

cat("\n--- 3. S4 System ---\n")
# S4 is formal: setClass, setMethod, slots with validation

if (!isClass("Student")) setClass("Student",
  slots = list(
    name = "character",
    age = "numeric",
    gpa = "numeric"
  ),
  prototype = list(gpa = 0.0)
)

# Create S4 object
s1 <- new("Student", name = "Alice", age = 20, gpa = 3.8)
print(s1)
print(s1@name) # slot access with @
print(slot(s1, "gpa"))
print(class(s1))

# Validity method
setValidity("Student", function(object) {
  if (object@gpa < 0 || object@gpa > 4.0) {
    return("GPA must be between 0 and 4.0")
  }
  if (object@age < 0) return("Age must be positive")
  return(TRUE)
})
# Try invalid
print(try(new("Student", name = "Bad", age = 20, gpa = 5.0)))

# S4 generic and method
if (!isGeneric("showInfo")) setGeneric("showInfo", function(object) standardGeneric("showInfo"))
setMethod("showInfo", "Student", function(object) {
  cat("Student:", object@name, ", Age:", object@age, ", GPA:", object@gpa, "\n")
})
showInfo(s1)

# Inheritance in S4
if (!isClass("GradStudent")) setClass("GradStudent",
  contains = "Student",
  slots = list(thesis = "character")
)
gs <- new("GradStudent", name = "Bob", age = 25, gpa = 3.9, thesis = "AI Research")
print(gs)
showInfo(gs) # inherits? Will use Student method unless overridden
setMethod("showInfo", "GradStudent", function(object) {
  cat("Grad Student:", object@name, ", Thesis:", object@thesis, "\n")
})
showInfo(gs)

cat("\n--- 4. Reference Classes (R5) ---\n")
PersonRC <- setRefClass("PersonRC",
  fields = list(name = "character", age = "numeric"),
  methods = list(
    initialize = function(name = "", age = 0) {
      .self$name <- name
      .self$age <- age
    },
    greet = function() {
      paste("Hi, I am", name, "and I am", age, "years old")
    },
    haveBirthday = function() {
      age <<- age + 1
      cat("Happy Birthday! Now", age, "\n")
    },
    show = function() {
      cat("PersonRC:", name, ",", age, "\n")
    }
  )
)
rc1 <- PersonRC$new(name = "Eve", age = 22)
rc1$show()
print(rc1$greet())
rc1$haveBirthday()
rc1$show()
# Reference semantics: copy is by reference, not value!
rc2 <- rc1
rc2$haveBirthday()
cat("rc1 age after rc2 birthday (reference):", rc1$age, "\n") # both changed!

cat("\n--- 5. R6 (if available) ---\n")
if (requireNamespace("R6", quietly = TRUE)) {
  library(R6)
  BankAccount <- R6Class("BankAccount",
    public = list(
      balance = 0,
      initialize = function(balance = 0) {
        self$balance <- balance
      },
      deposit = function(amount) {
        self$balance <- self$balance + amount
        invisible(self)
      },
      withdraw = function(amount) {
        if (amount > self$balance) stop("Insufficient funds")
        self$balance <- self$balance - amount
        invisible(self)
      },
      print = function(...) {
        cat("Balance:", self$balance, "\n")
      }
    ),
    private = list(
      log = function(msg) cat("[LOG]", msg, "\n")
    )
  )
  acc <- BankAccount$new(100)
  acc$print()
  acc$deposit(50)$withdraw(30)
  acc$print()
} else {
  message("R6 not installed - install.packages('R6') for R6 OOP")
}

cat("\n--- 6. S3 vs S4 vs R6 summary ---\n")
cat("S3: simple, informal, use class attribute + UseMethod\n")
cat("S4: formal, slots, validation, setClass/setMethod\n")
cat("R6: reference semantics, private/public, mutable (like OOP in Python/Java)\n")

cat("\n--- Done: OOP ---\n")
