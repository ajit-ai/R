# Advanced Plotting in Base R
# ============================================================

cat("--- 1. Multiple plot layouts ---\n")
png("advanced_layout.png", width = 800, height = 600)
par(mfrow = c(2, 2)) # 2x2 grid
plot(1:10, main = "Plot 1")
plot(1:10, rnorm(10), main = "Plot 2 Scatter")
hist(rnorm(100), main = "Plot 3 Histogram", col = "lightblue")
boxplot(mpg ~ cyl, data = mtcars, main = "Plot 4 Boxplot", col = "lightgreen")
par(mfrow = c(1, 1))
dev.off()
cat("Saved advanced_layout.png\n")

cat("\n--- 2. Custom colors and palettes ---\n")
png("advanced_colors.png", width = 800, height = 400)
par(mfrow = c(1, 2))
# Palette examples
barplot(1:5, col = rainbow(5), main = "Rainbow")
barplot(1:5, col = heat.colors(5), main = "Heat Colors")
dev.off()
# Color brewer-like manual
palette(c("red", "green", "blue", "purple", "orange"))
cat("Palette set\n")

cat("\n--- 3. Line types and point characters ---\n")
png("advanced_lines_points.png", width = 700, height = 500)
plot(1:10, type = "n", main = "Line Types (lty) and Point Characters (pch)")
for (i in 1:6) {
  lines(1:10 + rnorm(10, 0, 0.3), lty = i, lwd = 2, col = i)
}
legend("topleft", legend = paste("lty", 1:6), lty = 1:6, lwd = 2, col = 1:6, cex = 0.7)

# pch demo
plot(1:25, pch = 1:25, col = 1:25, cex = 1.5, bg = "lightblue",
     main = "pch 1:25 (point characters)", xlab = "pch value", ylab = "")
dev.off()
cat("Saved advanced_lines_points.png\n")

cat("\n--- 4. Annotations and legends ---\n")
png("advanced_annotations.png", width = 700, height = 500)
plot(cars, main = "Cars: Speed vs Distance with Annotations", pch = 19, col = "darkblue")
abline(lm(dist ~ speed, data = cars), col = "red", lwd = 2)
text(10, 80, "Regression Line", col = "red", cex = 1.2)
arrows(12, 70, 15, 40, col = "red", lwd = 1.5)
mtext("Source: cars dataset", side = 1, line = 4, cex = 0.7)
legend("topleft", legend = c("Data", "Fit"), pch = c(19, NA), lty = c(NA, 1),
       col = c("darkblue", "red"), lwd = c(NA, 2))
# Add grid
grid(col = "gray", lty = "dotted")
dev.off()
cat("Saved advanced_annotations.png\n")

cat("\n--- 5. Boxplot customization ---\n")
png("advanced_boxplot2.png", width = 700, height = 500)
boxplot(len ~ supp * dose, data = ToothGrowth,
        col = c("orange", "skyblue"),
        main = "Tooth Growth by Supplement and Dose",
        xlab = "Supplement & Dose", ylab = "Length",
        notch = TRUE, outline = TRUE)
# Add points
stripchart(len ~ supp * dose, data = ToothGrowth, vertical = TRUE,
           method = "jitter", pch = 19, col = "darkred", add = TRUE)
dev.off()
cat("Saved advanced_boxplot2.png\n")

cat("\n--- 6. Histogram with density overlay ---\n")
png("advanced_hist_density.png", width = 700, height = 500)
hist(iris$Sepal.Length, freq = FALSE, col = "lightblue", border = "white",
     main = "Histogram with Density Overlay", xlab = "Sepal Length")
lines(density(iris$Sepal.Length), col = "red", lwd = 2)
curve(dnorm(x, mean = mean(iris$Sepal.Length), sd = sd(iris$Sepal.Length)),
      add = TRUE, col = "darkgreen", lwd = 2, lty = 2)
legend("topright", legend = c("Kernel Density", "Normal Fit"),
       col = c("red", "darkgreen"), lty = c(1, 2), lwd = 2)
dev.off()
cat("Saved advanced_hist_density.png\n")

cat("\n--- 7. Pie and bar with customization ---\n")
png("advanced_pie_bar.png", width = 800, height = 400)
par(mfrow = c(1, 2))
# Enhanced pie
slices <- c(20, 30, 25, 25)
lbls <- c("A", "B", "C", "D")
pct <- round(slices / sum(slices) * 100)
lbls <- paste(lbls, pct, "%", sep = " ")
pie(slices, labels = lbls, col = rainbow(4), main = "Pie with %")
# Enhanced bar
barplot(slices, names.arg = lbls, col = rainbow(4), main = "Bar Chart",
        ylim = c(0, 35))
text(x = 1:4 * 1.2 - 0.5, y = slices + 1, labels = slices, cex = 0.8)
par(mfrow = c(1, 1))
dev.off()
cat("Saved advanced_pie_bar.png\n")

cat("\n--- 8. 3D-like perspective (using base) ---\n")
png("advanced_persp.png", width = 600, height = 500)
# Volcano dataset (built-in)
persp(volcano, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
      main = "Volcano Topography (persp)")
dev.off()
cat("Saved advanced_persp.png\n")

cat("\n--- 9. Interactive-like: saving multiple formats ---\n")
# PDF also works
pdf("advanced_plots.pdf", width = 8, height = 6)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 19,
     main = "Iris PDF Export")
dev.off()
cat("Saved advanced_plots.pdf\n")

# List generated files
print(list.files(pattern = "advanced_.*\\.png$"))
print(list.files(pattern = "\\.pdf$"))

cat("\n--- Done: Advanced Plots ---\n")
