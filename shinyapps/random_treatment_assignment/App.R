library(shiny)

## Define UI
ui = fluidPage(
  
        ## App Title
        headerPanel(""), 
        helpText(HTML("<b>"), "Interactive Graph: Random Treatment Assignment", HTML("</b>"), 
                 style = "margin:0; font-size: 22px; color: #ea3a44"),
        helpText("By Elena Llaudet, co-author of", 
                 a(HTML("<em>"), "Data Analysis for Social Science: A Friendly and Practical Introduction", HTML("</em>"), "(Princeton University Press)",
                   target = "_blank",
                   href = "https://bit.ly/dss_book", 
                   style = "color: #797979"
                 ), style = "font-size: 18px; color: #797979; margin:0"),
        helpText(HTML("<br>"), style = "font-size:2px"),
        
        ## Framed Text
        helpText("Random treatment assignment makes treatment and control groups comparable 
                     when the sample size is large enough.",
                 style = "text-align: left; font-size: 16px; color: #333333; border-width:3px; 
                  border-style:solid; border-color:#ea3a44; padding-top: 0.5em; 
                  padding-bottom: 0.5em; padding-right: 1em; padding-left:1em"), 
        helpText(HTML("<br>"), style = "font-size:2px"),
        
        ## Explanation
        helpText("For illustration purposes, suppose there were only five types of individuals 
                     in the world: orange, 
                     blue, pink, green, and purple. If we were to assign individuals to two 
                     different groups--the treatment group and the control group--at random 
                     (that is, through a random process such as the flip of a coin), the two 
                     groups would contain similar proportions of each type of individual 
                     as long as the sample size is large enough.", 
                 style = "font-size: 16px; color: #333333"),
        helpText("Let's examine this further:", style = "font-size: 16px; color: #333333"),
        
        ## Steps
        helpText(HTML("<ul> <li> <b>"), "STEP 1.", HTML("</b>"), 
                 "Look at the graph below and notice that when the sample size is of 20 individuals 
                     (4 orange, 2 blue, 4 pink, 6 green, and 4 purple), the treatment group might end up 
                     with all the pink individuals and the control group might end up with all the 
                     blue individuals, making the two groups clearly not comparable even though the 
                     groups were created at random. 
                     When the sample size is very small, the two groups will likely be different 
                     because the sample size is simply too small to create two groups with similar 
                     compositions", 
                 HTML("</li>"), style = "font-size: 16px; color: #333333"),
        
        helpText(HTML("<li> <b>"), "STEP 2.", HTML("</b>"), 
                 "Now, move the slide to increase the sample size
                     and observe how the composition of the treatment and control groups start 
                     to approximate each other as a result. (Once you let go of the slide, 
                     R will assign the number of individuals that you have chosen to the 
                     two groups at random, and reproduce the histograms
                     showing you the results.) Try different sample sizes between 20 and 300.",  
                 HTML("</li>"), style = "font-size: 16px; color: #333333"),
        
        helpText(HTML("<li> <b>"), "STEP 3.", HTML("</b>"), 
                 "Increase the sample size to 300 and notice 
                     that the composition of the two groups are now quite similar. 
                     They should now be both composed of roughly 20% 
                     orange individuals, 10% blue individuals, 20% pink individuals, 
                     30% green individuals, and 20% purple individuals 
                     (i.e., the same proportions found in the full sample). This is
                     because by assigning individuals to the two groups at random, 
                     about half of the individuals
                     from each type end up in the treatment group, and the other 
                     half end up in the control group.",  
                 HTML("</li></ul>"), style = "font-size: 16px; color: #333333"),
        
        helpText("This explains why in randomized experiments, in which, by definition, we assign individuals to treatment and control groups at random, the two groups should be comparable, that is, have similar pre-treatment characteristics, on average, if the sample size is large enough.", style = "font-size: 16px; color: #333333"),
        headerPanel(""), ## to add blank space before graph

        ## Sidebar Layout with Inputs and Outputs
        sidebarLayout(
          
          ## Sidebar Panel for Inputs
          sidebarPanel(
            
            ## Input
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
            
            ## Output: Graph
            plotOutput(outputId = "distPlot")
          )
        ),

        ## Text After Graph
        headerPanel(""), ## to add blank space before graph
        helpText("Notes about the graph: 
            The histrograms show the number of individuals from each type that 
            are in (a) the full sample, (b) the treatment group, and (c) the control group.
            Notice that n stands for the total number of individuals in the sample, n_t stands 
            for the total number of individuals in the treatment group, 
            and n_c stands for the total number of individuals in the control group.", 
                 style = "font-size: 16px; color: #333333"),
      )

      ## Define Server Logic Required to Draw the Graph
server = function(input, output) {
  
  ## Graph
  output$distPlot <- renderPlot({
    
    n <- input$sample_size
    volunteers <- c(rep(0, n * 0.2), rep(2, n * 0.1), rep(3, n * 0.2), rep(4, n * 0.3), rep(5, n * 0.2))
    set.seed(678)
    treated <- sample(c(0, 1), size = length(volunteers), replace = TRUE, prob = c(0.5, 0.5))
    data <- data.frame(volunteers, treated)
    my_colors <- c("darkorange", "royalblue", "deeppink", "seagreen3", "blueviolet")
    
    par(mfrow = c(1, 3), cex = 1, mar = c(1, 5, 3, 2))
    
    hist(data$volunteers,
         breaks = 6, main = "",
         xlab = "", col = my_colors, ylim = c(0, n / 3 + 0.10 * n), axes = F, border = "white")
    
    mtext("Full Sample",
          side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1.1, font = 2)
    
    mtext(paste("(n = ", length(data$volunteers), ")", sep = ""),
          side = 3, line = 0, outer = FALSE, adj = 0.5, cex = 1.1, font = 1)
    
    axis(2, col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
    
    hist(data$volunteers[data$treated == 1],
         breaks = 6,
         main = "", xlab = "", col = my_colors, ylim = c(0, n / 3 + 0.10 * n), axes = F, border = "white")
    
    mtext("Treatment Group",
          side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1, font = 2)
    
    mtext(paste("(n_t = ", length(data$volunteers[data$treated == 1]), ")", sep = ""),
          side = 3, line = 0, outer = FALSE, adj = 0.5, cex = 1, font = 1)
    
    axis(2, col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
    
    hist(data$volunteers[data$treated == 0],
         breaks = 6, main = "",
         xlab = "", col = my_colors, ylim = c(0, n / 3 + 0.10 * n), axes = F, border = "white")
    
    mtext("Control Group",
          side = 3, line = 1.5, outer = FALSE, adj = 0.5, cex = 1, font = 2)
    
    mtext(paste("(n_c = ", length(data$volunteers[data$treated == 0]), ")", sep = ""),
          side = 3, line = 0, outer = FALSE, adj = 0.5, cex = 1, font = 1)
    
    axis(2, col = "gray17", col.ticks = "gray", col.axis = "gray17", tck = -0.05)
            })
      }

## Create Shiny App
shinyApp(ui = ui, server = server)
