
# REFER THE PDF TO UNDERSTAND THIS FILE ---

#filter ---
Studio
filter(flights, dest %in% c("SFO", "OAK"))
filter(flights, dest == "SFO" | dest == "OAK")
# Not this!
filter(flights, dest == "SFO" | "OAK")

filter(flights, date < "2001-02-01")

filter(flights, hour >= 0, hour <= 5)
filter(flights, hour >= 0 & hour <= 5)

filter(flights, dep_delay > 60)
filter(flights, arr_delay > 2 * dep_delay)


#Select ---
#selecting the two delay variables in different ways
select(flights, arr_delay, dep_delay)
select(flights, arr_delay:dep_delay)
select(flights, ends_with("delay"))
select(flights, contains("delay"))


#arrange ---
arrange(flights, date, hour, minute)
arrange(flights, desc(dep_delay))
arrange(flights, desc(arr_delay))
arrange(flights, desc(dep_delay - arr_delay))


#mutate ---
flights <- mutate(flights,
                  speed = dist / (time / 60))
arrange(flights, desc(speed))

mutate(flights, delta = dep_delay - arr_delay)

mutate(flights,
         hour = dep %/% 100,
         minute = dep %% 100)



#Group by and summarise ---
by_date <- group_by(flights, date)
by_hour <- group_by(flights, date, hour)
by_plane <- group_by(flights, plane)
by_dest <- group_by(flights, dest)

by_date <- group_by(flights, date)
delays <- summarise(filter(by_date, !is.na(dep_delay)),
                    mean = mean(dep_delay),
                    median = median(dep_delay),
                    q75 = quantile(dep_delay, 0.75),
                    over_15 = mean(dep_delay > 15),
                    over_30 = mean(dep_delay > 30),
                    over_60 = mean(dep_delay > 60),
                    count = n()
)

#Alternate
delays <- summarise(by_date,
                    mean = mean(dep_delay, na.rm = TRUE),
                    median = median(dep_delay, na.rm = TRUE),
                    q75 = quantile(dep_delay, 0.75, na.rm = TRUE),
                    over_15 = mean(dep_delay > 15, na.rm = TRUE),
                    over_30 = mean(dep_delay > 30, na.rm = TRUE),
                    over_60 = mean(dep_delay > 60, na.rm = TRUE)
)



#Pipe operator ---

hourly_delay <- flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(date, hour) %>%
  summarise(delay = mean(dep_delay), n = n()) %>%
  filter(n > 10)

flights %>%
  group_by(dest) %>%
  summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>%
  arrange(desc(arr_delay))

.Last.value %>% View()


flights %>%
  group_by(carrier, flight, dest) %>%
  tally(sort = TRUE) %>% # Save some typing
  filter(n == 365)

flights %>%
  group_by(carrier, flight, dest) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  filter(n == 365)

# Slightly different answer
flights %>%
group_by(carrier, flight) %>%
filter(n() == 365)

per_hour <- flights %>%
  filter(cancelled == 0) %>%
  mutate(time = hour + minute / 60) %>%
  group_by(time) %>%
  summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

qplot(time, arr_delay, data = per_hour)
qplot(time, arr_delay, data = per_hour, size = n) + scale_size_area()
qplot(time, arr_delay, data = filter(per_hour, n > 30), size = n) +
  scale_size_area()

ggplot(filter(per_hour, n > 30), aes(time, arr_delay)) +
geom_vline(xintercept = 5:24, colour = "white", size = 2) +
geom_point()



