# Hypothesis Testing in R
# ============================================================

cat("--- 1. t-test ---\n")
# One-sample t-test: is mean of x different from mu=10?
set.seed(42)
x <- rnorm(30, mean = 10.5, sd = 2)
print(t.test(x, mu = 10))
print(t.test(x, mu = 10, alternative = "greater"))
print(t.test(x, mu = 10, conf.level = 0.99))

# Two-sample t-test
group_a <- rnorm(30, mean = 50, sd = 10)
group_b <- rnorm(30, mean = 55, sd = 10)
print(t.test(group_a, group_b))
print(t.test(group_a, group_b, var.equal = TRUE)) # Student's t
print(t.test(group_a, group_b, paired = FALSE))

# Paired t-test
before <- c(85, 90, 78, 92, 88)
after <- c(90, 92, 80, 95, 91)
print(t.test(before, after, paired = TRUE))

cat("\n--- 2. Chi-squared test ---\n")
# Test independence in contingency table
tbl <- matrix(c(30, 20, 50, 100), nrow = 2, byrow = TRUE,
              dimnames = list(c("Group A", "Group B"), c("Success", "Failure")))
print(tbl)
print(chisq.test(tbl))
print(chisq.test(tbl, correct = FALSE)) # without Yates

# Goodness of fit
observed <- c(30, 20, 50)
expected_p <- c(0.3, 0.3, 0.4)
print(chisq.test(observed, p = expected_p))

cat("\n--- 3. ANOVA ---\n")
# One-way ANOVA: does mpg differ by cyl?
print(summary(aov(mpg ~ factor(cyl), data = mtcars)))
# Two-way ANOVA
print(summary(aov(len ~ supp * dose, data = ToothGrowth)))
# Check residuals
anova_model <- aov(mpg ~ factor(cyl), data = mtcars)
print(summary(anova_model))
print(TukeyHSD(anova_model))

cat("\n--- 4. Correlation tests ---\n")
print(cor.test(mtcars$mpg, mtcars$wt, method = "pearson"))
print(cor.test(mtcars$mpg, mtcars$wt, method = "spearman"))
print(cor.test(mtcars$mpg, mtcars$wt, method = "kendall"))

cat("\n--- 5. Proportion tests ---\n")
# prop.test: is proportion = 0.5?
print(prop.test(x = 45, n = 100, p = 0.5))
print(prop.test(x = c(45, 55), n = c(100, 100))) # two proportions
# binom.test
print(binom.test(45, 100, p = 0.5))

cat("\n--- 6. Wilcoxon (non-parametric) ---\n")
print(wilcox.test(group_a, group_b))
print(wilcox.test(group_a, group_b, exact = FALSE))
# Paired Wilcoxon
print(wilcox.test(before, after, paired = TRUE))

cat("\n--- 7. Shapiro-Wilk normality test ---\n")
print(shapiro.test(rnorm(50, mean = 0, sd = 1))) # should be normal
print(shapiro.test(rexp(50, rate = 1))) # should be non-normal
print(shapiro.test(mtcars$mpg))

cat("\n--- 8. Kolmogorov-Smirnov test ---\n")
print(ks.test(rnorm(50), "pnorm"))
print(ks.test(group_a, group_b))

cat("\n--- 9. Variance tests ---\n")
print(var.test(group_a, group_b)) # F-test for equal variances
print(bartlett.test(len ~ supp, data = ToothGrowth))
print(fligner.test(len ~ interaction(supp, dose), data = ToothGrowth))

cat("\n--- 10. Practical: iris Species comparison ---\n")
# Does Sepal.Length differ by Species?
print(summary(aov(Sepal.Length ~ Species, data = iris)))
print(TukeyHSD(aov(Sepal.Length ~ Species, data = iris)))
# Pairwise t-tests with correction
print(pairwise.t.test(iris$Sepal.Length, iris$Species, p.adjust.method = "bonferroni"))
print(pairwise.t.test(iris$Sepal.Length, iris$Species, p.adjust.method = "holm"))

cat("\n--- Done: Hypothesis Tests ---\n")
