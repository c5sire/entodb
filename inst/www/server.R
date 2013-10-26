library(shiny)
#library(shinyIncubator)
#library(ggplot2)

path = file.path(getwd(),"entodb.csv")
data = read.csv(path, stringsAsFactors = FALSE, na.strings = "")

excl = names(data) %in% c("GenusOriginal","Order.1", "Rejections", "LATD", "LOND")
data = data[,!excl]

shinyServer(function(input, output, session) {
  
  output$mycolumns <- renderUI({
    withProgress(session, min=1, max=15, {
      setProgress(message = 'Calculation in progress',
                  detail = 'This may take a while...')
      
      checkboxGroupInput('show_vars', 'Columns to show:', names(data),
                         selected = names(data)[c(1,2,5,9,11, 20)])
    })
    
    
  })
  
  # a large table, reative to input$show_vars
  output$mytable1 = renderDataTable({
    withProgress(session, min=1, max=15, {
      setProgress(message = 'Calculation in progress',
                  detail = 'This may take a while...')
      
      data[, input$show_vars, drop = FALSE]
    })
    
  }, options = list(iDisplayLength=10))
  
 
  
})