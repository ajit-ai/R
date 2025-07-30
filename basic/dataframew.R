friend.data <- data.frame(
    friend_id = c(1:5), 
    friend_name = c("Sachin", "Sourav", 
                    "Dravid", "Sehwag", 
                    "Dhoni"),
    stringsAsFactors = FALSE
)
print(friend.data)

friend.data <- data.frame(
    friend_id = c(1:5), 
    friend_name = c("Sachin", "Sourav", 
                    "Dravid", "Sehwag", 
                    "Dhoni"),
    stringsAsFactors = FALSE
)
print(str(friend.data))


friend.data <- data.frame(
    friend_id = c(1:5), 
    friend_name = c("Sachin", "Sourav", 
                    "Dravid", "Sehwag", 
                    "Dhoni"),
    stringsAsFactors = FALSE
)
print(summary(friend.data))


friend.data <- data.frame(
    friend_id = c(1:5), 
    friend_name = c("Sachin", "Sourav", 
                    "Dravid", "Sehwag", 
                    "Dhoni"),
    stringsAsFactors = FALSE
)

result <- data.frame(friend.data$friend_name)
print(result)


friend.data <- data.frame(
    friend_id = c(1:5), 
    friend_name = c("Sachin", "Sourav", 
                    "Dravid", "Sehwag", 
                    "Dhoni"),
    stringsAsFactors = FALSE
)

friend.data$location <- c("Kolkata", "Delhi", 
                          "Bangalore", "Hyderabad",
                          "Chennai")
resultant <- friend.data
print(resultant)


friend.data <- data.frame(
  friend_id = c(1:5), 
  friend_name = c("Sachin", "Sourav", 
                  "Dravid", "Sehwag", 
                  "Dhoni"),
  stringsAsFactors = FALSE
)

print(friend.data[1])

friend.data[['friend_name']]

print(friend.data$friend_id)

friend.data <- data.frame(
  friend_id = c(1:5), 
  friend_name = c("Sachin", "Sourav", 
                  "Dravid", "Sehwag", 
                  "Dhoni"),
  stringsAsFactors = FALSE
)

dim(friend.data)


Products <- data.frame(
  Product_ID = c(101, 102, 103),
  Product_Name = c("T-Shirt", "Jeans", "Shoes"),
  Price = c(15.99, 29.99, 49.99),
  Stock = c(50, 30, 25)
)

cat("Existing dataframe (Products):\n")
print(Products)

New_Product <- c(104, "Sunglasses", 39.99, 40)
Products <- rbind(Products, New_Product)

cat("\nUpdated dataframe after adding a new product:\n")
print(Products)


Products <- data.frame(
  Product_ID = c(101, 102, 103),
  Product_Name = c("T-Shirt", "Jeans", "Shoes"),
  Price = c(15.99, 29.99, 49.99),
  Stock = c(50, 30, 25)
)

cat("Existing dataframe (Products):\n")
print(Products)

Discount <- c(5, 10, 8)
Products <- cbind(Products, Discount)

colnames(Products)[ncol(Products)] <- "Discount"

cat("\nUpdated dataframe after adding a new column 'Discount':\n")
print(Products)

Products <- data.frame(
  Product_ID = c(101, 102, 103),
  Product_Name = c("T-Shirt", "Jeans", "Shoes"),
  Price = c(15.99, 29.99, 49.99),
  Stock = c(50, 30, 25)
)

cat("Existing dataframe (Products):\n")
print(Products)

Discount <- c(5, 10, 8)
Products <- cbind(Products, Discount)

colnames(Products)[ncol(Products)] <- "Discount"

cat("\nUpdated dataframe after adding a new column 'Discount':\n")
print(Products)

library(dplyr)

data <- data.frame(
  friend_id = c(1, 2, 3, 4, 5),
  friend_name = c("Sachin", "Sourav", "Dravid", "Sehwag", "Dhoni"),
  location = c("Kolkata", "Delhi", "Bangalore", "Hyderabad", "Chennai")
)

print(data)

data <- subset(data, friend_id != 3)

print(data)


df1 <- data.frame(
  Name = c("Alice", "Bob"),
  Age = c(25, 30),
  Score = c(80, 75)
)

df2 <- data.frame(
  Name = c("Charlie", "David"),
  Age = c(28, 35),
  Score = c(90, 85)
)

cat("Dataframe 1:\n")
print(df1)

cat("\nDataframe 2:\n")
print(df2)

combined_df <- rbind(df1, df2)

cat("\nCombined Dataframe:\n")
print(combined_df)

df1 <- data.frame(
  Name = c("Alice", "Bob"),
  Age = c(25, 30),
  Score = c(80, 75)
)

df2 <- data.frame(
  Height = c(160, 175),
  Weight = c(55, 70)
)

cat("Dataframe 1:\n")
print(df1)

cat("\nDataframe 2:\n")
print(df2)

combined_df <- cbind(df1, df2)

cat("\nCombined Dataframe:\n")
print(combined_df)