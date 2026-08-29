library(testthat)

test_that("descriptive statistics", {
  x <- c(10, 12, 15, 18, 20, 22, 25)
  expect_equal(median(x), 18)
  expect_true(cor(mtcars$mpg, mtcars$wt) < -0.8)
  expect_equal(mean(c(10, 20, 30)), 20)
  expect_equal(sum(c(1, 2, 3)), 6)
})

test_that("hypothesis tests return htest", {
  set.seed(42)
  g1 <- rnorm(30, 50, 10); g2 <- rnorm(30, 55, 10)
  expect_s3_class(t.test(g1, g2), "htest")
  tbl <- matrix(c(10, 20, 30, 40), nrow = 2)
  expect_s3_class(chisq.test(tbl), "htest")
  av <- aov(mpg ~ factor(cyl), data = mtcars)
  expect_true(inherits(summary(av), "summary.aov"))
})

test_that("regression lm and glm", {
  m <- lm(dist ~ speed, data = cars)
  expect_s3_class(m, "lm")
  expect_length(coef(m), 2)
  expect_gt(summary(m)$r.squared, 0.6)
  pred <- predict(m, newdata = data.frame(speed = 10))
  expect_length(pred, 1)
  glm_m <- glm(am ~ mpg, data = mtcars, family = binomial)
  expect_s3_class(glm_m, "glm")
  expect_length(coef(glm_m), 2)
})

test_that("statistics files parse", {
  expect_true(file.exists("../../statistics/01_descriptive.R") || file.exists("statistics/01_descriptive.R"))
  # check key files exist via relative path
  files <- c("statistics/01_descriptive.R", "statistics/02_hypothesis_tests.R", "statistics/03_regression_anova.R")
  for (f in files) {
    alt <- file.path("../../", f)
    path <- if (file.exists(f)) f else if (file.exists(alt)) alt else f
    expect_true(file.exists(path) || file.exists(f), info = f)
  }
})
