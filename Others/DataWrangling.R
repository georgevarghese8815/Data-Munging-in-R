library(dplyr)
tbl_df(diamonds)
class(tbl_df(diamonds))
View(diamonds)
select(diamonds, 3, 2, 6, everything())
select(diamonds, clarity:VVS1)


# Getting the data
install.packages("devtools")
library(devtools)
devtools::install_github("rstudio/EDAWR")
library(EDAWR)

data("cases")
names(cases)[-1]
unlist(cases[1:3, 2:4])

data("storms")
data("pollution")


install.packages("tidyr")
library(tidyr)      # used to reshape your data
?gather             # wide to long
?spread             # long to wide


# wide to long
head(cases)
gather(cases, "year", "n", 2:4)

# long to wide
pollution
spread(pollution, key = "size", value = "amount")

?unite
?separate
storms
separate(storms, col = date, into = c("year", "month", "date"), sep = "-", FALSE)

temp <- unite(separate(storms, col = date, into = c("year", "month", "date"), sep = "-"), col = "date", 4:6, sep = "-")
temp$date <- as.Date(temp$date)
rm(temp)


library(dplyr)          # A package that helps transform tabular data. Helps access more information than is displayed
?select             # Extract existing variables
?filter             # Extract existing observations
?arrange            
?mutate             # Derive new variables
?summarise          # Change the unit of analysis
?group_by


#select
select(storms, -wind)
select(storms, pressure, everything())


# filter
filter(storms, wind >= 50)
filter(storms, wind >= 50, storm %in% c("Alberto", "Alex", "Arlene"))   # works as an 'and' condition


# mutate
mutate(storms, ratio = pressure/wind, inverse = ratio ^ -1)


# summarise and arrange
pollution %>% summarise(median = median(amount), mean = mean(amount), var = var(amount))
arrange(storms, wind)
arrange(storms, desc(wind), date)


# pipes
storms[storms$wind >= 50, c('storm', "pressure")]     # Below is an alternate method using pipes
storms %>% 
  filter(wind >= 50) %>%
  select(storm, pressure)


# group by ---
pollution
group_by(pollution, city) %>% summarise(mean = mean(amount),
                                        sum = sum(amount))

tb %>% ungroup()
tb %>% group_by(country, year) %>% summarise(cases = sum(cases))

