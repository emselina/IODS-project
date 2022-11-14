#Elina Sohlberg 
#8.11.2022 
#R script for data wrangling for assignment 2

#2. 
#Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R (the separator is a tab ("\t") 
#and the file includes a header) and explore the structure and dimensions of the data.
#Write short code comments describing the output of these explorations. (1 point)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

#[1] 183  60
#Dimensions of the data frame are 183 rows and 60 columns.

str(lrn14)

# The data is data.frame with 183 obs. of 60 variables.

#3
#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
#by combining questions in the learning2014 data

#Scale all combination variables to the original scales (by taking the mean). Exclude observations where the exam points variable is zero. 
#(The data should then have 166 observations and 7 variables) (1 point)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

#create analysis dataset
analysis_dataset <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")

# select the columns

analysis_columns <- select(lrn14, one_of(analysis_dataset))


#Exclude observations where the exam points variable is zero.

analysis_columns <- filter(analysis_columns, Points !=0)


dim(analysis_columns)

[1] 166   7

#4.
#Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio). 
#Save the analysis dataset to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). 
#You can name the data set for example as learning2014.csv. See ?write_csv for help or search the web for pointers and examples. 
#Demonstrate that you can also read the data again by using read_csv().  
#(Use `str()` and `head()` to make sure that the structure of the data is correct).  (3 points)

setwd("IODS_project")
#Error in setwd("IODS_project") : cannot change working directory

write_csv(analysis_columns, "data/learning2014.csv")

analysis_columns2 <- read.csv("data/learning2014.csv")
dim(analysis_columns2)
[1] 166   7

str(analysis_columns2)

head(analysis_columns2)



