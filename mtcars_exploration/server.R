library(shiny)
library(DT)

function(input, output) {
    fit = reactive({
        if(input$nbcyl == "All"){
            mt <- mtcars
        }
        else{
            mt <- mtcars[mtcars$cyl == as.numeric(input$nbcyl),]
        }
        brushed_data <- brushedPoints(mt, input$brush1,xvar = input$x, yvar = input$y)
        if( nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(brushed_data[,input$y] ~ brushed_data[,input$x])
        
    })
    
    output$table = DT::renderDataTable(
        datatable(if(!is.null(fit())){
            data.frame("Intercept" = as.numeric(fit()[[1]][1]),
                       "Slope" = as.numeric(fit()[[1]][2]))
        },
        rownames = FALSE))
    output$scatterPlot <- renderPlot({
        if(input$nbcyl == "All"){
            mt <- mtcars
        }
        else{
            mt <- mtcars[mtcars$cyl == as.numeric(input$nbcyl),]
        }
        # create a dataFrame containing mpg, disp, hp, drat, wt , and qsec
        plot(mt[,input$x],mt[,input$y],xlab = input$x, ylab = input$y)
        if(!is.null(fit())){
            abline(fit(), col = "red", lwd = 3)            
        }
        })
}
