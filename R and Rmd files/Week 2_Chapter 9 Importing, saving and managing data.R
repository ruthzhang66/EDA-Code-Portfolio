##Chapter 9 

#display all objects in the current workspace
ls()	

#remove the objects a, b ..
rm(a, b, ..)	

#remove all objects
rm(list = ls())	

#display current working directory
getwd()	

#Changes the working directory to a specified file location
setwd(dir = "C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject")

#Returns the names of all files in the working directory
list.files()

#write x to mydata.txt
#decide how to seperate column with sep 
#(e.g.; sep = "," for a comma-separated file, and sep = \t" for a tab-separated file)
write.table(x, file = "mydata.txt", sep)

#save a, b, . to myimage.RData
save(a, b, .., file = "myimage.RData)	

#save images to myimage.RData
save.image(file = "myimage.RData"")

#load objects in myimage.RData
load(file = "myimage.RData")

#read a text file called mydata.txt
#separate columns with sep (e.g. sep = "," for comma-delimited files, and sep = "\t" for tab-delimited files), 
#and decide whether there should be a header column with header = TRUE
read.table(file = "mydata.txt", sep, header)

# create dataframes study1.df, score.by.sex, and study1.htest
study1.df <- data.frame(id = 1:5,sex = c("m", "m", "f", "f", "m"),score = c(51, 20, 67, 52, 42))
score.by.sex <- aggregate(score ~ sex,FUN = mean, data = study1.df)
study1.htest <- t.test(score ~ sex, data = study1.df)

# save dataframes to working directory
save(study1.df, score.by.sex, study1.htest, file = "C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject/data/study.RData")

#  save images to working directory
save.image(file = "C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject/data/study.RData")

# load study1.RData into my workspace
load(file = "C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject/data/study.RData")

# Load objects in projectimage.RData into my workspace
load(file = "C:/Users/lsyad/OneDrive/Desktop/taizilu/HU/Term3/EDA/MyRProject/data/study.RDataprojectimage.RData")

# remove huge.df from my workspace
rm(huge.df)

# remove all from workspace
rm(list = ls())


# set the pirates dataframe object to a tab-delimited
# save the file as pirates.txt in working directory
write.table(x = pirates,file = "pirates.txt", sep = "\t")

# write the pirates dataframe object (tab-delimited columns)
# save the file as pirates.txt to the desktop
write.table(x = pirates,file = "Users/nphillips/Desktop/pirates.txt", sep = "\t")

# read a tab-delimited text file to mydata.txt from working directory into
# save as a new object called mydata
mydata <- read.table(file = 'data/mydata.txt', sep = '\t',header = TRUE, stringsAsFactors = FALSE)    

# read a text file from the web
fromweb <- read.table(file = 'http://goo.gl/jTNf6P', sep = '\t', header = TRUE)





