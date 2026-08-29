# Error Handling and Debugging in R
# ============================================================

cat("--- 1. stop() / warning() / message() ---\n")
safe_divide <- function(a, b) {
  if (b == 0) stop("Division by zero is not allowed!")
  if (b < 0) warning("Divisor is negative, result will be negative")
  message("Computing division...")
  return(a / b)
}
print(try(safe_divide(10, 2)))
print(try(safe_divide(10, 0)))
print(try(safe_divide(10, -2)))

cat("\n--- 2. try() ---\n")
result <- try(log("a"), silent = TRUE)
print(result)
print(class(result))
if (inherits(result, "try-error")) {
  print("Caught error via try()")
}
# try with silent FALSE shows error message
result2 <- try(sum(1, "a"))
print(result2)

cat("\n--- 3. tryCatch() ---\n")
result <- tryCatch(
  {
    x <- as.numeric("abc")
    if (is.na(x)) stop("Conversion resulted in NA")
    log(x)
  },
  warning = function(w) {
    message("Warning caught: ", w$message)
    return(NA)
  },
  error = function(e) {
    message("Error caught: ", e$message)
    return(NULL)
  },
  finally = {
    message("Finally block always executes")
  }
)
print(result)

# tryCatch with different error types
parse_input <- function(x) {
  tryCatch(
    {
      val <- as.integer(x)
      if (is.na(val)) stop("NA after conversion")
      return(val * 2)
    },
    error = function(e) {
      message("Error: ", e$message)
      return(NA)
    }
  )
}
print(parse_input("10"))
print(parse_input("abc"))

cat("\n--- 4. withCallingHandlers ---\n")
withCallingHandlers(
  {
    warning("This is a warning")
    message("This is a message")
    print("Execution continues")
  },
  warning = function(w) {
    message("Handler caught warning: ", w$message)
    invokeRestart("muffleWarning")
  },
  message = function(m) {
    message("Handler caught message: ", m$message)
    invokeRestart("muffleMessage")
  }
)

cat("\n--- 5. Custom conditions ---\n")
custom_function <- function(x) {
  if (x < 0) {
    stop("x must be non-negative", call. = FALSE)
  } else if (x == 0) {
    warning("x is zero, result is 1", call. = FALSE)
    return(1)
  }
  return(sqrt(x))
}
print(custom_function(9))
print(try(custom_function(-1)))
print(custom_function(0))

cat("\n--- 6. suppressWarnings / suppressMessages ---\n")
print(suppressWarnings(as.numeric(c("1", "a", "3"))))
suppressMessages(message("This will be hidden"))

cat("\n--- 7. Debugging helpers ---\n")
# traceback() - shows call stack after error (demo)
f <- function() g()
g <- function() h()
h <- function() stop("Error in h")
print(try(f()))
# traceback() would show f -> g -> h after error if run interactively

# browser() - interactive debugging (commented to avoid halt)
debug_function <- function(x) {
  # browser() # uncomment to debug interactively
  y <- x * 2
  return(y + 10)
}
print(debug_function(5))

# debug / undebug (show usage, not actually stepping)
# debug(debug_function)
# debug_function(5)
# undebug(debug_function)

cat("\n--- 8. Validate input pattern ---\n")
process_data <- function(df) {
  if (!is.data.frame(df)) stop("Input must be a data.frame")
  if (nrow(df) == 0) stop("Data frame is empty")
  if (any(is.na(df))) warning("Data contains NA values")
  message("Processing ", nrow(df), " rows")
  return(summary(df))
}
print(process_data(iris[1:5, ]))
print(try(process_data(data.frame())))
print(try(process_data(c(1, 2, 3))))

cat("\n--- 9. stopifnot() ---\n")
check_positive <- function(x) {
  stopifnot(is.numeric(x), length(x) == 1, x > 0)
  return(log(x))
}
print(check_positive(10))
print(try(check_positive(-5)))
print(try(check_positive("a")))

cat("\n--- Done: Error Handling ---\n")
