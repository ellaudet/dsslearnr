library(shiny)

## Define UI
ui = fluidPage(

    ## App Title
    headerPanel(""), 
    helpText(HTML("<b>"), "Interactive Graph: The Least Squares Method", HTML("</b>"), 
             style = "margin:0; font-size: 22px; color: #ea3a44"),
    helpText("By Elena Llaudet, co-author of", 
             a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", 
               HTML("</em>"), "(Princeton University Press)",
               target = "_blank",href = "https://bit.ly/dss_book", style = "color: #797979"), 
             style = "font-size: 18px; color: #797979; margin:0"),
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    ## Framed Text
    helpText("To find the line of best fit, we often use the least squares method,
        which chooses the line that minimizes the sum of the squared errors.",
             style = "text-align: left; font-size: 16px; color: #333333; border-width:3px; 
                  border-style:solid; border-color:#ea3a44; padding-top: 0.5em; 
                  padding-bottom: 0.5em; padding-right: 1em; padding-left:1em"), 
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    
    helpText(HTML("<ul> <li> <b>"), "STEP 1.", HTML("</b>"), 
          "Take a look at the scatter plot below,
          which shows the relationship between two variables, X and Y.
           In theory, we could draw an infinite number of lines on this scatter plot,
           but some lines will do a better job than others at summarizing the relationship between X and Y.
            Intuitively, we know that the line of best fit should be as close to the data
          (that is, the dots in the scatter plot) as possible.
          Mathematically, this means that the line of best fit should have
          the smallest errors possible, where the errors are defined as the vertical distances between the dots and the line.",
          HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b> STEP 2. </b>
         For illustration purposes, let's consider the fit of three different lines. 
         Let's begin by considering the line defined as Line #1.  
         Go ahead and check the first box below, which asks R to show you the
         line on the scatter plot. (By default, R will show you Line #1.)
            Does this line do a good job in summarizing the relationship between X and Y? 
           Not really. Among other things, Line #1 has a negative slope,
           while X and Y clearly have a positive linear relationship.
           (Higher values of X are often associated with higher values of Y
           and lower values of X are often associated with lower values of Y.)"), 
          HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), 
          "One way to explore how well a line fits the data is to consider the errors
          associated with the line, that is, the vertical distances between the dots and the line.
          So, go ahead and check the second box below, which will ask R to show you the errors associated with the line.
           As you can now see, the errors (shown as vertical dashed red lines)
           are rather large because Line #1 is pretty far away from the data.
           We can conclude, then, that this line does not summarize the relationship
           between X and Y well because it fits the data poorly.", 
          HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b> STEP 4. </b>
        Let's see what happens when we consider a different line such as the one
        I defined as Line #2. (Go ahead and use the drop-down menu to select Line #2.)
         Does this line fit the data better? 
           Yes, it does.
           Line #2 is closer to the data than Line #1.
           As a result, the errors associated with Line #2 are much smaller.
           (The vertical distances between the dots and the line,
           shown as dashed red lines, are much shorter.)
            Is Line #2 the line of best fit? 
           No, it is not. We can fit a line even closer to the data,
           that is, with even smaller errors, which will do a better job at summarizing
           the relationship X and Y.</li>"),
             style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b> STEP 5.</b>
           Finally, use the drop-down menu to select Line #3 and let's consider its fit to the data.
           The errors associated with Line #3 are the smallest among the three. This is because Line #3 is the one closest to the data.
           (To see this more clearly, 
           observe what happens to the errors when you move from Line #1 to Line #2, and then to Line #3).
           Line #3 is, in fact, the line the least squares method would choose as the line of best fit because 
           it has the smallest possible errors. 
           Mathematically, the least squares method finds the line that minimizes the sum of the squared errors.
           Why do we want to minimize the sum of the <em>squared</em> errors rather
           than minimize the sum of the errors?
           Because we want to avoid having positive errors cancel out negative errors.
           The method is, then, called <em>least squares</em> because it <em>minimizes</em>
           the sum of the <em>squared</em> errors, hence, it finds <em>the least squares</em>.</li></ul>
           "), style = "font-size: 16px; color: #333333"),
    
    headerPanel(""), ## to add blank space before graph

    # Sidebar layout with input and output definitions
    sidebarLayout(

      # Sidebar panel for inputs ----
      sidebarPanel(

        # Input
        selectInput(
          inputId = "formula",
          label = "Choose the Line:",
          choices = c("Line #1", "Line #2", "Line #3")
        ),
        
        # Input
        checkboxInput("line", HTML("<b>Show the Line</b>"), FALSE),

        # Include clarifying text ----
        #helpText("By default, R will show the line defined as Line #1 below."),
        #headerPanel(""), ## to add blank space before graph

        # Input
        checkboxInput("errors", HTML("<b>Show the Errors</b>"), FALSE),

        # Include clarifying text ----
        #helpText("The errors are the vertical distances between the dots and the line."),
        #headerPanel(""), ## to add blank space before graph

        
      ),

      # Main panel for displaying outputs ----
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
            on the x-axis, and the second coordinate indicates the position of the point
            on the y-axis.",
             style = "font-size: 16px; color: #333333"),
    
  )
  
  ## Define Server Logic Required to Draw the Graph
  server = function(input, output) {
    output$distPlot <- renderPlot({
      set.seed(1234)
      x <- rnorm(20, mean = 2, sd = 2)
      error <- rnorm(20, mean = 0, sd = 4)
      y <- -1 + 2 * x + error

      intercept <- reactive({
        switch(input$formula,
          "Line #1" = 2,
          "Line #2" = 2,
          "Line #3" = -1
        )
      })

      slope <- reactive({
        switch(input$formula,
          "Line #1" = -1,
          "Line #2" = 0.5,
          "Line #3" = 2
        )
      })

      title <- reactive({
        switch(input$formula,
          "Line #1" =  1,
          "Line #2" =  2,
          "Line #3" =  3
        )
      })

      y2 <- intercept() + slope() * x + error

      fit <- lm(y2 ~ x)

      par(
        mfrow = c(1, 1),
        oma = c(1, 1, 1, 1) + 0.1, # bottom, left, top, right # outer margins
        mar = c(3, 3, 3, 1) + 0.1, # margin, default: c(5,4,4,2) + 0.1
        mgp = c(1, .5, 0), # margin line for axis title, default: c(3,1,0)
        cex = 1, adj = 1, # 1: right-justified
        yaxs = "r", xaxs = "r", las = 1
      ) # axis choice: "i" internal, "r" regular

      plot(x, y,
        main = "", col = "#bababa", ylim = c(-11, 15), xlim = c(-4, 8),
        ylab = "", xlab = "", cex = 1, xaxt = "n",
        yaxt = "n", yaxs = "r", xaxs = "r", axes = FALSE, col.lab = "gray17", bty = "n", pch = 19
      )

      if (input$line == FALSE) {
        mtext("Scatter Plot",
          side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
        )
      }

      if (input$line == TRUE) {
        abline(fit, col = "#ef3119", lwd = 1.5)

        mtext(paste("Scatter Plot with Line #", title()),
          side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
        )
      }

      if (input$errors == TRUE) {
        for (i in 1:length(fitted(fit))) {
          lines(x = c(x[i], x[i]), y = c(fitted(fit)[i], y[i]), col = "#f25c49", lty = "dashed", lwd = 1)
        }

        mtext("(with errors)",
          side = 3, line = 0.5, outer = FALSE, adj = 0.5, cex = 1.2, font = 2
        )
      }

      mtext("Y", side = 2, line = 0.5, outer = FALSE, cex = 1, col.lab = "gray17", at = 15, adj = 1, col = "gray17")
      mtext("X", side = 1, line = 0.5, outer = FALSE, cex = 1, col.lab = "gray17", adj = 1, col = "gray17")

      box(col = "gray17")
    })
  }

## Create Shiny App
shinyApp(ui = ui, server = server)
  
