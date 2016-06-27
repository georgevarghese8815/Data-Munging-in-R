
# ============================== Dates ========================
dt1 <- as.Date("2012-07-22")
dt2 <- as.Date("2012/08/16")
dt3 <- as.Date("20-Jan-2011", format = "%d-%b-%Y")
dt4 <- as.Date("October 6, 2010", format = "%B %d, %Y")
dt4


#Calculations with dates
dt1 - dt2
dt1 + 3
difftime(dt2, dt1, units = "weeks")

three.dates <- as.Date(c("2010-07-22", "2011-04-20", "2012-10-06"))
three.dates
diff(three.dates)


#Create a sequence of dates
six.weeks <- seq(dt1, length.out = 6, by = "week")
six.weeks <- seq(dt1, length = 6, by = 14)
six.weeks <- seq(dt1, length.out = 6, by = "2 weeks")
six.weeks <- seq(dt1, length.out = 6, by = "month")


#Internal Representation
unclass(six.weeks)



# ============================== DateTime =========================

#POSIXct
tm1 <- as.POSIXct("2015-08-15 10:01:52")
tm2 <- as.POSIXct("20160815 10:01:52", format = "%Y%m%d %H:%M:%S", tz = "GMT")


#Calculations with times
tm2 < tm1
tm1 + 30  #adds seconds
tm1 - 30
tm2 - tm1


#Get current time
Sys.time()
unclass(tm1)


#POSIXlt ------------- This class enables easy extraction of specific componants of a time. 
        #("ct" stand for calender time and "lt" stands for local time. 
        #"lt" also helps one remember that POXIXlt objects are lists.)
tm1.lt <- as.POSIXlt("2013-07-24 23:55:26")
tm1.ct <- as.POSIXct("2013-07-24 23:55:26")
unclass(tm1.lt)
x <- unlist(tm1.lt)

#extract components of a time object:
tm1.lt$sec
tm1.lt$wday

#truncate time
trunc(tm1.lt, "days")
trunc(tm1.lt, "mins")
trunc(tm1.lt, "hours")



# ============================== Chron =============================

#This class is a good option when you don't need to deal with timezones. It requires the package chron.

install.packages("chron")
library(chron)

tm1.c <- as.chron("2013-07-24 23:55:26")
tm1.c
tm2.c <- as.chron("07/25/13 08:32:07", "%m/%d/%y %H:%M:%S")
tm2.c

dates(tm1.c) #extract date
times(tm1.c) #extract time

# Add days
tm1.c + 10
tm1.c - 10

# Calculate the difference between times
tm2.c - tm1.c
difftime(tm2.c, tm1.c, units = "hours")
detach("package:chron", unload = TRUE)



# ============================== Lubridate =======================

install.packages("lubridate")
library(lubridate)

# Create a time
tm1.lub <- ymd_hms("2013/04/18 22:25:28")
tm2.lub <- mdy_hms("08-15-01 22:22:11")
tm3.lub <- ydm_hm("2013-25-07 4:00am")
tm4.lub <- dmy("26072013")


# Extracting components
year(tm1.lub)
week(tm1.lub)
wday(tm1.lub, label = TRUE)
hour(tm1.lub)
tz(tm1.lub)
second(tm2.lub) <- 7
tm2.lub


# Converting to decimal hours can facilitate some types of calculations
tm1.dechr <- hour(tm1.lub) + minute(tm1.lub)/60 + second(tm1.lub)/3600
tm1.dechr


# Lubridate distinguishes between four types of objects: instants, intervals, durations, and periods.
# An instant is a specific moment in time. 
# Intervals, durations, and periods are all ways of recording time spans.

# Dates and times parsed in lubridate are instants:
is.instant(tm1.lub)

# Rounding an instant
round_date(tm1.lub, "minute")
round_date(tm1.lub, "day")
round_date(tm1.lub, "hour")


# Current date and time
now()
today()

with_tz(tm1.lub, "America/Los_Angeles")
force_tz(tm1.lub, "America/Los_Angeles")


# Calculations with instants
day(tm2.lub) - day(tm1.lub)
tm2.lub > tm1.lub


# An interval is the span of time that occurs between two specified instants
in.bed <- as.interval(tm1.lub, tm2.lub)
tm3.lub %within% in.bed  # Check whether a certain instant occured with a specified interval
tm4.lub %within% in.bed


# Determine whether two intervals overlap
daylight <- as.interval(ymd_hms("2015-08-7 1:1:1"), mdy_hms("7-15-2015 1:2:1"))
int_overlaps(daylight, in.bed)


# A duration is a time span not anchored to specific start and end times.
# It has an exact, fixed length, and is stored internally in seconds.

# Create some durations
ten.mins <- dminutes(10)
five.days <- ddays(5)
one.year <- dyears(1)

# Arithmetic with durations
tm1.lub - ten.mins
five.days + dhours(12)
ten.mins/as.duration(in.bed)


# A period is a time span not anchored to specific start and end times, 
# and measured in units larger than seconds with inexact lengths.

# Create some periods
three.weeks <- weeks(3)
four.hours <- hours(4)

# Arithmetic with periods
tm1.lub + three.weeks
tm4.lub + ten.mins

sabbatical <- months(6) + days(12)
sabbatical + seconds(50) + tm4.lub



# ============================== Calculating mean clock times ==========================

bed.times <- c(23.9, 0.5, 22.7, 0.1, 23.3, 1.2, 23.6)
mean(bed.times)  # doesn't work

install.packages("psych")
library(psych)
circadian.mean(bed.times)






# ============================== Times and dates in a data frame =======================
sleep <- data.frame(bed.time = ymd_hms("2013-09-01 23:05:24", "2013-09-02 22:51:09", 
                                       "2013-09-04 00:09:16", "2013-09-04 23:43:31", 
                                       "2013-09-06 00:17:41", "2013-09-06 22:42:27", 
                                       "2013-09-08 00:22:27"), 
                    rise.time = ymd_hms("2013-09-02 08:03:29", "2013-09-03 07:34:21", 
                                        "2013-09-04 07:45:06", "2013-09-05 07:07:17", 
                                        "2013-09-06 08:17:13", "2013-09-07 06:52:11", 
                                        "2013-09-08 07:15:19"), 
                    sleep.time = dhours(c(6.74, 7.92, 7.01, 6.23, 6.34, 7.42, 6.45)))


sleep$rise.time - sleep$bed.time


# We want to calculate sleep efficiency, the percent of time in bed spent asleep.
sleep$efficiency <- round(sleep$sleep.time/(sleep$rise.time - sleep$bed.time) * 100, 1)
str(sleep)
colMeans(sleep)   # Doesn't work

circadian.mean(hour(sleep$bed.time) + minute(sleep$bed.time)/60 + second(sleep$bed.time)/3600)
circadian.mean(hour(sleep$rise.time) + minute(sleep$rise.time)/60 + second(sleep$rise.time)/3600)
mean(sleep$sleep.time)/3600
mean(sleep$efficiency)










