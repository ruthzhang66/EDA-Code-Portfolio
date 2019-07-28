#20 Vectors

library(tidyverse)

#check types of various vectors
typeof(letters)

typeof(1:10)

typeof(1)

typeof(1L)


#create a vector and check its length
x <- list("a", "b", 1:10)
length(x)

#check logical a vector
1:10 %% 3 == 0

#create a vector
c(TRUE, TRUE, FALSE, NA)

#square of the square root of a number
x <- sqrt(2) ^ 2
x

# the below formula can result in special values NaN, Inf and -Inf:
c(-1, 0, 1) / 0

#codes to check for sepcial values
is.finite()
is.infinite()
is.nan()

is_logical()					
is_integer()				
is_double()				
is_numeric()				
is_character()		
is_atomic()		
is_list()			
is_vector()

#check the size/memory needed for different variables
x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)


#Coercion: combine a logical vector with numeric ones
x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y)

#proportion that is greater than 10
mean(y)

# check types of vectors containing different values 
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

#basic mathematical operations "sample" "runif"
sample(10) + 100
runif(10) > 0.5

# create vectors of different lengths
1:10 + 1:2
1:10 + 1:3

#create tables using "repeated" functions
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

# create vectors as x, y, z or a, b, c
c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))

#Reference to elements at different positions
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
x[c(1, 1, 5, 5, 5, 2)]

#Negative inputs will not work
x[c(-1, -3, -5)]

#error to use both positive and negative inputs
x[c(1, -1)]

#subsetting with zero leading to no values
x[0]

# check non-missing values of x
x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]

# check even values of a vector
x[x %% 2 == 0]

# subsetting
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

#list will give you hierarchical or tree-like tables
x <- list(1, 2, 3)
x

#check the structure
str(x)

x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

#list() can have different inputs:
y <- list("a", 1L, 1.5, TRUE)
str(y)

#combination of lists
z <- list(list(1, 2), list(3, 4))
str(z)

#list examples
x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

#three ways to subset a list
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
str(a[4])
str(a[[1]])
str(a[[4]])
a$a
a[["a"]]


#create individual attribute values with attr() or 
#set once and for all with attributes()
x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

#as.Date implementation
methods("as.Date")
getS3method("as.Date", "default")


#represent categorical data
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)

attributes(x)

#dates input (with time zones)
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)
typeof(x)
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)

attr(x, "tzone") <- "US/Pacific"
x
attr(x, "tzone") <- "US/Eastern"
x

#Tibbles: "tbl_df" + "tbl" + "data.frame"
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)

attributes(tb)


#data.frames' type and attributes
df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)





















