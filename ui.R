#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
# location:https://verence.shinyapps.io/DivisorsAndPrimNumbers/

library(shiny)
library(plotly)

# Define UI for application that draws divisors
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Divisors and Prime Numbers "),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("r_number_range",
                   "Set range of numbers to display:",
                   min = 1,
                   max = 500,
                   value = c(1,100)),
       br(),
       
       strong("Add prime numbers to the plot:"),
       
       checkboxInput("b_prime_number","add prime Numbers vertical (red)", value = FALSE),
       checkboxInput("b_prime_divisor","add prime Numbers horizontal (blue)", value = FALSE)
       
  ),
    
    # Show a plot of the generated distribution
    mainPanel(
      # Output: Tabset w/ plot, summary,
      tabsetPanel(type = "tabs",
        tabPanel("Plot",plotlyOutput('divisorPlot', height = "600px")),
        tabPanel("Documentation"
                 ,p("Here you can finde a short describtion of this small shiny web application the and how to use it.")
                
                ,h3("Purpose of this application")
                ,p("This application calculates the divisor of given bunch of numbers. The numbers are on the x-axis in the plot. All devisors of a number are on the y-axis in the plot.")
                ,p("Divisor example: divisors of 12 are 1,2,3,4,6,12; divisors of 8 are 1,2,4,8 ; divisors of 7 are 1,7 (7 is a prime Number)" )

                ,h3("How to use this application")
                ,p("Use the slider to set the range of numbers shown in the plot with all there divisors:")
                ,img(src="slider.png",width="300", alt="Number slider in sidebar")  
               
                ,p()
                ,p("You also can add all prime numbers of the selected range to the plot by enable the checkboxes." )
                ,p("The first checkbox will add the prime numbers on y-axis:") 
                ,img(src="checkbox_horizontal.png",width="300", alt="show prime numbers in plot")  
                ,p("The second one will add the prime numbers on x-axis:")
                ,img(src="checkbox_vertical.png",width="300", alt="show prime numbers in plot")  
                ,p("By useing the editor menue of the plot you can zoom in/out, do a snapshot of the plot, and so on:")
                ,img(src="edit_plot.png",width="300", alt="show prime numbers in plot")  
                
                )
      )
      #plotlyOutput('divisorPlot') 
      #h3("In the selected range are: "),
      #textOutput('t_amount_prime_number')
      #h3("prime numbers.")
      #plotOutput("distPlot")
    )
  )
))
