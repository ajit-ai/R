# Machine Learning: Clustering (K-means, Hierarchical, DBSCAN concept)
# ============================================================

cat("--- 1. K-means Clustering ---\n")
data(iris)
# Use numeric columns only
iris_numeric <- iris[, 1:4]
print(head(iris_numeric))

set.seed(123)
k3 <- kmeans(iris_numeric, centers = 3, nstart = 25)
print(k3)
print(k3$centers)
print(k3$size) # points per cluster
print(k3$withinss)
print(k3$tot.withinss)
print(k3$betweenss)
print(table(Cluster = k3$cluster, Species = iris$Species)) # compare with true labels

# Elbow method: try k=1..10
cat("\n--- Elbow Method ---\n")
wss <- numeric(10)
for (k in 1:10) {
  set.seed(123)
  wss[k] <- kmeans(iris_numeric, centers = k, nstart = 10)$tot.withinss
}
print(wss)
png("ml_kmeans_elbow.png", width = 600, height = 400)
plot(1:10, wss, type = "b", pch = 19, col = "blue",
     main = "Elbow Method for K-means", xlab = "Number of clusters K", ylab = "Total within SS")
dev.off()
cat("Saved ml_kmeans_elbow.png\n")

# K-means on mtcars
cat("\n--- K-means on mtcars ---\n")
mtcars_scaled <- scale(mtcars)
set.seed(42)
km_mtcars <- kmeans(mtcars_scaled, centers = 3, nstart = 20)
print(km_mtcars$centers[1:2, 1:4])
print(table(km_mtcars$cluster))
print(table(km_mtcars$cluster, mtcars$cyl))

png("ml_kmeans_mtcars.png", width = 700, height = 500)
# PCA for visualization
pca_mtcars <- prcomp(mtcars_scaled)
plot(pca_mtcars$x[, 1:2], col = km_mtcars$cluster, pch = 19, cex = 1.5,
     main = "K-means (k=3) on mtcars - PCA projection", xlab = "PC1", ylab = "PC2")
# Project centers onto PC space: centers %*% rotation
center_pca <- km_mtcars$centers %*% pca_mtcars$rotation[, 1:2]
points(center_pca, col = 1:3, pch = 8, cex = 2, lwd = 2)
legend("topright", legend = paste("Cluster", 1:3), col = 1:3, pch = 19)
dev.off()
cat("Saved ml_kmeans_mtcars.png\n")

cat("\n--- 2. Hierarchical Clustering ---\n")
# Distance matrix
d <- dist(iris_numeric[1:30, ]) # subset for readability
print(as.matrix(d)[1:5, 1:5])

# Methods: complete, single, average, ward.D2
hc_complete <- hclust(d, method = "complete")
hc_average <- hclust(d, method = "average")
hc_ward <- hclust(dist(iris_numeric), method = "ward.D2")

png("ml_hclust.png", width = 900, height = 600)
par(mfrow = c(1, 2))
plot(hc_complete, main = "Complete Linkage (n=30)", xlab = "", cex = 0.7)
plot(hc_ward, main = "Ward.D2 (iris full)", xlab = "", cex = 0.6)
par(mfrow = c(1, 1))
dev.off()
cat("Saved ml_hclust.png\n")

# Cut tree
clusters_hc <- cutree(hc_ward, k = 3)
print(table(clusters_hc, iris$Species))
print(table(clusters_hc))

# Dendrogram customization
png("ml_dendrogram.png", width = 800, height = 500)
plot(hc_ward, labels = FALSE, main = "Dendrogram with cut at k=3")
rect.hclust(hc_ward, k = 3, border = 2:4)
dev.off()
cat("Saved ml_dendrogram.png\n")

cat("\n--- 3. Comparing K-means vs Hierarchical ---\n")
print("K-means table:")
print(table(Kmeans = k3$cluster, Species = iris$Species))
print("Hierarchical table:")
print(table(HClust = clusters_hc, Species = iris$Species))
# Accuracy if we map clusters to majority species (quick)
# For kmeans, cluster 1 mostly setosa, etc.

cat("\n--- 4. Scaling effect ---\n")
# Without scaling vs with scaling
set.seed(123)
km_unscaled <- kmeans(iris_numeric, centers = 3, nstart = 10)
km_scaled <- kmeans(scale(iris_numeric), centers = 3, nstart = 10)
print("Unscaled centers:")
print(km_unscaled$centers)
print("Scaled centers:")
print(km_scaled$centers)

cat("\n--- 5. DBSCAN concept (if dbscan package) ---\n")
if (requireNamespace("dbscan", quietly = TRUE)) {
  library(dbscan)
  db <- dbscan(iris_numeric, eps = 0.5, minPts = 5)
  print(table(db$cluster))
  print(db$cluster[1:10])
} else {
  cat("dbscan package not installed - install.packages('dbscan')\n")
  cat("Showing manual density concept: points with many neighbors\n")
  # Manual: count neighbors within eps
  eps <- 0.7
  dmat <- as.matrix(dist(iris_numeric))
  neighbor_counts <- rowSums(dmat < eps) - 1 # exclude self
  print(head(neighbor_counts))
  print(table(neighbor_counts > 5))
}

cat("\n--- Done: Clustering ---\n")
