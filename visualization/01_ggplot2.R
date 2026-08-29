# ggplot2 - Grammar of Graphics
# Requires: ggplot2 (install.packages("ggplot2") if missing)
# Falls back to base R examples if not installed
# ============================================================

cat("--- ggplot2 Examples ---\n")
has_ggplot2 <- requireNamespace("ggplot2", quietly = TRUE)
has_ggplot2_plot <- FALSE
if (has_ggplot2) {
  library(ggplot2)
  cat("ggplot2 version:", as.character(packageVersion("ggplot2")), "\n")

  # Base dataset: iris, mtcars
  cat("\n--- 1. Scatter plot ---\n")
  p1 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
    geom_point(size = 2) +
    labs(title = "Iris Sepal Dimensions", x = "Sepal Length", y = "Sepal Width") +
    theme_minimal()
  print(p1)
  ggsave("gg_scatter.png", p1, width = 6, height = 4, dpi = 100)
  cat("Saved gg_scatter.png\n")

  cat("\n--- 2. Line plot ---\n")
  df_line <- data.frame(x = 1:20, y = cumsum(rnorm(20)))
  p2 <- ggplot(df_line, aes(x = x, y = y)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_point(color = "red", size = 2) +
    labs(title = "Cumulative Random Walk")
  print(p2)
  ggsave("gg_line.png", p2, width = 6, height = 4, dpi = 100)

  cat("\n--- 3. Bar chart ---\n")
  df_bar <- as.data.frame(table(mtcars$cyl))
  colnames(df_bar) <- c("cyl", "count")
  p3 <- ggplot(df_bar, aes(x = cyl, y = count, fill = cyl)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = count), vjust = -0.5) +
    labs(title = "Cars by Cylinder Count")
  print(p3)
  ggsave("gg_bar.png", p3, width = 6, height = 4, dpi = 100)

  cat("\n--- 4. Histogram ---\n")
  p4 <- ggplot(mtcars, aes(x = mpg)) +
    geom_histogram(binwidth = 3, fill = "skyblue", color = "black", bins = 10) +
    labs(title = "MPG Distribution", x = "Miles per Gallon")
  print(p4)
  ggsave("gg_hist.png", p4, width = 6, height = 4, dpi = 100)

  cat("\n--- 5. Boxplot ---\n")
  p5 <- ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(width = 0.2, alpha = 0.3) +
    labs(title = "Sepal Length by Species")
  print(p5)
  ggsave("gg_boxplot.png", p5, width = 6, height = 4, dpi = 100)

  cat("\n--- 6. Faceting ---\n")
  p6 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point(aes(color = factor(cyl)), size = 3) +
    facet_wrap(~ cyl, labeller = label_both) +
    labs(title = "MPG vs Weight Faceted by Cylinders")
  print(p6)
  ggsave("gg_facet.png", p6, width = 8, height = 4, dpi = 100)

  cat("\n--- 7. Themes and Scales ---\n")
  p7 <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
    geom_point(size = 3) +
    scale_color_brewer(palette = "Set1", name = "Cylinders") +
    theme_bw() +
    theme(legend.position = "bottom") +
    labs(title = "Themed Scatter")
  print(p7)
  ggsave("gg_themed.png", p7, width = 6, height = 4, dpi = 100)

  cat("\n--- 8. Density plot ---\n")
  p8 <- ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
    geom_density(alpha = 0.5) +
    labs(title = "Density of Sepal Length")
  print(p8)
  ggsave("gg_density.png", p8, width = 6, height = 4, dpi = 100)

  has_ggplot2_plot <- TRUE
} else {
  cat("ggplot2 not installed - showing base R equivalents\n")
  cat("Install with: install.packages('ggplot2')\n")
  # Base R fallback plots
  png("base_scatter.png", width = 600, height = 400)
  plot(iris$Sepal.Length, iris$Sepal.Width, col = as.factor(iris$Species),
       pch = 19, main = "Iris Sepal (base R)")
  legend("topright", legend = levels(iris$Species), pch = 19,
         col = 1:3)
  dev.off()
  cat("Created base_scatter.png as fallback\n")
}

# Always run base R advanced plots (works without ggplot2)
cat("\n--- 9. Base R Advanced Plots (always available) ---\n")

png("base_boxplot.png", width = 600, height = 400)
boxplot(Sepal.Length ~ Species, data = iris, col = c("red", "green", "blue"),
        main = "Boxplot: Sepal Length by Species")
dev.off()
cat("Saved base_boxplot.png\n")

png("base_pairs.png", width = 600, height = 600)
pairs(iris[1:4], col = as.numeric(iris$Species) + 1, pch = 19,
      main = "Pairs Plot Iris")
dev.off()
cat("Saved base_pairs.png\n")

png("base_heatmap.png", width = 600, height = 500)
heatmap(as.matrix(mtcars), scale = "column", main = "mtcars Heatmap")
dev.off()
cat("Saved base_heatmap.png\n")

png("base_corplot.png", width = 600, height = 500)
cor_mat <- cor(mtcars)
# Simple corr visualization without corrplot package
heatmap(cor_mat, Rowv = NA, Colv = NA, col = heat.colors(256),
        scale = "none", main = "Correlation Matrix Heatmap")
dev.off()
cat("Saved base_corplot.png\n")

# Cleanup check
cat("\n--- Generated files ---\n")
print(list.files(pattern = "\\.png$"))

cat("\n--- Done: Visualization ---\n")
