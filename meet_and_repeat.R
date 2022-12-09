#Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS,
#data set are in the wide form:
  
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T)



colnames(BPRS)
str(BPRS)
dim(BPRS)



colnames(RATS)
str(RATS)
dim(RATS)


#Convert the categorical variables of both data sets to factors

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group in RATS

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)



# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) 


#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. (


# Convert to long form BPRS
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number and add as a new column
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))


# Convert data to long form RATS add Time variable
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>%
  arrange(Time)


names(BPRS)
dim(BPRS)
str(BPRS)
view(BPRS)
summary(BPRS)


names(BPRSL)
dim(BPRSL)
str(BPRSL)
view(BPRSL)
summary(BPRSL)



names(RATS)
dim(RATS)
str(RATS)
view(RATS)
summary(RATS)


names(RATSL)
dim(RATSL)
str(RATSL)
view(RATSL)
summary(RATSL)


write.csv(RATSL, "data/RATSL.csv", row.names = FALSE)


write.csv(BPRSL, "data/BPRSL.csv", row.names = FALSE)



