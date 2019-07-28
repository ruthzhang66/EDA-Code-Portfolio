##5 Data transformation

#install packages
library(nycflights13)
library(tidyverse)

#view data
flights

#select all flights on January 1st and store them to jan1
filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)

#select all flights on December 25th and store them to dec25
dec25 <- filter(flights, month == 12, day == 25)

#Computers can't store an infinite number of digits
#instead of ==, use near()
near(sqrt(2) ^ 2,  2)
near(1 / 49 * 49, 1)

#filter flights that departed in November or December
filter(flights, month == 11 | month == 12)

#x %in% y selects every row where x is one of the values in y. 
#use it to rewrite the code above
nov_dec <- filter(flights, month %in% c(11, 12))

#flights that weren't delayed by more than two hours
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#comparison for missing values
NA > 5
10 == NA
NA + 10
NA / 2

#determine if a value is missing
is.na(x)

#filter() only includes rows where the condition is TRUE; 
#it excludes both FALSE and NA values
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

#arrange() works similarly to filter() 
#except that instead of selecting rows, it changes their order.
arrange(flights, year, month, day)

#use desc() to reorder by a column in descending order
arrange(flights, desc(dep_delay))

#missing values at the end
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

# select columns by name
select(flights, year, month, day)

# select columns between year and day (inclusive)
select(flights, year:day)

# select all columns except those from year to day (inclusive)
select(flights, -(year:day))

#use rename(),to keeps all the variables that are not mentioned
rename(flights, tail_num = tailnum)

#use select() and everything() to move selected variables to the start of the df
select(flights, time_hour, air_time, everything())

#add new variables using mutate()
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

#columns just being created:

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

#use transmute() to keep the new variables
#can put formulas to create new variables

transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

#modular arithmetic can be calculated using %/% (integer division) and %% (remainder)
#which can break integers up into pieces
#For example, in the flights dataset, you can compute hour and minute from dep_time with
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)

#lead() and lag() allow you to refer to leading or lagging values
(x <- 1:10)
lag(x)
lead(x)

#functions for running sums, products, mins and maxes
cumsum(x)
cummean(x)
cumprod(x)
cummin(x)
cummax(x)

#The default gives smallest values the smallest ranks;
#use desc(x) to give the largest values the smallest ranks
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))

#variants for min_rank(): row_number(), dense_rank(), percent_rank(), cume_dist(), ntile()
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

#summarise(). 
#change a data frame to a single row:
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

#change the dataset to individual groups using groupby
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

#relationship between the distance and arr_delay
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)

#store delay larger than 20
delay <- filter(delay, count > 20, dest != "HNL")

#plot using dist as x and deay as y
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)


#another method
# %>% can be seena as "then", using %>% to create a df cartered to your need
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")


#na.rm argument can remove the missing values prior to computation
#na.rm = TRUE
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

#remove the cancelled flights
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

#the planes with  highest average delays:

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

#plot the delay grouped by tailnum
ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)


#scatterplot: flights vs. average delay:

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

#plot with n bigger than 25
delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

#install the Lahman package
#convert to a tibble
install.packages("Lahman")
batting <- as_tibble(Lahman::Batting)

#save variables grouped by player ID
batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

#save data with ab values larger than 100
batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)


#combine aggregation with logical subsetting
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

#measures of spread: sd(x), IQR(x), mad(x)
#sd(x) is the standard measure of spread. The interquartile range IQR(x) and 
#median absolute deviation mad(x) are robust equivalents used to deal with outliers.
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

#measures of rank: min(x), quantile(x, 0.25), max(x). Quantiles are a generalisation of the median. 
#For example, quantile(x, 0.25) will find a value of x that is greater than 25% of the values,
#and less than the remaining 75%
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#measures of position: first(x), nth(x, 2), last(x)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

# filter on ranks
# add new variables using mutate
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

# n() returns the size of the current group
#  use sum(!is.na(x)) to count the values w/o NA. 
#  use n_distinct(x) to count unique values.
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))
not_cancelled %>% 
  count(dest)


#count the sum of miles 
not_cancelled %>% 
  count(tailnum, wt = distance)

#Counts and proportions of logical values
# for example, flights left before 5am
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))

# proportion of flights delayed larger than an hour
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))

#combine different variables to a df
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))


#ungrouping
daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights

#grouped mutates and filters
# the worst members (descending) of each group:
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

#all groups bigger than a threshold (365)
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests

#calculations using %>%

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)





