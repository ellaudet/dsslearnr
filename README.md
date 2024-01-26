# dsslearnr: Practice Exercises for DSS Readers

This package contains [`learnr`](https://rstudio.github.io/learnr/index.html) tutorials with practice exercises for [*Data Analysis for Social Science: A Friendly and Practical Introduction*]([https://press.princeton.edu/books/paperback/9780691199436/data-analysis-for-social-science]) (DSS for short) by [Elena Llaudet](https://scholar.harvard.edu/ellaudet) and [Kosuke Imai](https://imai.fas.harvard.edu/) from Princeton University Press. 

To install this package, first run the following R code to install the necessary packages:

``` r
remotes::install_github("rstudio/learnr")
remotes::install_github("ellaudet/dsslearnr")
```

To start the tutorial that relates to Chapter 1, rum the following piece of R code:

``` r
learnr::run_tutorial("01-introduction", package = "dsslearnr") # will start the tutorial for chapter 1
```

To start the tutorial that relates to Chapter 1, rum the following piece of R code:

``` r
learnr::run_tutorial("02-experimental", package = "dsslearnr") # will start the tutorial for chapter 2
```

Eventulally, there will be one tutorial per chapter in the book.  (I am still in the process of creating them.) You can see the full list of current tutorials by running:

``` r
learnr::run_tutorial(package = "dsslearnr")
```



