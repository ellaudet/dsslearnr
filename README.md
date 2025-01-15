# dsslearnr: Practice Exercises for Llaudet and Imai's Data Analysis for Social Science (DSS)

This repository contains [`learnr`](https://rstudio.github.io/learnr/index.html) tutorials with practice exercises for [*Data Analysis for Social Science: A Friendly and Practical Introduction*](https://press.princeton.edu/books/paperback/9780691199436/data-analysis-for-social-science) by Elena Llaudet and Kosuke Imai, published by Princeton University Press.

## Installation

To access the tutorials, open RStudio and install the necessary packages by running the following code:

    install.packages("remotes")
    remotes::install_github("rstudio/learnr")
    remotes::install_github("rstudio-education/gradethis")
    remotes::install_github("ellaudet/dsslearnr")

## Starting the Tutorials

You can launch each tutorial by running its corresponding R code in RStudio. Below are the commands to start each tutorial:

- **Chapter 1: Introduction**
    
      learnr::run_tutorial("01-introduction", package = "dsslearnr")
    
- **Chapter 2: Estimating Causal Effects with Randomized Experiments**
    
      learnr::run_tutorial("02-experimental", package = "dsslearnr")

    
Tutorials for subsequent chapters are currently in development.

- View the full list of available tutorials:
    
      learnr::run_tutorial(package = "dsslearnr")


## Feedback and Contact

Any errors in these tutorials are my responsibility. If you encounter any issues or have suggestions for improvements, please contact me at [ellaudet@gmail.com](mailto:ellaudet@gmail.com). Your feedback is highly appreciated!

---

*I hope these tutorials are helpful to you and your students!* - Elena
