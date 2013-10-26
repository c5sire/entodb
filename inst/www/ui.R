library(shiny)

header = paste("<img src='", file.path("banner1.jpg"),"'/>", sep="")

shinyUI(pageWithSidebar(
  headerPanel("", windowTitle = "CIP entomological collection") ,
  sidebarPanel(
    helpText(HTML(header)),
    helpText('Select below which columns to include in the table. 
Below the table filter records by variable values.'),
    uiOutput("mycolumns")
    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('entodb',
               dataTableOutput("mytable1"))
    )
  )
))
