library(shiny)

## Define UI
ui = fluidPage(

    ## App Title
    headerPanel(""),
    helpText(HTML("<b>"), "Interactive Graph: Understanding Mean and Standard Deviation", HTML("</b>"),
             style = "margin:0; font-size: 22px; color: #ea3a44"),
    helpText("By Elena Llaudet, co-author of",
             a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", HTML("</em>"),
               "(Princeton University Press)",
               target = "_blank",href = "https://bit.ly/dss_book",
               style = "color: #797979"), style = "font-size: 18px; color: #797979; margin:0"),
    helpText(HTML("<br>"), style = "font-size:2px"),

    ## Framed Text
    helpText(HTML("To summarize the main traits of
             the distribution of a variable, we can use descriptive statistics
             such as mean and standard deviation:<br>
               <ul><li>The <b> mean </b> determines the center of the distribution. </li>
               <li>The <b> standard deviation </b> determines the spread of the distribution,
             that is, the amount of variation relative to the center. More specifically,
             it determines the average distance of the observations to the mean.</li></ul>"),
             style = "text-align: left; font-size: 16px; color: #333333; border-width:3px; border-style:solid; border-color:#ea3a44;
           padding-top: 0.5em; padding-bottom: 0.5em; padding-right: 1em; padding-left:1em"
    ), helpText(HTML("<br>"), style = "font-size:2px"),

    ## Explanation and Steps
    helpText("For illustration purposes, we can examine how the mean and standard deviation
  change the distribution of a normal random variable.", style = "font-size: 16px; color: #333333"),

  helpText(HTML("<ul> <li> <b>"), "STEP 1.", HTML("</b>"),
        "To begin with, look at the graph below.
          It is the density histogram of a normal random variable
          with mean 0 and standard deviation 1.
           Since the mean is 0, the distribution is centered at 0.
           And, since the standard deviation is 1,
           the average distance between the observations and the mean is 1.",
        HTML("</li>"), style = "font-size: 16px; color: #333333"),

  helpText(HTML("<li> <b>"), "STEP 2.", HTML("</b>"),
      "Now, let's see how the distribution changes
           when we change one of the two descriptive statistics at a time.
           Let's start by observing how the distribution of the variable changes as a result of changing its mean
           by using the first slide below.
           (Once you let go of the slide,
           R will re-draw the density histogram using the chosen descriptive statistics.)
           After changing the value of the mean around,
           notice that the mean does not change the shape of the distribution.
           The mean of the variable only determines the center of the distribution.
           When the mean equals 0, for example, the distribution is centered at 0.
           If we increase the mean to 1, then the distribution will shift to the right and become centered at 1.",
           HTML("</li>"), style = "font-size: 16px; color: #333333"),

  helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), "Now, let's observe how the distribution of the variable changes
      as a result of changing its standard deviation by using the second slide below.
           After changing the value of the standard deviation around,
           notice that the standard deviation does not change the center of the distribution.
           The standard deviation only changes the spread of the distribution.
           The larger the standard deviation,
           the larger the average distance of the observations to the mean,
           and the wider and flatter the distribution will be.
           When the standard deviation equals 1, for example, the observations are only one unit away from the mean, on average.
           They are, therefore, relatively close to the mean and the distribution is relatively narrow and high at the center.
           If we increase the standard deviation to 3, the observations will move farther away from the mean, on average.
           As a result, the distribution will become more dispersed and lower at the center.",
           HTML("</li></ul>"), style = "font-size: 16px; color: #333333"),
  headerPanel(""), ## to add blank space before graph

  ## Sidebar Layout with Inputs and Outputs
  sidebarLayout(

      # Sidebar Panel for Inputs
      sidebarPanel(

        # Input
        sliderInput(
          inputId = "mean",
          label = "Mean",
          min = -2,
          max = 2,
          value = 0
        ),

        # Input
        sliderInput(
          inputId = "sd",
          label = "Standard Deviation",
          min = 1,
          max = 3,
          value = 1
        )
      ),

      # Main Panel for Displaying Outputs
      mainPanel(

        # Output: Graph
        plotOutput(outputId = "distPlot")
      )
    ),

  ## Text After Graph
  headerPanel(""), ## to add blank space before graph
  helpText("Notes about the graph:
        The density histogram of a variable is the visual representation
        of the variable's distribution through bins of different heights.
        The position of the bins along the x-axis indicates the interval
        of values and the relative height of the bins
        implies the relative proportion of the observations in the bins.",
           style = "font-size: 16px; color: #333333"),

  )

  ## Define Server Logic Required to Draw the Graph
  server = function(input, output) {

    # Graph
    output$distPlot <- renderPlot({
      par(mfrow = c(1, 1), cex = 1, mar = c(3, 5, 5, 2))
      set.seed(678)
      x.bar <- input$mean
      sigma <- input$sd
      x <- rnorm(n = 1e6, mean = x.bar, sd = sigma)
      hist(x,
        breaks = 100, freq = FALSE, col = "gray", ylim = c(0, 0.4), xlim = c(-10, 10), border = "white", ylab = "",
        main = "",
        xlab = "", axes = F, col.lab = "gray17"
      )
      mtext(paste("Normal Random Variable"),
        side = 3, line = 2.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
      )
      mtext(paste("Mean = ", x.bar, " and Standard Deviation = ", sigma, sep = ""),
        side = 3, line = 1, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
      )

      axis(1, c(-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10), col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
    })
  }

  ## Create Shiny App
  shinyApp(ui = ui, server = server)

