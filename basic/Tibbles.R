if (requireNamespace("tibble", quietly = TRUE)) {
  library(tibble)
  my_data <- tibble(
    name = c("Ajit", "Dinesh", "Ajay"),
    age = c(25, 30, 35),
    city = c("Mumbai", "Chennai", "Bengaluru")
  )
  print(my_data)
} else {
  # fallback to data.frame
  my_data <- data.frame(
    name = c("Ajit", "Dinesh", "Ajay"),
    age = c(25, 30, 35),
    city = c("Mumbai", "Chennai", "Bengaluru"),
    stringsAsFactors = FALSE
  )
  print(my_data)
  message("tibble not installed - using data.frame fallback")
}