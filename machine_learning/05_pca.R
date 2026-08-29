# Machine Learning: PCA, Scaling, and Dimensionality Reduction
# ============================================================

cat("--- 1. PCA on iris ---\n")
data(iris)
iris_num <- iris[, 1:4]
print(head(iris_num))
print(summary(iris_num))

# PCA with prcomp (recommended, uses SVD)
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE)
print(summary(pca))
print(pca$rotation) # loadings
print(pca$x[1:5, ])  # scores
print(pca$sdev)      # standard deviations
print(pca$center)
print(pca$scale)

# Variance explained
var_explained <- pca$sdev^2 / sum(pca$sdev^2)
print(var_explained)
print(cumsum(var_explained))
cat("PC1 explains:", round(var_explained[1] * 100, 1), "% variance\n")
cat("PC1+PC2 explains:", round(sum(var_explained[1:2]) * 100, 1), "% variance\n")

png("ml_pca_scree.png", width = 700, height = 400)
par(mfrow = c(1, 2))
plot(var_explained, type = "b", pch = 19, col = "blue",
     main = "Scree Plot", xlab = "Principal Component", ylab = "Variance Explained")
barplot(var_explained, names.arg = paste0("PC", 1:4), col = "skyblue",
        main = "Variance per PC", ylab = "Proportion")
par(mfrow = c(1, 1))
dev.off()
cat("Saved ml_pca_scree.png\n")

png("ml_pca_biplot.png", width = 700, height = 600)
biplot(pca, scale = 0, cex = 0.7, col = c("gray", "red"),
       main = "PCA Biplot - Iris")
dev.off()
cat("Saved ml_pca_biplot.png\n")

png("ml_pca_scatter.png", width = 700, height = 500)
plot(pca$x[, 1], pca$x[, 2], col = as.numeric(iris$Species) + 1, pch = 19, cex = 1.2,
     main = "PCA: PC1 vs PC2", xlab = paste0("PC1 (", round(var_explained[1]*100, 1), "%)"),
     ylab = paste0("PC2 (", round(var_explained[2]*100, 1), "%)"))
legend("topright", legend = levels(iris$Species), col = 2:4, pch = 19)
# Add loadings as arrows
arrows(0, 0, pca$rotation[, 1] * 3, pca$rotation[, 2] * 3, col = "red", length = 0.1, lwd = 2)
text(pca$rotation[, 1] * 3.2, pca$rotation[, 2] * 3.2, labels = rownames(pca$rotation), col = "red")
dev.off()
cat("Saved ml_pca_scatter.png\n")

cat("\n--- 2. PCA with princomp (alternative) ---\n")
pca2 <- princomp(iris_num, cor = TRUE) # cor=TRUE scales
print(summary(pca2))
print(pca2$loadings)

cat("\n--- 3. PCA on mtcars ---\n")
mtcars_scaled <- scale(mtcars)
pca_mtcars <- prcomp(mtcars_scaled, center = FALSE, scale. = FALSE) # already scaled
print(summary(pca_mtcars))
var_mtcars <- pca_mtcars$sdev^2 / sum(pca_mtcars$sdev^2)
print(var_mtcars[1:5])
png("ml_pca_mtcars.png", width = 700, height = 500)
plot(pca_mtcars$x[, 1], pca_mtcars$x[, 2], pch = 19, col = as.factor(mtcars$cyl),
     main = "mtcars PCA", xlab = "PC1", ylab = "PC2")
text(pca_mtcars$x[, 1], pca_mtcars$x[, 2], labels = rownames(mtcars), cex = 0.6, pos = 3)
legend("topright", legend = paste("cyl", sort(unique(mtcars$cyl))), col = 1:3, pch = 19)
dev.off()
cat("Saved ml_pca_mtcars.png\n")

cat("\n--- 4. Manual PCA check (eigen) ---\n")
# PCA via eigen decomposition of correlation matrix
cor_mat <- cor(iris_num)
eig <- eigen(cor_mat)
print(eig$values)
print(eig$vectors)
# Compare with prcomp sdev^2
cat("Eigen values vs pca sdev^2:\n")
print(data.frame(eigen = eig$values, pca_var = pca$sdev^2))

cat("\n--- 5. Choosing number of PCs ---\n")
# Kaiser criterion: eigenvalues > 1
print(eig$values[eig$values > 1])
# Cumulative variance 90%
cumvar <- cumsum(var_explained)
print(which(cumvar >= 0.9)[1]) # first PC reaching 90%
cat("PCs needed for 90% variance:", which(cumvar >= 0.9)[1], "\n")

cat("\n--- 6. Reconstruction ---\n")
# Reconstruct using first 2 PCs
# X_reconstructed = scores[,1:2] %*% t(loadings[,1:2]) * scale + center
scores2 <- pca$x[, 1:2]
loadings2 <- pca$rotation[, 1:2]
# Unscale
X_recon_scaled <- scores2 %*% t(loadings2)
X_recon <- sweep(sweep(X_recon_scaled, 2, pca$scale, "*"), 2, pca$center, "+")
print(head(iris_num))
print(head(X_recon))
# Reconstruction error
recon_error <- mean((as.matrix(iris_num) - X_recon)^2)
cat("Reconstruction MSE (2 PCs):", recon_error, "\n")
# With all 4 PCs error should be ~0
X_recon_full <- pca$x %*% t(pca$rotation)
X_recon_full <- sweep(sweep(X_recon_full, 2, pca$scale, "*"), 2, pca$center, "+")
cat("Full reconstruction MSE:", mean((as.matrix(iris_num) - X_recon_full)^2), "\n")

cat("\n--- Done: PCA ---\n")
