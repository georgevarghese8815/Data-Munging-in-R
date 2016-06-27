library(dplyr)
library(ggplot2)
devtools::install_github("rstudio/EDAWR", force = T)
library(EDAWR)
library(tidyr)

tbl_df(diamonds)
head(diamonds)
View(storms)
View(cases)
View(pollution)

storms.test <- (storms)
storms.test$ratio <- storms.test$wind/storms.test$pressure
mutate(storms.test, ratio = wind/pressure)

#Tidyr---

#Gather, spread, unite, separate
gather(cases, "year", "n", 2,3,4)
spread(pollution, size, amount)
storms2 <- separate(storms, date, c('year', 'month', 'date'), sep = "-")
storms3 <- unite(storms2, "date", year, month, date, sep = "/")
head(storms3)
storms3$date <- as.Date(storms3$date)



#Dplyr ---

install.packages("nycflights13")
#select
select(storms, -storm)
select(storms, wind:date)
select(storms, starts_with("d"))

#filter
filter(storms, wind >= 50)
filter(storms, wind >= 50, storm %in% c("Alberto", "Alex", "Allison"))

#mutate
mutate(storms, ratio = pressure / wind)
mutate(storms, ratio = pressure / wind, inverse = ratio^-1)

#summarise
pollution %>% summarise(median = median(amount), variance = var(amount))
pollution %>% summarise(mean = mean(amount), sum = sum(amount), n = n())

#arrange
arrange(storms, wind)
arrange(storms, desc(wind))
arrange(storms, wind, date)

#The pipe operator
storms %>%
  filter(wind >= 50) %>%
  select(storm, pressure)

storms %>%
  mutate(ratio = pressure / wind) %>%
  select(storm, ratio)

#Group by
pollution %>% group_by(city)

pollution %>% group_by(city) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())

pollution %>% group_by(size) %>% summarise(mean = mean(amount))

tb %>% group_by(country, year)

# bind_cols
a <- matrix(seq(1,6), 3,2)
a <- data.frame(x = 1:3, y = 4:6)
b <- data.frame(x = 7:9, y = 10:12)
bind_cols(a, b)

# bind_rows
bind_rows(a,b)

#union, intersect, setdiff
c <- data.frame(x = 1:5, y = 6:10)
union(a,c)
intersect(a,c)
setdiff(a,c)

#leftjoin
left_join(a, c, by = 'x')

left_join(songs, artists, by = "name")
left_join(songs2, artists2, by = c("first", "last"))

#innerjoin
inner_join(songs, artists, by = "name")

#rightjoin
right_join(songs,artists, by = 'name')

#outerjoin
full_join(songs, artists, by = 'name')

#semijoin
semi_join(songs, artists, by = "name")  #same as left join, but doesnt return anything from the right table.

#antijoin
anti_join(songs, artists, by = "name")  #same as setdiff(), but doesnt return anything from the right table.


