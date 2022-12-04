
#Read in the “Human development” and “Gender inequality” data sets. Here are the links to the datasets


hd <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#hd
str(hd)

dim(hd)



summary(hd)

#gii

str(gii)

dim(gii)

summary(gii)


colnames(hd)

#[1] "HDI.Rank"                              
#[2] "Country"                               
#[3] "Human.Development.Index..HDI."         
#[4] "Life.Expectancy.at.Birth"              
#[5] "Expected.Years.of.Education"           
#[6] "Mean.Years.of.Education"               
#[7] "Gross.National.Income..GNI..per.Capita"
#[8] "GNI.per.Capita.Rank.Minus.HDI.Rank"  

hd <- rename(hd, GNI = Gross.National.Income..GNI..per.Capita, HDI = Human.Development.Index..HDI., Life.Exp = Life.Expectancy.at.Birth,
             Edu.Exp = Expected.Years.of.Education,GNI.minus_HDI = GNI.per.Capita.Rank.Minus.HDI.Rank, Edu.Mean =Mean.Years.of.Education, HDI.Rank =HDI.Rank)


colnames(gii)

#[1] "GII.Rank"                                    
#[2] "Country"                                     
#[3] "Gender.Inequality.Index..GII."               
#[4] "Maternal.Mortality.Ratio"                    
#[5] "Adolescent.Birth.Rate"                       
#[6] "Percent.Representation.in.Parliament"        
#[7] "Population.with.Secondary.Education..Female."
#[8] "Population.with.Secondary.Education..Male."  
#[9] "Labour.Force.Participation.Rate..Female."    
#[10] "Labour.Force.Participation.Rate..Male." 




gii <- rename(gii, GII.Rank = GII.Rank, GII =Gender.Inequality.Index..GII., Mat.Mor=Maternal.Mortality.Ratio, 
       Ado.Birth=Adolescent.Birth.Rate, Parli.F=Percent.Representation.in.Parliament, Edu2.F=Population.with.Secondary.Education..Female.,
       Edu2.M=Population.with.Secondary.Education..Male., Labo.F=Labour.Force.Participation.Rate..Female.,
       Labo.M=Labour.Force.Participation.Rate..Male.)

gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Labo.FM = Labo.F / Labo.M)

# join two data sets

hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

dim(hd_gii)
#[1] 195  19

human <- hd_gii


write.csv(human, "data/human.csv", row.names = FALSE)


#load human data 
human <- read.csv("data/human.csv")
dim(human)
str(human)

library(stringr)
library(dplyr)
 

GNI_n <- str_replace(human$GNI, pattern=",", replace = "") %>% as.numeric

#Mutate
human <- mutate(human, GNI = GNI_n)

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))


# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))


#Filter out region from human dataset


# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human[1:last,]

# add countries as rownames
rownames(human_) <- human_$Country

  
#remove Country column from human_ dataset
human_ <- dplyr::select(human_, -Country)

dim(human_)
#155   8



write.csv(human_, "data/human.csv", row.names = FALSE)