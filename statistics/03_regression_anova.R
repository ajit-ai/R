# Regression and ANOVA - Detailed
# ============================================================

cat("--- 1. Simple Linear Regression ---\n")
# Using cars dataset: dist ~ speed
model1 <- lm(dist ~ speed, data = cars)
print(summary(model1))
print(coefficients(model1))
print(confint(model1))
print(fitted(model1)[1:5])
print(residuals(model1)[1:5])
print(predict(model1, newdata = data.frame(speed = c(10, 15, 20))))
# With interval
print(predict(model1, newdata = data.frame(speed = c(10, 15, 20)),
              interval = "confidence"))
print(predict(model1, newdata = data.frame(speed = c(10, 15, 20)),
              interval = "prediction"))

cat("\n--- 2. Multiple Linear Regression ---\n")
# mtcars: mpg ~ wt + hp + cyl
model2 <- lm(mpg ~ wt + hp + cyl, data = mtcars)
print(summary(model2))
print(anova(model2))
print(vcov(model2)) # variance-covariance

# Stepwise selection
print(step(model2, direction = "both", trace = FALSE))
# Or using full model
full_model <- lm(mpg ~ ., data = mtcars)
print(summary(full_model))
# Best via AIC
print(step(full_model, trace = FALSE))

cat("\n--- 3. Model Diagnostics ---\n")
png("regression_diagnostics.png", width = 800, height = 600)
par(mfrow = c(2, 2))
plot(model1)
par(mfrow = c(1, 1))
dev.off()
cat("Saved regression_diagnostics.png\n")

# Residual analysis
print(shapiro.test(residuals(model1))) # normality of residuals
print(summary(rstandard(model1))[1:5]) # standardized residuals

cat("\n--- 4. Polynomial Regression ---\n")
# mpg vs wt with quadratic term
model_poly <- lm(mpg ~ wt + I(wt^2), data = mtcars)
print(summary(model_poly))
# Compare
print(anova(model2, model_poly))

cat("\n--- 5. Logistic Regression ---\n")
# Predict am (0=auto, 1=manual) from mpg and wt
model_logit <- glm(am ~ mpg + wt, data = mtcars, family = binomial)
print(summary(model_logit))
print(exp(coef(model_logit))) # odds ratios
print(predict(model_logit, type = "response")[1:5])
print(predict(model_logit, type = "link")[1:5])
# Confusion matrix
pred_prob <- predict(model_logit, type = "response")
pred_class <- ifelse(pred_prob > 0.5, 1, 0)
print(table(Predicted = pred_class, Actual = mtcars$am))
print(mean(pred_class == mtcars$am)) # accuracy

cat("\n--- 6. ANOVA in depth ---\n")
# One-way
aov1 <- aov(mpg ~ factor(cyl), data = mtcars)
print(summary(aov1))
print(model.tables(aov1, type = "means"))

# Two-way with interaction
aov2 <- aov(len ~ supp * dose, data = ToothGrowth)
print(summary(aov2))
print(TukeyHSD(aov2))

# Repeated measures style (using Error)
# aov3 <- aov(y ~ treatment * time + Error(subject/time), data=...)

cat("\n--- 7. Interaction terms ---\n")
model_inter <- lm(mpg ~ wt * hp, data = mtcars)
print(summary(model_inter))
# Visualize interaction
png("interaction_plot.png", width = 600, height = 400)
interaction.plot(mtcars$cyl, mtcars$gear, mtcars$mpg,
                 main = "Interaction: cyl x gear on mpg",
                 xlab = "Cylinders", ylab = "MPG", trace.label = "Gears")
dev.off()
cat("Saved interaction_plot.png\n")

cat("\n--- 8. Correlation matrix and pairs ---\n")
print(cor(mtcars))
png("pairs_mtcars.png", width = 600, height = 600)
pairs(mtcars[, c("mpg", "wt", "hp", "disp")], pch = 19, col = "steelblue",
      main = "Pairs: mtcars")
panel.cor <- function(x, y, digits = 2, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- cor(x, y)
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  text(0.5, 0.5, txt, cex = 1.5)
}
# pairs with correlation panel would need custom, skipping for base

dev.off()

cat("\n--- 9. Cross-validation manual ---\n")
set.seed(123)
n <- nrow(mtcars)
train_idx <- sample(1:n, size = 0.8 * n)
train <- mtcars[train_idx, ]
test <- mtcars[-train_idx, ]
model_cv <- lm(mpg ~ wt + hp, data = train)
pred_cv <- predict(model_cv, newdata = test)
rmse <- sqrt(mean((test$mpg - pred_cv)^2))
mae <- mean(abs(test$mpg - pred_cv))
print(paste("RMSE:", round(rmse, 3)))
print(paste("MAE:", round(mae, 3)))
print(paste("R2 on test:", round(cor(test$mpg, pred_cv)^2, 3)))

cat("\n--- Done: Regression & ANOVA ---\n")
