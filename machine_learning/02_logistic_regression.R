# Machine Learning: Logistic Regression
# ============================================================

cat("--- 1. Binary Classification (mtcars am) ---\n")
data(mtcars)
# am: 0 = automatic, 1 = manual
print(table(mtcars$am))
print(prop.table(table(mtcars$am)))

# Train/test split
set.seed(123)
idx <- sample(1:nrow(mtcars), size = floor(0.7 * nrow(mtcars)))
train <- mtcars[idx, ]
test <- mtcars[-idx, ]

# Fit logistic regression
model <- glm(am ~ mpg + wt + hp, data = train, family = binomial)
print(summary(model))
print(exp(coef(model))) # odds ratios

# Predictions
pred_prob_train <- predict(model, newdata = train, type = "response")
pred_prob_test <- predict(model, newdata = test, type = "response")
pred_class_train <- ifelse(pred_prob_train > 0.5, 1, 0)
pred_class_test <- ifelse(pred_prob_test > 0.5, 1, 0)

# Confusion matrices
cat("\nTrain Confusion:\n")
print(table(Predicted = pred_class_train, Actual = train$am))
cat("\nTest Confusion:\n")
print(table(Predicted = pred_class_test, Actual = test$am))

accuracy <- function(pred, actual) mean(pred == actual)
cat("Train Accuracy:", accuracy(pred_class_train, train$am), "\n")
cat("Test Accuracy :", accuracy(pred_class_test, test$am), "\n")

# Precision, Recall, F1
precision <- function(pred, actual) {
  tp <- sum(pred == 1 & actual == 1)
  fp <- sum(pred == 1 & actual == 0)
  if (tp + fp == 0) return(0)
  tp / (tp + fp)
}
recall <- function(pred, actual) {
  tp <- sum(pred == 1 & actual == 1)
  fn <- sum(pred == 0 & actual == 1)
  if (tp + fn == 0) return(0)
  tp / (tp + fn)
}
f1 <- function(pred, actual) {
  p <- precision(pred, actual)
  r <- recall(pred, actual)
  if (p + r == 0) return(0)
  2 * p * r / (p + r)
}
cat("Test Precision:", precision(pred_class_test, test$am), "\n")
cat("Test Recall   :", recall(pred_class_test, test$am), "\n")
cat("Test F1       :", f1(pred_class_test, test$am), "\n")

cat("\n--- 2. Using iris (binary: setosa vs others) ---\n")
iris_bin <- iris
iris_bin$IsSetosa <- ifelse(iris$Species == "setosa", 1, 0)
print(table(iris_bin$IsSetosa))

model_iris <- glm(IsSetosa ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                  data = iris_bin, family = binomial)
print(summary(model_iris))
pred_iris_prob <- predict(model_iris, type = "response")
pred_iris_class <- ifelse(pred_iris_prob > 0.5, 1, 0)
print(table(Predicted = pred_iris_class, Actual = iris_bin$IsSetosa))
cat("Iris Binary Accuracy:", accuracy(pred_iris_class, iris_bin$IsSetosa), "\n")

cat("\n--- 3. ROC Curve (manual) ---\n")
# Simple ROC points without pROC package
thresholds <- seq(0, 1, by = 0.05)
tpr <- numeric(length(thresholds))
fpr <- numeric(length(thresholds))
for (i in seq_along(thresholds)) {
  th <- thresholds[i]
  pred_th <- ifelse(pred_prob_test > th, 1, 0)
  tp <- sum(pred_th == 1 & test$am == 1)
  fn <- sum(pred_th == 0 & test$am == 1)
  fp <- sum(pred_th == 1 & test$am == 0)
  tn <- sum(pred_th == 0 & test$am == 0)
  tpr[i] <- ifelse(tp + fn == 0, 0, tp / (tp + fn))
  fpr[i] <- ifelse(fp + tn == 0, 0, fp / (fp + tn))
}
png("ml_logistic_roc.png", width = 600, height = 500)
plot(fpr, tpr, type = "b", pch = 19, col = "blue",
     main = "ROC Curve (mtcars am)", xlab = "False Positive Rate", ylab = "True Positive Rate")
abline(0, 1, lty = 2, col = "red")
dev.off()
cat("Saved ml_logistic_roc.png\n")
# AUC via trapezoidal rule
auc <- sum(diff(fpr) * (head(tpr, -1) + tail(tpr, -1)) / 2)
# Need sorted by fpr
ord <- order(fpr)
auc_correct <- sum(diff(fpr[ord]) * (head(tpr[ord], -1) + tail(tpr[ord], -1)) / 2)
cat("Approx AUC:", abs(auc_correct), "\n")
if (requireNamespace("pROC", quietly = TRUE)) {
  roc_obj <- pROC::roc(test$am, pred_prob_test)
  cat("pROC AUC:", pROC::auc(roc_obj), "\n")
}

cat("\n--- 4. Multinomial (if nnet available) ---\n")
if (requireNamespace("nnet", quietly = TRUE)) {
  library(nnet)
  # Multinomial for iris Species
  model_multi <- multinom(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                          data = iris, trace = FALSE)
  print(summary(model_multi))
  pred_multi <- predict(model_multi, newdata = iris)
  print(table(Predicted = pred_multi, Actual = iris$Species))
  cat("Multinomial Accuracy:", mean(pred_multi == iris$Species), "\n")
} else {
  cat("nnet not available\n")
}

cat("\n--- Done: Logistic Regression ---\n")
