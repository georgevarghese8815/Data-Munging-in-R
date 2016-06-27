library(dplyr)
library(datasets)
dim(airquality)
head(airquality)

# Select
a <- select(airquality, Temp, Month, Day)
glimpse(a)


#Filter
f1 <- filter(airquality, Temp > 70)
glimpse(f1)

f2 <- filter(airquality, Temp > 70, Month > 6)
f2 <- filter(airquality, Temp > 70 | Month > 6)


#Mutate
a <- mutate(airquality, test = (Solar.R + 20))
head(a)

# Group and Summarise
summarise(airquality, mean(Temp), test = TRUE)

#Count
count(airquality, Temp, Month)
count(airquality, Month)

#Sample
sample_n(airquality, 100)
sample_frac(airquality, 0.1)


#Arrange
arrange(airquality, desc(Month), Day)


#Pipe Operator
filteredData <- filter(airquality, Month != 6)
groupedData <- group_by(filteredData, Month)
class(groupedData)
attributes(groupedData)
attr(groupedData, "indices")[1]
summarise(groupedData, mean = mean(Temp))


