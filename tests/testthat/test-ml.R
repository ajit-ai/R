library(testthat)

test_that("k-means clustering", {
  set.seed(123)
  km <- kmeans(iris[, 1:4], centers = 3, nstart = 10)
  expect_length(km$cluster, 150)
  expect_length(unique(km$cluster), 3)
  expect_equal(sum(km$size), 150)
  wss <- sapply(1:4, function(k) kmeans(iris[, 1:4], k, nstart = 5)$tot.withinss)
  expect_true(all(diff(wss) < 0))
})

test_that("hierarchical clustering", {
  d <- dist(iris[1:10, 1:4])
  hc <- hclust(d, method = "complete")
  expect_s3_class(hc, "hclust")
  cl <- cutree(hc, k = 3)
  expect_length(cl, 10)
  expect_length(unique(cl), 3)
})

test_that("decision tree rpart", {
  skip_if_not_installed("rpart")
  library(rpart)
  set.seed(123)
  idx <- sample(1:nrow(iris), 100)
  train <- iris[idx, ]; test <- iris[-idx, ]
  tree <- rpart(Species ~ ., data = train, method = "class")
  expect_s3_class(tree, "rpart")
  pred <- predict(tree, test, type = "class")
  expect_length(pred, nrow(test))
  expect_gt(mean(pred == test$Species), 0.8)
})

test_that("knn class", {
  skip_if_not_installed("class")
  library(class)
  set.seed(123)
  idx <- sample(1:nrow(iris), 100)
  train <- scale(iris[idx, 1:4])
  test <- scale(iris[-idx, 1:4], center = attr(train, "scaled:center"), scale = attr(train, "scaled:scale"))
  pred <- knn(train, test, cl = iris$Species[idx], k = 5)
  expect_length(pred, nrow(test))
  expect_gt(mean(pred == iris$Species[-idx]), 0.8)
})

test_that("PCA", {
  pca <- prcomp(iris[, 1:4], center = TRUE, scale. = TRUE)
  expect_equal(nrow(pca$x), 150)
  expect_equal(ncol(pca$x), 4)
  var_expl <- pca$sdev^2 / sum(pca$sdev^2)
  expect_gt(var_expl[1], 0.7)
  expect_equal(sum(var_expl), 1, tolerance = 1e-8)
})

test_that("linear and logistic regression", {
  set.seed(123)
  idx <- sample(1:nrow(mtcars), floor(0.7 * nrow(mtcars)))
  train <- mtcars[idx, ]; test <- mtcars[-idx, ]
  m <- lm(mpg ~ wt + hp, data = train)
  pred <- predict(m, test)
  expect_length(pred, nrow(test))
  expect_lt(sqrt(mean((test$mpg - pred)^2)), 5)
  m2 <- glm(am ~ mpg + wt, data = mtcars, family = binomial)
  prob <- predict(m2, type = "response")
  expect_length(prob, nrow(mtcars))
  expect_true(all(prob >= 0 & prob <= 1))
  expect_gt(mean(ifelse(prob > 0.5, 1, 0) == mtcars$am), 0.7)
})
