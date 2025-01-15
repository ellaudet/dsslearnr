library(shiny)

## Define UI
ui = fluidPage(

    ## App Title
    headerPanel(""), 
    helpText(HTML("<b>"), "Interactive Graph: Random Sampling", HTML("</b>"), 
             style = "margin:0; font-size: 22px; color: #ea3a44"),
    helpText("By Elena Llaudet, co-author of", 
             a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", 
             HTML("</em>"), "(Princeton University Press)",
             target = "_blank",href = "https://bit.ly/dss_book", style = "color: #797979"), 
             style = "font-size: 18px; color: #797979; margin:0"),
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    ## Framed Text
    helpText("Random sampling creates a representative sample of the target population when the sample size is large enough.",
             style = "text-align: left; font-size: 16px; color: #333333; border-width:3px; 
                  border-style:solid; border-color:#ea3a44; padding-top: 0.5em; 
                  padding-bottom: 0.5em; padding-right: 1em; padding-left:1em"), 
    helpText(HTML("<br>"), style = "font-size:2px"),
    
    ## Explanation and Steps
    helpText("For illustration purposes, suppose there were only five types of individuals 
           in the world: orange, blue, pink, green, and purple.
           If we randomly select individuals from the population into a sample,
           the resulting sample will be representative of the population (that is, the sample will accurately 
           reflect the characteristics of the population), as long as the sample size is large enough.",
           style = "font-size: 16px; color: #333333"),
    helpText("Let's examine this further:", style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<ul> <li> <b>"), "STEP 1.", HTML("</b>"), 
             "Look at the graph below and notice that when when we draw a random sample of 20 individuals 
             from a target population of 1,000 individuals, 
           the sample might end up without a single blue individual eventhough the sample was created 
           through random sampling.
            When the sample size is very small, the sample will likely 
             not be representative of the population
           because the sample size is simply too small to create a subset 
           of individuals with a similar composition as the population",
             HTML("</li>"), style = "font-size: 16px; color: #333333"),
    
    helpText(HTML("<li> <b>"), "STEP 2.", HTML("</b>"),
             "Now, move the slide to increase the sample size and observe how the composition of the 
             sample starts to approximate the composition of the population as a result.
             (Once you let go of the slide, R will randomly select the number of people that you have 
             chosen into the sample and reproduce the histograms showing you the results.) 
             Try different sample sizes between 20 and 300.",
             HTML("</li>"), style = "font-size: 16px; color: #333333"),
  
    helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), 
            "Increase the sample size to 300 and notice 
             that the composition of the sample is now quite similar to the composition of the population.
             They should now be both composed of roughly 20% orange individuals, 10% blue individuals, 
           20% pink individuals, 30% green individuals, and 20% purple individuals.", 
           HTML("</li></ul>"), style = "font-size: 16px; color: #333333"),
  
    headerPanel(""), ## to add blank space before graph

    ## Sidebar Layout with Inputs and Outputs
    sidebarLayout(

      ## Sidebar Panel for Inputs
      sidebarPanel(

        # Input
        sliderInput(
          inputId = "sample_size",
          label = "Sample Size (n)",
          min = 20,
          max = 300,
          value = 20
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
            The histograms show the number of individuals from each type that are in 
             (a) the target population, and (b) the random sample of n individuals drawn from the target population.
             Notice that N stands for the total number of individuals in the target population 
             and n stands for the total number of individuals in the sample.",
             style = "font-size: 16px; color: #333333"),
    
  )
  
  ## Define Server Logic Required to Draw the Graph
  server = function(input, output) {
    
    ## Graph
    output$distPlot <- renderPlot({
      
      N <- 1000 # input$population_size
      n <- input$sample_size
      population <- c(rep(0, N * 0.2), rep(2, N * 0.1), rep(3, N * 0.2), rep(4, N * 0.3), rep(5, N * 0.2))
      set.seed(12678)
      selected <- sample(c(0, 1), size = length(population), replace = TRUE, prob = c(1 - n / N, n / N))
      data <- data.frame(population, selected)
      my_colors <- c("darkorange", "royalblue", "deeppink", "seagreen3", "blueviolet")

      par(mfrow = c(1, 2), cex = 1, mar = c(1, 5, 3, 2))
      
      hist(data$population,
        breaks = 6,
        main = "",
        ylim = c(0, N / 3 + 0.10 * N), 
        xlab = "", col = my_colors, axes = F, border = "white")
      
      axis(2, col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
      
      mtext("Population",
            side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.1, font = 2)
      
      mtext(paste("(N = ", N , ")", sep = ""),
            side = 3, line = 0, outer = FALSE, adj = 0.5, cex = 1.1, font = 1)
      
      hist(data$population[data$selected == 1],
        breaks = 6, 
        main = "",
        ylim = c(0, n / 3 + 0.10 * n),
        xlab = "", col = my_colors, axes = F, border = "white")
      
      axis(2, col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
      
      mtext("Sample",
            side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.1, font = 2)
      
      mtext(paste("(n = ", n , ")", sep = ""),
            side = 3, line = 0, outer = FALSE, adj = 0.5, cex = 1.1, font = 1)
      
    })
  }

  ## Create Shiny App
  shinyApp(ui = ui, server = server)
  