# Machine Learning: Linear Regression - Comprehensive
# ============================================================

cat("--- 1. Simple Linear Regression (cars) ---\n")
data(cars)
print(head(cars))
print(summary(cars))

model <- lm(dist ~ speed, data = cars)
print(summary(model))
cat("Coefficients:", coef(model), "\n")
cat("R-squared:", summary(model)$r.squared, "\n")
cat("Adjusted R-squared:", summary(model)$adj.r.squared, "\n")

# Manual calculation check
x <- cars$speed; y <- cars$dist
slope <- cov(x, y) / var(x)
intercept <- mean(y) - slope * mean(x)
cat("Manual slope:", slope, " intercept:", intercept, "\n")

# Prediction
new_speeds <- data.frame(speed = c(10, 15, 20, 25))
pred <- predict(model, newdata = new_speeds, interval = "confidence")
print(pred)
pred2 <- predict(model, newdata = new_speeds, interval = "prediction")
print(pred2)

cat("\n--- 2. Multiple Linear Regression (mtcars) ---\n")
data(mtcars)
print(head(mtcars))

# Train/test split
set.seed(123)
n <- nrow(mtcars)
idx <- sample(1:n, size = floor(0.75 * n))
train <- mtcars[idx, ]
test <- mtcars[-idx, ]

model_multi <- lm(mpg ~ wt + hp + disp + cyl, data = train)
print(summary(model_multi))

# Predictions and metrics
pred_train <- predict(model_multi, newdata = train)
pred_test <- predict(model_multi, newdata = test)

rmse <- function(actual, predicted) sqrt(mean((actual - predicted)^2))
mae <- function(actual, predicted) mean(abs(actual - predicted))
r2 <- function(actual, predicted) cor(actual, predicted)^2

cat("Train RMSE:", rmse(train$mpg, pred_train), "\n")
cat("Test  RMSE:", rmse(test$mpg, pred_test), "\n")
cat("Train R2  :", r2(train$mpg, pred_train), "\n")
cat("Test  R2  :", r2(test$mpg, pred_test), "\n")

# Residual analysis
png("ml_linear_residuals.png", width = 800, height = 600)
par(mfrow = c(2, 2))
plot(model_multi)
par(mfrow = c(1, 1))
dev.off()
cat("Saved ml_linear_residuals.png\n")

cat("\n--- 3. Feature selection ---\n")
full_model <- lm(mpg ~ ., data = train)
print(summary(full_model))
# Stepwise AIC
step_model <- step(full_model, direction = "both", trace = FALSE)
print(summary(step_model))
cat("Selected formula:", deparse(formula(step_model)), "\n")

# Compare models via ANOVA
print(anova(model_multi, step_model))

cat("\n--- 4. Regularization concept (manual ridge-like) ---\n")
# Without glmnet, show correlation and VIF concept
print(cor(train[, c("wt", "hp", "disp", "cyl")]))
# Variance Inflation Factor (if car package available)
if (requireNamespace("car", quietly = TRUE)) {
  print(car::vif(model_multi))
} else {
  cat("Install 'car' package for VIF: install.packages('car')\n")
  # Manual VIF for wt: 1/(1-R2 of wt ~ other predictors)
  vif_wt_model <- lm(wt ~ hp + disp + cyl, data = train)
  vif_wt <- 1 / (1 - summary(vif_wt_model)$r.squared)
  cat("Manual VIF for wt:", vif_wt, "\n")
}

cat("\n--- 5. Polynomial features ---\n")
model_poly <- lm(mpg ~ wt + I(wt^2) + hp, data = train)
print(summary(model_poly))
cat("Poly Train R2:", r2(train$mpg, predict(model_poly, train)), "\n")
cat("Poly Test  R2:", r2(test$mpg, predict(model_poly, test)), "\n")

cat("\n--- 6. Cross-validation (k-fold manual) ---\n")
k <- 5
set.seed(42)
folds <- sample(rep(1:k, length.out = nrow(mtcars)))
cv_rmse <- numeric(k)
for (i in 1:k) {
  cv_train <- mtcars[folds != i, ]
  cv_test <- mtcars[folds == i, ]
  cv_model <- lm(mpg ~ wt + hp, data = cv_train)
  cv_pred <- predict(cv_model, newdata = cv_test)
  cv_rmse[i] <- rmse(cv_test$mpg, cv_pred)
  cat("Fold", i, "RMSE:", cv_rmse[i], "\n")
}
cat("Mean CV RMSE:", mean(cv_rmse), " SD:", sd(cv_rmse), "\n")

cat("\n--- Done: Linear Regression ---\n")
