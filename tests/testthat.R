# testthat entry point - compatible with testthat if installed, otherwise fallback
# Usage: Rscript tests/testthat.R  OR  Rscript -e "testthat::test_dir('tests/testthat')"

if (requireNamespace("testthat", quietly = TRUE)) {
  library(testthat)
  cat("Running with testthat", as.character(packageVersion("testthat")), "\n")
  test_dir("tests/testthat", reporter = "summary")
} else {
  cat("testthat not installed - running fallback tests/run_all_tests.R\n")
  source("tests/run_all_tests.R")
}
