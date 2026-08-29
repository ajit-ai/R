# Machine Learning: Decision Trees, Random Forest, kNN
# Requires rpart (included in base R distribution)
# ============================================================

cat("--- 1. Decision Tree with rpart ---\n")
library(rpart)
# rpart is part of base R recommended packages
print(packageVersion("rpart"))

# Classification tree: iris Species
set.seed(123)
idx <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train <- iris[idx, ]
test <- iris[-idx, ]

tree_iris <- rpart(Species ~ ., data = train, method = "class",
                   control = rpart.control(minsplit = 5, cp = 0.01))
print(tree_iris)
print(summary(tree_iris))
print(printcp(tree_iris))
print(tree_iris$cptable)

png("ml_tree_iris.png", width = 800, height = 600)
plot(tree_iris, uniform = TRUE, main = "Decision Tree - Iris")
text(tree_iris, use.n = TRUE, all = TRUE, cex = 0.8)
dev.off()
cat("Saved ml_tree_iris.png (base plot)\n")

# Fancy plot if rpart.plot available
if (requireNamespace("rpart.plot", quietly = TRUE)) {
  png("ml_tree_iris_fancy.png", width = 800, height = 600)
  rpart.plot::rpart.plot(tree_iris, main = "Fancy Iris Tree")
  dev.off()
  cat("Saved ml_tree_iris_fancy.png\n")
}

# Predictions
pred_train <- predict(tree_iris, train, type = "class")
pred_test <- predict(tree_iris, test, type = "class")
print("Train Confusion:")
print(table(Predicted = pred_train, Actual = train$Species))
print("Test Confusion:")
print(table(Predicted = pred_test, Actual = test$Species))
cat("Train Accuracy:", mean(pred_train == train$Species), "\n")
cat("Test Accuracy :", mean(pred_test == test$Species), "\n")

# Pruning
print("CP table:")
printcp(tree_iris)
optimal_cp <- tree_iris$cptable[which.min(tree_iris$cptable[, "xerror"]), "CP"]
cat("Optimal CP:", optimal_cp, "\n")
pruned <- prune(tree_iris, cp = optimal_cp)
print(pruned)
pred_pruned <- predict(pruned, test, type = "class")
cat("Pruned Test Accuracy:", mean(pred_pruned == test$Species), "\n")

cat("\n--- 2. Regression Tree (mtcars mpg) ---\n")
tree_reg <- rpart(mpg ~ wt + hp + disp + cyl + gear, data = mtcars, method = "anova")
print(tree_reg)
png("ml_tree_reg.png", width = 800, height = 500)
plot(tree_reg, uniform = TRUE, main = "Regression Tree - mtcars MPG")
text(tree_reg, use.n = TRUE, cex = 0.8)
dev.off()
cat("Saved ml_tree_reg.png\n")
pred_reg <- predict(tree_reg, mtcars)
cat("Regression RMSE:", sqrt(mean((mtcars$mpg - pred_reg)^2)), "\n")
cat("Regression R2  :", cor(mtcars$mpg, pred_reg)^2, "\n")

cat("\n--- 3. kNN Classification (class package) ---\n")
library(class)
# Need scaled features
set.seed(123)
idx_knn <- sample(1:nrow(iris), size = 0.7 * nrow(iris))
train_knn <- iris[idx_knn, 1:4]
test_knn <- iris[-idx_knn, 1:4]
train_labels <- iris[idx_knn, 5]
test_labels <- iris[-idx_knn, 5]

# Scale using train parameters
train_scaled <- scale(train_knn)
test_scaled <- scale(test_knn, center = attr(train_scaled, "scaled:center"),
                     scale = attr(train_scaled, "scaled:scale"))

for (k in c(1, 3, 5, 7, 11)) {
  pred_knn <- knn(train = train_scaled, test = test_scaled, cl = train_labels, k = k)
  acc <- mean(pred_knn == test_labels)
  cat("k =", k, " Accuracy:", acc, "\n")
}
# Best k=5 detail
pred_knn5 <- knn(train_scaled, test_scaled, train_labels, k = 5)
print(table(Predicted = pred_knn5, Actual = test_labels))

cat("\n--- 4. Random Forest (if available) ---\n")
if (requireNamespace("randomForest", quietly = TRUE)) {
  library(randomForest)
  set.seed(123)
  rf <- randomForest(Species ~ ., data = train, ntree = 100, importance = TRUE)
  print(rf)
  print(importance(rf))
  pred_rf <- predict(rf, test)
  print(table(Predicted = pred_rf, Actual = test$Species))
  cat("RF Test Accuracy:", mean(pred_rf == test$Species), "\n")
  png("ml_rf_importance.png", width = 700, height = 500)
  varImpPlot(rf, main = "Random Forest Variable Importance")
  dev.off()
  cat("Saved ml_rf_importance.png\n")
} else {
  cat("randomForest not installed - install.packages('randomForest')\n")
  cat("Showing bagging concept manually with multiple trees:\n")
  # Manual bagging demo: 5 bootstrap trees, majority vote (simplified)
  set.seed(123)
  n_trees <- 5
  votes <- matrix(NA, nrow = nrow(test), ncol = n_trees)
  for (i in 1:n_trees) {
    boot_idx <- sample(1:nrow(train), replace = TRUE)
    boot_train <- train[boot_idx, ]
    t <- rpart(Species ~ ., data = boot_train, method = "class")
    votes[, i] <- as.character(predict(t, test, type = "class"))
  }
  print(head(votes))
  # Majority vote per row
  majority <- apply(votes, 1, function(x) names(which.max(table(x))))
  cat("Manual Bagging Accuracy:", mean(majority == as.character(test$Species)), "\n")
}

cat("\n--- 5. Cross-validation for tree ---\n")
# 5-fold CV for decision tree
k <- 5
set.seed(42)
folds <- sample(rep(1:k, length.out = nrow(iris)))
cv_acc <- numeric(k)
for (i in 1:k) {
  cv_train <- iris[folds != i, ]
  cv_test <- iris[folds == i, ]
  cv_tree <- rpart(Species ~ ., data = cv_train, method = "class")
  cv_pred <- predict(cv_tree, cv_test, type = "class")
  cv_acc[i] <- mean(cv_pred == cv_test$Species)
  cat("Fold", i, "Accuracy:", cv_acc[i], "\n")
}
cat("Mean CV Accuracy:", mean(cv_acc), " SD:", sd(cv_acc), "\n")

cat("\n--- Done: Decision Trees & Ensemble ---\n")
