library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # divisor function
  divisor_vector <- function(x){
    #  Vector of numberes to test against
    y <- seq_len(ceiling( x / 2 ) )
    # include the number itself
    if (x != 1) {
      y <- c(y,x)
    }
    #  Modulo division. If remainder is 0 that number is a divisor of x so return it
    y[ x%%y == 0 ]
  } 
  
  # divisor data frame
  divisor_df <- function(x){
    #  Vector of numberes to test against
    y <- divisor_vector(x)
    ret <- data.frame(rep(x,length(y)),y)
    names(ret) <- c('number','divisor')
    ret
  }
   
  prim <- c(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499) 
  
  output$divisorPlot <- renderPlotly({
    # set parameter
    range_min <- input$r_number_range[1]
    range_max <- input$r_number_range[2]
    show_prime <- input$b_prime_number
    show_divisor <- input$b_prime_divisor
    
    # initialize data frame
    number <- c()
    divisor <- c()
    df <- data.frame(number,divisor) 
    
    # fill up data frame
    for (num in range_min:range_max){
      df <- rbind(df,divisor_df(num))
    }
    
    
    # generate plot
    library(plotly)
    #plot(df,xlim=range(1:500),ylim=range(1:500))
    # print in graph
    #  p <- plot_ly(df, x = df$number , y = df$divisor, type = "scatter")  
    #       %>% add_trace(y = ~divisor, name = 'divisor', mode = 'markers')
    p <- ggplot(data = df, aes(x = number, y = divisor)) + 
      geom_point() 

   
    # add vertical lines
    if (show_prime) {
      p <- p + geom_vline(xintercept = prim[prim<=range_max & prim >= range_min], color="red" ) 
    }

    # add horizontal lines
    if (show_divisor) {
      p <- p + geom_hline(yintercept = prim[prim<=range_max & prim >= range_min], color="blue" ) 
    }
    
        
    ggplotly(p) %>% 
      layout( autosize=TRUE)
    
  })
  
  #d <- 34
  #output$t_amount_prime_number <- renderText(d)
  
}
)