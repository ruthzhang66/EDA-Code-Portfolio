##12 Tidy Data

#check a tibble of 6 x 4
table1

#check a tibble of 12 x 4
table2

# check a tibble of 6 x 3
table3

#check cases
table4a

#check populations
table4b

# compute cases divided by population per 10,000
table1 %>% 
mutate(rate = cases / population * 10000)

# count cases per year
table1 %>% 
count(year, wt = cases)

#plot these changes over time using ggplot
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

#combine different columns to one
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

table4b %>% 
gather(`1999`, `2000`, key = "year", value = "population")

#combine the tidied versions of table4a and table4b into a single tibble
#using function dplyr::left_join()
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

#use spread() to analyze the table
table2 %>%
  spread(key = type, value = count)

 
#split one column with population and case into two variables
table3 %>% 
  separate(rate, into = c("cases", "population"))

#use a certain character to separate a column, 
#use separate() as an argument
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

#convert it to better types using convert = TRUE
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

#split the last two digits
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

#use unite() to combine different columns 
table5 %>% 
unite(new, century, year)

#use sep="" to remove the default underscore
table5 %>% 
  unite(new, century, year, sep = "")

#create a vector containing missing values
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

#make the implicit missing value explicit by putting years in the columns
stocks %>% 
  spread(year, return)

#na.rm = TRUE can turn explicit missing values implicit
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

#complete() can turn explicit missing values implicit
stocks %>% 
  complete(year, qtr)

#carry previous value forward to replace NA
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

#fill() will fill missing values. 
#where missing values can be replaced by the most recent non-missing value
treatment %>% 
  fill(person)

#gather columns
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1

#count "key":
who1 %>% 
  count(key)

#replace characters in the key column and nake variable names consistent.
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

#separate the values 
#split the codes at each "_".
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

#drop the new column
who3 %>% 
  count(new)

# drop column iso2 and iso3
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

#split after the first character
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

#Who dataset is tidy now
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)











