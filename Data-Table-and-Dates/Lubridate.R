# Basics

library(lubridate)
ymd("20110604") == ymd("110604")
mdy("06-04-2011")
dmy("04/06/2011")

arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")


# Setting and Extracting information
second(arrive)
second(arrive) <- 25
wday(arrive)
wday(arrive, label = TRUE)


# Time Intervals
auckland <- interval(arrive, leave)

jsm <- interval(ymd(20110720, tz = "Pacific/Auckland"), ymd(20110831, tz = "Pacific/Auckland"))
int_overlaps(jsm, auckland)
setdiff(auckland, jsm)
intersect(auckland, jsm)


# Duration and Periods
minutes(2)
dminutes(2)

leap_year(2011)
ymd(20110101) + dyears(1)
ymd(20110101) + years(1)

leap_year(2012)
ymd(20120101) + dyears(1)
ymd(20120101) + years(1)

meetings <- ymd(20120101) + weeks(0:5)
meetings %within% jsm

auckland / ddays(1)
auckland / ddays(2)
auckland / dminutes(1)



# Date Arithmetic
jan31 <- ymd("2013-01-31")
jan31 + months(0:11)
floor_date(jan31, "month") + months(0:11) + days(31)
jan31 %m+% months(0:11)













