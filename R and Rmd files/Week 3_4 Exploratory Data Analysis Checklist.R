##Chapter 4
#Use data from US EDA Ozone 2017 dataset provided in Moodle
library(readr)
USEPA <- read_csv("C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject/data/US EPA data 2017.csv")

names(USEPA) <- make.names(names(USEPA))

nrow(USEPA)
ncol(USEPA)

#examine each class of the df
str(USEPA)

#show the first few rows and last few rows of the df
head(USEPA[, c(6:7, 10)])
tail(USEPA[, c(6:7, 10)])

#display latitude as a table
table(USEPA$Latitude)

#install library
#take a look at which observations were measured at latitude 37.1655
library(dplyr)
filter(USEPA, Latitude == "37.1655") %>% select(`Sample Duration`,`Arithmetic Mean`)


#pulled all of the measurements taken at State Code 01 and Couty Code 049
filter(USEPA, USEPA$'State Code' == "01" & USEPA$'County Code' == "049") %>% select(`Sample Duration`,`Arithmetic Mean`) %>% as.data.frame

#check how many counties are represented in this dataset
select(USEPA, 'County Code') %>% unique %>% nrow

#look at the unique elements 
unique(USEPA$'County Code')

#summary the arithmetic mean column
summary(USEPA$`Arithmetic Mean`)

#calculate deciles
quantile(USEPA$`Arithmetic Mean`, seq(0, 1, 0.1))

#combine state code and county code using groub_by
ranking <- group_by(USEPA, USEPA$'State Code', USEPA$'County Code') %>%
  summarize(USEPA = mean(`1st Max Value`)) %>%
  as.data.frame %>%
  arrange(desc(USEPA))

#output top 10 and bottom 10
head(ranking, 10)
tail(ranking,10)    

#check the # of observations for state code 01 and county code 049
filter(USEPA, USEPA$`County Code` == "049" & USEPA$`State Code` == "01") %>% nrow

#set random number generator and resample the indices of the rows of the data frame
set.seed(102)
N <- nrow(USEPA)
idx <- sample(N, N, replace = TRUE)

#use the resampled data to create a new dataset, USEPA2
USEPA2<- USEPA[idx, ]
ranking2 <- group_by(USEPA2, USEPA2$'State Code', USEPA2$'County Code') %>%
  summarize(USEPA2 = mean(`1st Max Value`)) %>%
  as.data.frame %>%
  arrange(desc(USEPA2))

#compare the top 10 states and counties from our original ranking and 
#the top 10 counties from our ranking based on the resampled data
cbind(head(ranking, 10),head(ranking2, 10))

#compare the bottom 10 states and counties from our original ranking and 
#the top 10 counties from our ranking based on the resampled data
cbind(tail(ranking, 10), tail(ranking2, 10))
