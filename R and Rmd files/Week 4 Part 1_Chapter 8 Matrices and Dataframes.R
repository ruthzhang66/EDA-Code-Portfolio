##Chapter 8

#create a matrix using cbind()
x <- 1:5
y <- 6:10
z <- 11:15

cbind(x, y, z)
# create a matrix (x, y and z are rows)
rbind(x, y, z)
# create a matrix with characters and numeric numbers
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))

# create a matrix of from 1 to 10, 
# the number of rows is 5 and column is 2
matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

# the number of rows is 2 and column is 5
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

# the number of rows is 5 and column is 2
# filled by row
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)

# create a dataframe named survey
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))

# display the structure of the df
str(survey)

# create another dataframe of survey without factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)

# display the structure of the df (no factors anymore)
str(survey)

#dispay several rows in the front
head(ChickWeight)

#display last few rows
tail(ChickWeight)

# display the df in a different window
View(ChickWeight)

# summarize statistical information of the df
summary(ToothGrowth)

# show the structure of ToothGrowth
str(ToothGrowth)

# show names of the df
names(ToothGrowth)

# show the "len" column of the df
ToothGrowth$len

# calculate the mean of the len column
mean(ToothGrowth$len)

# show a table of the supp column of ToothGrowth.
table(ToothGrowth$supp)

# the first few rows of len and supp columns of ToothGrowth
head(ToothGrowth[c("len", "supp")])

# create a new dataframe
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))

# add a new column called sex to survey to the "survey" dataframe
survey$sex <- c("m", "m", "f", "f", "m")

# update the name of the first column
names(survey)[1] <- "participant.number"

# update the column name from age to age.years in survey
names(survey)[names(survey) == "age"] <- "years"

# show row 1-6 and column 1 of ToothGrowth
ToothGrowth[1:6, 1]

# show row 1-3 and columns 1 & 3 of ToothGrowth
ToothGrowth[1:3, c(1,3)]

# show row 1 with all columns of ToothGrowth
ToothGrowth[1, ]

# show column 2 with all rows of ToothGrowth
ToothGrowth[, 2]

# create a new df "ToothGrowth.VC" with only the rows of ToothGrowth
#  where supp equals VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

# create a new df ""ToothGrowth.OJ" with only the rows of ToothGrowth
#  where supp equals OJ and dose < 1

ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                  ToothGrowth$dose < 1, ]

# show data where len < 20 AND supp == "OJ" AND dose >= 1
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "OJ" &
         dose >= 1)

# show data where len > 30 AND supp == "VC" (only return the len and dose columns)
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

# the mean tooth length of Guinea pigs given OJ
# step 1: create a subsettted dataframe called oj
oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")

#step 2: Calculate the mean from oj dataset
mean(oj$len)

# create a dataframe called health

health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))

# calculate bmi using formula below
health$weight / health$height ^ 2

# Save 
with(health, height / weight ^ 2)

# calculation (long code)
health$weight + health$height / health$age + 2 * health$height

# Shorten the code above achieving the same result
with(health, weight + height / age + 2 * height)



