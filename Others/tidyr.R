head(airquality)
library(tidyr)
test <- spread(airquality, Month, Day)
airquality$Month <- as.numeric(airquality$Month)
str(airquality)
