library(shiny)

## Define UI
ui = fluidPage(

    ## App Title
    headerPanel(""),
    helpText(HTML("<b>"), "Interactive Graph: Understanding the Correlation Coefficient", HTML("</b>"),
             style = "margin:0; font-size: 22px; color: #ea3a44"),
    helpText("By Elena Llaudet, co-author of",
             a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", HTML("</em>"), "(Princeton University Press)",
               target = "_blank",
               href = "https://bit.ly/dss_book",
               style = "color: #797979"
             ), style = "font-size: 18px; color: #797979; margin:0"),
    helpText(HTML("<br>"), style = "font-size:2px"),

    ## Framed Text
    helpText("The correlation coefficient (or correlation) is a statistic that ranges from -1 to 1 and
  captures the direction and strength of the linear association between two variables.",
          HTML("<br><ul><li><b> The sign of the correlation coefficient
  reflects the direction of the linear association </b>
  between the two variables: the correlation coefficient is positive
  whenever the line of best fit
  has a positive slope and
  negative whenever the line of best fit has a negative slope.</li>"),
          HTML("<li><b> The absolute value of the correlation coefficient reflects the strength of the
  linear association </b> between the two variables,
       ranging from 0 (no linear association) to 1 (perfect linear association).</li> </ul>"),
          style = "font-size: 16px; color: #333333; border-width:3px; border-style:solid; border-color:#EF3119;
           padding-top: 0.5em; padding-bottom: 0.2em; padding-right: 1em; padding-left:1em"),
    helpText(HTML("<br>"), style = "font-size:2px"),

    ## Steps
    helpText(HTML("<ul> <li> <b> STEP 1. </b>
             To begin with, look at the graph below.
          It is the scatter plot of two variables that have a correlation coefficient
  equal to 1. Before moving on, let's make sure that we can make sense of the value of the
  correlation coefficient by looking at the scatterplot:
  <ul><li>The correlation is positive because the slope of the line of best fit is positive,
          that is, the line moves upward from left to right.</li>
  <li> The absolute value of the correlation is 1 because the two variables have a perfect linear relationship, that is,
  all the observations are exactly on top of the line of best fit. (To see this more clearly, check the box below to ask R to show in
           the scatter plot the line of best fit as a dashed red line.) </li></ul>"),
             HTML("</li>"), style = "font-size: 16px; color: #333333"),

    helpText(HTML("<li> <b>"), "STEP 2.", HTML("</b>"),
             "Let's examine how the scatter plot changes when we change the two characteristics one at a time. Let's start by using the first drop-down menu below to change the direction of the linear association
  between the two variables to negative. (Once you select a different option using the drop-down menus,
           R will re-draw the scatter plot using the chosen characteristics and compute the new correlation coefficient.)
  Notice that when the linear association goes from being positive to being negative,
      the line of best fit will go from having a positive slope (moving upward from left to right),
      to having a negative slope (moving downward from left to right).
  When choosing a negative linear association, the slope of the line of best fit will be negative and
  so will the sign of the correlation coefficient.",
             HTML("</li>"), style = "font-size: 16px; color: #333333"),

    helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), "Now, use the second drop-down menu below
    to change the strength of the linear association
  between the two variables. Observe that whenever you choose weaker linear associations,
  the observations will move farther away from the line of best fit and the absolute value of the correlation
  coefficient will decrease. Conversely, whenever you choose stronger linear associations,
  the observations will move closer to the line of best fit and the absolute value of the correlation
  coefficient will increase.", HTML("</li></ul>"), style = "font-size: 16px; color: #333333"),
    headerPanel(""), ## to add blank space before graph

    ## Sidebar Layout with Inputs and Outputs
    sidebarLayout(

      ## Sidebar Panel for Inputs
      sidebarPanel(

        # Input
        selectInput(
          inputId = "sign",
          label = "Choose the Sign of the Linear Association:",
          choices = c("positive linear association", "negative linear association")
        ),

        # Input
        selectInput(
          inputId = "strength",
          label = "Choose the Strength of the Linear Association:",
          choices = c(
            "perfect linear association",
            "strong linear association",
            "weak to moderate linear association",
            "no linear association (approximately)"
            )
        ),

        # Input
        checkboxInput("line", "Show Line of Best Fit", FALSE)

      ),

      ## Main Panel for Displaying Outputs
      mainPanel(

        # Output
        plotOutput(outputId = "distPlot")
      )
    ),

    ## Text After
    headerPanel(""), ## to add blank space before graph
    helpText("Notes about the graph:
          A scatter plot is the graphical representation of the relationship between two variables,
               where one variable is plotted along the x-axis, and the other is plotted along the y-axis.
               And, the line of best fit is the line that best summarizes the relationship between two variables.",
             style = "font-size: 16px; color: #333333"),

  )

  ## Define Server Logic Required to Draw the Graph
  server = function(input, output) {

    ## Graph
    output$distPlot <- renderPlot({
      sign <- reactive({
        switch(input$sign,
          "positive linear association" = 1,
          "negative linear association" = -1
        )
      })

      strength <- reactive({
        switch(input$strength,
          "no linear association (approximately)" = rnorm(1000, mean = 50, sd = 20),
          "weak to moderate linear association" = x + rnorm(1000, mean = 50, sd = 16),
          "strong linear association" = x + rnorm(1000, mean = 50, sd = 7),
          "perfect linear association" = x
        )
      })

      par(mfrow = c(1, 1), cex = 1, mar = c(3, 5, 3, 2))
      set.seed(1234)
      x <- rnorm(1000, mean = 50, sd = 10)
      y <- sign() * strength()
      z <- cor(x, y)
      plot(x, y,
        main = "", col = "#c7c7c7", ylab = "", xlab = "", cex = .6, xaxt = "n",
        yaxt = "n", yaxs = "r", xaxs = "r", axes = F, col.lab = "gray17", bty = "n", pch = 19
      )

      if (input$line == TRUE) {
        abline(lm(y ~ x), col = "#ef3119", lty = "dashed", lwd = 1.5)
      }

      mtext(paste("Correlation =", deparse(round(z, 2))),
        side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
      )
      box(col = "gray17")
    })
  }

  ## Create Shiny App
  shinyApp(ui = ui, server = server)
