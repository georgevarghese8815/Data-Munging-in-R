library(dplyr)
library(ggplot2)

flights <- tbl_df(read.csv("C:/Users/George varghese/Desktop/Analytics/Dplyr and tidyr/Hadley Wickham/dplyr-tutorial/flights.csv", stringsAsFactors = FALSE))
flights$date <- as.Date(flights$date)

weather <- tbl_df(read.csv("C:/Users/George varghese/Desktop/Analytics/Dplyr and tidyr/Hadley Wickham/dplyr-tutorial/weather.csv", stringsAsFactors = FALSE))
weather$date <- as.Date(weather$date)

planes <- tbl_df(read.csv("C:/Users/George varghese/Desktop/Analytics/Dplyr and tidyr/Hadley Wickham/dplyr-tutorial/planes.csv", stringsAsFactors = FALSE))

airports <- tbl_df(read.csv("C:/Users/George varghese/Desktop/Analytics/Dplyr and tidyr/Hadley Wickham/dplyr-tutorial/airports.csv", stringsAsFactors = FALSE))

flights
weather
planes
airports
