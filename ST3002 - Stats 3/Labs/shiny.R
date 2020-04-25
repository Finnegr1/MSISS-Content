ui <- dashboardPage( skin = "green",
                     dashboardHeader(title = "Airwitter",
                                     dropdownMenu(type = "messages",
                                                  messageItem(
                                                    from = "Marketing Dept",
                                                    message = "Negative tweets -10% since yesterday."
                                                  ),
                                                  messageItem(
                                                    from = "Support",
                                                    message = "Access to help files now available.",
                                                    icon = icon("life-ring"),
                                                    time = "2014-12-01"
                                                  )
                                     ),
                                     dropdownMenu(type = "notifications",
                                                  notificationItem(
                                                    text = "+40% Customer Service Issues!!",
                                                    icon = icon("exclamation-triangle"),
                                                    status = "warning"
                                                  )
                                     ),
                                     dropdownMenu(type = "tasks", badgeStatus = "success",
                                                  taskItem(value = 90, color = "green",
                                                           "Visualisation eLearning"
                                                  ),
                                                  taskItem(value = 17, color = "aqua",
                                                           "Project X"
                                                  ),
                                                  taskItem(value = 75, color = "yellow",
                                                           "Daily maintenance"
                                                  )
                                     )),
                     dashboardSidebar(
                       sidebarMenu(
                         menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                         menuItem("Widgets", tabName = "widgets", icon = icon("th")),
                         menuItem("Trends", tabName = "trends", icon = icon("th"))
                         
                       )
                     ),
                     dashboardBody(
                       tabItems(
                         # First tab content
                         tabItem(tabName = "dashboard",
                                 h2("Dashboard"),
                                 fluidRow(
                                   box(plotOutput("plot1", height = 250)),
                                   
                                   box(
                                     title = "Controls",
                                     sliderInput("slider", "Number of observations:", 1, 100, 50)
                                   )
                                 )
                         ),
                         
                         # Second tab content
                         tabItem(tabName = "widgets",
                                 h2("Widgets tab content")
                         ),
                         tabItem(tabName = "widgets",
                                 h2("Who's Trending?"),
                                 fluidRow(
                                   box(plotOutput("plot2", height =350))
                                 )
                         )
                       )
                     )
)

server <- function(input, output) { 
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  output$plot2 <- p2
}

shinyApp(ui, server)
