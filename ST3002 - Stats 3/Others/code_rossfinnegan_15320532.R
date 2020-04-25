##ST3002: Airline Sentiment Visualisations
##Ross Finnegan, 15320532 02/04/2018

#Packages required to run program
install.packages("chron")
install.packages("leaflet")
install.packages("yaml")
install.packages("digest")
install.packages("shinydashboard")


library(shinydashboard)
library(shiny)
library(leaflet)
library(chron)
library(plyr)
library(ggplot2)
#ggplot 2.x have plot titles left aligned - I prefer centred titles
theme_update(plot.title = element_text(hjust = 0.5))

#Set working directory - please change as required
setwd("C:/Users/Ross/Documents/MSISS/Third Year/ST3002 - Stats 3")


##PART A - Importing/Preparing Data
#Read in csv file with US tweet sentiment data - defining the file name allows for future flexibility
file_name <- "US-tweet-dat.csv"
raw_data <- read.csv(file_name, header = T, stringsAsFactors = F)

#Removals:
#1. anon_id is removed as it has no bearing on our visualisations
#2. tweet_location column removed as this data is poorly formatted and inconsistent
#3. user_timezone column is removed as the timezone does not affect the time of the tweet for the dataset compiler
#4. text is removed as these visualisations are intended to be qualitative. The tweet text is more important for the second branch of the company.
#These removals may be adjusted by any future user of this code.
removals <- c(1,8,11,12)
clean_data <- raw_data[,-removals]

#Confidence threshold:Level where sentiment is deemed inconclusive
conf_thres <- 0.4

#We then remove tweets where the sentiment confidence is too low
clean_data <- subset(clean_data, clean_data[,2]> conf_thres)
#A number of the neutral sentiment tweets have negativereason_confidence of 0
#This is recoded to NA in order to keep these tweets in our clean dataset
clean_data[,4][clean_data[,4] == 0] <- NA
clean_data <- subset(clean_data, (clean_data[,4]> conf_thres | is.na(clean_data[,4])))

#negativereason is of interest to the client, therefore we encode NAs, and remove unprofessional language
clean_data[,3][clean_data[,3] == ""] <- NA
clean_data[,3][clean_data[,3] == "Can't Tell"] <- "Undetermined"
clean_data[,3][clean_data[,3] == "longlines"] <- "Excessive Line Wait-Times"


#In order to generate a number of visualisations, the tweet_created timestamp is divided into its date and time components
#We then remove the timestamp column to avoid data repetition
clean_data$tweet_date <- sapply(strsplit(as.character(clean_data$tweet_created), " "), "[", 1)
clean_data$tweet_time <- sapply(strsplit(as.character(clean_data$tweet_created), " "), "[", 2)
clean_data <- clean_data[,-8]

#Only a small sample of the remaining dataset contains coordinate data. However this creates an excellent visualisation to pitch to clients.
#We take this subset by removing empty and invalid coordinates and keep it separate for later visualisation
coordinate_data <- subset(clean_data, clean_data[,7] != "")
coordinate_data <- subset(coordinate_data, coordinate_data[,7] != "[0.0, 0.0]" )
coordinate_data$latitude <- sapply(strsplit(as.character(coordinate_data$tweet_coord), ","), "[", 1)
coordinate_data$latitude <- gsub("\\[|\\]", "", coordinate_data$latitude)
coordinate_data$longitude <- sapply(strsplit(as.character(coordinate_data$tweet_coord), ","), "[", 2)
coordinate_data$longitude <- gsub("\\[|\\]", "", coordinate_data$longitude)
coordinate_data <- coordinate_data[,-7]

##PART B - Visualisations
#Visualisation 1 - Who's Trending?
#Use ggplot function to create a bar chart to show which airlines are being tweeted about most
 trend_plot <- ggplot(clean_data, aes(clean_data$airline)) + geom_bar(fill = "red")+
  coord_flip()+ labs(title = "Who's Trending?", x = "Airline" ,y = "Number of Tweets") 

#Visualisation 2 - Shows the breakdown of airline sentiment for each airline
#Stacked bar chart showing the breakdown of an airlines tweet by sentiment
sent_plot <- ggplot(clean_data, aes(clean_data$airline, fill = clean_data$airline_sentiment)) + geom_bar() +
  labs(title = "Composition of Airline Sentiment", x = "Airline", y = "Number of Tweets", fill = "Sentiment")+ scale_fill_manual(values=c("indianred2","royalblue1","lightgreen","indianred2","royalblue1","lightgreen","indianred2","royalblue1","lightgreen"))
#Visualisation 3 - Breakdown of Reasons for Negative Tweets
#Take a subset of the data that has a negative reason, i.e. is a negative tweet
negative_data <- subset(clean_data, !is.na(clean_data$negativereason ))
#Plot the negative reasons as a stacked bar chart with date on the x axis to watch trends
neg_plot <- ggplot(negative_data, aes(negative_data$tweet_date, fill = negative_data$negativereason)) + geom_bar()+
  labs(title = "Reasons for Negative Tweets", x = "Date", y ="Number of Tweets", fill = "Negative Reason")

#Visualisation 4 - Breakdown of Tweet Sentiment by Time Period
#Short function to append seconds and turn a character string to a time object
to.times <- function(x) times(paste0(x, ":00"))
clean_data$tweet_time <- to.times(clean_data$tweet_time)

#Divide data into three 8 hour slots by extracting the hours from each time object
#eg hours(13:34:00) would be 13. This allows for easy division of the data.
clean_data$time_period[hours(clean_data$tweet_time)>=4 & hours(clean_data$tweet_time)<12 ] <- "Morning"
clean_data$time_period[hours(clean_data$tweet_time)>=12 & hours(clean_data$tweet_time)<20] <- "Evening"
clean_data$time_period[hours(clean_data$tweet_time)>=20 | hours(clean_data$tweet_time)<4] <- "Night"

#Order the factors to appear chronologically when visualised
clean_data$time_period <- ordered(clean_data$time_period, levels = c("Morning", "Evening", "Night"))

#Stacked bar chart of tweet sentiment for each time period.
time_plot <- ggplot(clean_data, aes(clean_data$time_period, fill = clean_data$airline_sentiment)) + geom_bar()+
  labs(title = "Tweet Sentiment by Time Period", x = "Time Period", y ="Number of Tweets", fill = "Tweet Sentiment")+
  scale_fill_manual(values=c("indianred2","royalblue1","lightgreen","indianred2","royalblue1","lightgreen","indianred2","royalblue1","lightgreen"))



#Visualisation 5 - Visualise geographical sentiment
#Use the leaflet function to plot our coordinate data onto the world map
#addLegend: creates a key that makes the map easier to interpret
#addCircleMarkers: maps the markers onto the map using each points longitude and latitude, we define the colour of the ring by sentiment
#                  at present the airline associated with the tweet pops up when a circle is clicked, this may be changed as required
worldmap <- leaflet(data = coordinate_data) %>% addTiles()  %>% addLegend("bottomright", colors = c("red","blue", "green"),
                                                                         labels = c("Negative ", "Neutral ", "Positive "),
                                                                         title = "Tweet Sentiment",
                                                                         opacity = 1)%>% addCircleMarkers(~as.numeric(coordinate_data$longitude), ~as.numeric(coordinate_data$latitude) , 
                                                                         color=~ifelse(coordinate_data$airline_sentiment == "negative" , "red", ifelse(coordinate_data$airline_sentiment == "neutral","blue","green")),
                                                                         popup = ~as.character(coordinate_data$airline))



##Part C - User Dashboard
#ui: Define dashboard interface. Three sections dashboardHeader, dashboardSidebar, dashboardBody
#dashboardHeader: attributes that create the header (title, dropdown menus for messages, notifications etc.)
#dashboardSidebar: contains the links to all visualisations (tabs)
#dashboardBody: contains the contents of each tab

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
                                                    time = "2018-04-11"
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
                         #icons are from the font awesome suite which is linked to shiny
                         menuItem("Trending", tabName = "trending", icon = icon("twitter")),
                         menuItem("Sentiment by Airline", tabName = "sentiment", icon = icon("plane")),
                         menuItem("Negative Reasons", tabName = "negative", icon = icon("thumbs-down")),
                         menuItem("Sentiment by Time", tabName = "time", icon = icon("clock-o")),
                         menuItem("Geographical Sentiment", tabName = "map", icon = icon("map"))
                         
                         
                       )
                     ),
                     dashboardBody(
                       tabItems(
                         # First tab content
                         tabItem(tabName = "trending",
                                 h2("Who's Trending?"),
                                 fillPage(plotOutput("trend_plot", height =450, width = 700))
                         ),
                         #Second tab content
                         tabItem(tabName = "sentiment",
                                 h2("Sentiment by Airline"),
                                 fillPage(plotOutput("sent_plot", height =450, width = 700)) 
                         ),
                         #Third tab content
                         tabItem(tabName = "negative",
                                 h2("Reason for Negative Tweets"),
                                 fillPage(plotOutput("neg_plot", height =450, width = 700))
                         ),
                         #Fourth tab content
                         tabItem(tabName = "time",
                                 h2("Sentiment by Time Period"),
                                 fillPage(plotOutput("time_plot", height =450, width = 700))
                         ),
                         #Fifth tab content
                         tabItem(tabName = "map",
                                 h2("Geographical Sentiment"),
                                 h3("This map is interactive.\nZoom in and take a closer look!"),
                                 fillPage(leafletOutput("worldmap"))
                         )
                         
                       )
                     )
)

#server function contains what needs to be sent to the server and which server
server <- function(input, output) { 
  set.seed(122)
  #These are the plots we need for our tabs. All visualisations are created above in Part B
  output$trend_plot <- renderPlot(trend_plot)
  output$sent_plot <- renderPlot(sent_plot)
  output$neg_plot <- renderPlot(neg_plot)
  output$time_plot <- renderPlot(time_plot)
  output$worldmap <- renderLeaflet(worldmap)
    
}

#Generates dashboard  
shinyApp(ui, server)
