# R - Comprehensive Learning Repository

R is an interpreted programming language widely used for statistical computing, data analysis and visualization. This repository provides structured examples for learning R from basics to advanced machine learning.

## 📁 Repository Structure

```
R/
├── basic/                  # 52 basic examples (syntax, data structures, plotting)
│   ├── Hello.r
│   ├── vectors1.R
│   ├── matrix.R
│   ├── dataFrame.R
│   ├── plotting.R, bar_chart.R, pie_chart.R, histograms.R, lines.R
│   └── ... (52 files)
├── intermediate/           # 9 intermediate topics ✨ NEW
│   ├── 01_apply_family.R           # apply, lapply, sapply, vapply, mapply, tapply
│   ├── 02_functional_programming.R # closures, recursion, Reduce/Filter/Map, environments
│   ├── 03_error_handling.R         # try, tryCatch, stop/warning, debugging
│   ├── 04_file_io.R                # CSV, RDS, readLines, file connections, JSON
│   ├── 05_dates_times.R            # Date, POSIXct/lt, difftime, lubridate
│   ├── 06_regex_strings.R          # grep, gsub, strsplit, stringr
│   ├── 07_missing_values.R         # NA/NaN, na.omit, duplicated, scale, cut
│   ├── 08_oop.R                    # S3, S4, Reference Classes, R6
│   └── 09_tidyverse.R              # dplyr, tidyr, tibble, pipes
├── visualization/          # 2 visualization modules ✨ NEW
│   ├── 01_ggplot2.R                # ggplot2: scatter, bar, hist, boxplot, facet, theme
│   └── 02_advanced_plots.R         # base R: layouts, palettes, histograms, 3D
├── statistics/             # 3 statistics modules ✨ NEW
│   ├── 01_descriptive.R            # mean/median/mode, var/sd, correlation, distributions
│   ├── 02_hypothesis_tests.R       # t-test, chisq, ANOVA, Wilcoxon, Shapiro
│   └── 03_regression_anova.R       # lm, glm, diagnostics, stepwise, interaction
├── machine_learning/       # 5 ML modules ✨ NEW
│   ├── 01_linear_regression.R      # simple/multiple, CV, polynomial, regularization
│   ├── 02_logistic_regression.R    # binary, metrics, ROC, multinomial
│   ├── 03_clustering.R             # k-means, hierarchical, elbow, DBSCAN
│   ├── 04_decision_tree.R          # rpart, pruning, kNN, random forest
│   └── 05_pca.R                    # prcomp, scree, biplot, reconstruction
├── algorithms/             # 3 algorithm modules ✨ NEW
│   ├── 01_sorting.R                # bubble, selection, insertion, merge, quick, counting
│   ├── 02_searching.R              # linear, binary, interpolation, hash/env
│   └── 03_recursion_dynamic.R      # factorial, fibonacci, GCD, DP (coin, LCS, knapsack)
└── tests/                  # Test suite ✨ NEW
    ├── run_all_tests.R             # Base-R test runner (no deps) - 54 tests
    ├── testthat.R                  # testthat entry point
    └── testthat/
        ├── test-basic.R            # basic/*.R tests
        ├── test-intermediate.R
        ├── test-statistics.R
        ├── test-ml.R
        └── test-algorithms.R
```

## 🚀 Features Covered

### Basics (`basic/`)
- Syntax, assignment (`<-`, `<<-`, `->`, `assign`), data types, `class`/`typeof`
- Vectors, lists, matrices, arrays, data frames, tibbles, factors
- Strings, type conversion, conditional statements, loops, functions
- Math operations, I/O (`readline`, CSV), statistics (`mtcars`), plotting (base R)

### Intermediate (`intermediate/`)
- **Apply family**: `apply`, `lapply`, `sapply`, `vapply`, `mapply`, `tapply`, `rapply`
- **Functional programming**: closures, recursion (factorial, Fibonacci, GCD), `Reduce`/`Filter`/`Map`
- **Error handling**: `stop`/`warning`/`message`, `try`/`tryCatch`, `withCallingHandlers`, `browser`
- **File I/O**: `read.csv`/`write.csv`, `saveRDS`/`readRDS`, `scan`, `readLines`, `file()`
- **Dates/Times**: `Date`, `POSIXct`/`POSIXlt`, `format`, `difftime`, time zones
- **Regex**: `grep`/`grepl`, `sub`/`gsub`, `strsplit`, `stringr` analogs
- **Missing values**: `NA`/`NaN`/`Inf`, `complete.cases`, `duplicated`, `scale`, `cut`
- **OOP**: S3 (`UseMethod`), S4 (`setClass`/`setMethod`), Reference Classes, R6

### Visualization (`visualization/`)
- **ggplot2**: `geom_point`/`line`/`bar`/`hist`/`boxplot`/`density`, `facet_wrap`, `theme`, `scale_*`, `ggsave`
- **Base R advanced**: `par(mfrow)`, palettes, `lty`/`pch`, annotations, `persp`, PDF export

### Statistics (`statistics/`)
- Descriptive: `mean`/`median`/`mode`, `var`/`sd`/`IQR`/`quantile`, `cor`/`cov`, `table`/`prop.table`
- Distributions: `dnorm`/`pnorm`/`qnorm`/`rnorm`, `dbinom`, `dpois`, `sample`
- Tests: `t.test`, `chisq.test`, `aov` + `TukeyHSD`, `cor.test`, `prop.test`, `wilcox.test`, `shapiro.test`

### Machine Learning (`machine_learning/`)
- Linear regression (`lm`, stepwise, CV, polynomial)
- Logistic regression (`glm(binomial)`, confusion matrix, ROC/AUC)
- Clustering (`kmeans` + elbow, `hclust` + dendrogram)
- Decision trees (`rpart`, pruning), kNN (`class::knn`), random forest, PCA (`prcomp`)

### Algorithms (`algorithms/`)
- Sorting: bubble, selection, insertion, merge, quick, counting + `sort`/`order`/`rank`
- Searching: linear, binary (iterative/recursive), interpolation, `which`/`match`/`%in%`
- Recursion & DP: Fibonacci (memoized), Hanoi, coin change, LCS, knapsack, BST

## 🧪 Testing

### Run all tests (no extra packages required)
```r
Rscript tests/run_all_tests.R
```
Outputs 54 tests covering:
- Operators, data types, data structures, strings, control flow
- File I/O, statistics, plotting
- Apply family, functional programming, error handling, dates, regex, OOP
- All statistics, ML, and algorithm examples

### With `testthat` (optional)
```r
install.packages("testthat")
Rscript tests/testthat.R
# or
Rscript -e "testthat::test_dir('tests/testthat')"
```

Expected output:
```
========================================
 TEST SUMMARY
========================================
Total : 54
Passed: 54
Failed: 0
All tests PASSED
```

### Run individual example categories
```r
Rscript intermediate/01_apply_family.R
Rscript visualization/01_ggplot2.R
Rscript machine_learning/03_clustering.R
Rscript algorithms/01_sorting.R
```

## 📦 Installation

Requires **R >= 4.0**. Base R packages cover 90% of examples. Optional packages for enhanced features:
```r
install.packages(c("dplyr", "tidyr", "ggplot2", "tibble", "stringr",
                   "rpart.plot", "randomForest", "data.table", "jsonlite",
                   "lubridate", "testthat"))
```

## 🔧 Fixes Included

- Fixed syntax error in `basic/Stringsm.R` (invalid quoting)
- Fixed `basic/lengths.R`, `basic/Tibbles.R`, `basic/dataframew.R` to use conditional `requireNamespace` (graceful fallback without dplyr/stringr/tibble)
- Fixed `basic/csv.R` empty file now documented via `intermediate/04_file_io.R`
- Improved robustness: all new files handle missing optional packages with fallbacks

## 🌿 Branches

- `main` - stable, production branch
- `develop` - integration branch for new features (merged to `main`)

## 📄 License

Open-source examples for learning R.
