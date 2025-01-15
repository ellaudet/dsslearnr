library(shiny)

## Define UI
ui = fluidPage(
    
    ## App Title
    headerPanel(""), 
    helpText(HTML("<b>"), "Interactive Graph: Understanding the Intercept and Slope of a Line", HTML("</b>"), 
             style = "margin:0; font-size: 22px; color: #ea3a44"),
    helpText("By Elena Llaudet, co-author of", 
             a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", 
               HTML("</em>"), "(Princeton University Press)",
               target = "_blank",href = "https://bit.ly/dss_book", style = "color: #797979"), 
             style = "font-size: 18px; color: #797979; margin:0"),
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    ## Framed Text
    helpText("We can define a line as Y = ", HTML("&alpha;"), "+", HTML("&beta;"), "X, where:",
      HTML("<ul><li> &alpha;", "(the Greek letter alpha) is the", 
           HTML("<b>"), "intercept",  HTML("</b>"), "coefficient, which determines the vertical location of 
           the line and is defined as the value of Y when X equals 0. </li>"),
      HTML("<li> &beta;", "(the Greek letter beta) is the",
           HTML("<b>"), "slope", HTML("</b>"), "coefficient, which determines the angle or steepness of the line
           and is defined as the change in Y divided by the change in X between two points on the line,
           commonly known as rise over run.</li></ul>"),
      style = "text-align: left; font-size: 16px; color: #333333; border-width:3px; 
                  border-style:solid; border-color:#ea3a44; padding-top: 0.5em; 
                  padding-bottom: 0.5em; padding-right: 1em; padding-left:1em"), 
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    
    helpText(HTML("<ul> <li> <b>"), "STEP 1.", HTML("</b>"), 
             "Look at the graph below. It shows a line with intercept = 1 and slope = 2.
              The line can, thus, be written as Y = 1 + 2X.
              Before moving on, let's make sure that we can make sense of 
              the values of both coefficients by looking at the line on the graph.", 
              HTML("<ul><li>To make sense of the intercept, we need to look at the point on the line
              that corresponds to X=0:
              <ul><li> To find the point on the line
              that corresponds to X=0 on the graph, find 0 on the x-axis, move up to the line,
              and then find the height of the corresponding point on the y-axis.
              (Note that the y-axis is not always drawn at X=0, and therefore,
              the intercept is not necessarily the value of Y at the point where the line crosses
              the y-axis.) </li><li>
              In this case, we find that the point on the line that corresponds to X=0 is (0,1). </li><li>
              To confirm the location of this point, check the first box below and R will show this point on the line (in red).</li><li>
              Since the value of Y of the point on the line that corresponds to X=0 is 1, 
              the intercept of this line should indeed be 1. </li></ul></li>
              <li>To make sense of the slope, we need to pick two points on the line and compute
              the change in Y (that is, the rise or vertical distance) divided by the change in X 
              (that is, the run or horizontal distance) between the two points:
              <ul><li> Let's pick the point that corresponds to X=0 (which we have already found)
              and the point that corresponds to X=2.</li><li>
              To find the point on the line that corresponds to X=2,
              find 2 on the x-axis, move up to the line,
              and then find the height of the corresponding point on the y-axis.</li><li>
              In this case, this point is (2,5). </li><li>
              To confirm the location of this point,
              check the second box below and R will show this point on the line (in black).</li><li>
              The two points we are picking, then, are (0,1) and (2,5).</li><li>
              Mathematically, the rise or change in Y equals the final value of Y minus the initial value of Y
              and the run or change in X equals the final value of X minus the initial value of X.</li><li>
              If we consider (0,1) the initial point and (2,5) the final point, then:
              <ul><li> rise = 5-1 = 4 </li><li>
              run = 2-0 = 2 </li><li> 
              slope = rise/run = 4/2 = 2 </li></ul></li><li>
              The slope of this line should indeed be 2; every one-unit increase in X 
              is associated with an increase in Y of 2 units, on average. </li><li>
              Note that we would have arrived at the same conclusion had we picked any other two points on the line.</li></ul></li></ul>"), 
             style = "font-size: 16px; color: #333333"),
    
      helpText(HTML("<li> <b>"), "STEP 2.", HTML("</b>"),
             "Now, to better understand the two coefficients that define a line,
           let's change their values one at a time. 
           Go ahead and move the first slide below to change the value of the intercept.
           (Once you let go of the slide,
           R will re-draw the line using the chosen parameters.)
           Change the value of the intercept around and
           notice that the intercept does not affect the angle or steepness of the line;
           it only determines the line's vertical location.
           When we change the intercept from 1 to -1, for example, the whole line shifts down 2 units.
           The point on the line that corresponds to X=0 (shown in red) goes from being (0,1) to being (0,-1) and
           the point on the line that corresponds to X=2 (shown in black) goes from being (2,5) to being (2,3).",
             HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), 
             "Now, change the value of the slope around by moving the second slide below, and
           notice that the slope does not affect the vertical location of the line;
           it only determines the line's steepness or angle.
           For example, if we keep the intercept at the original value of 1, but change the slope from 2 to 1,
           the steepness of the line will decrease.
           While the location of the point that corresponds to X=0 (shown in red) remains the same
           because we have not changed the intercept, the location of the point that corresponds to X=2
           (shown in black)
           will go from being (2,5) to being (2,3). The new slope is smaller because even though the run has not
           changed (it continues to be 2-0 = 2), the rise is now smaller (3-1 = 2). As a result, the new rise over run is 2/2 = 1,
           and thus, the new slope is 1.
           Every one-unit increase in X is now associated with an increase in Y of 1 unit.", 
             HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b>"), "STEP 4.", HTML("</b>"), 
            "Finally, let's see what happens when we continue to decrease the value of the slope into negative numbers.
            First, notice that when moving the slope from being positive to being negative, the direction of the line will change.
            The line will go from having a positive incline (moving upward from left to right),
            to having a negative incline (moving downward from left to right).
            The point corresponding to X=2 (shown in black) will go from being higher than the point corresponding to X=0 (shown in red),
            to being lower, indicating that increases in X are now associated with decreases in Y.
            If, for example, we set the slope to equal -2, while keeping the intercept at 1, the point corresponding to X=0 (shown in red)
            will continue to be (0,1), but the point corresponding to X=2 (shown in black) will now be (2,-3).
            Consequently, the rise between the two points will be -3-1 = -4 (since we continue to consider the red point the initial point and the black point the final point),
            the run will be 2-0 = 2, and the new slope will be -2/2 = -2.
            Every one-unit increase in X is now associated with a *decrease* in Y of 2 units.", 
            HTML("</li></ul>"), style = "font-size: 16px; color: #333333"),
    
    headerPanel(""), ## to add blank space before graph

    ## Sidebar Layout with Inputs and Outputs
    sidebarLayout(
      
      ## Sidebar Panel for Inputs
      sidebarPanel(
        
        # Input
        checkboxInput("red_dot", HTML("<b>Show Point on the Line Where X=0 (in Red)</b>"), FALSE),
        helpText(""),

        # Input
        checkboxInput("black_dot", HTML("<b>Show Point on the Line Where X=2 (in Black)</b>"), FALSE),
        helpText(""),
        headerPanel(""), ## to add blank space before graph

        # Input
        sliderInput(
          inputId = "intercept",
          label = "Intercept",
          min = -2,
          max = 2,
          value = 1
        ),

        # Input
        sliderInput(
          inputId = "slope",
          label = "Slope",
          min = -2,
          max = 2,
          value = 2
        )

      ),

      ## Main Panel for Displaying Outputs
      mainPanel(
        
        # Output
        plotOutput(outputId = "distPlot")
      )
    ),
    
    ## Text After Graph
    headerPanel(""), ## to add blank space before graph
    helpText("Notes about the graph: 
            In a scatter plot, each point consists of two coordinates in
            the two-dimensional space. The first coordinate indicates
            the position of the point
            on the x-axis,
            and the second coordinate indicates the position of the point
            on the y-axis. For example, the point (0,1) should
            be lined up with the number 0 on the x-axis and the
            number 1 on the y-axis.",
             style = "font-size: 16px; color: #333333"),
    
  )
  
  ## Define Server Logic Required to Draw the Graph
  server = function(input, output) {
    output$distPlot <- renderPlot({
      par(
        mfrow = c(1, 1),
        # oma = c(2,2,2,2) + 0.1, # outer margin: bottom, left, top, right
        # mar = c(3,3,1,1) + 0.1, # inner margin, default: c(5,4,4,2) + 0.1
        # mgp = c(2,0.5,0), # margin line for axis title, default: c(3,1,0)
        cex = 1, adj = 1, # 1: right-justified
        yaxs = "r", xaxs = "r", las = 1
      )

      intercept <- input$intercept
      slope <- input$slope

      # set.seed(1234)
      # x <- rnorm(1000, mean=50, sd=0)
      # error <- rnorm(1000, mean=0, sd=0)
      # y <- intercept + slope*x + error

      x <- 0
      y <- 1

      plot(x, y,
        main = "", col = "white",
        ylab = "", xlab = "", cex = .6, xaxt = "n",
        yaxt = "n", yaxs = "r", xaxs = "r", xlim = c(-2, 4), ylim = c(-6, 6), axes = FALSE, col.lab = "gray17", bty = "n", pch = 19)

      axis(1, c(-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7), col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.02)
      axis(2, c(-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7), col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.02)

      mtext("Y", side = 2, line = 2.5, outer = FALSE, cex = 1.2, col.lab = "gray17", at = 6, col = "gray17")
      mtext("X", side = 1, line = 2.5, outer = FALSE, cex = 1.2, col.lab = "gray17", adj = 1, col = "gray17")

      mtext(paste("Y = ", intercept, " + ", slope, "X", sep = ""),
        side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2)

      abline(a = intercept, b = slope, col = "darkgray", lwd = 2, lty = "solid")
      box(col = "gray17")

      if (input$red_dot == TRUE) {
        lines(x = c(0, 0), y = c(intercept, -7), lty = "dashed", lwd = 2, col = "#bababa")
        lines(x = c(-7, 0), y = c(intercept, intercept), lty = "dashed", lwd = 2, col = "#bababa")
        points(c(0, 0), c(intercept, intercept), col = "#ef3119", lwd = 1, pch = 19)
      }

      if (input$black_dot == TRUE) {
        lines(x = c(2, 2), y = c(intercept + slope * 2, -7), lty = "dashed", lwd = 2, col = "#bababa")
        lines(x = c(-7, 2), y = c(intercept + slope * 2, intercept + slope * 2), lty = "dashed", lwd = 2, col = "#bababa")
        points(c(2, 2), c(intercept + slope * 2, intercept + slope * 2), col = "black", lwd = 1, pch = 19)
      }
      
    })
  }

## Create Shiny App
shinyApp(ui = ui, server = server)

