
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

hd <- rename(hd, GNI = Gross.National.Income..GNI..per.Capita, HDI = Human.Development.Index..HDI., Life_Exp = Life.Expectancy.at.Birth,
       Edu_Exp = Expected.Years.of.Education,GNI_minus_HDI = GNI.per.Capita.Rank.Minus.HDI.Rank, Edu_Mean =Mean.Years.of.Education, HDI_Rank =HDI.Rank)


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




gii <- rename(gii, GII_Rank = GII.Rank, GII =Gender.Inequality.Index..GII., Mat_Mor=Maternal.Mortality.Ratio, 
       Ado_Birth=Adolescent.Birth.Rate, Parli=Percent.Representation.in.Parliament, Edu2_F=Population.with.Secondary.Education..Female.,
       Edu2_M=Population.with.Secondary.Education..Male., Labo_F=Labour.Force.Participation.Rate..Female.,
       Labo_M=Labour.Force.Participation.Rate..Male.)

gii <- mutate(gii, Edu2_ratio = Edu2_F / Edu2_M, Labo_ratio = Labo_F / Labo_M)

# join two data sets

hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))

dim(hd_gii)
#[1] 195  19

human <- hd_gii


write.csv(human, "data/human.csv", row.names = FALSE)

human <- read.csv("data/human.csv")
dim(human)




