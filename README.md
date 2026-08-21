# dsslearnr: Review Exercises for Llaudet and Imai's Data Analysis for Social Science (DSS)

This repository contains [`learnr`](https://rstudio.github.io/learnr/index.html) tutorials with review exercises for [*Data Analysis for Social Science: A Friendly and Practical Introduction*](https://press.princeton.edu/books/paperback/9780691199436/data-analysis-for-social-science) by Elena Llaudet and Kosuke Imai, published by Princeton University Press. They are interactive R tutorials for students to check their understanding of the material on their own after completing the readings and performing the analyses explained in the book — they are meant to supplement, not replace, the book. Each includes multiple-choice questions and hands-on coding exercises, with instant feedback so students can check their understanding on their own. At the end, students can generate a progress report of their work. Eventually, there will be a tutorial for each chapter in the book. Check again soon! 

## Installation

To access the tutorials, open RStudio and install the necessary packages by running the following code:

    install.packages("remotes")
    remotes::install_github("ellaudet/dsslearnr")
    

## Starting the Tutorials

You can launch each tutorial by running the code below in RStudio.

- **Chapter 1: Introduction**
    
      learnr::run_tutorial("01-introduction", package = "dsslearnr")
    
- **Chapter 2: Estimating Causal Effects with Randomized Experiments**
    
      learnr::run_tutorial("02-experimental", package = "dsslearnr")

- **Chapter 3: Inferring Population Characteristics via Survey Research**

      learnr::run_tutorial("03-population", package = "dsslearnr")
    
To view the full list of available tutorials, run:
    
      learnr::run_tutorial(package = "dsslearnr")


## Feedback

If you encounter any issues or have suggestions for improvements, please contact me at [ellaudet@gmail.com](mailto:ellaudet@gmail.com). Your feedback is highly appreciated! *I hope these tutorials are helpful to you and your students!* - Elena
