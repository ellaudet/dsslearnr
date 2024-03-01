# dsslearnr: Practice Exercises for Llaudet and Imai's Data Analysis for Social Science (DSS)

This package contains [`learnr`](https://rstudio.github.io/learnr/index.html) tutorials with practice exercises for [*Data Analysis for Social Science: A Friendly and Practical Introduction*](https://press.princeton.edu/books/paperback/9780691199436/data-analysis-for-social-science) (DSS for short) by [Elena Llaudet](https://scholar.harvard.edu/ellaudet) and [Kosuke Imai](https://imai.fas.harvard.edu/) from Princeton University Press. 

To be able to access the tutorials, open RStudio and run the following R code to install the necessary packages:

``` r
install.packages("remotes")
remotes::install_github("rstudio/learnr")
remotes::install_github("rstudio-education/gradethis")
remotes::install_github("ellaudet/dsslearnr")
```

Then, to start the tutorial that relates to *Chapter 1: Introduction*, run the following piece of R code:

``` r
learnr::run_tutorial("01-introduction", package = "dsslearnr")
```

And, to start the tutorial that relates to *Chapter 2: Estimating Causal Effects with Randomized Experiments*, run the following piece of R code:

``` r
learnr::run_tutorial("02-experimental", package = "dsslearnr")
```

Eventulally, there will be one tutorial per chapter in the book.  (I am still in the process of creating them.) You can see the full list of current tutorials by running:

``` r
learnr::run_tutorial(package = "dsslearnr")
```

Any errors found in these practice exercises are my own. If you find any, I would really appreciate it if you could let me know by sending me an email at [ellaudet@gmail.com](ellaudet@gmail.com). Thank you! 

*I hope these practice exercises are helpful to you and/or your students!* - Elena


