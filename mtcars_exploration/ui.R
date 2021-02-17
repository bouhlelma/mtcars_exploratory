library(shiny)
library(DT)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Exploration of Motor Trend Car Road Tests Data"),
    p("This app allows the user to rapidly explore a few variables in the Motor Trend Car Road Tests Data. For a quick use of"),
    p("the app, you first segregate the data with respect to the number of cylinders ('All' means the entire data is used)."),
    p("Then, choose the x and y-variables to display. Finally, you brush the set of points where you want to apply a linear model."),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h3("Number of cylinders to be considered in the study"),
            selectInput(inputId = "nbcyl",
                        label = "",
                        choices = c(4,6,8,"All"),
                        selected = "All",
                        width = "220px"
            ),
            div(style = "font-size: 10px; padding: 3px 30px; margin:-3em",
                h6("* All: 4, 6, and 8 cylinder's cars are used")
            ),
            div(style = "padding: 50px 35px; margin:-3em",
            h3("Choose your x and y-axis:"),
            fluidRow(column(6,
                            # Select which Gender(s) to plot
                            radioButtons("x", "x-axis:",c("MPG" = "mpg",
                                                          "Displacement" = "disp",
                                                          "Horsepower" = "hp",
                                                          "Weights" = "wt"),
                                         select = "mpg"
                            )),
                     column(6,
                            radioButtons("y", "y-axis:",
                                         c("MPG" = "mpg",
                                           "Displacement" = "disp",
                                           "Horsepower" = "hp",
                                           "Weights" = "wt"), select = "disp")
                     )))
            ),
            
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("scatterPlot", brush = brushOpts(id = "brush1")),
            DT::dataTableOutput("table")
        )
    )
))
